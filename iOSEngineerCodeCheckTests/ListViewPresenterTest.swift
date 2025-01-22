import XCTest

@testable import iOSEngineerCodeCheck
final class ListViewPresenterTest: XCTestCase {
    
    var presenter: ListViewPresenter!
    var view: ListViewInputMock!
    var transition: UIViewController!
    var router: ListViewRouterMock!
    var interactor: ListViewInteractorMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        view = ListViewInputMock()
        transition = UIViewController()
        router = ListViewRouterMock()
        interactor = ListViewInteractorMock()
        
        presenter = ListViewPresenter(
            view: view,
            transition: transition,
            dependencies: ListViewPresenterDependencies(
                router: router,
                interactor: interactor
            )
        )
    }
    
    func test_onTapSearch() {
        let result = [RepositoryEntity.Item(name: "name",
                                            owner: RepositoryEntity.Item.Owner(avatarUrl: "url"),
                                            language: "language",
                                            stargazersCount: 0,
                                            watchersCount: 1,
                                            forksCount: 2,
                                            openIssuesCount: 3)]
        interactor.result = result
        presenter.onTapSearch("テスト")
        XCTAssertEqual(interactor.isGetItemCalled, true)
        XCTAssertEqual(interactor.searchWordValue, "テスト")
        XCTAssertEqual(interactor.result.count, 1)
        XCTAssertEqual(interactor.result.first?.name, "name")
        XCTAssertEqual(interactor.result.first?.owner?.avatarUrl, "url")
        XCTAssertEqual(interactor.result.first?.language, "language")
        XCTAssertEqual(interactor.result.first?.stargazersCount, 0)
        XCTAssertEqual(interactor.result.first?.watchersCount, 1)
        XCTAssertEqual(interactor.result.first?.forksCount, 2)
        XCTAssertEqual(interactor.result.first?.openIssuesCount, 3)
        XCTAssertEqual(view.isReloadCalled, true)
    }
    
    func test_onTapCancel() {
        presenter.onTapCancel()
        XCTAssertEqual(interactor.isTaskCancelCalled, true)
    }
    
    func test_onTapCell() {
        let result = [RepositoryEntity.Item(name: "name",
                                            owner: RepositoryEntity.Item.Owner(avatarUrl: "url"),
                                            language: "language",
                                            stargazersCount: 0,
                                            watchersCount: 1,
                                            forksCount: 2,
                                            openIssuesCount: 3)]
        presenter.repositoryList = result
        presenter.onTapCell(0)
        XCTAssertEqual(router.isPresentDetailViewCalled, true)
        XCTAssertEqual(router.entityValue?.name, "name")
        XCTAssertEqual(router.entityValue?.owner?.avatarUrl, "url")
        XCTAssertEqual(router.entityValue?.language, "language")
        XCTAssertEqual(router.entityValue?.stargazersCount, 0)
        XCTAssertEqual(router.entityValue?.watchersCount, 1)
        XCTAssertEqual(router.entityValue?.forksCount, 2)
        XCTAssertEqual(router.entityValue?.openIssuesCount, 3)
    }
    
    func test_getRepositoryList() {
        let result = [RepositoryEntity.Item(name: "name",
                                            owner: RepositoryEntity.Item.Owner(avatarUrl: "url"),
                                            language: "language",
                                            stargazersCount: 0,
                                            watchersCount: 1,
                                            forksCount: 2,
                                            openIssuesCount: 3)]
        presenter.repositoryList = result
        
        let list = presenter.getRepositoryList()
        XCTAssertEqual(list.count, 1)
    }

}

class ListViewInputMock: ListViewInput {
    var isReloadCalled = false
    
    func reload() {
        isReloadCalled = true
    }
}

class ListViewInteractorMock: ListViewInteractorProtocol {
    var isTaskCancelCalled = false
    var isGetItemCalled = false
    var searchWordValue = ""
    var result = [RepositoryEntity.Item]()
    
    func taskCancel() {
        isTaskCancelCalled = true
    }
    
    func getRepositories(_ searchWord: String, completion: @escaping ([RepositoryEntity.Item]) -> Void) {
        isGetItemCalled = true
        searchWordValue = searchWord
        completion(result)
    }
}

class ListViewRouterMock: ListViewRouterProtocol {
    var isPresentDetailViewCalled = false
    var entityValue: RepositoryEntity.Item?

    func presentDetailView(from: UIViewController, entity: RepositoryEntity.Item) {
        isPresentDetailViewCalled = true
        entityValue = entity
    }
}
