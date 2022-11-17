//
//  MerucariView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/16.
//

import SwiftUI

struct MerucariView: View {
    let merucariUrl = "https://jp.mercari.com/search?keyword="
    @Binding var isShowView: Bool
    @Binding var word: String
    
    var body: some View {
        VStack {
            // エンコーディング
            let encodeString = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            WebView(url: merucariUrl + "\(encodeString!)")
            VStack {
                Button(action: {
                    self.isShowView = false
                }, label: {
                    Text("戻る")
                })
            }
        }
    }
}

//struct Merucari_Previews: PreviewProvider {
//    static var previews: some View {
//        MerucariView(isShowSubView: .constant(false))
//    }
//}
