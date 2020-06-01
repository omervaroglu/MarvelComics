//
//  HeroModel.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 31.05.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation

struct ResultData: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [Hero]?
}

struct Hero: Codable {
    let id: Int?
    let name, resultDescription: String?
    let modified: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let urls: [URLElement]?
    var savedImagePath : String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, urls
    }
}

struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
enum Extension: String, Codable {
    case gif = ".gif"
    case jpg = ".jpg"
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType?
    let url: String?
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
