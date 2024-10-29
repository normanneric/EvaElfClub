//
//  NetworkManager.swift
//  EvaClub
//
//  Created by D K on 25.10.2024.
//

import Foundation

class NetworkManager  {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    
    func fetchNews(completion: @escaping ([News]?) -> Void) {
        guard let url = URL(string: "https://api.jsonserve.com/GQKCUs") else {
            print("Error URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let clubs = try decoder.decode([News].self, from: data)
                completion(clubs)
            } catch {
                print("Error JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
}
