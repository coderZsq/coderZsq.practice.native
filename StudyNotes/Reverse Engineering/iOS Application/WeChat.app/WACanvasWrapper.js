/*
 * 在全局暴露一个 NativeGlobal 对象
 * 设计文档：http://git.code.oa.com/wxweb/game-design/blob/master/global/NativeGlobal/README.md
 */
(function() {

NativeGlobal = {}
var g = NativeGlobal

// The 'ej' object provides some basic info and utility functions
var ej = new GlobalUtils.GlobalUtils()
var Canvas = GlobalUtils.Canvas
var BindingObject = GlobalUtils.BindingObject

// TODO Reporter-SDK 里面会用到这个全局变量，不能直接移除
// __wxConfig = undefined

g.log = function (str) { ej.log(str) }
 
g.SharedCanvas = function () {
  return new Canvas(1)
}
 
g.setTimeout = function (cb, t) { return ej.setTimeout(cb, t || 0) }
g.setInterval = function(cb, t){ return ej.setInterval(cb, t || 0) }
g.clearTimeout = function(id){ return ej.clearTimeout(id) }
g.clearInterval = function(id){ return ej.clearInterval(id) }
g.requestAnimationFrame = function(cb){ return ej.requestAnimationFrame(cb) }
g.cancelAnimationFrame = function(id){ return ej.cancelAnimationFrame(id) }
g.setPreferredFramesPerSecond = function(fps){ return ej.setPreferredFramesPerSecond(fps) }
g.loadFont = function(path){ return ej.loadFont(path) }
g.encodeArrayBuffer = function(str, code){ return ej.encodeArrayBuffer(str, code) }
g.decodeArrayBuffer = function(buffer, code){ return ej.decodeArrayBuffer(buffer, code) }
g.performanceNow = function(){ return ej.performanceNow() }
g.getTextLineHeight = function(style,weight,size,family,text){ return ej.getTextLineHeight(style,weight,size,family,text) }
g.startProfile = function () { return ej.startProfile() }
g.stopProfile = function () { return ej.stopProfile() }
g.getProfileResult = function () { return ej.getProfileResult() }

g.setGlobalAttribute = function (a){return ej.setGlobalAttribute(a) }
 
 createCommandBuffer = function (buffer){ return ej.createCommandBuffer(buffer) }
 processCommandBuffer = function (sync){ return ej.processCommandBuffer(sync) }
 
// TODO 临时暴露到全局以解决 Reporter 错误
setTimeout = g.setTimeout
 var Image = GlobalUtils.Image;
 g.Image = function(){
 var img = new Image
 img.uid = img.__id();
 return img;
 }
 
var screenCanvas = new GlobalUtils.Canvas()
var hasScreenCanvas = false
g.Canvas = function () {
  if (hasScreenCanvas) {
    var c = new Canvas()
    c.uid = c.__canvasId()
    return c
  } else {
    hasScreenCanvas = true
    screenCanvas.uid = screenCanvas.__canvasId()
    return screenCanvas
  }
}
g.BindingObject = function () {
  return new BindingObject(ej)
}

var touchInput = new GlobalUtils.TouchInput(screenCanvas)
var touchEventNames = ['ontouchstart', 'ontouchmove', 'ontouchend', 'ontouchcancel']
touchEventNames.forEach(function (touchEventName) {
  touchInput[touchEventName] = function (touches, changedTouches, timestamp) {
    if (typeof WeixinCanvas[touchEventName] === 'function') {
      var event = {
        type: touchEventName,
        touches: JSON.parse(JSON.stringify(touches)),
        changedTouches: JSON.parse(JSON.stringify(changedTouches)),
        timeStamp: timestamp
      }
      event.canvasId = g.canvasId;
      WeixinCanvas[touchEventName].call(g, event)
    }
  }
})
 
ej.onbindingobjectdestruct = function (id) {
  if (typeof g.EventHandler.onbindingobjectdestruct === 'function') {
    g.EventHandler.onbindingobjectdestruct.call(g, id)
  }
}

var global = (function () { return this })()
delete global.GlobalUtils
})();
