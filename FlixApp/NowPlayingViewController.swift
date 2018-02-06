//
//  NowPlayingViewController.swift
//  FlixApp
//
//  Created by Robert  Koepp on 2/5/18.
//  Copyright © 2018 Robert Koepp. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // force unwrap
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        // always going to pull from network, even if we have data in cache, not always gon do, but want to do so for testing purposed
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        
        // when our network request returns, it will jump back on our main thread
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
     
        // closure: <#T##(Data?, URLResponse?, Error?) -> Void#>
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // this will run when the network reqeust returns, (asyncronous)
            if let error = error {
                 print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                for movie in movies {
                    let title = movie["title"] as! String
                    print(title)
                }
            }
        }
        
        task.resume()
        
    }

    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
}
