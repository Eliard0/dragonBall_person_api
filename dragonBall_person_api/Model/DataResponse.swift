//
//  DataResponse.swift
//  dragonBall_person_api
//
//  Created by Eliardo Venancio on 29/10/24.
//

import Foundation

struct DataResponse: Decodable {
    let items: [Data]
    let meta: Meta
    let links: Links
}

struct Meta: Decodable {
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
}

struct Links: Decodable {
    let first: String
    let previous: String?
    let next: String?
    let last: String
}
