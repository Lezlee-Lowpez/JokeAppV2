//
//  JokeResponse.swift
//  JokesAppV2
//
//  Created by Lesley Lopez on 8/7/24.
//

import Foundation

struct JokeResponse: Codable {
    
    var error: Bool?
    var category: String?
    var type: String?
    var joke: String?
    var flags: Flag?
    var id: Int?
    var safe: Bool?
    var lang: String?
}

struct Flag: Codable {
    
    var nsfw: Bool?
    var religious: Bool?
    var political: Bool?
    var racist: Bool?
    var sexist: Bool?
    var explicit: Bool?
}
