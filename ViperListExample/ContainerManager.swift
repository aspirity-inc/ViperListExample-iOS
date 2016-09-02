//
//  ContainerManager.swift
//  ViperListExample
//
//  Created by Anton NamtarR Tarasov on 30.08.16.
//  Copyright (c) 2016 Aspirity. All rights reserved.
//

import Foundation
import Swinject
import AlamofireImage

class ContainerManager {

    static var manager = ContainerManager()

    let container = Container()

    func initDependencies() {
        container.register(RootWireframe.self) { c in
            ListWireframe(presenter: c.resolve(ListPresenterInterface.self))
        }
        container.register(ListPresenterInterface.self) { c in
            ListPresenter(interactor: c.resolve(ListInteractorInterface.self))
        }
        container.register(ListInteractorInterface.self) { c in
            ListInteractor(provider: c.resolve(DataProviderInterface.self))
        }
        container.register(DataProviderInterface.self) { _ in
            RestProvider(baseUrl: "https://demo6609798.mockable.io/")
        }.inObjectScope(.Container)
        container.register(DetailsWireframeInterface.self) { c in
            DetailsWireframe(presenter: c.resolve(DetailsPresenterInterface.self))
        }
        container.register(DetailsPresenterInterface.self) { _ in
            DetailsPresenter()
        }
        container.register(AutoPurgingImageCache.self) { _ in
            AutoPurgingImageCache(memoryCapacity: 40 * 1024 * 1024, preferredMemoryUsageAfterPurge: 20 * 1024 * 1024)
        }.inObjectScope(.Container)
    }
}
