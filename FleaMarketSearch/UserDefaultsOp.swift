//
//  UserDefaultsOp.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/17.
//

import Foundation

class UserDefaultsOp {
    var userDefaults = UserDefaults.standard
    
    func wordsSet(words: [String]) {
        userDefaults.set(words, forKey: "searchedWords")
        //        print("wordsSet", userDefaults.stringArray(forKey: "searchedWords"))
        
        
    }
    func countRemove() {
        var countRemove: [String] = userDefaults.stringArray(forKey: "searchedWords")!
        if countRemove.count > 20 {
            countRemove.removeFirst()
            wordsSet(words: countRemove)
        }
    }
    func orderedSet(words: [String]) ->[String] {
        let orderedSet = NSOrderedSet(array: words)
        let uniqueValeus = orderedSet.array as! [String]
        return uniqueValeus
        
    }
    func readWords() -> [String] {
        guard let readWords: [String] = userDefaults.stringArray(forKey: "searchedWords") else {
            return []
        }
        print("getWords",readWords)
        return readWords
    }
    
}
