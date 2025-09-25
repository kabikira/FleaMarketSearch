import SwiftUI
import GoogleMobileAds

struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GoogleMobileAds.BannerView {
        let banner = GoogleMobileAds.BannerView(adSize: AdSizeBanner)
        if let unitID = Bundle.main.object(forInfoDictionaryKey: "GADBannerAdUnitID") as? String,
           unitID.isEmpty == false {
            banner.adUnitID = unitID
        } else {
            assertionFailure("GADBannerUnitID が Info.plist から取得できません")
            banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        }

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            banner.rootViewController = rootVC
        }

        banner.load(Request())
        return banner
    }

    func updateUIView(_ uiView: GoogleMobileAds.BannerView, context: Context) {
    }
}
