//
//  WebView.swift
//  FleaMarketSearch
//
//  Created by koala panda on 2022/11/16.
//

import SwiftUI
import WebKit

final class WebViewStore: NSObject, ObservableObject, WKNavigationDelegate {
    let webView: WKWebView
    let progressView: UIProgressView

    private var progressObservation: NSKeyValueObservation?
    private(set) var lastLoadedURL: String?

    override init() {
        webView = WKWebView()
        progressView = UIProgressView()
        super.init()
        webView.navigationDelegate = self
        observeProgress()
    }

    deinit {
        progressObservation?.invalidate()
    }

    func loadIfNeeded(urlString: String) {
        guard lastLoadedURL != urlString, let requestURL = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: requestURL)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.webView.load(request)
            self.lastLoadedURL = urlString
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
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
                for (let mutation of mutationsList) {
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

    private func observeProgress() {
        progressObservation = webView.observe(\.estimatedProgress, options: .new) { [weak self] webView, _ in
            guard let self else { return }
            DispatchQueue.main.async {
                self.progressView.alpha = 1.0
                self.progressView.setProgress(Float(webView.estimatedProgress), animated: true)

                if webView.estimatedProgress >= 1.0 {
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {
                        self.progressView.alpha = 0.0
                    }, completion: { _ in
                        self.progressView.setProgress(0.0, animated: false)
                    })
                }
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    @ObservedObject var store: WebViewStore
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = store.webView
        if store.progressView.superview == nil {
            webView.addSubview(store.progressView)
            configureLayout(for: store.progressView, in: webView)
        }
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.allowsBackForwardNavigationGestures = true
        store.loadIfNeeded(urlString: url)
    }

    private func configureLayout(for progressView: UIProgressView, in webView: WKWebView) {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.0
        progressView.alpha = 0.0
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 1.0),
            progressView.topAnchor.constraint(equalTo: webView.safeAreaLayoutGuide.topAnchor, constant: 0),
            progressView.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0)
        ])
    }
}
