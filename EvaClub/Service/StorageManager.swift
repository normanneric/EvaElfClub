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
