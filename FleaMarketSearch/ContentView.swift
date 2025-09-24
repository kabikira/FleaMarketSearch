//
//  ContentView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/13.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @State var isShowingView: Bool = false
    @State var word = ""
    @State var words:[String] = []
    @State var showingSheet: Bool = false
    
    var userDefaultsOp = UserDefaultsOp()
    var body: some View {
        VStack {
            AdMobBannerView()
                .frame(height: 50)
                .background(Color.white)
            if isShowingView {
                HostingTabView(isShowView: $isShowingView, word: $word)
            } else {
                Spacer()
                    .frame(height: 100)
                VStack {
                    VStack {
                        Text("フリマ")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                        Text("ケンサク")
                                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    }
                    SearchScreenView(word: $word)
                    Spacer()
                        .frame(height: 20)
                    HStack {
                        SearchButtonView(word: $word, words: $words, showingSheet: $showingSheet, isShowingView: $isShowingView, userDefaultsOp: userDefaultsOp)
                    }
                }
                Spacer()
                    .frame(height: 250)
            }
        }
    }
}

struct AdMobBannerView: UIViewRepresentable {

    // SDKの BannerView を返す
    func makeUIView(context: Context) -> GoogleMobileAds.BannerView {
        // v12 以降の新しい型・定数名
        let banner = GoogleMobileAds.BannerView(adSize: AdSizeBanner)
        if let unitID = Bundle.main.object(forInfoDictionaryKey: "GADBannerAdUnitID") as? String,
           unitID.isEmpty == false {
            banner.adUnitID = unitID
        } else {
            assertionFailure("GADBannerUnitID が Info.plist から取得できません")
            banner.adUnitID = "ca-app-pub-3940256099942544/2934735716" // フォールバック用テストID
        }

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            banner.rootViewController = rootVC
        }

        // v12 以降は GADRequest -> Request に変更
        banner.load(Request())
        return banner
    }

    func updateUIView(_ uiView: GoogleMobileAds.BannerView, context: Context) {
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
