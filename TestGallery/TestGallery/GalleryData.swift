//
//  GalleryData.swift
//  TestGallery
//
//  Created by Александр Воробей on 03.05.2021.
//

import Foundation

struct GalleryData: Decodable {
    let photoURL: String
    let userURL: String
    let userName: String
    let colors: [String]
        
    enum CodingKeys: String, CodingKey {
            case photoURL = "photo_url"
            case userURL = "user_url"
            case userName = "user_name"
            case colors
        }
}

typealias GalleryDictionary = [String: GalleryData]?

