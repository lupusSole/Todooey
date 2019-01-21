//
//  item.swift
//  Todooey
//
//  Created by Kyle Patterson on 2019-01-19.
//  Copyright © 2019 sun wolf. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
   @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @ objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
