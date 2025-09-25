//
//  FleaMarketSearchApp.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/13.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport
import FirebaseCore

// AppDelegateでAdMobを初期化
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        MobileAds.shared.start { _ in
        }
        return true
    }
}

@main
struct FleaMarketSearchApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var remoteConfigOp = RemoteConfigOp()
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .onAppear {
                        requestTrackingAuthorization()
                    }
                ForceUpdateView(requirement: remoteConfigOp.requirement) {
                    Task {
                        await remoteConfigOp.refresh(force: true)
                    }
                }
            }
            .task {
                await remoteConfigOp.refresh()
            }
            .onChange(of: scenePhase) { newValue in
                guard newValue == .active else { return }
                Task {
                    await remoteConfigOp.refresh()
                }
            }
        }
    }

    private func requestTrackingAuthorization() {
        // iOS 14以降のみATTをリクエスト
        if #available(iOS 14, *) {
            // ユーザーにUIが落ち着いてから表示するため少し遅延
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .authorized:
                        print("Tracking authorized")
                    case .denied:
                        print("Tracking denied")
                    case .notDetermined:
                        print("Tracking not determined")
                    case .restricted:
                        print("Tracking restricted")
                    @unknown default:
                        print("Unknown tracking status")
                    }
                }
            }
        }
    }
}
