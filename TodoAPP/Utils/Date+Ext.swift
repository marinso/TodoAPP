//
//  Date.swift
//  TodoAPP
//
//  Created by Martin Nasierowski on 06/06/2020.
//  Copyright © 2020 Martin Nasierowski. All rights reserved.
//

import Foundation

extension Date {
    func toMediumString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}

