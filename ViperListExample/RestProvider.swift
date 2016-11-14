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
    
    let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    fileprivate func makeRequest(_ method: Alamofire.HTTPMethod, url: String, parameters: [String : Any]? = nil) -> Observable<(HTTPURLResponse, AnyObject?)> {
        return Observable<(HTTPURLResponse, AnyObject?)>.create { observer in
            let request = Alamofire.request(self.baseUrl + url, method: method, parameters: parameters).responseJSON(completionHandler: {response in
                if let resp = response.response {
                    if resp.statusCode > 199 && resp.statusCode < 300 {
                        observer.onNext((resp, response.result.value as AnyObject?))
                    } else {
                        observer.onError(NSError(domain: "HTTP", code: resp.statusCode, userInfo: nil))
                    }
                } else {
                    observer.onError(NSError(domain: "HTTP", code: -1, userInfo: nil))
                }
                observer.onCompleted()
            })
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func getListOfItemsForPage(_ page: Int) -> Observable<(HTTPURLResponse, AnyObject?)> {
        return makeRequest(.get, url: "images", parameters: ["page" : page])
    }
}
