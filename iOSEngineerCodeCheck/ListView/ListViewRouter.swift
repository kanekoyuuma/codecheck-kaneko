import UIKit

protocol ListViewRouterProtocol {
    func presentDetailView(from: UIViewController, entity: RepositoryEntity.Item)
}

final class ListViewRouter: ListViewRouterProtocol {
    func presentDetailView(from: UIViewController, entity: RepositoryEntity.Item) {
        DetailViewRouter().present(from: from, entity: entity)
    }
}
