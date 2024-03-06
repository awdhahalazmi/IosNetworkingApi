//
//  Pets.swift
//  Networking and ApiTask
//
//  Created by Awdhah Alazemi on 04/03/2024.
//

import Foundation

struct Pet: Codable{
    var id: Int? = 0
    let name: String
    let image: String
    let age: Int
    let gender: String
    let adopted: Bool
    
}
