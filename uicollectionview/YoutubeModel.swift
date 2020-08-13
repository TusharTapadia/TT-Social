//
//  YoutubeModel.swift
//  uicollectionview
//
//  Created by Tushar Tapadia on 06/08/20.
//  Copyright © 2020 Tushar Tapadia. All rights reserved.
//

import Foundation

struct youtubeResponse {
    let items: [data]
}

struct data:Codable {
    let data: Response
    let count: Int?
}

struct Response: Codable{
    let link: String?
    let thumbnail: String?
}
