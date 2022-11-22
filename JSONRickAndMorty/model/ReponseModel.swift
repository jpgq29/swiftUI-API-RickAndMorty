//
//  ReponseModel.swift
//  JSONRickAndMorty
//
//  Created by Appa on 21/11/22.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


struct Episodio: Codable {
    let id: Int
    let name: String
}
