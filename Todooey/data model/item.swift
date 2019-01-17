//
//  item.swift
//  Todooey
//
//  Created by Kyle Patterson on 2019-01-17.
//  Copyright © 2019 sun wolf. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable{
    var title: String = ""
    var done: Bool = false
}
