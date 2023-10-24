//
//  Model.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import Foundation
struct MenuList: Codable {
    let menu: [MenuItem]
}


struct MenuItem: Codable, Identifiable {
    let id : Int
    let title: String
    let price: String
    let description: String
    let image: String
    let category: String
}
