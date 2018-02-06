//
//  NowPlayingViewController.swift
//  FlixApp
//
//  Created by Robert  Koepp on 2/5/18.
//  Copyright © 2018 Robert Koepp. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 200

        
        // view controller is data source
        tableView.dataSource = self
        
        // force unwrap
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        // always going to pull from network, even if we have data in cache, not always gon do, but want to do so for testing purposed
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        
        // when our network request returns, it will jump back on our main    thread
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
     
        // closure: <#T##(Data?, URLResponse?, Error?) -> Void#>
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // this will run when the network reqeust returns, (asyncronous)
            if let error = error {
                 print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
            }
        }
        
        task.resume()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overViewLabel.text = overview
        
        return cell
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
}
