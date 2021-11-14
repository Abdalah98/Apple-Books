//
//  string+EXT.swift
//  News
//
//  Created by Abdallah on 8/11/21.
//

import Foundation
extension String {
    func convertToDate()-> Date? {
            let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dataFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dataFormatter.timeZone   = .current
        return dataFormatter.date(from: self)
    }

    func convertToDisplayFormat() -> String{
        guard let date = self.convertToDate() else {return ""}
        return date.convertToMonthYearFormat()
    }
}
