//
//  PaypayView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/17.
//

import SwiftUI

struct PaypayView: View {
    private let paypayUrl = "https://paypayfleamarket.yahoo.co.jp"
    @Binding var isShowView: Bool
    @Binding var word: String
    
    var body: some View {
        VStack {
            VStack {
                BackButtonView(isShowView: $isShowView)
            }
            // エンコーディング
            let encodeString = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            // paypayはワードがなにも入ってないと探してるページはありませんになるから文字が空のときはなにも検索してないページにいく
            if encodeString == "" {
                WebView(url: paypayUrl)
            }
            else{
                WebView(url: paypayUrl + "/search/\(encodeString!)")
            }
        }
    }
}
