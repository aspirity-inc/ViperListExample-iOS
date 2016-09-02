//
//  ListWireframe.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import UIKit
import Swinject

let listViewController = "ListViewController"

class ListWireframe : RootWireframe, ListWireframeInterface {

    var listPresenter: ListPresenter?
    var listView: ListViewController?
    var detailsWireframe: DetailsWireframeInterface?
    
    init(presenter: ListPresenterInterface?) {
        self.listPresenter = presenter as? ListPresenter
    }

    func showRootViewController(window: UIWindow?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        listView = storyboard.instantiateViewControllerWithIdentifier(listViewController) as? ListViewController
        listView?.presenter = listPresenter
        listPresenter?.view = listView
        listPresenter?.wireframe = self
        window?.rootViewController = UINavigationController(rootViewController: listView!)
    }

    func showItemDetails(item: ListItem) {
        if (detailsWireframe == nil) {
            detailsWireframe = ContainerManager.manager.container.resolve(DetailsWireframeInterface.self)
        }
        let details = DetailsItem(title: item.title, url: item.url)
        detailsWireframe?.showItemDetails(details, fromViewController: listView)
    }
}