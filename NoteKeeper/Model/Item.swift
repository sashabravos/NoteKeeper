//
//  Item.swift
//  NoteKeeper
//
//  Created by Александра Кострова on 18.05.2023.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?

    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
