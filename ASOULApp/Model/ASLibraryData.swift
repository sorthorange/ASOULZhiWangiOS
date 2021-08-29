//

//
//  ASLibraryData.swift
//  ASOULApp
//
//  Created by 霍橙 on 2021/8/27.
//  
//
    

import UIKit
import YYModel

@objcMembers class ASLibraryData: NSObject, YYModel {
    var submissionTime: Int = 0
    var author: String = ""
    var id: String = ""
    var title: String = ""
    var plainContent: String = ""
    var tags: [String] = [String]()
    
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return ["id" : "_id"]
    }
}
