//
//  CategoryViewController.swift
//  NoteKeeper
//
//  Created by Александра Кострова on 17.05.2023.
//

import UIKit
import RealmSwift

final class CategoryViewController: UITableViewController {
    
    let realm = RealmManager()
    
    private var categoriesArray: Results<Category>?
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCategory))
        button.tintColor = .label
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // setup navigationBar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Notekeeper"
        navigationItem.rightBarButtonItem = addButton
        
        // register cell
        tableView.register(CategoryCell.self, forCellReuseIdentifier: Keys.categoryСell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesArray = realm.loadCategoryItems()
        self.tableView.reloadData()
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.categoryСell,
                                                 for: indexPath as IndexPath)
                as? CategoryCell else { return UITableViewCell() }
        
        if let category = categoriesArray?[indexPath.row] {
            cell.taskNameLabel.text = category.name
            let taskCount = category.items.count
            cell.tasksCountLabel.text = taskCount != 0 ? "You have \(taskCount) task" : ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?.count ?? 1
    }
    
    //    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let noteVC = NoteViewController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            noteVC.selectedCategory = categoriesArray?[indexPath.row]
        }
        
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if let category = categoriesArray?[indexPath.row] {
            if category.items.count == 0 {
                realm.delete(object: category)
            } else {
                unfinishedTasksAlert()
            }
        }
        tableView.reloadData()
        
    }
    
    // MARK: - Add New Categories
    
    @objc func addNewCategory() {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Some kind of to-do list..."
        }
        let closeAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Done", style: .default) { _ in
            let textField = alert.textFields?.first
            if let text = textField?.text {
                if text != "" {
                    let newCategory = Category()
                    newCategory.name = text
                    self.realm.save(objects: newCategory, self.tableView)
                }
            }
        }
        alert.addAction(closeAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Alerts
    
    private func unfinishedTasksAlert() {
        let alert = UIAlertController(title: "The task isn't completed",
                                      message: "You still have unfinished sub-tasks",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
