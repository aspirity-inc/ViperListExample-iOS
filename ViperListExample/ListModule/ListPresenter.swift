//
//  ListPresenter.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import Foundation
import RxSwift

class ListPresenter : ListPresenterInterface {

    let interactor: ListInteractorInterface?
    var view: ListViewInterface?
    var wireframe: ListWireframeInterface?

    init(interactor: ListInteractorInterface?) {
        self.interactor = interactor
    }

    func getItemsForPage(page: Int) {
        _ = interactor?.getItemsForPage(page)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { array in
                self.view?.showItems(array, shouldRestart: (page == 1))
            }, onError: { error in
                self.view?.showError("Oops! Something unexpected happened.")
            }, onCompleted: nil, onDisposed: nil)
    }

    func listItemClicked(item: ListItem) {
        wireframe?.showItemDetails(item)
    }
}