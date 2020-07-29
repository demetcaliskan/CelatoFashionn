//
//  NotProduct.swift
//  CelatoFashion
//
//  Created by Kaan Koç on 16.07.2020.
//  Copyright © 2020 Demet. All rights reserved.
//

import Foundation
import UIKit.UIImage

class NotProduct {
    
    private var name: String
    private var amount: String
    private var category: String
    private var color: String
    private var price: String
    private var size: String
    private var id: String
    private var gender: String
    private var placeholderImage : UIImage
    
    init(name: String, amount: String, category: String, color: String, price: String, size: String, id: String, gender: String) {
 
        self.name = name
        self.amount = amount
        self.category = category
        self.color = color
        self.price = price
        self.size = size
        self.id = id
        self.gender = gender
        self.placeholderImage = UIImage(named: "Product")!
        
    }
    init() {

        self.name = ""
        self.amount = ""
        self.category = ""
        self.color = ""
        self.price = ""
        self.size = ""
        self.id = "0"
        self.gender = ""
        self.placeholderImage = UIImage(named: "Product")!
    }
    // SETTERS
    func setName(name: String) {
        self.name = name
    }
    func setAmount(amount: String) {
        self.amount = amount
    }
    func setCategory(category: String) {
        self.category = category
    }
    func setColor(color: String) {
        self.color = color
    }
    func setPrice(price: String) {
        self.price = price
    }
    func setSize(size: String) {
        self.size = size
    }
    func setId(id: String) {
        self.id = id
    }
    func setGender(gender: String) {
        self.gender = gender
    }
    
    // GETTERS
    func getName() -> String {
        return name
    }
    func getAmount() -> String {
        return amount
    }
    func getCategory() -> String {
        return category
    }
    func getColor() -> String {
        return color
    }
    func getPrice() -> String {
        return price
    }
    func getSize() -> String {
        return size
    }
    func getId() -> String {
        return id
    }
    func getGender() -> String {
        return gender
    }
    func setImage(image: UIImage) {
        self.placeholderImage = image
    }
    func getImage() -> UIImage {
        return self.placeholderImage
    }
    func ToString() -> String {
        return "id is " + self.id + " name is " + self.name + " category is " + self.category + " color is " + self.color + " price is " + self.price + " size is " + self.size + " amount is " + self.amount + " gender is " + self.gender
    }
}
