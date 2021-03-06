//
//  MovieGridViewController.swift
//  flix
//
//  Created by Richard Hsu on 2020/1/25.
//  Copyright © 2020 Richard Hsu. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate   = self
        collectionView.dataSource = self
        
        // ----- Configure layout -----
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let numOfImagesPerRow          = CGFloat(3)
        layout.minimumLineSpacing      = 0
        layout.minimumInteritemSpacing = 0
        
        let width  = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / numOfImagesPerRow
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        // ----- Movies DB API query -----
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
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
                self.collectionView.reloadData()
           }
        }
        task.resume()
    }
    
    // MARK: - UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        // Populate the cell with a poster image
        let movie      = movies[indexPath.item]
        let baseURL    = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL  = URL(string: baseURL + posterPath)
        cell.posterView.af_setImage(withURL: posterURL!)
        
        return cell
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell      = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie     = movies[indexPath.item]
        
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
    }
}
