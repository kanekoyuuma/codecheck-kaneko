import Foundation

protocol ListViewInteractorProtocol {
    func taskCancel()
    func getRepositories(_ searchWord: String, completion: @escaping ([RepositoryEntity.Item]) -> Void)
}

final class ListViewInteractor: ListViewInteractorProtocol {
    var task: URLSessionTask?
    
    func taskCancel() {
        task?.cancel()
    }
    
    func getRepositories(_ searchWord: String, completion: @escaping ([RepositoryEntity.Item]) -> Void) {
        let url = "https://api.github.com/search/repositories?q=\(searchWord)"
        task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                let repository: RepositoryEntity = try decoder.decode(RepositoryEntity.self, from: data!)
                completion(repository.items)
            } catch {
                print("error:", error.localizedDescription)
            }
        }
        // タスクの更新
        task?.resume()
    }
}
