import UIKit

typealias ListViewPresenterDependencies = (
    router: ListViewRouterProtocol,
    interactor: ListViewInteractorProtocol
)

// MARK: Public
final class ListViewPresenter {
    var repositoryList: [RepositoryEntity.Item] = []
    var transition: UIViewController?
    
    private weak var view: ListViewInput?
    // 依存
    private var dependencies: ListViewPresenterDependencies
    
    init(view: ListViewInput,
         transition: UIViewController,
         dependencies: ListViewPresenterDependencies = (
            router: ListViewRouter(),
            interactor: ListViewInteractor()
         )) {
             self.view = view
             self.transition = transition
             self.dependencies = dependencies
         }
    
}

// MARK: ListViewDelegate
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
        guard let transition else { return }
        
        let selectCellItem = repositoryList[selectIndex]
        dependencies.router.presentDetailView(from: transition, entity: selectCellItem)
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
