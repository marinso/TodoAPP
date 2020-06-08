//
//  Task.swift
//  TodoAPP
//
//  Created by Martin Nasierowski on 03/06/2020.
//  Copyright © 2020 Martin Nasierowski. All rights reserved.
////
import RealmSwift
import Foundation

class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var category = ""
    @objc dynamic var date: Date? = nil
}
