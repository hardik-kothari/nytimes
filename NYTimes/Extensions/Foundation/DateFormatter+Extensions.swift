//
//  DateFormatter+Extensions.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

extension DateFormatter {
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}
