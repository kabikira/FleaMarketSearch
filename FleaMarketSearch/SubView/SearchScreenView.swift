//
//  SearchScreenView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/22.
//

import SwiftUI

struct SearchScreenView: View {
    @Binding var word: String
    var body: some View {
        ZStack {
            // 背景
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(red: 239 / 255,
                            green: 239 / 255,
                            blue: 241 / 255))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width/10)
            HStack {
                // 虫眼鏡
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                // テキストフィールド
                TextField("なにをお探しですか？", text: $word)
                    .foregroundColor(.black)
                
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
    }
}
