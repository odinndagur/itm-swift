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
let youtube_link = Expression<String>("youtube_link")
let sign_id = Expression<Int>("id")

//let loadedUsers: [User] = try db.prepare(users).map { row in
//    return try row.decode()
//}

struct Sign: Codable, Identifiable {
    let id: Int
    let phrase: String
    let youtube_id: String
    let youtube_link: String
}

let signList: [Sign] = try! db.prepare(signs).map { row in
    return Sign(
        id: row[sign_id],
        phrase: row[phrase],
        youtube_id: row[youtube_id],
        youtube_link: row[youtube_link]
    )
}


func searchSigns(pattern:String) -> [Sign]{
    let temp = try! db.prepare(signs.filter(phrase.like("%" + pattern + "%"))).map {row in
        return Sign(
            id: row[sign_id],
            phrase: row[phrase],
            youtube_id: row[youtube_id],
            youtube_link: row[youtube_link]
        )
    }
    return temp
}

func signById(id:Int) -> Sign{
    let row = try! db.pluck(signs.filter(sign_id==id))
    return Sign(
        id: row![sign_id],
        phrase: row![phrase],
        youtube_id: row![youtube_id],
        youtube_link: row![youtube_link]
    )
}

//func printStuff(){
//    for s in try! db.prepare(signs) {
//        print("id: \(s[youtube_id]), phrase: \(s[phrase])")
//        // id: 1, email: alice@mac.com, name: Optional("Alice")
//    }
//    // SELECT * FROM "users"
//}
//
//func getStuff() -> AnySequence<Row>{
//    return try! db.prepare(signs)
//}
