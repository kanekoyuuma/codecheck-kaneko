import UIKit

protocol ListViewDelegate: AnyObject {
    func onTapSearch(_ value: String)
    func onTapCancel()
    func onTapCell(_ selectIndex: Int)
    func getRepositoryList() -> [ListViewCellEntity]
}

protocol ListViewInput: AnyObject {
    func reload()
}

final class ListViewController: UIViewController {
    static let identifyCell = "ListViewCell"
    
    var delegate: ListViewDelegate?
    var repositoryList: [[String: Any]] = []
    var word: String!
    var index: Int!
    var listView: ListView!
        
    override func loadView() {
        super.loadView()
        self.view = ListView(frame: .zero)
        self.view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listView = self.view as? ListView
        
        listView.repositorySearchBar.delegate = self
        listView.repositoryTable.delegate = self
        listView.repositoryTable.dataSource = self
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = delegate?.getRepositoryList().count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listView.repositoryTable.dequeueReusableCell(
            withIdentifier: ListViewController.identifyCell
        ) as? ListViewCell else {
            return UITableViewCell()
        }
        
        let repository = delegate?.getRepositoryList()[indexPath.row]
        
        cell.setData(ListViewCellEntity(
            name: repository?.name ?? "",
            language: repository?.language ?? ""
        ))
                
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルのタップ処理
        delegate?.onTapCell(indexPath.row)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 初期化
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.onTapCancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        word = searchBar.text!
        
        if word.count != 0 {
            delegate?.onTapSearch(word)
        }
    }
}

extension ListViewController: ListViewInput {
    func reload() {
        DispatchQueue.main.async {
            self.listView.repositoryTable.reloadData()
        }
    }
}
