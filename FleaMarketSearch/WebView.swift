import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // ページ読み込み完了時に呼ばれる
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("読み込み完了")
            let hiddenProfileScript = """
                function hideElement(selector) {
                    let element = document.querySelector(selector);
                    if (element) {
                        element.style.display = 'none';
                    }
                }

                hideElement('.header_wrapper');
                hideElement('.btvTkg');

                // MutationObserverを使って、動的に追加される要素を監視
                const observer = new MutationObserver(function(mutationsList, observer) {
                    for(let mutation of mutationsList) {
                        if (mutation.type === 'childList') {
                            hideElement('.merNavigationBottom');
                            hideElement('.page-header');
                        }
                    }
                });

                observer.observe(document.body, { childList: true, subtree: true });

                // 初回実行
                hideElement('.merNavigationBottom');
                hideElement('.page-header');

                """
            webView.evaluateJavaScript(hiddenProfileScript) { _, error in
                if let error = error {
                    print("JavaScript Error: \(error.localizedDescription)")
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator

        let progressView = UIProgressView(progressViewStyle: .default)
        webView.addSubview(progressView)

        // UIProgressViewのレイアウト設定
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalTo: webView.widthAnchor),
            progressView.topAnchor.constraint(equalTo: webView.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: webView.leadingAnchor)
        ])

        // URLリクエストの作成とロード
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // updateUIViewではなく、makeUIView内で設定するのでここは空でOK
    }
}
