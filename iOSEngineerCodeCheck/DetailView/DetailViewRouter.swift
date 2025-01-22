import UIKit

protocol DetailViewRouterProtocol {
    func present(from: UIViewController, entity: RepositoryEntity.Item)
}

// MARK: Public
final class DetailViewRouter: DetailViewRouterProtocol {
    
    func present(from: UIViewController, entity: RepositoryEntity.Item) {
        let view = create(entity: entity)
        from.navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: Private
extension DetailViewRouter {
    func create(entity: RepositoryEntity.Item) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailViewPresenter(entity: entity, view: view)
        view.delegate = presenter
        return view
    }
}
