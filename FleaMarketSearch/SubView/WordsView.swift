//
//  WordsView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/17.
//

import SwiftUI

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

//struct WordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WordsView()
//    }
//}
