import UIKit

protocol DetailViewInteractorProtocol {
    func getAvaterImage(_ value: RepositoryEntity.Item, completion: @escaping (UIImage) -> Void)
}

final class DetailViewInteractor: DetailViewInteractorProtocol {
    
    func getAvaterImage(_ value: RepositoryEntity.Item, completion: @escaping (UIImage) -> Void) {
        guard let avatarUrl = value.owner?.avatarUrl, let url = URL(string: avatarUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            let img = UIImage(data: data!)!
            DispatchQueue.main.async {
                completion(img)
            }
        }.resume()
    }
}
