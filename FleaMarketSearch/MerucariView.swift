//
//  MerucariView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/16.
//

import SwiftUI

struct MerucariView: View {
    let merucariUrl = "https://jp.mercari.com/search?keyword="
    var body: some View {
        VStack {
            WebView(url: merucariUrl)
        }
       
    }
}

struct Merucari_Previews: PreviewProvider {
    static var previews: some View {
        MerucariView()
    }
}
