//
//  MerucariView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/16.
//

import SwiftUI

struct MerucariView: View {
    private let merucariUrl = "https://jp.mercari.com/search?keyword="
    @ObservedObject var store: WebViewStore
    @Binding var isShowView: Bool
    @Binding var word: String

    var body: some View {
        VStack {
            VStack {
                BackButtonView(isShowView: $isShowView)
            }
            // エンコーディング
            let encodeString = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            WebView(store: store, url: merucariUrl + encodeString)
        }
    }
}

//struct Merucari_Previews: PreviewProvider {
//    static var previews: some View {
//        MerucariView(isShowSubView: .constant(false))
//    }
//}
