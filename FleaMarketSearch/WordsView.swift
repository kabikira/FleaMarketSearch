//
//  WordsView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/17.
//

import SwiftUI

struct WordsView: View {
    @Binding var showingSheet: Bool
    @Binding var words: [String]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(0 ..< words.count, id: \.self) { index in
                        
                        Button (action: {
                            
                            // シート切り替え
                            showingSheet.toggle()
                            
                        }) {
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
