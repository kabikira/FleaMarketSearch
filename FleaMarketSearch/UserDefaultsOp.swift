//
//  UserDefaultsOp.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/17.
//

import Foundation

class UserDefaultsOp {
    var userDefaults = UserDefaults.standard
    
    func wordsSet(words: [String]) -> [String] {
        
        userDefaults.set(words, forKey: "searchedWords")
        
        let seachWords: [String] = userDefaults.array(forKey: "searchedWords") as! [String]
        
        // 重複したキーワードをならびかえずに除去
        let orderedSet = NSOrderedSet(array: seachWords)
        var uniqueValeus = orderedSet.array as! [String]
        
        //userDefaultsに10個より多く要素が入っていたらインデックス0から削除
        if uniqueValeus.count > 10 {
            uniqueValeus.removeFirst()
            userDefaults.set(uniqueValeus, forKey: "searchedWords")
        }
        
        print(uniqueValeus)
        return uniqueValeus
        
    }
    
    
}
