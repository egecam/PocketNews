//
//  NetworkManager.swift
//  PocketNews
//
//  Created by Ege Çam on 16.07.2022.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData(tags: String) {
        
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=\(tags)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                                
//                                if tags == "front_page" {
//
//                                } else if tags == "ask_hn" {
//                                    // ask_hn data model
//                                } else {
//                                    // show_hn data model
//                                }
                                
                            }
                        } catch {
                            print(error)
                        }
                        
                    }
                }
            }
            task.resume()
        }
        
        
        
    }
    
    
}
