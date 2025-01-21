import Foundation

/*
 languageLabel.text = "Written in \(list["language"] as? String ?? "")"
 stargazersLabel.text = "\(list["stargazers_count"] as? Int ?? 0) stars"
 wachersLabel.text = "\(list["watchers_count"] as? Int ?? 0) watchers"
 forksLabel.text = "\(list["forks_count"] as? Int ?? 0) forks"
 issuesLabel.text = "\(list["open_issues_count"] as? Int ?? 0) open issues"
 */
struct Repository: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let name: String?
        let language: String?
        let stargazersCount: Int?
        let watchersCount: Int?
        let forksCount: Int?
        let openIssuesCount: Int?
        
        private enum CodingKeys: String, CodingKey {
            case name = "full_name"
            case language = "language"
            case stargazersCount = "stargazers_count"
            case watchersCount = "watchers_count"
            case forksCount = "forks_count"
            case openIssuesCount = "open_issues_count"
        }
    }
}

protocol ListViewInteractorProtocol {
    func taskCancel()
    func getRepositories(_ searchWord: String, completion: @escaping ([Repository.Item]) -> Void)
}

final class ListViewInteractor: ListViewInteractorProtocol {
    var task: URLSessionTask?
    
    func taskCancel() {
        task?.cancel()
    }
    
    func getRepositories(_ searchWord: String, completion: @escaping ([Repository.Item]) -> Void) {
        let url = "https://api.github.com/search/repositories?q=\(searchWord)"
        task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            
           
          
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let repository: Repository = try decoder.decode(Repository.self, from: data!)
                completion(repository.items)
            } catch {
                print("error:", error.localizedDescription)
            }
            
            
            
            
//            if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
//                if let items = obj["items"] as? [[String: Any]] {
//                self.repositoryList = items
//                    completion(items)
//                    DispatchQueue.main.async {
//                        self.listView.repositoryTable.reloadData()
//                    }
//                }
//            }
        }
        // これ呼ばなきゃリストが更新されません
        task?.resume()
    }
    func hoge() {
        
    }
}
