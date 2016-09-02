//
//  ListItem.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import Foundation
import ObjectMapper

struct ListItem : Mappable {

    var id: Int?
    var title: String?
    var thumbnailUrl: String?
    var url: String?

    init?(_ map: Map) {
    }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        title           <- map["name"]
        thumbnailUrl    <- map["thumbnailUrl"]
        url             <- map["url"]
    }

    class IntTransform : TransformType {
        typealias Object = Int
        typealias JSON = String

        func transformFromJSON(value: AnyObject?) -> Object? {
            return Int(value as! String)
        }

        func transformToJSON(value: Object?) -> JSON? {
            return String(value)
        }
    }
}
