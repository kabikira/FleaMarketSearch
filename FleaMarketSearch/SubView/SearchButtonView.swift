//
//  SearchButtonView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/22.
//

import SwiftUI

struct SearchButtonView: View {
    @Binding var word: String
    @Binding var words: [String]
    @Binding var showingSheet: Bool
    @Binding var isShowingView: Bool
    var userDefaultsOp: UserDefaultsOp
    var body: some View {
        Button {
            // 10個より多く要素が入っていたらインデックス0から削除
            if words.count > 10 {
                words.removeFirst()
            }
            showingSheet.toggle()
        } label: {
            Text("履歴")
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.width/8)
        }
        
        .buttonStyle(.bordered)
        .sheet(isPresented: $showingSheet) {
            WordsView(showingSheet: $showingSheet, word: $word, words: $words)
        }
        
        
        
        Spacer()
            .frame(width: 100)
        Button {
            isShowingView.toggle()
            // 10個より多く要素が入っていたらインデックス0から削除
            if words.count > 10 {
                words.removeFirst()
            }
            // 一旦配列に保存し
            words.append(word)
            print("ContentView",words)
            // ここにユーザデフォルトに保存する処理
            userDefaultsOp.wordsSet(words: words)
        } label: {
            Text("検索")
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.width/8)
        }
        .buttonStyle(.borderedProminent)
    }
}

