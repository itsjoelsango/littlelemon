//
//  MenuItem.swift
//  LittleLemon
//
//  Created by Jo Michael on 3/6/23.
//

import Foundation

struct MenuItem: Decodable {
    let title: String
    let image: String
    let price: String
    let description: String
    let category: String
    let id: Int64
}
