//
//  CategoryResponse.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/11/23.
//

import Foundation

struct CategoryResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}
