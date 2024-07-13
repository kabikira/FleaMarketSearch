//
//  WebView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/16.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var webView = WKWebView()
    var progressView = UIProgressView()

    let url: String

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // WebViewの読み込み状況を監視する
        func addProgressObserver() {
            parent.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }

        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            // progressViewのアニメーション処理
            if keyPath == "estimatedProgress" {
                parent.progressView.alpha = 1.0
                parent.progressView.setProgress(Float(parent.webView.estimatedProgress), animated: true)

                if parent.webView.estimatedProgress >= 1.0 {
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
                        self?.parent.progressView.alpha = 0.0
                    }, completion: { (finished: Bool) in
                        self.parent.progressView.setProgress(0.0, animated: false)
                    })
                }
            }
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
        webView.navigationDelegate = context.coordinator
        webView.addSubview(progressView)

        // UIProgressViewのレイアウト設定
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.widthAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 1.0).isActive = true
        progressView.topAnchor.constraint(equalTo: webView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        progressView.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0).isActive = true

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.addProgressObserver()
        webView.allowsBackForwardNavigationGestures = true
        guard let url = URL(string: url) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
