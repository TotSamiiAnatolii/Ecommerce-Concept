//
//  MainAPI.swift
//  Ecommerce Concept
//
//  Created by APPLE on 14.12.2022.
//

import UIKit

struct MainAPI {
    
    func getRequestProduct(complition: @escaping((Result<PhotosCoolections, Error>)->())) {
        
        let url = URLComponents(string: URLManager.shared.mainScreenURL)
        
        guard let url = url?.url else {fatalError()}
        
        let request = URLRequest(url: url)
        
        DispatchQueue.main.async {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: request ) {data, response, error in
                
                if let error = error {
                    complition(.failure(error))
                    print(error.localizedDescription)
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200 ... 300 :
                        print("Status: \(response.statusCode)")
                        break
                    default:
                        print("Status: \(response.statusCode)")
                    }
                }
                
                guard let data = data else {return}
                print(data)
                do {
                    let result = try JSONDecoder().decode(PhotosCoolections.self , from: data)
                    
                    complition(.success(result))
                    
                } catch {
                    complition(.failure(error))
                    print(error)
                }
            }
            task.resume()
        }
    }
}
