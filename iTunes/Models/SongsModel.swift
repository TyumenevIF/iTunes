//
//  SongsModel.swift
//  iTunes_test
//
//  Created by Ilyas Tyumenev on 05.05.2022.
//

import Foundation

struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
