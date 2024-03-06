//
//  enums.swift
//  Networking and ApiTask
//
//  Created by Awdhah Alazemi on 05/03/2024.
//

import Foundation
enum TagsEnum {
    case name
    case gender
    case age
    case adoption
    case image
    
    
    func TagsToString() -> String{
        switch self{
        case .name: return "name"
        case .gender: return "gender"
        case .age: return "age"
        case .adoption: return "adoption"
        case .image: return "image"
        }
    }
}
