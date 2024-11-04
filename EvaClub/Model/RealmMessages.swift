//
//  RealmMessages.swift
//  EvaClub
//
//  Created by D K on 29.10.2024.
//

import Foundation
import RealmSwift

class RealmMessages: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var messages: List<String> 
}
