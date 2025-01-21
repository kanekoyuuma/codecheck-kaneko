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
    var repositoryList: [Repository.Item] = []
    
    private weak var view: ListViewInput?
    // 依存
    private var dependencies: ListViewPresenterDependencies
    
    init(view: ListViewInput,
        dependencies: ListViewPresenterDependencies = (
            router: ListViewRouter(),
            interactor: ListViewInteractor()
        )) {
            self.view = view
            self.dependencies = dependencies
        }
    
}

extension ListViewPresenter: ListViewDelegate {
    
    func onTapSearch(_ value: String) {
        dependencies.interactor.getRepositories(value) { [weak self] value in
            self?.repositoryList = value
            self?.view?.reload()
        }
    }
    
    func onTapCancel() {
        dependencies.interactor.taskCancel()
    }
    
    func onTapCell(_ selectIndex: Int) {
        
    }
    
    func getRepositoryList() -> [ListViewCellEntity] {
        self.repositoryList.compactMap {
            ListViewCellEntity(
                name: $0.name ?? "",
                language: $0.language ?? ""
            )
        }
    }
}
