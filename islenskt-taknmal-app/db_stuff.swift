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

let sign_related = Table("sign_related")
let sign_related_sign_id = Expression<Int>("sign_id")
let sign_related_related_id = Expression<Int>("related_id")

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

func signsByIds(ids:[Int]) -> [Sign]{
    return ids.map {id in
        return signById(id: id)
    }
}

func relatedSignsById(id:Int) -> [Sign] {
    let related_signs = try! db.prepare(sign_related.filter(sign_related_sign_id == id)).map {related in
        return signById(id: related[sign_related_related_id])}
    return related_signs
}

let collections: [SignCollection] = [
    SignCollection(name: "Öll tákn", signs: signList),
    SignCollection(name: "Vikudagar", signs: signsByIds(ids: [5890,10695,6042,2082,2703,5180,8981])),
    SignCollection(name: "Mánuðir", signs: signsByIds(ids: [4367,1983,5782,288,5706,4448,4447,470,7726,6638,6532,1346])),
    SignCollection(name: "Skóli",signs: signsByIds(ids: [5,2,50,20,51,22])),
    SignCollection(name: "LRL",signs: signsByIds(ids: [500,201,510,290,522,230]))
]
