//
//  DetailsAPI.swift
//  Ecommerce Concept
//
//  Created by USER on 10.12.2022.
//

import Foundation

struct DetailsAPI {
  
    func getDetails(completion: @escaping((Result<ModelDetail, Error>) -> Void)) {
        
        let url = URLComponents(string: URLManager.shared.detailsScreenURL)
        
        guard let url = url?.url else {fatalError()}
        
        let request = URLRequest(url: url)
        
        DispatchQueue.main.async {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: request ) {data, response, error in
                
                if let error = error {
                    completion(.failure(error))
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
                    let result = try JSONDecoder().decode(ModelDetail.self , from: data)
                    
                    completion(.success(result))
                    
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            }
            task.resume()
        }
    }
}

