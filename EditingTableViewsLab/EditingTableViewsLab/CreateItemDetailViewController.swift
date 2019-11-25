//
//  CreateItemDetailViewController.swift
//  EditingTableViewsLab
//
//  Created by Bienbenido Angeles on 11/25/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import UIKit

class CreateItemDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    
    var createdItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        nameLabel.delegate = self
        priceLabel.delegate = self
        // Do any additional setup after loading the view.
    }

    func loadData(){
        createdItem = Item(name: nil, price: nil, section: "Unpurchased")
    }
}
extension CreateItemDetailViewController:  UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
        
        if textField == nameLabel{
            nameLabel.resignFirstResponder()
            createdItem?.name = textField.text
        }else if textField == priceLabel{
            priceLabel.resignFirstResponder()
            createdItem?.price = Double(textField.text!)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameLabel{
            createdItem?.name = textField.text
        } else if textField == priceLabel{
            createdItem?.price = Double(textField.text!)
        }
        return true
    }
}
