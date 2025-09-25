import SwiftUI

struct ForceUpdateView: View {
    let requirement: RemoteConfigOp.Requirement
    let retryAction: () -> Void

    @Environment(\.openURL) private var openURL

    var body: some View {
        Group {
            switch requirement {
            case .none:
                EmptyView()
            case .required(let url):
                overlay(url: url)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: requirement)
    }

    private func overlay(url: URL) -> some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("新しいバージョンが必要です")
                    .font(.title2.bold())
                Text("最新バージョンへアップデートしてからご利用ください。")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Button {
                    openURL(url)
                } label: {
                    Text("アップデートする")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                Button {
                    retryAction()
                } label: {
                    Text("再読み込み")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(24)
            .frame(maxWidth: 340)
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
