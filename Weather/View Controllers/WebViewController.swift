//
//  WebViewController.swift
//  Weather
//
//  Created by User on 15.11.2020.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var url: String!
    
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

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    
    // MARK: - WKNavigationDelegate
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
