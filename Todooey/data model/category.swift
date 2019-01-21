//
//  category.swift
//  Todooey
//
//  Created by Kyle Patterson on 2019-01-19.
//  Copyright © 2019 sun wolf. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
