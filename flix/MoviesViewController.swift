//
//  MoviesViewController.swift
//  flix
//
//  Created by Richard Hsu on 2020/1/18.
//  Copyright © 2020 Richard Hsu. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        moviesTableView.delegate   = self
        

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            
                // Store the movies in a property to use elsewhere
                self.movies = dataDictionary["results"] as! [[String: Any]]
            
                // Reload table view data
                self.moviesTableView.reloadData()
           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get movie info from current row
        let movie    = movies[indexPath.row]
        let title    = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        // Initialize the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        // Populate the cell with title and synopsis
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        // Populate the cell with a poster image
        let baseURL    = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL  = URL(string: baseURL + posterPath)
        cell.posterView.af_setImage(withURL: posterURL!)
        
        return cell
    }
}
