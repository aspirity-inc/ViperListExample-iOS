//
//  DetailsWireframe.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import UIKit

let detailsViewController = "DetailsViewController"

class DetailsWireframe : DetailsWireframeInterface {
    
    var detailsPresenter: DetailsPresenter?
    var detailsView: DetailsViewController?
    
    init(presenter: DetailsPresenterInterface?) {
        detailsPresenter = presenter as? DetailsPresenter
    }
    
    func showItemDetails(item: DetailsItem, fromViewController: ListViewController?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        detailsView = storyboard.instantiateViewControllerWithIdentifier(detailsViewController) as? DetailsViewController
        detailsView?.presenter = detailsPresenter
        detailsPresenter?.view = detailsView
        detailsPresenter?.details = item
        fromViewController?.navigationController?.pushViewController(detailsView!, animated: true)
    }
}