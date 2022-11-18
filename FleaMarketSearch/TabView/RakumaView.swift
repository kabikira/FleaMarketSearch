//
//  RakumaView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/17.
//

import SwiftUI

struct RakumaView: View {
    private let rakumaUrl = "https://fril.jp/s?query="
    @Binding var isShowView: Bool
    @Binding var word: String
    
    var body: some View {
        VStack {
            VStack {
                BackButtonView(isShowView: $isShowView)
            }
            // エンコーディング
            let encodeString = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            WebView(url: rakumaUrl + "\(encodeString!)")
        }
    }
}
