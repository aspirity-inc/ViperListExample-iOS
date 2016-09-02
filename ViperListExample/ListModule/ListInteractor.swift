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

    func getItemsForPage(page: Int) -> Observable<[ListItem]> {
        return provider.getListOfItemsForPage(page).map({ (response, dict) throws -> [ListItem] in
            return Mapper<ListItem>().mapArray(dict!)!
        }).observeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "ru.aspirity.viper.background-queue"))
    }
}
