//
//  News.swift
//  EvaClub
//
//  Created by D K on 25.10.2024.
//

import Foundation

class News: Codable {
    var title: String
    var body: String
    var image: String
 
    init(title: String, body: String, image: String) {
        self.title = title
        self.body = body
        self.image = image
    }
}

extension News {
    static func MOCK() -> News {
            return News(title: "New Club Opening in the City Center", body: "The gaming club network has opened a new location in the heart of the city. Spacious rooms, the latest gaming consoles, and high-speed internet are now ready for the first visitors!", image: "https://i.ibb.co/0DfNnP2/1.webp")
    }
}
