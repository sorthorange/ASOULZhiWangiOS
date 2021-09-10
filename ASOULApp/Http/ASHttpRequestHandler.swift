//

//
//  ASHttpRequestHandler.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/27.
//  
//
    

import UIKit
import AFNetworking
import YYModel

class ASHttpRequestHandler: NSObject {
    /// 获取小作文库作文列表
    class func getLibrary(pageNum: Int, pageSize: Int, success: (([ASLibraryData]?) -> ())?, failure: ((Error) -> ())?) {
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
    /// 获取小作文详情
    class func getLibraryArticle(id: String, success: ((String?) -> ())?, failure: ((Error) -> ())?) {
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
    /// 查重接口 文档 https://github.com/ASoulCnki/ASoulCnkiBackend/blob/master/api.md
    class func postCheckDuplicate(content: String, success: ((ASCheckDuplicateData?) -> ())?, failure: ((Error) -> ())?) {
        let params = ["text":content]
        let manager = AFHTTPSessionManager()
        // 设置发送格式为json
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.post("https://asoulcnki.asia/v1/api/check", parameters: params, headers: nil, progress: nil) { _, result in
            guard let result = (result as? [AnyHashable: Any]), let code = result["code"] as? Int else {
                failure?(NSError.init(domain: "ASDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "获取数据失败"]))
                return
            }
            if code == 0 {
                if let data = result["data"] as? [AnyHashable: Any] {
                    success?(ASCheckDuplicateData.yy_model(with: data))
                } else {
                    success?(nil)
                }
            } else {
                if let message = result["message"] as? String {
                    failure?(NSError.init(domain: "ASDomain", code: code, userInfo: [NSLocalizedDescriptionKey: message]))
                } else {
                    failure?(NSError.init(domain: "ASDomain", code: code, userInfo: [NSLocalizedDescriptionKey: "获取数据失败"]))
                }
            }
        } failure: { _, error in
            failure?(error)
        }
    }
    /// 获取bilibili用户信息接口 https://api.bilibili.com/x/space/acc/info?mid=
    class func getBilibiliUserInfo(id: Int, success: ((ASBilibiliUserInfo?) -> ())?, failure: ((Error) -> ())?) {
        AFHTTPSessionManager().get("https://api.bilibili.com/x/space/acc/info?mid=\(id)", parameters: nil, headers: nil, progress: nil) { _, result in
            guard let result = (result as? [AnyHashable: Any]), let code = result["code"] as? Int else {
                failure?(NSError.init(domain: "ASDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "获取数据失败"]))
                return
            }
            if code == 0 {
                if let data = result["data"] as? [AnyHashable: Any] {
                    success?(ASBilibiliUserInfo.yy_model(with: data))
                } else {
                    success?(nil)
                }
            } else {
                if let message = result["message"] as? String {
                    failure?(NSError.init(domain: "ASDomain", code: code, userInfo: [NSLocalizedDescriptionKey: message]))
                } else {
                    failure?(NSError.init(domain: "ASDomain", code: code, userInfo: [NSLocalizedDescriptionKey: "获取数据失败"]))
                }
            }
        } failure: { _, error in
            failure?(error)
        }

    }
}
