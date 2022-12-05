//
//  db_stuff.swift
//  islenskt-taknmal-app
//
//  Created by Óðinn Dagur Bjarnason on 22.11.2022.
//

import Foundation
import SQLite

import SQLite
let path = Bundle.main.path(forResource: "db", ofType: "sqlite3")!
let db = try! Connection(path, readonly: true)

let signs = Table("sign")
let youtube_id = Expression<String>("youtube_id")
let phrase = Expression<String>("phrase")

//let loadedUsers: [User] = try db.prepare(users).map { row in
//    return try row.decode()
//}

struct Phrase: Codable {
    let phrase: String
}

let allSigns: [String] = try! db.prepare(signs).map { row in
    return row[phrase]
}

func printStuff(){
    for s in try! db.prepare(signs) {
        print("id: \(s[youtube_id]), phrase: \(s[phrase])")
        // id: 1, email: alice@mac.com, name: Optional("Alice")
    }
    // SELECT * FROM "users"
}

func getStuff() -> AnySequence<Row>{
    return try! db.prepare(signs)
}
