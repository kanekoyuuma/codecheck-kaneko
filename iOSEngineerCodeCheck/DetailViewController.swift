import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var stargazersLabel: UILabel!
    @IBOutlet private weak var wachersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!

    var listViewController: ListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let list = listViewController.repositoryList[listViewController.index]
        stargazersLabel.text = "Written in \(list["language"] as? String ?? "")"
        stargazersLabel.text = "\(list["stargazers_count"] as? Int ?? 0) stars"
        wachersLabel.text = "\(list["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(list["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(list["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let list = listViewController.repositoryList[listViewController.index]
        
        titleLabel.text = list["full_name"] as? String
        
        if let owner = list["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.imageView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
}
