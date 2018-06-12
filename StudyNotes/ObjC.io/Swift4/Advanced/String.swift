//
//  String.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

extension String {
    
    static func run() {
        
        let single = "Pok\u{00E9}mon"
        let double = "Poke\u{0301}mon"
        print((single, double))
        
        print(single.count)
        print(double.count)
        print(single == double)
        
        print(single.utf16.count)
        print(double.utf16.count)
        
        let nssingle = single as NSString
        print(nssingle.length)
        let nsdouble = double as NSString
        print(nsdouble.length)
        print(nssingle == nsdouble)
        
        print(single.utf16.elementsEqual(double.utf16))
        
        let chars: [Character] = [
            "\u{1ECD}\u{300}",
            "\u{F2}\u{323}",
            "\u{6F}\u{323}\u{300}",
            "\u{6F}\u{300}\u{323}"
        ]
        let allEqual = chars.dropFirst().all {$0 == chars.first}
        print(allEqual)
        
        let crlf = "\r\n"
        print(crlf.count)
        
        let oneEmoji = "😂"
        print(oneEmoji)
        print(oneEmoji.count)
        
        let flags = "🇧🇷🇳🇿"
        print(flags.count)
        
        let hello = "Hello"
        print(hello.allPrefixes1)
        print(hello.allPrefixes2)
        
        var greeting = "Hello, world!"
        if let comma = greeting.index(of: ",") {
            print(greeting[..<comma])
            greeting.replaceSubrange(comma..., with: " again.")
        }
        print(greeting)
        
        let s = "abcdef"
        let second = s.index(after: s.startIndex)
        print(s[second])
        
        let sixth = s.index(second, offsetBy: 4)
        print(s[sixth])
        
        let safeIdx = s.index(s.startIndex, offsetBy: 400, limitedBy: s.endIndex)
        print(safeIdx)
        
        print(s[..<s.index(s.startIndex, offsetBy: 4)])
        print(s.prefix(4))
        
        for (i, c) in "hello".enumerated() {
            print("\(i): \(c)")
        }
        
        var hello2 = "Hello!"
        if let idx = hello2.index(of: "!") {
            hello2.insert(contentsOf: ", world", at: idx)
        }
        print(hello2)
        
        let sentence = "The quick brown fox jumped over the lazy dog."
        let firstSpace = sentence.index(of: " ") ?? sentence.endIndex
        let firstWord = sentence[..<firstSpace]
        print(firstWord)
        print(type(of: firstWord))
        
        let poem = """
            Over the wintry
            forest, winds howl in rage
            with no leaves to blow
            """
        let lines = poem.split(separator: "\n")
        print(lines)
        print(type(of: lines))
        
        print(sentence.wrapped(after: 15))
        print("Hello, world!".split(separators: ",!"))
        
        print(lastWord(in: "one, two, three, four, five"))
        
        let substring = sentence[...]
        print(substring)
        
        let commaSeparatedNumbers = "1,2,3,4,5"
        let numbers = commaSeparatedNumbers.split(separator: ",").flatMap {Int($0)}
        print(numbers)
        
        let pokemon = "Poke\u{301}mon"
        if let index = pokemon.index(of: "é") {
            let scalar = pokemon.unicodeScalars[index]
            print(String(scalar))
        }
        
        if let accentIndex = pokemon.unicodeScalars.index(of: "\u{301}") {
            accentIndex.samePosition(in: pokemon)
        }
        
        let sentence2 = """
            The quick brown fox jumped \
            over the lazy dog.
            """
        var words: [String] = []
        sentence2.enumerateSubstrings(in: sentence2.startIndex..., options: .byWords) {
            (word, range, _, _) in
            guard let word = word else {return}
            words.append(word)
        }
        print(words)
        
        let text = "☞ Click here for more info."
        let linkTarget = URL(string: "https://www.youtube.com/watch?v=DLzxrzFCyOs")!
        let formatted = NSMutableAttributedString(string: text)
        if let linkRange = formatted.string.range(of: "Click here") {
            let nsRange = NSRange(linkRange, in: formatted.string)
            formatted.addAttribute(.link, value: linkTarget, range: nsRange)
        }
        
        if let queryRange = formatted.string.range(of: "here"), let utf16Index = String.Index(queryRange.lowerBound, within: formatted.string.utf16) {
            let utf16Offset = utf16Index.encodedOffset
            var attributesRange = UnsafeMutablePointer<NSRange>.allocate(capacity: 1)
            defer {
                attributesRange.deinitialize(count: 1)
                attributesRange.deallocate(capacity: 1)
            }
            
            let attributes = formatted.attributes(at: utf16Offset, effectiveRange: attributesRange)
            print(attributesRange.pointee)
            
            if let effectiveRange = Range(attributesRange.pointee, in: formatted.string) {
                print(formatted.string[effectiveRange])
            }
        }
        
        let lowercaseLetters = ("a" as Character)..."z"
//        Type 'ClosedRange<Character>' does not conform to protocol 'Sequence'
//        for c in lowercaseLetters {
//
//        }
        print(lowercaseLetters.contains("A"))
        print(lowercaseLetters.contains("é"))

        let lowercase = ("a" as Unicode.Scalar)..."z"
        print(Array(lowercase.map(Character.init)))
        
        let code = "struct Array<Element>: Collection {}"
        print(code.words())
        
        print(Regex("^h..lo*!$").match("hellooooo!"))
        
        let r: Regex = "^h..lo*!$"
        func findMatches(in strings: [String], regex: Regex) -> [String] {
            return strings.filter {regex.match($0)}
        }
        print(findMatches(in: ["foo", "bar", "baz"], regex: "^b.."))
        
        print(Regex("colou?r"))
        
        var s1 = ""
        let numbers1 = [1, 2, 3, 4]
        print(numbers1, to: &s1)
        print(s1)
        
        var stream = ArrayStream()
        print("Hello", to: &stream)
        print("World", to: &stream)
        print(stream.buffer)
        
        var utf8Data = Data()
        var string = "café"
        print(utf8Data.write(string))
        
        var textRepresentation = ""
        let queue: FIFOQueue = [1, 2, 3]
        queue.write(to: &textRepresentation)
        print(textRepresentation)
        
        let slow: SlowStreamer = [
            "You'll see that this gets",
            "written slowly line by line",
            "to the standard output"
        ]
        print(slow)
        
        var standarderror = StdErr()
        print("oops!", to: &standarderror)
        print(standarderror)
        
        var replacer = ReplacingStream(replacing: [
            "in the cloud" : "on someone else's computer"
        ])
        
        let source = "People find it convenient to store their data in the cloud."
        print(source, terminator: "", to: &replacer)
        
        var output = ""
        print(replacer, terminator: "", to: &output)
        print(output)
    }
}

//extension NSObject: Equatable {
//    static func ==(lhs: NSObject, rhs: NSObject) -> Bool {
//        return lhs.isEqual(rhs)
//    }
//}

extension StringTransform {
    static let toUnicodeName = StringTransform(rawValue: "Any-Name")
}

extension Unicode.Scalar {
    var unicodeName: String {
        let name = String(self).applyingTransform(.toUnicodeName, reverse: false)!
        let prefixPattern = "\\N{"
        let suffixPattern = "}"
        let prefixLength = name.hasPrefix(prefixPattern) ? prefixPattern.count : 0
        let suffixLength = name.hasSuffix(suffixPattern) ? suffixPattern.count : 0
        return String(name.dropFirst(prefixLength).dropLast(suffixLength))
    }
}

extension String {
    var allPrefixes1: [Substring] {
        return (0...self.count).map(self.prefix)
    }
}

extension String {
    var allPrefixes2: [Substring] {
        return [""] + self.indices.map {index in self[...index]}
    }
}

//extension Collection where Element: Equatable {
//    public func split(separator: Element, maxSplits: Int = Int.max, omittingEmptySubquences: Bool = true) -> [SubSequence]
//}

extension String {
    func wrapped(after: Int = 70) -> String {
        var i = 0
        let lines = self.split(omittingEmptySubsequences: false) {
            character in
            switch character {
            case "\n" where i >= after:
                i = 0
                return true
            default:
                i += 1
                return false
            }
        }
        return lines.joined(separator: "\n")
    }
}

extension Collection where Element: Equatable {
    func split<S: Sequence>(separators: S) -> [SubSequence] where Element == S.Element {
        return split{separators.contains($0)}
    }
}

func lastWord(in input: String) -> String? {
    let words = input.split(separators: [",", " "])
    guard let lastWord = words.last else {return nil}
    return String(lastWord)
}

//extension Sequence where Element: StringProtocol {
//    public func joined(separator: String = "") -> String
//}

extension Unicode.Scalar: Strideable {
    public typealias Stride = Int
    
    public func distance(to other: Unicode.Scalar) -> Int {
        return Int(other.value) - Int(self.value)
    }
    
    public func advanced(by n: Int) -> Unicode.Scalar {
        return Unicode.Scalar(UInt32(Int(value) + n))!
    }
}

extension String {
    func words(with charset: CharacterSet = .alphanumerics) -> [Substring] {
        return self.unicodeScalars.split {
            !charset.contains($0)
        }.map(Substring.init)
    }
}

//public struct Character {
//    internal enum Representation {
//        case smallUTF16(Builtin.Int63)
//        case large(Buffer)
//    }
//    internal var _representation: Representation
//}

public struct Regex {
    private let regexp: String
    
    public init(_ regexp: String) {
        self.regexp = regexp
    }
}

extension Regex {
    
    public func match(_ text: String) -> Bool {
        if regexp.first == "^" {
            return Regex.matchHere(regexp: regexp.dropFirst(), text: text[...])
        }
        var idx = text.startIndex
        while true {
            if Regex.matchHere(regexp: regexp[...], text: text.suffix(from: idx)) {
                return true
            }
            guard idx != text.endIndex else {break}
            text.formIndex(after: &idx)
        }
        return false
    }
}

extension Regex {
    private static func matchHere(regexp: Substring, text: Substring) -> Bool {
        if regexp.isEmpty {
            return true
        }
        if let c = regexp.first, regexp.dropFirst().first == "*" {
            return matchStar(character: c, regexp: regexp.dropFirst(2), text: text)
        }
        if regexp.first == "$" && regexp.dropFirst().isEmpty {
            return text.isEmpty
        }
        if let tc = text.first, let rc = regexp.first, rc == "." || tc == rc {
            return matchHere(regexp: regexp.dropFirst(), text:text.dropFirst())
        }
        return false
    }
    
    private static func matchStar(character c: Character, regexp: Substring, text: Substring) -> Bool {
        var idx = text.startIndex
        while true {
            if matchHere(regexp: regexp, text: text.suffix(from: idx)) {
                return true
            }
            if idx == text.endIndex || (text[idx] != c && c != ".") {
                return false
            }
            text.formIndex(after: &idx)
        }
    }
}

extension Regex: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        regexp = value
    }
}

extension Regex: CustomStringConvertible {
    public var description: String {
        return "/\(regexp)/"
    }
}

extension Regex: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "{expression: \(regexp)}"
    }
}

extension FIFOQueue: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        let elements = map {String(describing: $0)}.joined(separator: ", ")
        return "[\(elements)]"
    }
    public var debugDescription: String {
        let elements = map {String(reflecting: $0)}.joined(separator: ", ")
        return "FIFOQueue: [\(elements)]"
    }
}

//public func print<Target: TextOutputStream>(_ items: Any..., separator: String = " ". terminator: String = "\n", to output: inout Target)

struct ArrayStream: TextOutputStream {
    var buffer: [String] = []
    mutating func write(_ string: String) {
        buffer.append(string)
    }
}

extension Data: TextOutputStream {
    mutating public func write(_ string: String) {
        self.append(contentsOf: string.utf8)
    }
}

extension FIFOQueue: TextOutputStreamable {
    func write<Target>(to target: inout Target) where Target : TextOutputStream {
        target.write("[")
        target.write(map {String(describing: $0)}.joined(separator: ","))
        target.write("]")
    }
}

struct SlowStreamer: TextOutputStreamable, ExpressibleByArrayLiteral {
    let contents: [String]
    
    init(arrayLiteral elements: String...) {
        contents = elements
    }
    
    func write<Target>(to target: inout Target) where Target : TextOutputStream {
        for x in contents {
            target.write(x)
            target.write("\n")
            sleep(1)
        }
    }
}

struct StdErr: TextOutputStream {
    mutating func write(_ string: String) {
        guard !string.isEmpty else {return}
        fputs(string, stderr)
    }
}

struct ReplacingStream: TextOutputStream, TextOutputStreamable {
    let toReplace: DictionaryLiteral<String, String>
    private var output = ""
    
    init(replacing toReplace: DictionaryLiteral<String, String>) {
        self.toReplace = toReplace
    }
    
    mutating func write(_ string: String) {
        let toWrite = toReplace.reduce(string) {partialResult, pair in
            partialResult.replacingOccurrences(of: pair.key, with: pair.value)
        }
        print(toWrite, terminator: "", to: &output)
    }
    
    func write<Target>(to target: inout Target) where Target : TextOutputStream {
        output.write(to: &target)
    }
}

protocol StringViewSelector {
    associatedtype View: Collection
    
    static var caret: View.Element {get}
    static var asterisk: View.Element {get}
    static var period: View.Element {get}
    static var dollar: View.Element {get}
    
    static func view(from s: String) -> View
}

struct UTF8ViewSelector: StringViewSelector {
    static var caret: UInt8 {return UInt8(ascii: "^")}
    static var asterisk: UInt8 {return UInt8(ascii: "*")}
    static var period: UInt8 {return UInt8(ascii: ".")}
    static var dollar: UInt8 {return UInt8(ascii: "$")}
    
    static func view(from s: String) -> String.UTF8View {
        return s.utf8
    }
}

struct CharacterViewSelector: StringViewSelector {
    static var caret: Character {return "^"}
    static var asterisk: Character {return "*"}
    static var period: Character {return "."}
    static var dollar: Character {return "$"}
    
    static func view(from s: String) -> String {
        return s
    }
}
