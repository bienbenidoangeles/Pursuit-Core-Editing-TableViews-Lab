//
//  Item.swift
//  EditingTableViewsLab
//
//  Created by Bienbenido Angeles on 11/25/19.
//  Copyright © 2019 Bienbenido Angeles. All rights reserved.
//

import Foundation

struct Item {
    var name: String?
    var price: Double?
    var section: String
    
    static let items: [Item] = [
        Item(name: nil, price: nil, section: "Unpurchased"),
        Item(name: nil, price: nil, section: "Purchased")
    ]
    
    static func getSections() -> [[Item]] {
        let sortedItems = items.sorted{$0.section < $1.section}
        let uniqueItems = Set(sortedItems.map{$0.section})
        var sections = Array(repeating: [Item](), count: uniqueItems.count)
        var currentIndex = 0
        var currentSection = sortedItems.first?.section
        for item in sortedItems{
            if item.section == currentSection {
                sections[currentIndex].append(item)
            } else{
                currentIndex += 1
                currentSection = item.section
                sections[currentIndex].append(item)
            }
        }
        return sections
    }
}
