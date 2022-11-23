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
        
        var getWords: [String] = userDefaults.array(forKey: "searchedWords") as! [String]
        
        //userDefaultsに10個より多く要素が入っていたらインデックス0から削除
        if getWords.count > 10 {
            getWords.removeFirst()
            userDefaults.set(getWords, forKey: "searchedWords")
        }
        
        print(getWords)
        
    }
    
    // userDefaultsの配列を渡す
    func passWord() -> [String] {
        let passwords = userDefaults.array(forKey: "searchedWords") as! [String]
        return passwords.reversed()
    }
    
}
