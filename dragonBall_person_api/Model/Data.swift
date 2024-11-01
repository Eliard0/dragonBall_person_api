//
//  data.swift
//  dragonBall_person_api
//
//  Created by Eliardo Venancio on 29/10/24.
//

struct Data: Decodable {
    let id: Int
    let name: String
    let image: String?
    let ki: String
    let maxKi: String
    let race: String
}

