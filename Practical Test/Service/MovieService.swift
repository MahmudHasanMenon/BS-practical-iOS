//
//  ImageListService.swift
//  Gradpos-Image-listing
//
//  Created by localadmin on 17/5/2022.
//

import Foundation


class MovieService: NSObject {
    
    private var apiClient: APIClient?
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    
    func getMovieList(queryText: String, completion: @escaping (Data?, Error?, Int?) -> ()) {
        let url = "\(Url.BASE_URL)&query=\(queryText)"
        var urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        self.apiClient?.get(urlString, completion: { (data, error, statusCode) in
            if let error = error {
                completion(nil, error, 400)
                return
            }
            completion(data, nil, statusCode)
        })
    }
 
}


