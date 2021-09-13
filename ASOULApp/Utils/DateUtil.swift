//

//
//  DateUtil.swift
//  ASOULApp
//
//  Created by southorange on 2021/9/10.
//  
//
    

import UIKit

class DateUtil: NSObject {
    class func convertIntToDateString(_ value: Int? = nil) -> String {
        var date: Date
        if let value = value {
            date = Date(timeIntervalSince1970: TimeInterval(value))
        } else {
            date = Date()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.string(from: date)
    }
}
