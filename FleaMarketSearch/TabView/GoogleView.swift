//
//  GoogleView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/17.
//

import SwiftUI

struct GoogleView: View {
    private let googleUrl = "https://www.google.com/search?q="
    @Binding var isShowView: Bool
    @Binding var word: String
    
    var body: some View {
        VStack {
            // エンコーディング
            let encodeString = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            WebView(url: googleUrl + "\(encodeString!)")
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
