//

//
//  ASLibraryData.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/27.
//  
//
    

import UIKit
import YYModel

@objcMembers class ASLibraryData: NSObject, YYModel {
    /// 发布时间
    var submissionTime: Int = 0
    /// 作者
    var author: String = ""
    /// 小作文id
    var id: String = ""
    /// 小作文标题
    var title: String = ""
    /// 小作文正文
    var plainContent: String = ""
    /// 小作文标签
    var tags: [String] = [String]()
    
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return ["id" : "_id"]
    }
}
