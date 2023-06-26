//
//  ViewController.swift
//  NoteKeeper
//
//  Created by Александра Кострова on 15.05.2023.
//

import UIKit
import RealmSwift

class NoteViewController: UITableViewController {
    
    let realm = RealmManager()
    
    private var noteItems: Results<Item>?
    
    var selectedCategory: Category? {
        didSet {
            noteItems = self.realm.loadItems(selectedCategory)
                    self.tableView.reloadData()
                }
    }
    
    private lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        button.tintColor = .label
        return button
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup navigationBar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = selectedCategory?.name ?? "Notes"
        navigationItem.rightBarButtonItem = addButton
        
        // setup search bar
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // register cell
        tableView.register(NoteCell.self, forCellReuseIdentifier: Keys.noteCell)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            guard let noteItems = noteItems else { return }
            for note in noteItems {
                if note.done {
                    realm.delete(object: note)
                }
            }
        }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.noteCell,
                                                       for: indexPath as IndexPath) as? NoteCell
        else { return UITableViewCell() }
        
        if let item = noteItems?[indexPath.row] {
            cell.taskNameLabel.text = item.title
            cell.checkmark.image = item.done ? Keys.CheckmarkCondition.check : Keys.CheckmarkCondition.notYet
                    }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteItems?.count ?? 1
    }
    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = noteItems?[indexPath.row] {
            do {
                try realm.realm?.write {
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
           return .delete
       }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if let selectedItem = noteItems?[indexPath.row] {
            realm.delete(object: selectedItem)
        }
        tableView.reloadData()
    }
    
    // MARK: - Add New Items
    
    @objc func addNewItem() {
        let alert = UIAlertController(title: "New", message: "Add new task or item", preferredStyle: .alert)
               alert.addTextField { alertTextField in
                   alertTextField.placeholder = "Write down here..."
               }
               let action = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
                   
                   guard let self = self else { return }
                   
                   let textField = alert.textFields?.first
                   if let newTask = textField?.text {
                       if newTask != "" {
                           if let currentCategory = self.selectedCategory {
                               do {
                                   try self.realm.realm?.write {
                                       let newItem = Item()
                                       newItem.title = newTask
                                       newItem.dateCreated = Date()
                                       currentCategory.items.append(newItem)
                                   }
                               } catch {
                                   print("error saving data \(error.localizedDescription)")
                               }
                           }
                       }
                   }
                   self.tableView.reloadData()
               }
               let closeAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               alert.addAction(closeAction)
               alert.addAction(action)
               present(alert, animated: true, completion: nil)
    }
}

// MARK: - Search Bar Methods

extension NoteViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        noteItems = noteItems?.filter("title CONTAINS[cd] %@", searchText)
            .sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            noteItems = self.realm.loadItems(selectedCategory)
            self.tableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        noteItems = self.realm.loadItems(selectedCategory)
        self.tableView.reloadData()
    }
}
