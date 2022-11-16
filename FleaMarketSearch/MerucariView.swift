//
//  MerucariView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/16.
//

import SwiftUI

struct MerucariView: View {
    let merucariUrl = "https://jp.mercari.com/search?keyword="
    @Binding var isShowSubView: Bool
    var body: some View {
        VStack {
            WebView(url: merucariUrl)
            VStack {
                Button(action: {
                    self.isShowSubView = false
                }, label: {
                    Text("戻る")
                })
            }
        }
    }
}

struct Merucari_Previews: PreviewProvider {
    static var previews: some View {
        MerucariView(isShowSubView: .constant(false))
    }
}
