//
//  NetworkRequest.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 04.05.2022.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    private init() { }
    
    func requestData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {        
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)
        guard let url = URL(string: urlString) else { return }

        let task = session.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        task.resume()
    }
}
