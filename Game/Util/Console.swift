//
//  Console.swift
//  Game
//
//  Created by Rodolphe Desruelles on 16/02/2022.
//

import Foundation


// Console utilities like helpers to get data from the user
enum Console {
    // Getting a string from the console
    static func readString(precededBy message: String? = nil, trimmed: Bool = true) -> String {
        message.map { print($0, terminator: "") }
        
        let result = readLine() ?? ""
        return trimmed ? result.trimmingCharacters(in: CharacterSet.whitespaces) : result
    }
    
    // Getting an Int from the console
    static func readInt(precededBy message: String? = nil) -> Int {
        while true {
            message.map { print($0, terminator: "") }
            
            if let number = Int(readLine() ?? "") {
                return number
            }
            print("Not a number. Retry.")
        }
    }
    
    // Getting an Int a restricted interval from the console
    static func readIntBetween(between: (Int, Int), precededBy message: String? = nil) -> Int {
        let (min, max) = between
        
        while true {
            let text = [message, "(\(min)-\(max)) -> "]
                .compactMap { $0 }
                .joined(separator: " ")
            print(text, terminator: "")
            
            if let input = readLine(), let choice = Int(input), choice >= min, choice <= max {
                return choice
            }
            print("Bad number. Retry.")
        }
    }
    
    // Getting the index of a selected line in a strings array from the console
    static func chooseInMenu(_ choices: [String]) -> Int {
        for (index, label) in choices.enumerated() {
            print("\(index+1). \(label)")
        }
        return readIntBetween(between: (1, choices.count)) - 1
    }
    
    // Getting the selected object in an objects array from the console
    static func chooseInArray<T>(_ choices: [T], displayWith labelFn: (T) -> String) -> T {
        for (index, t) in choices.enumerated() {
            print("\(index+1). \(labelFn(t))")
        }
        let chosenIndex = readIntBetween(between: (1, choices.count)) - 1
        return choices[chosenIndex]
    }
    
    // Getting the selected case among all case of an enum from the console
    static func chooseInEnum<T: RawRepresentable & CaseIterable>(_: T.Type) -> T
        where T.RawValue: StringProtocol
    {
        let choices = T.allCases.map { $0.rawValue.capitalized }
        
        let chosenIndex = Console.chooseInMenu(choices)
        return T.allCases[chosenIndex as! T.AllCases.Index]
    }
    
    // Asking a question and waiting for yes (y) or no (n) in the console
    static func readYesNo(precededBy message: String? = nil) -> Bool {
        while true {
            let text = [message, "(yes/no) -> "]
                .compactMap { $0 }
                .joined(separator: " ")
            print(text, terminator: "")
            
            if let input = readLine() {
                if input.isEmpty {
                    continue
                } else if "yes".starts(with: input.lowercased()) {
                    return true
                } else if "no".starts(with: input.lowercased()) {
                    return false
                }
            }
            print("Bad response. Retry.")
        }
    }
}
