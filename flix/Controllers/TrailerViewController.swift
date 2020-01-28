//
//  TrailerViewController.swift
//  flix
//
//  Created by Richard Hsu on 2020/1/27.
//  Copyright © 2020 Richard Hsu. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet var webView: WKWebView!
    
    var movie: [String: Any]!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://api.themoviedb.org/3/movie/\(movie["id"] ?? "530915")/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // Get the trailer key
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = dataDictionary["results"] as! [[String: Any]]
                let key = results[0]["key"]
                
                // Load YouTube trailer into player
                let videoUrlString = "https://www.youtube.com/watch?v=\(key ?? "SUXWAEX2jlg")"
                let videoURL = URL(string: videoUrlString)
                let myRequest = URLRequest(url: videoURL!)
                self.webView.load(myRequest)
           }
        }
        task.resume()
    }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
