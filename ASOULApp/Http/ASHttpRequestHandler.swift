//

//
//  ASHttpRequestHandler.swift
//  ASOULApp
//
//  Created by 霍橙 on 2021/8/27.
//  
//
    

import UIKit
import AFNetworking
import YYModel

class ASHttpRequestHandler: NSObject {
    class func requestLibrary(pageNum: Int, pageSize: Int, success: (([ASLibraryData]?) -> ())?, failure: ((Error) -> ())?) {
        //https://asoul.icu/v/articles/q?pageNum=0&pageSize=36
        AFHTTPSessionManager().get("https://asoul.icu/v/articles/q?pageNum=\(pageNum)&pageSize=\(pageSize)", parameters: nil, headers: nil, progress: nil) { task, resultObject in
            if let result = (resultObject as? [String : Any])?["articles"] as? [[String : Any]] {
                let data = NSArray.yy_modelArray(with: ASLibraryData.self, json: result) as?[ASLibraryData]
                success?(data)
            } else {
                success?(nil)
            }
        } failure: { task, error in
            failure?(error)
        }

    }
    
    class func requestLibraryArticle(id: String, success: ((String?) -> ())?, failure: ((Error) -> ())?) {
        //https://asoul.icu/v/articles/613812569dd7d310bb35a955/html
        AFHTTPSessionManager().get("https://asoul.icu/v/articles/\(id)/html", parameters: nil, headers: nil, progress: nil) { _, resultObject in
            if let result = (resultObject as? [String : String])?["htmlContent"] {
                success?(result)
            } else {
                success?(nil)
            }
        } failure: { _, error in
            failure?(error)
        }

    }
}
