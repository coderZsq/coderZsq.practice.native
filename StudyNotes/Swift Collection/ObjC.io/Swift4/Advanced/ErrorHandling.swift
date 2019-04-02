//
//  ErrorHandling.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct ErrorHandling {
    
    static func run() {
        #if false
        let result = contents(ofFile: "input.txt")
        switch result {
        case let .success(contents):
            print(contents)
        case let .failure(error):
            if let fileError = error as? FileError, fileError == .fileDoesNotExist {
                print("File not found")
            } else {
                //处理错误
            }
        }
        #endif
        
        do {
            let result = try contents(ofFile: "input.txt")
            print(result)
        } catch FileError.fileDoesNotExist {
            print("File not found")
        } catch {
            print(error)
            //处理其他错误
        }
        #if false
        do {
            let result = try parse(text: "{\"message\": \"We come in peace\"}")
            print(result)
        } catch ParseError.wrongEncoding {
            print("Wrong encoding")
        } catch let ParseError.warning(line, message) {
            print("Warning at line \(line): \(message)")
        } catch {
            
        }
        #endif
//        _ = parse(text: invalidValue)
        
//        if let result = try? parse(text: input) {
//            print(result)
//        }
        
        do {
            let int = try Int("42").or(error: ReadIntError.couldNotRead)
        } catch {
            print(error)
        }
    }
}
//#if false
enum Result2<A> {
    case failure(Error)
    case success(A)
}
//#endif
func contentsOrNil(ofFile filename: String) -> String? {return nil}

enum FileError: Error {
    case fileDoesNotExist
    case noPermission
}
#if false
func contents(ofFile filename: String) -> Result<String> {return .success("")}
#endif

func contents(ofFile filename: String) throws -> String {return ""}

enum ParseError: Error {
    case wrongEncoding
    case warning(line: Int, message: String)
}

func parse(text: String) throws -> Result<String, ParseError> {return .success("")}

enum Result<A, ErrorType: Error> {
    case failure(ErrorType)
    case success(A)
}

func parse(text: String) -> Result<[String], ParseError> {return .success([])}

extension ParseError: CustomNSError {
    static let errorDomain = "io.objc.parseError"
    var errorCode: Int {
        switch self {
        case .wrongEncoding: return 100
        case .warning(_, _): return 200
        }
    }
    var errorUserInfo: [String : Any] {
        return [:]
    }
}

func checkFile(filename: String) throws -> Bool {return false}
#if false
func checkAllFiles(filenames: [String]) throws -> Bool {
    for filename in filenames {
        guard try checkFile(filename: filename) else {return false}
    }
    return true
}
#endif
extension Int {
    var isPrime: Bool {
        return true
    }
}

func checkPrimes(_ numbers: [Int]) -> Bool {
    for number in numbers {
        guard number.isPrime else {return false}
    }
    return true
}

extension Sequence {
    func all2(matching predicate: (Element) -> Bool) -> Bool {
        for element in self {
            guard predicate(element) else {return false}
        }
        return true
    }
}

func checkPrimes2(_ numbers: [Int]) -> Bool {
    return numbers.all2 {$0.isPrime}
}

extension Sequence {
    func all(matching predicate: (Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            guard try predicate(element) else {return false}
        }
        return true
    }
}

func checkAllFiles(filenames: [String]) throws -> Bool {
    return try filenames.all(matching: checkFile)
}

//func contents(ofFile filename: String) throws -> String {
//    let file = open("test.txt", O_RDONLY)
//    defer {close(file)}
//    let contents = try process(file: file)
//    return contents
//}

extension Optional {
    func or(error: Error) throws -> Wrapped {
        switch self {
        case let x?: return x
        case nil: throw error
        }
    }
}

enum ReadIntError: Error {
    case couldNotRead
}

func checkFilesAndFetchProcessID(filenames: [String]) -> Int {
    do {
        try filenames.all(matching: checkFile)
        let pidString = try contents(ofFile: "Pidfile")
        return try Int(pidString).or(error: ReadIntError.couldNotRead)
    } catch {
        return 42
    }
}

extension Result2 {
    func flatMap<B>(transform: (A) -> Result2<B>) -> Result2<B> {
        switch self {
        case let .failure(m): return .failure(m)
        case let .success(x): return transform(x)
        }
    }
}

//func checkFilesAndFetchProcessID(filenames: [String]) -> Result2<Int> {
//    return filenames.all(matching: checkFile).fla
//}
