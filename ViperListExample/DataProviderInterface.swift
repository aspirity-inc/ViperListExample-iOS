//
//  DataProvider.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import Foundation
import RxSwift

protocol DataProviderInterface {
    
    func getListOfItemsForPage(page: Int) -> Observable<(NSHTTPURLResponse, AnyObject?)>
    
}