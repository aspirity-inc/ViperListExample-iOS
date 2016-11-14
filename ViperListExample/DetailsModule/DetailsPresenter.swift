//
//  DetailsPresenter.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import Foundation

class DetailsPresenter : DetailsPresenterInterface {
    
    weak var view: DetailsViewInterface?
    var wireframe: DetailsWireframeInterface?
    var details: DetailsItem?
    
    func updateView() {
        if let data = details {
            view?.showData(data.url, title: data.title)
        } else {
            view?.showError("Oops! Something unexpected happened.")
        }
    }    
}
