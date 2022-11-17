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
                MerucariView(isShowSubView: $isShowingView, word: $word)
            } else {
                ZStack {
                    // 背景
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 239 / 255,
                                    green: 239 / 255,
                                    blue: 241 / 255))
                        .frame(height: 46)
                    HStack {
                        // 虫眼鏡
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        // テキストフィールド
                        TextField("ここで検索！", text: $word)
                        
                        // 検索文字が空ではない場合は、クリアボタンを表示
                        if !word.isEmpty {
                            Button {
                                word.removeAll()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 6)
                        }
                    }
                }
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
                }
                Button {
                    showingSheet.toggle()
                } label: {
                    Text("履歴")
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
