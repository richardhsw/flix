//
//  MovieDetailsViewController.swift
//  flix
//
//  Created by Richard Hsu on 2020/1/25.
//  Copyright © 2020 Richard Hsu. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String: Any]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Populate labels
        titleLabel.text    = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        // Populate poster image
        let baseURL    = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL  = URL(string: baseURL + posterPath)
        posterView.af_setImage(withURL: posterURL!)
        
        // Populate backdrop image
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL  = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        backdropView.af_setImage(withURL: backdropURL!)
    }
    
    @IBAction func showTrailer(_ sender: Any) {
        performSegue(withIdentifier: "ShowMovieTrailer", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieTrailer" {
            let trailerController = segue.destination as! TrailerViewController
            
            trailerController.movie = movie
        }
    }

}
