//
//  ListInteractor.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//
import Foundation
import RxSwift
import ObjectMapper

class ListInteractor : ListInteractorInterface {
    
    let provider: DataProviderInterface
    
    var data: [ListItem]? = nil
    
    init(provider: DataProviderInterface?) {
        self.provider = provider!
    }
    
    func getItemsForPage(_ page: Int) -> Observable<([ViewableListItem], Int)> {
        let observable = provider.getListOfItemsForPage(page).do(onNext: ({ list, pages in
            self.data = list
        }), onError: nil, onCompleted: nil, onSubscribe: nil, onDispose: nil)
        
        let list = observable.flatMap { list, pages in
            return Observable.from(list)
            }.map { item in
                return ViewableListItem(title: item.title, imageUrl: item.thumbnailUrl)
            }.toArray()
        
        let pages = observable.map { list, pages in
            return pages
        }
        
        return Observable.zip(list, pages) { l, p in
            return (l, p)
        }
    }
}
