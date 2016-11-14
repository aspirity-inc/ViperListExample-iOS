//
//  ListViewInterface.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import Foundation

protocol ListViewInterface {
    
    func showItems(_ newItems: [ListItem], shouldRestart: Bool)
    func showError(_ text: String)
    
}
