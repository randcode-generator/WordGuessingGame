//
//  WordList.swift
//  WordMaker
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit

class WordList {
    var words: [String] = ["ARGUE", "ARRAY", "FUN", "FUNNY"];
    var word = ""
    init() {
        let count: UInt32 = UInt32(words.count)
        let index = Int(arc4random_uniform(count))
        word = words[index]
    }
    
    func getRandomWord() -> String {
        return word
    }
    
    func getRandomWordAsArray() -> [String] {
        var letters: [String] = [];
        for letter in word.characters {
            letters.append(String(letter))
        }
        return letters
    }
}
