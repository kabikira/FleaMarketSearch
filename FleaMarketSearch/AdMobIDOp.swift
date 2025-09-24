import Foundation

enum AdMobIDOp {
    private enum Key {
        static let appID = "GADApplicationIdentifier"
        static let bannerUnitID = "GADBannerAdUnitID"
    }

    private static func string(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String, value.isEmpty == false else {
            assertionFailure("Missing AdMob configuration for \(key). Check the assigned .xcconfig file.")
            return ""
        }
        return value
    }

    static var appID: String { string(for: Key.appID) }
    static var bannerUnitID: String { string(for: Key.bannerUnitID) }
}
