/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit

class GameScene: SKScene {
  var background: SKTileMapNode!
  var obstaclesTileMap: SKTileMapNode?
  var bugsprayTileMap: SKTileMapNode?

  var bugsNode = SKNode()
  
  var player = Player()
  var hud = HUD()
  
  var firebugCount: Int = 0

  var timeLimit: Int = 10
  var elapsedTime: Int = 0
  var startTime: Int?

  var currentLevel: Int = 1

  var gameState: GameState = .initial {
    didSet {
      hud.updateGameState(from: oldValue, to: gameState)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    background =
      childNode(withName: "background") as! SKTileMapNode
    obstaclesTileMap = childNode(withName: "obstacles")
      as? SKTileMapNode

    if let timeLimit =
      userData?.object(forKey: "timeLimit") as? Int {
      self.timeLimit = timeLimit
    }
    // 1
    let savedGameState = aDecoder.decodeInteger(forKey: "Scene.gameState")
    if let gameState = GameState(rawValue: savedGameState), gameState == .pause {
      self.gameState = gameState
      firebugCount = aDecoder.decodeInteger(
        forKey: "Scene.firebugCount")
      elapsedTime = aDecoder.decodeInteger(
        forKey: "Scene.elapsedTime")
      currentLevel = aDecoder.decodeInteger(
        forKey: "Scene.currentLevel")
      // 2
      player = childNode(withName: "Player") as! Player
      hud = camera!.childNode(withName: "HUD") as! HUD
      bugsNode = childNode(withName: "Bugs")!
      bugsprayTileMap = childNode(withName: "Bugspray")
        as? SKTileMapNode
    }

    addObservers()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }


  override func didMove(to view: SKView) {
    if gameState == .initial {
      addChild(player)
      setupWorldPhysics()
      createBugs()
      setupObstaclePhysics()
      if firebugCount > 0 {
        createBugspray(quantity: firebugCount + 10)
      }
      setupHUD()
      gameState = .start
    }
    setupCamera()
  }
  
  func setupHUD() {
    camera?.addChild(hud)
    hud.addTimer(time: timeLimit)
    hud.addBugCount(with: bugsNode.children.count)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    guard let touch = touches.first else { return }
    switch gameState {
    // 1
    case .start:
      gameState = .play
      isPaused = false
      startTime = nil
      elapsedTime = 0
    // 2
    case .play:
      player.move(target: touch.location(in: self))
    case .win:
      transitionToScene(level: currentLevel + 1)
    case .lose:
      transitionToScene(level: 1)
    case .reload:
      // 1
      if let touchedNode =
        atPoint(touch.location(in: self)) as? SKLabelNode {
        // 2
        if touchedNode.name == HUDMessages.yes {
          isPaused = false
          startTime = nil
          gameState = .play
          // 3
        } else if touchedNode.name == HUDMessages.no {
          transitionToScene(level: 1)
        }
      }
    default:
      break
    }
  }

  func setupCamera() {
    guard let camera = camera, let view = view else { return }
    
    let zeroDistance = SKRange(constantValue: 0)
    let playerConstraint = SKConstraint.distance(zeroDistance,
                                                 to: player)
    // 1
    let xInset = min(view.bounds.width/2 * camera.xScale,
                     background.frame.width/2)
    let yInset = min(view.bounds.height/2 * camera.yScale,
                     background.frame.height/2)
    
    // 2
    let constraintRect = background.frame.insetBy(dx: xInset,
                                                  dy: yInset)
    // 3
    let xRange = SKRange(lowerLimit: constraintRect.minX,
                         upperLimit: constraintRect.maxX)
    let yRange = SKRange(lowerLimit: constraintRect.minY,
                         upperLimit: constraintRect.maxY)
    
    let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
    edgeConstraint.referenceNode = background
    // 4
    camera.constraints = [playerConstraint, edgeConstraint]
  }
  
  func setupWorldPhysics() {
    background.physicsBody =
      SKPhysicsBody(edgeLoopFrom: background.frame)
    background.physicsBody?.categoryBitMask = PhysicsCategory.Edge
    
    physicsWorld.contactDelegate = self

  }
  
  func setupObstaclePhysics() {
    guard let obstaclesTileMap = obstaclesTileMap else { return }
    // 1
    for row in 0..<obstaclesTileMap.numberOfRows {
      for column in 0..<obstaclesTileMap.numberOfColumns {
        // 2
        guard let tile = tile(in: obstaclesTileMap,
                              at: (column, row))
          else { continue }
        guard tile.userData?.object(forKey: "obstacle") != nil
          else { continue }
        // 3
        let node = SKNode()
        node.physicsBody = SKPhysicsBody(rectangleOf: tile.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.friction = 0
        node.physicsBody?.categoryBitMask =
          PhysicsCategory.Breakable
        
        node.position = obstaclesTileMap.centerOfTile(
          atColumn: column, row: row)
        obstaclesTileMap.addChild(node)
      }
    }
  }
  
  func createBugs() {
    guard let bugsMap = childNode(withName: "bugs")
      as? SKTileMapNode else { return }
    // 1
    for row in 0..<bugsMap.numberOfRows {
      for column in 0..<bugsMap.numberOfColumns {
        // 2
        guard let tile = tile(in: bugsMap,
                              at: (column, row))
          else { continue }
        // 3
        let bug: Bug
        if tile.userData?.object(forKey: "firebug") != nil {
          bug = Firebug()
          firebugCount += 1
        } else {
          bug = Bug()
        }
        bug.position = bugsMap.centerOfTile(atColumn: column,
                                            row: row)
        bugsNode.addChild(bug)
        bug.moveBug()
      }
    }
    // 4
    bugsNode.name = "Bugs"
    addChild(bugsNode)
    // 5
    bugsMap.removeFromParent()
  }

  func createBugspray(quantity: Int) {
    // 1
    let tile = SKTileDefinition(texture:
      SKTexture(pixelImageNamed: "bugspray"))
    // 2
    let tilerule = SKTileGroupRule(adjacency:
      SKTileAdjacencyMask.adjacencyAll, tileDefinitions: [tile])
    // 3
    let tilegroup = SKTileGroup(rules: [tilerule])
    // 4
    let tileSet = SKTileSet(tileGroups: [tilegroup])
    
    // 5
    let columns = background.numberOfColumns
    let rows = background.numberOfRows
    bugsprayTileMap = SKTileMapNode(tileSet: tileSet,
                                    columns: columns,
                                    rows: rows,
                                    tileSize: tile.size)
    // 6
    for _ in 1...quantity {
      let column = Int.random(min: 0, max: columns-1)
      let row = Int.random(min: 0, max: rows-1)
      bugsprayTileMap?.setTileGroup(tilegroup,
                                    forColumn: column, row: row)
    }
    // 7
    bugsprayTileMap?.name = "Bugspray"
    addChild(bugsprayTileMap!)

  }

  func tile(in tileMap: SKTileMapNode,
            at coordinates: TileCoordinates)
    -> SKTileDefinition? {
      return tileMap.tileDefinition(atColumn: coordinates.column,
                                    row: coordinates.row)
  }

  func tileCoordinates(in tileMap: SKTileMapNode,
                       at position: CGPoint) -> TileCoordinates {
    let column = tileMap.tileColumnIndex(fromPosition: position)
    let row = tileMap.tileRowIndex(fromPosition: position)
    return (column, row)
  }

  func tileGroupForName(tileSet: SKTileSet, name: String)
    -> SKTileGroup? {
      let tileGroup = tileSet.tileGroups
        .filter { $0.name == name }.first
      return tileGroup
  }

  func updateBugspray() {
    guard let bugsprayTileMap = bugsprayTileMap else { return }
    let (column, row) = tileCoordinates(in: bugsprayTileMap,
                                        at: player.position)
    if tile(in: bugsprayTileMap, at: (column, row)) != nil {
      bugsprayTileMap.setTileGroup(nil, forColumn: column,
                                   row: row)
      player.hasBugspray = true
    }
  }
  
  func updateHUD(currentTime: TimeInterval) {
    // 1
    if let startTime = startTime {
      // 2
      elapsedTime = Int(currentTime) - startTime
    } else {
      // 3
      startTime = Int(currentTime) - elapsedTime
    }
    // 4
    hud.updateTimer(time: timeLimit - elapsedTime)
  }


  override func update(_ currentTime: TimeInterval) {
    if gameState != .play  {
      isPaused = true
      return
    }

    if !player.hasBugspray {
      updateBugspray()
    }
    advanceBreakableTile(locatedAt: player.position)
    updateHUD(currentTime: currentTime)
    checkEndGame()
  }

  func advanceBreakableTile(locatedAt nodePosition: CGPoint) {
    guard let obstaclesTileMap = obstaclesTileMap else { return }
    // 1
    let (column, row) = tileCoordinates(in: obstaclesTileMap,
                                        at: nodePosition)
    // 2
    let obstacle = tile(in: obstaclesTileMap,
                        at: (column, row))
    //3
    guard let nextTileGroupName =
      obstacle?.userData?.object(forKey: "breakable") as? String
      else { return }
    // 4
    if let nextTileGroup =
      tileGroupForName(tileSet: obstaclesTileMap.tileSet,
                       name: nextTileGroupName) {
      obstaclesTileMap.setTileGroup(nextTileGroup,
                                    forColumn: column, row: row)
    }
  }

  func checkEndGame() {
    if bugsNode.children.count == 0 {
      player.physicsBody?.linearDamping = 1
      gameState = .win
    } else if timeLimit - elapsedTime <= 0 {
      player.physicsBody?.linearDamping = 1
      gameState = .lose
    }
  }

  func transitionToScene(level: Int) {
    // 1
    guard let newScene = SKScene(fileNamed: "Level\(level)")
      as? GameScene else {
        fatalError("Level: \(level) not found")
    }
    // 2
    newScene.currentLevel = level
    view!.presentScene(newScene,
                       transition: SKTransition.flipVertical(withDuration: 0.5))
  }

}

extension GameScene : SKPhysicsContactDelegate {
  func remove(bug: Bug) {
    bug.removeFromParent()
    background.addChild(bug)
    bug.die()
    hud.updateBugCount(with: bugsNode.children.count)
  }

  func didBegin(_ contact: SKPhysicsContact) {
    let other = contact.bodyA.categoryBitMask
      == PhysicsCategory.Player ?
        contact.bodyB : contact.bodyA
    
    switch other.categoryBitMask {
    case PhysicsCategory.Bug:
      if let bug = other.node as? Bug {
        remove(bug: bug)
      }
    case PhysicsCategory.Firebug:
      if player.hasBugspray {
        if let firebug = other.node as? Firebug {
          remove(bug: firebug)
          player.hasBugspray = false
        }
      }
    case PhysicsCategory.Breakable:
      if let obstacleNode = other.node {
        // 1
        advanceBreakableTile(locatedAt: obstacleNode.position)
        // 2
        obstacleNode.removeFromParent()
      }

    default:
      break
    }
    if let physicsBody = player.physicsBody {
      if physicsBody.velocity.length() > 0 {
        player.checkDirection()
      }
    }
  }

}

// MARK: - Notifications
extension GameScene {
  func applicationDidBecomeActive() {
    print("* applicationDidBecomeActive")
    if gameState == .pause {
      gameState = .reload
    }
  }
  
  func applicationWillResignActive() {
    print("* applicationWillResignActive")
    isPaused = true
    if gameState != .lose {
      gameState = .pause
    }
  }
  
  func applicationDidEnterBackground() {
    print("* applicationDidEnterBackground")
    if gameState != .lose {
      saveGame()
    }
  }

  func addObservers() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(applicationDidBecomeActive),
                                           name: .UIApplicationDidBecomeActive, object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(applicationWillResignActive),
                                           name: .UIApplicationWillResignActive, object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(applicationDidEnterBackground),
                                           name: .UIApplicationDidEnterBackground, object: nil)
  }

}

// MARK: - Saving Games
extension GameScene {
  func saveGame() {
    // 1
    let fileManager = FileManager.default
    guard let directory =
      fileManager.urls(for: .libraryDirectory,
                       in: .userDomainMask).first
      else { return }
    // 2
    let saveURL = directory.appendingPathComponent("SavedGames")
    // 3
    do {
      try fileManager.createDirectory(atPath: saveURL.path,
                                      withIntermediateDirectories: true,
                                      attributes: nil)
    } catch let error as NSError {
      fatalError(
        "Failed to create directory: \(error.debugDescription)")
    }
    // 4
    let fileURL = saveURL.appendingPathComponent("saved-game")
    print("* Saving: \(fileURL.path)")
    // 5
    NSKeyedArchiver.archiveRootObject(self, toFile: fileURL.path)
  }
  
  override func encode(with aCoder: NSCoder) {
    aCoder.encode(firebugCount,
                  forKey: "Scene.firebugCount")
    aCoder.encode(elapsedTime,
                  forKey: "Scene.elapsedTime")
    aCoder.encode(gameState.rawValue,
                  forKey: "Scene.gameState")
    aCoder.encode(currentLevel,
                  forKey: "Scene.currentLevel")
    super.encode(with: aCoder)
  }

  class func loadGame() -> SKScene? {
    print("* loading game")
    var scene: SKScene?
    // 1
    let fileManager = FileManager.default
    guard let directory =
      fileManager.urls(for: .libraryDirectory,
                       in: .userDomainMask).first
      else { return nil }
    // 2
    let url = directory.appendingPathComponent(
      "SavedGames/saved-game")
    // 3
    if FileManager.default.fileExists(atPath: url.path) {
      scene = NSKeyedUnarchiver.unarchiveObject(
        withFile: url.path) as? GameScene
      _ = try? fileManager.removeItem(at: url)
    }
    return scene
  }

}

