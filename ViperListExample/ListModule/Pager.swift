//
//  Pager.swift
//  ViperListExample
//
//  Created by NamtarR on 06.09.16.
//  Copyright © 2016 Aspirity. All rights reserved.
//

import UIKit
import ObjectMapper

struct Pager: Mappable {

    var page: Int?
    var pages: Int?
    
    init(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        page    <- map["page"]
        pages   <- map["pages"]
    }    
}
