//
//  RealmManager.swift
//  NoteKeeper
//
//  Created by Александра Кострова on 26.06.2023.
//

import UIKit
import RealmSwift

struct RealmManager {
    
     let realm = try? Realm()
    
     func save <T: Object> (objects: T, _ tableView: UITableView) {
        do {
            try realm?.write {
                realm?.add(objects)
            }
        } catch let error as NSError {
            print("failed with save category: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    func loadCategoryItems() -> Results<Category>? {
        return realm?.objects(Category.self)
    }
    
    func loadItems(_ selectedCategory: Category?) -> Results<Item>? {
        return selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
    }
    
     func delete<T: Object>(object: T) {
        do {
            try realm?.write {
                realm?.delete(object)
            }
        } catch let error as NSError {
            print("error saving data \(error.localizedDescription)")
        }
    }
}
