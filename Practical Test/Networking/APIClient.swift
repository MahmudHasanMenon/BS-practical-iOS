
import Foundation

struct APIClient {
    
    func get(_ url: String, completion: @escaping (Data?, Error?, Int?) -> ()) {
        if Reachability.isConnectedToNetwork() {
            guard let url = URL(string: url) else {
                        return
                    }
            var request = URLRequest(url: url)
                   request.httpMethod = "GET"
                   
                   URLSession.shared.dataTask(with: request) { data, response, error in
                       if let data = data {
                           completion(data, nil, 200)
                       }
                       if let response = response {
                           
                       }
                       
                   }.resume()
               }
            
            
        }
          
    }
    

    
