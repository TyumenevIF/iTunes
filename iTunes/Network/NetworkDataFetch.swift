//
//  NetworkDataFetch.swift
//  iTunes
//
//  Created by Ilyas Tyumenev on 04.05.2022.
//

import Foundation
import UIKit

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum(urlString: String, response: @escaping (AlbumModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let albums = try JSONDecoder().decode(AlbumModel.self, from: data)
                    response(albums, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
}
