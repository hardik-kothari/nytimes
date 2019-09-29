//
//  String+Extensions.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

extension String {
    func toUTCDate(format: String) -> Date? {
        let utcDateFormatter = DateFormatter(format: format)
        utcDateFormatter.calendar = NSCalendar.current
        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return utcDateFormatter.date(from: self)
    }
}
