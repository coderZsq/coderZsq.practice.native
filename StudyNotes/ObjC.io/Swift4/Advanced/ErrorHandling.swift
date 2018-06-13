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
    }
}
#if false
enum Result<A> {
    case failure(Error)
    case success(A)
}
#endif
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

