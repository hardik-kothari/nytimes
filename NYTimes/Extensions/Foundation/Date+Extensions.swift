//
//  Date+Extensions.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

extension Date {
    func toLocalString(format: String) -> String? {
        let localDateFormatter = DateFormatter(format: format)
        localDateFormatter.calendar = NSCalendar.current
        localDateFormatter.timeZone = TimeZone.current
        return localDateFormatter.string(from: self)
    }
}
