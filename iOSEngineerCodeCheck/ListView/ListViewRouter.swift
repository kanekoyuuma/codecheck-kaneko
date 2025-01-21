import UIKit

protocol ListViewRouterProtocol {
    func present(from: UIViewController)
}

// MARK: Public
final class ListViewRouter: ListViewRouterProtocol {
    func present(from: UIViewController) {
        
    }
}

// MARK: Private
extension ListViewRouter {
    func create() {
        let view = ListViewController()
    }
}
