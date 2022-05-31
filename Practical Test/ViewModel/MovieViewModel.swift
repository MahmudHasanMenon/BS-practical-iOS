//
//  ImageListViewModel.swift
//  Gradpos-Image-listing
//
//  Created by localadmin on 17/5/2022.
//

import Foundation
import UIKit

class MovieViewModel {
    
    private var movieService: MovieService?
    private var view: UIView!
    var movieArray: [MovieData] = []
    var searchMovieArray: [MovieData] = []
    
    init() {}

    init(_ view: UIView) {
        self.view = view
        self.movieService = MovieService(apiClient: APIClient())
    }
    
    // MARK: - API Handlers
    
    func getMoviewLists(queryText: String, _completion: @escaping (Bool) -> ()) {
        self.movieService?.getMovieList(queryText: queryText, completion: { (data, error, statusCode) in
            do{
                if error == nil {
                    if let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        if let results = jsonData["results"] as? Array<Any> {
//                            print("jsonData...\(jsonData)")
                            for i in 0..<results.count {
                                let movie = results[i] as? Dictionary<String, Any>
                                if let title = movie!["original_title"] as? String{
                                    if let overView = movie!["overview"] as? String{
                                        if let poster_path = movie!["poster_path"] as? String{
                                            let movieData = MovieData(overview: overView, title: title, bannerPath: poster_path)
                                            self.movieArray.append(movieData)
                                        }
                                    }
                                }
                            }
                            print("self.movieArray...\(self.movieArray)")
                            _completion(true)
                        }
                    }
                     
                
                }
                
            }catch{
                print("Error in get json data..>!!")
            }
             
        })
    }
    
    
    func getSearchMoviewLists(queryText: String, _completion: @escaping (Bool) -> ()) {


        self.movieService?.getMovieList(queryText: queryText, completion: { (data, error, statusCode) in
//            print("data...\(data)")
            print("error...\(error)")
            do{
                if error == nil {
                    if let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                     {
                        if let results = jsonData["results"] as? Array<Any> {
//                            print("jsonData...\(jsonData)")
                            self.searchMovieArray = []
                            for i in 0..<results.count {
                                let movie = results[i] as? Dictionary<String, Any>
                                if let title = movie!["original_title"] as? String{
                                    if let overView = movie!["overview"] as? String{
                                        if let poster_path = movie!["poster_path"] as? String{
                                            let movieData = MovieData(overview: overView, title: title, bannerPath: poster_path)
                                            self.searchMovieArray.append(movieData)
                                        }
                                    }
                                }
                            }
                            _completion(true)
                        }
                    }
                     
                }
                
            }catch{
                print("Error in get json data..>!!")
            }
             
        })
    }
 
 
}

