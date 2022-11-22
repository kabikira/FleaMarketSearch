//
//  HostingTabView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/18.
//

import SwiftUI

struct HostingTabView: View {
    @Binding var isShowView: Bool
    @Binding var word: String
    
    var body: some View {
        VStack {
            TabView() {
                MerucariView(isShowView: $isShowView, word: $word)
                    .tabItem {
                            Image(systemName: "m.square")
                            Text("メルカリ")
                    }.tag(0)
                RakumaView(isShowView: $isShowView, word: $word)
                    .tabItem {
                        Image(systemName: "r.square")
                        Text("ラクマ")
                    }.tag(1)
                YafuokuView(isShowView: $isShowView, word: $word)
                    .tabItem {
                            Image(systemName: "y.square")
                            Text("ヤフオク")
                    }.tag(2)
                PaypayView(isShowView: $isShowView, word: $word)
                    .tabItem {
                        Image(systemName: "p.square")
                        Text("paypay")
                    }.tag(3)
                GoogleView(isShowView: $isShowView, word: $word)
                    .tabItem {
                        Image(systemName: "g.square")
                        Text("グーグル")
                    }.tag(4)
            }
        }
    }
}

//struct HostingTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        HostingTabView()
//    }
//}
