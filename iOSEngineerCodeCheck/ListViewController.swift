import UIKit

class ListViewController: UIViewController {
    
    static let identifyCell = "ListViewCell"

//    @IBOutlet private weak var repositorySearchBar: UISearchBar!
    
    var repositoryList: [[String: Any]] = []
    var task: URLSessionTask?
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
        // Do any additional setup after loading the view.
        listView = self.view as? ListView
        
        listView.repositorySearchBar.delegate = self
        listView.repositoryTable.delegate = self
        listView.repositoryTable.dataSource = self
        
        
//        repositorySearchBar.text = "GitHubのリポジトリを検索できるよー"
//        repositorySearchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let viewController = segue.destination as! DetailViewController
            viewController.listViewController = self
        }
        
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repositoryList[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        word = searchBar.text!
        
        if word.count != 0 {
            let url = "https://api.github.com/search/repositories?q=\(word!)"
            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                    self.repositoryList = items
                        DispatchQueue.main.async {
                            self.listView.repositoryTable.reloadData()
                        }
                    }
                }
            }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
        }
        
    }
}
