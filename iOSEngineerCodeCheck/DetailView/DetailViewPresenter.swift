import UIKit

typealias DetailViewPresenterDependencies = (
    router: DetailViewRouterProtocol,
    interactor: DetailViewInteractorProtocol
)

struct DetailViewEntity {
    let name: String
    let language: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
}

final class DetailViewPresenter {
    var entity: RepositoryEntity.Item?
    
    private weak var view: DetailViewInput?
    // 依存
    private var dependencies: DetailViewPresenterDependencies
    
    init(entity: RepositoryEntity.Item,
         view: DetailViewInput,
         dependencies: DetailViewPresenterDependencies = (
            router: DetailViewRouter(),
            interactor: DetailViewInteractor()
         )) {
             self.entity = entity
             self.view = view
             self.dependencies = dependencies
         }
}

extension DetailViewPresenter: DetailViewDelegate {
    func onDidLoad() {
        guard let entity else { return }
        let value = DetailViewEntity(
            name: entity.name ?? "",
            language: entity.language ?? "",
            stargazersCount: entity.stargazersCount ?? 0,
            watchersCount: entity.watchersCount ?? 0,
            forksCount: entity.forksCount ?? 0,
            openIssuesCount: entity.openIssuesCount ?? 0
        )
        self.view?.setupLayout(value)
        
        dependencies.interactor.getAvaterImage(entity) { [weak self] value in
            self?.view?.setImage(value)
        }
    }
}
