//
//  Comic.swift
//  MarvelAPI
//
//  Created by Ömer Varoğlu on 1.06.2020.
//  Copyright © 2020 Omer Varoglu. All rights reserved.
//

import Foundation


struct ComicsResult: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: ComicDataClass?
}

struct ComicDataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [Comic]?
}

struct Comic: Codable {
    let id, digitalID: Int?
    let title: String?
    let issueNumber: Int?
    let resultDescription: String??
    let pageCount: Int?
    let resourceURI: String?
    let urls: [URLElementForComics]?
    let series: Series?
    let variants: [Series]?
    let dates: [DateElement]?
    let thumbnail: Thumbnail?
    let images: [Thumbnail]?
    let characters: Characters?
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Series]?
    let returned: Int?
}

// MARK: - Series
struct Series: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - DateElement
struct DateElement: Codable {
    let type: DateType?
    let date: String?
}

enum DateType: String, Codable {
    case digitalPurchaseDate
    case focDate
    case onsaleDate
    case unlimitedDate
}

enum Format: String, Codable {
    case comic
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String?
    let name: String?
    let type: ItemType?
}

enum ItemType: String, Codable {
    case cover
    case interiorStory
}

// MARK: - TextObject
struct TextObject: Codable {
    let type: TextObjectType
    let language: Language
    let text: String?
}

enum Language: String, Codable{
    case enUs
}

enum TextObjectType: String, Codable{
    case issuePreviewText
    case issueSolicitText
}

// MARK: - URLElement
struct URLElementForComics: Codable {
    let type: URLTypeForComics?
    let url: String?
}

enum URLTypeForComics: String, Codable {
    case detail
    case inAppLink
    case purchase
    case reader
}


