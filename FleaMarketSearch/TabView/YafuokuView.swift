//
//  YafuokuView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/17.
//

import SwiftUI

struct YafuokuView: View {
    private let yafuokuUrl = "https://auctions.yahoo.co.jp/search/search?aq=-1&auccat=&ei=utf-8&fr=auc_top&oq=&p="
    @Binding var isShowView: Bool
    @Binding var word: String
    
    var body: some View {
        VStack {
            VStack {
                BackButtonView(isShowView: $isShowView)
            }
            // エンコーディング
            let encodeString = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            WebView(url: yafuokuUrl + "\(encodeString!)")
        }
    }
}
