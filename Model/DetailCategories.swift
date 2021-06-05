//
//  DetailCategories.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on June 3, 2021

import Foundation

struct DetailCategories : Codable {

        let categories : [Category]?

        enum CodingKeys: String, CodingKey {
                case categories = "categories"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                categories = try values.decodeIfPresent([Category].self, forKey: .categories)
        }

}
