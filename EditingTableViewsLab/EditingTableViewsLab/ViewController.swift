//
//  ViewController.swift
//  EditingTableViewsLab
//
//  Created by Bienbenido Angeles on 11/25/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var groceryItems = [[Item]](){
        didSet{
            tableView.reloadData()
        }
    }
    
    var isEditingTableView = false {
        didSet{
            tableView.isEditing = isEditingTableView
            navigationItem.leftBarButtonItem?.title = isEditingTableView ? "Done" : "Edit"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        tableView.dataSource = self
    }
    
    func loadData(){
        groceryItems = Item.getSections()
    }

    @IBAction func addNewItem(segue: UIStoryboardSegue){
        guard let createItemVC = segue.source as? CreateItemDetailViewController, let createdItem = createItemVC.createdItem else {
            fatalError("unable to access CreateItemDVC as source")
        }
        let indexPath = IndexPath(row: 0, section: 0)
        groceryItems.insert([createdItem], at: 1)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        isEditingTableView.toggle()
    }
    
    
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        let item = groceryItems[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.price?.description
        return cell
        
    }
    
    //section func
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groceryItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groceryItems[section].first?.section
    }
    
    //deleting rows in table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print("")
        case .delete:
            groceryItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            print("")
        }
    }
    
    //reording rows in table view
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = groceryItems[sourceIndexPath.section][sourceIndexPath.row]
        groceryItems.remove(at: sourceIndexPath.section)
        groceryItems.insert([itemToMove], at: destinationIndexPath.section)
    }
    
}

