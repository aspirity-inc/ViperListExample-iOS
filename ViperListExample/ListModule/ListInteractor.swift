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

    init(provider: DataProviderInterface?) {
        self.provider = provider!
    }

    func getItemsForPage(_ page: Int) -> Observable<([ListItem], Int)> {
        return provider.getListOfItemsForPage(page).map({ (response, dict) throws -> ([ListItem], Int) in
            let list = Mapper<ListItem>().mapArray(dict?.objectForKey("list"))
            let pager = Mapper<Pager>().map(dict?.objectForKey("pager"))
            return (list!, pager!.pages!)
        }).subscribeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "ru.aspirity.viper.background-queue"))
            .observeOn(MainScheduler.instance)
    }
}
