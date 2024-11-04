//
//  RealmCart.swift
//  EvaClub
//
//  Created by D K on 04.11.2024.
//

import Foundation
import RealmSwift


class RealmCart: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var totalValue: Double?
    @Persisted var elements = RealmSwift.List<RealmCartElement>()
}

class RealmCartElement: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name: String?
    @Persisted var price: Double?
    @Persisted var quantity: Int?
}
