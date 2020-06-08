//
//  String+Ext.swift
//  TodoAPP
//
//  Created by Martin Nasierowski on 06/06/2020.
//  Copyright © 2020 Martin Nasierowski. All rights reserved.
//

import Foundation

extension String {
    func fromMediumDateStringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.date(from: self)
    }
}
