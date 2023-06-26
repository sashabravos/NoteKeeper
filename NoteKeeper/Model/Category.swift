//
//  Category.swift
//  NoteKeeper
//
//  Created by Александра Кострова on 18.05.2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
