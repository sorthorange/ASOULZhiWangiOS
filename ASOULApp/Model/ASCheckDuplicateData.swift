//

//
//  ASCheckDuplicateData.swift
//  ASOULApp
//
//  Created by southorange on 2021/9/9.
//  
//
    

import UIKit
import YYModel

@objc enum ASCheckDupulicateReplyType: Int {
    /// 视频
    case video = 1
    /// 专栏
    case column = 12
    /// 动态
    case dynamic1 = 11
    /// 动态
    case dynamic2 = 17
}

@objcMembers class ASCheckDuplicateReplyData: NSObject, YYModel {
    /// 原文从文本评论中的复制占比
    var rate: CGFloat = 0
    /// 评论的回复ID
    var replyId: String = ""
    /// 评论的类型
    var type: ASCheckDupulicateReplyType = .video
    /// 动态id （不明）
    var dynamicId: String = ""
    /// 动态/视频/专栏 发布者的UID
    var originUid: Int = 0
    /// 动态/视频/专栏 对应的ID
    var originId: String = ""
    /// 评论发布者uid
    var publisherUid: Int = 0
    /// 评论发布者的用户名
    var publisherName: String = ""
    /// 评论的创建时间
    var createTime: Int = 0
    /// 评论正文
    var content: String = ""
    /// 评论点赞数
    var likeNum: Int = 0
    /// 评论引用的评论的回复id
    var originReplyId: String = ""
    /// 与该评论相似的评论数
    var similarCount: Int = 0
    /// 该评论点赞数+所有相似评论点赞数
    var similarLikeSum: Int = 0
    /// 评论链接
    var replyUrl: String = ""
    
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "replyId": "reply.rpid",
            "type": "reply.type_id",
            "dynamicId": "reply.dynamic_id",
            "originUid": "reply.uid",
            "originId": "reply.oid",
            "publisherUid": "reply.mid",
            "publisherName": "reply.m_name",
            "createTime": "reply.ctime",
            "content": "reply.content",
            "likeNum": "reply.like_num",
            "originReplyId": "reply.origin_rpid",
            "similarCount": "reply.similar_count",
            "similarLikeSum": "reply.similar_like_sum",
            "replyUrl": "reply_url",
        ]
    }
}

@objcMembers class ASBilibiliUserInfo: NSObject, YYModel {
    /// Uid
    var uid = ""
    /// 用户名
    var name = ""
    /// 头像
    var avatar = ""
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "uid" : "mid",
            "avatar" : "face",
        ]
    }
}

@objcMembers class ASCheckDuplicateData: NSObject, YYModel {
    /// 相似度
    var rate: CGFloat = 0
    var startTime: Int = 0
    var endTime: Int = 0
    /// 相似小作文列表
    var replyList = [ASCheckDuplicateReplyData]()
    
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return [
            "startTime" : "start_time",
            "endTime" : "end_time",
            "replyList" : "related",
        ]
    }
    
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["replyList": ASCheckDuplicateReplyData.self]
    }
}
