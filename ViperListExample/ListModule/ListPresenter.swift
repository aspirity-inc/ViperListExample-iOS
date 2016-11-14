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
    weak var view: ListViewInterface?
    var wireframe: ListWireframeInterface?
    var pages: Int?
    var page: Int = 0
    
    let disposeBag = DisposeBag()

    init(interactor: ListInteractorInterface?) {
        self.interactor = interactor
    }
    
    fileprivate func loadItems() {
        if (pages == nil || page < pages! ) {
            _ = interactor?.getItemsForPage(page)
                .subscribe(onNext: { (array, pages) in
                    self.pages = pages
                    self.view?.showItems(array, shouldRestart: (self.page == 1))
                    }, onError: { error in
                        self.view?.showError("Oops! Something unexpected happened.")
                    }, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        }
    }
    
    func getMoreItems() {
        page += 1
        loadItems()
    }
    
    func refresh() {
        page = 1
        loadItems()
    }

    func listItemClicked(_ item: ListItem) {
        wireframe?.showItemDetails(item)
    }
}
