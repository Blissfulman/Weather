//
//  WebViewController.swift
//  Weather
//
//  Created by Evgeny Novgorodov on 15.11.2020.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var webView: WKWebView!
    
    // MARK: - Properties
    
    var url: String!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        guard let openingURL = URL(string: url) else { return }
        let urlRequest = URLRequest(url: openingURL)
        webView.load(urlRequest)
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let urlString = navigationAction.request.url?.absoluteString {
            if urlString.contains("https://yandex.ru/pogoda/") {
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
}
