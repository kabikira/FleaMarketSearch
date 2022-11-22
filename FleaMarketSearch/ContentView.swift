//
//  ContentView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/13.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingView: Bool = false
    @State var word = ""
    @State var words: [String] = []
    @State var showingSheet: Bool = false
    
    var userDefaultsOp = UserDefaultsOp()
    var body: some View {
        VStack {
            
            if isShowingView {
                HostingTabView(isShowView: $isShowingView, word: $word)
            } else {
                SearchScreenView(word: $word)
                Spacer()
                    .frame(height: 30)
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
                            .font(.title)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                    }
                    .buttonStyle(.borderedProminent)
                    
                
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Text("履歴")
                            .font(.title)
                            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/6)
                    }
                
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $showingSheet) {
                        WordsView(showingSheet: $showingSheet, word: $word, words: $words)
                    }
                Spacer()
                    .frame(height: 100)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
