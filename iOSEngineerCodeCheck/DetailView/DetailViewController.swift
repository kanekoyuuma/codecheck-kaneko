import UIKit

protocol DetailViewDelegate: AnyObject {
    func onDidLoad()
}

protocol DetailViewInput: AnyObject {
    func setupLayout(_ value: DetailViewEntity)
    func setImage(_ value: UIImage)
}


final class DetailViewController: UIViewController {
    var detailView: DetailView!
    var delegate: DetailViewDelegate?
        
    override func loadView() {
        super.loadView()
        self.view = DetailView(frame: .zero)
        self.view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView = self.view as? DetailView
        delegate?.onDidLoad()
    }
}

extension DetailViewController: DetailViewInput {
    func setupLayout(_ value: DetailViewEntity) {
        detailView.setupLayout(value)
    }
    
    func setImage(_ value: UIImage) {
        detailView.avatarImageView.image = value
    }
}
