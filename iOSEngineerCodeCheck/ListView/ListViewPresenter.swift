//
//  ListViewPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 金子侑真 on 2025/01/21.
//  Copyright © 2025 YUMEMI Inc. All rights reserved.
//

import Foundation

typealias ListViewPresenterDependencies = (
    router: ListViewRouterProtocol,
    interactor: ListViewInteractorProtocol
)

struct ListViewCellEntity {
    let name: String
    let language: String
}

final class ListViewPresenter {
    private var dependencies: ListViewPresenterDependencies
    
    init(dependencies: ListViewPresenterDependencies = (
        router: ListViewRouter(),
        interactor: ListViewInteractor()
    )) {
        self.dependencies = dependencies
    }
    
}
