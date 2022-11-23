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
            showingSheet.toggle()
            words = userDefaultsOp.wordsSet(words: words)
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
            // 一旦配列に保存し
            if word != "" {
                words.append(word)
                print("ContentView",words)
                // ここにユーザデフォルトに保存する処理
                words = userDefaultsOp.wordsSet(words: words)
            }
            
        } label: {
            Text("検索")
                .font(.title2)
                .frame(width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.width/8)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct WordsView: View {
    @Binding var showingSheet: Bool
    @Binding var word: String
    @Binding var words: [String]
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0 ..< words.count, id: \.self) { index in
                        
                        Button {
                            
                            // 検索ワードに追加
                            word = words[index]
                            // シート切り替え
                            showingSheet.toggle()
                            
                            
                        } label: {
                            Text(words[index])
                            
                        }
                    }
                }
            }
            .navigationTitle("検索履歴")
        }
    }
}
