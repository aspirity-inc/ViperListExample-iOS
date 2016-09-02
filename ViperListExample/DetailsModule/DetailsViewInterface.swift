//
//  DetailsViewInterface.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import Foundation

protocol DetailsViewInterface {
    
    func showData(url: String?, title: String?)
    func showError(text: String?)
    
}