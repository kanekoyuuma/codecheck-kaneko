import XCTest

@testable import iOSEngineerCodeCheck
final class DetailViewPresenterTest: XCTestCase {
    
    var presenter: DetailViewPresenter!
    var view: DetailViewInputMock!
    var router: DetailViewRouterMock!
    var interactor: DetailViewInteractorMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        view = DetailViewInputMock()
        router = DetailViewRouterMock()
        interactor = DetailViewInteractorMock()
        
        let selectItem = RepositoryEntity.Item(name: "name",
                                               owner: RepositoryEntity.Item.Owner(avatarUrl: "url"),
                                               language: "language",
                                               stargazersCount: 0,
                                               watchersCount: 1,
                                               forksCount: 2,
                                               openIssuesCount: 3)
        
        presenter = DetailViewPresenter(
            entity: selectItem,
            view: view,
            dependencies: DetailViewPresenterDependencies(
                router: router,
                interactor: interactor
            )
        )
    }
    
    func test_onDidLoad() {
        presenter.onDidLoad()
        
        let selectItem = RepositoryEntity.Item(name: "name",
                                               owner: RepositoryEntity.Item.Owner(avatarUrl: "url"),
                                               language: "language",
                                               stargazersCount: 0,
                                               watchersCount: 1,
                                               forksCount: 2,
                                               openIssuesCount: 3)
        
        XCTAssertEqual(interactor.isGetAvaterImageCalled, true)
        XCTAssertEqual(interactor.selectItem?.name, "name")
        XCTAssertEqual(interactor.selectItem?.owner?.avatarUrl, "url")
        XCTAssertEqual(interactor.selectItem?.language, "language")
        XCTAssertEqual(interactor.selectItem?.stargazersCount, 0)
        XCTAssertEqual(interactor.selectItem?.watchersCount, 1)
        XCTAssertEqual(interactor.selectItem?.forksCount, 2)
        XCTAssertEqual(interactor.selectItem?.openIssuesCount, 3)
        
        XCTAssertEqual(view.isSetupLayoutCalled, true)
        XCTAssertEqual(view.isSetImageCalled, true)
    }
}

class DetailViewInputMock: DetailViewInput {
    var isSetupLayoutCalled = false
    var isSetImageCalled = false
    
    func setupLayout(_ value: DetailViewEntity) {
        isSetupLayoutCalled = true
    }
    
    func setImage(_ value: UIImage) {
        isSetImageCalled = true
    }
}

class DetailViewInteractorMock: DetailViewInteractorProtocol {
    var isGetAvaterImageCalled = false
    var selectItem: RepositoryEntity.Item?
    
    func getAvaterImage(
        _ value: RepositoryEntity.Item,
        completion: @escaping (UIImage) -> Void
    ) {
        isGetAvaterImageCalled = true
        selectItem = value
        completion(UIImage())
    }
}

class DetailViewRouterMock: DetailViewRouterProtocol {
    var isPresentCalled = false
    var entityValue: RepositoryEntity.Item?
    
    func present(from: UIViewController, entity: RepositoryEntity.Item) {
        isPresentCalled = true
        entityValue = entity
    }
}
