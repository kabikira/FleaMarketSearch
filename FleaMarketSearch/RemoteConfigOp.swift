import Foundation
import Combine
import FirebaseRemoteConfig

@MainActor
final class RemoteConfigOp: ObservableObject {
    enum Requirement: Equatable {
        case none
        case required(URL)
    }

    @Published private(set) var requirement: Requirement = .none

    private let remoteConfig: RemoteConfig
    private let appVersionComponents: [Int]

    init(remoteConfig: RemoteConfig = .remoteConfig()) {
        self.remoteConfig = remoteConfig
        let bundleVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
        appVersionComponents = Self.versionComponents(from: bundleVersion)
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 3600
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults([
            RemoteConfigKey.minimumSupportedVersion.rawValue: NSString(string: bundleVersion),
            RemoteConfigKey.forceUpdateURL.rawValue: NSString(string: "")
        ])
        updateRequirement()
    }

    func refresh(force: Bool = false) async {
        do {
            try await fetchRemoteConfig(force: force)
            try await activateRemoteConfig()
            updateRequirement()
        } catch {
            print("RemoteConfig fetch failed: \(error.localizedDescription)")
        }
    }

    private func fetchRemoteConfig(force: Bool) async throws {
        let expiration: TimeInterval = force ? 0 : remoteConfig.configSettings.minimumFetchInterval
        _ = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<RemoteConfigFetchStatus, Error>) in
            remoteConfig.fetch(withExpirationDuration: expiration) { status, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: status)
                }
            }
        }
    }

    private func activateRemoteConfig() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            remoteConfig.activate { _, error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }

    private func updateRequirement() {
        let minimumString = remoteConfig[RemoteConfigKey.minimumSupportedVersion.rawValue].stringValue
        let minimumComponents = Self.versionComponents(from: minimumString)
        let urlString = remoteConfig[RemoteConfigKey.forceUpdateURL.rawValue].stringValue
        guard
            !urlString.isEmpty,
            let url = URL(string: urlString),
            Self.isCurrentVersion(appVersionComponents, lowerThan: minimumComponents)
        else {
            requirement = .none
            return
        }
        requirement = .required(url)
    }

    private static func versionComponents(from version: String) -> [Int] {
        version.split(separator: ".").compactMap { Int($0) }
    }

    private static func isCurrentVersion(_ current: [Int], lowerThan minimum: [Int]) -> Bool {
        let maxCount = max(current.count, minimum.count)
        for index in 0..<maxCount {
            let currentValue = index < current.count ? current[index] : 0
            let minimumValue = index < minimum.count ? minimum[index] : 0
            if currentValue < minimumValue {
                return true
            }
            if currentValue > minimumValue {
                return false
            }
        }
        return false
    }
}

private enum RemoteConfigKey: String {
    case minimumSupportedVersion = "minimum_supported_version"
    case forceUpdateURL = "force_update_url"
}
