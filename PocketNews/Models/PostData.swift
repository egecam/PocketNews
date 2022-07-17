//
//  PostData.swift
//  PocketNews
//
//  Created by Ege Çam on 16.07.2022.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
    let created_at: String
    let author: String
}
