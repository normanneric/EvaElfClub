//
//  StorageManager.swift
//  EvaClub
//
//  Created by D K on 28.10.2024.
//

import Foundation
import RealmSwift


class StorageManager {
    
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    @ObservedResults(RealmPerson.self) var persons
    @ObservedResults(RealmMessages.self) var messages
    @ObservedResults(RealmCart.self) var carts
    
    
    //cart
    
    func addToCart(item: MenuElement) {
        let cart = realm.objects(RealmCart.self).first ?? {
            let newCart = RealmCart()
            try! realm.write { realm.add(newCart) }
            return newCart
        }()

        try! realm.write {
            if let existingElement = cart.elements.first(where: { $0.name == item.name }) {
                existingElement.quantity = (existingElement.quantity ?? 0) + 1
            } else {
                let newElement = RealmCartElement()
                newElement.name = item.name
                newElement.price = Double(item.price)
                newElement.quantity = 1
                cart.elements.append(newElement)
            }
        }

        updateOrderTotalValue(cart: cart)
    }
    
    func updateOrderTotalValue(cart: RealmCart) {
        let total = cart.elements.reduce(0) { $0 + ($1.price ?? 0) * Double($1.quantity ?? 0) }
        
        try! realm.write {
            cart.totalValue = total
        }
    }
    
//    func removeElement(element: RealmCartElement) {
//        guard let cart = realm.objects(RealmCart.self).first,
//              let itemToUpdate = realm.object(ofType: RealmCartElement.self, forPrimaryKey: element.id),
//              let quantity = itemToUpdate.quantity else {
//            print("not found")
//            return
//        }
//
//        let newQuantity = quantity - 1
//        try! realm.write {
//            itemToUpdate.quantity = newQuantity
//            if newQuantity <= 0 {
//                deleteFoodItem(element: element)
//            }
//            updateOrderTotalValue(cart: cart)
//        }
//    }
    
    func removeElement(element: RealmCartElement) {
        let cart = realm.objects(RealmCart.self).first ?? RealmCart()
        
        if let itemToUpdate = realm.object(ofType: RealmCartElement.self, forPrimaryKey: element.id), let quantity = itemToUpdate.quantity {
            let newQuantity = quantity - 1
            do {
                try realm.write {
                    itemToUpdate.quantity = newQuantity
                }
                if newQuantity <= 0 {
                    deleteFoodItem(element: element)
                }
                updateOrderTotalValue(cart: cart)
                
            } catch {
                
            }
        } else {
            print("Элемент с id не найден в базе данных.")
        }
    }
    
    func deleteFoodItem(element: RealmCartElement) {
        
        do {
            try realm.write {
                realm.delete(element)
            }
        } catch {
            print("Error deleting")
        }
    }
    
    func deleteCart() {
        try! realm.write {
            realm.delete(realm.objects(RealmCart.self))
            realm.delete(realm.objects(RealmCartElement.self))
        }
    }
    
    func sumQuantitiesInFirstCart() -> Int {
        guard let firstCart = realm.objects(RealmCart.self).first else {
            print("No RealmCart found")
            return 0
        }
        return firstCart.elements.reduce(0) { $0 + ($1.quantity ?? 0) }
    }
    
    //mess
    
    func createMessages() {
        do {
            let messages = RealmMessages()
            try realm.write {
                realm.add(messages)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateMessages(list: [String]) {
        do {
            if let myModel = realm.objects(RealmMessages.self).first {
                try realm.write {
                    myModel.messages.removeAll()
                    myModel.messages.append(objectsIn: list)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createPerson() {
        do {
            let newPerson = RealmPerson()
            try realm.write {
                realm.add(newPerson)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateAge(_ age: String) {
        do {
            if let firstPerson = persons.first {
                try realm.write {
                    firstPerson.age = age
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateHeight(_ height: String) {
        do {
            if let firstPerson = persons.first {
                try realm.write {
                    firstPerson.height = height
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateHobby(_ hobby: String) {
        do {
            if let firstPerson = persons.first {
                try realm.write {
                    firstPerson.hobby = hobby
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateImage(_ image: Data?) {
        do {
            if let firstPerson = persons.first {
                try realm.write {
                    firstPerson.image = image
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateName(_ name: String) {
        do {
            if let firstPerson = persons.first {
                try realm.write {
                    firstPerson.name = name
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
