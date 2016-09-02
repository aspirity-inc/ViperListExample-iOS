//
//  RestProvider.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import RxSwift
import Alamofire

class RestProvider : DataProviderInterface {
    
    var baseUrl: String?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    private func makeRequest(method: Alamofire.Method, url: String, parameters: [String : AnyObject]? = nil) -> Observable<(NSHTTPURLResponse, AnyObject?)> {
        return Observable<(NSHTTPURLResponse, AnyObject?)>.create { observer in
            Alamofire.request(method, self.baseUrl! + url, parameters: parameters).responseJSON { response in
                if let resp = response.response {
                    if case 200 ... 299 = resp.statusCode {
                        observer.onNext((response.response!, response.result.value))
                    } else {
                        observer.onError(NSError(domain: "HTTP", code: resp.statusCode, userInfo: nil))
                    }
                } else {
                    observer.onError(NSError(domain: "HTTP", code: -1, userInfo: nil))
                }
                observer.onCompleted()
            }
            return AnonymousDisposable {}
        }
    }
    
    func getListOfItemsForPage(page: Int) -> Observable<(NSHTTPURLResponse, AnyObject?)> {
        return makeRequest(.GET, url: "images", parameters: ["page" : page])
    }
}