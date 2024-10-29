//
//  RealmUser.swift
//  EvaClub
//
//  Created by D K on 28.10.2024.
//

import Foundation
import RealmSwift

class RealmPerson: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name = ""
    @Persisted var age = ""
    @Persisted var height = ""
    @Persisted var hobby = ""
    @Persisted var image: Data?
}
