import UIKit

final class DetailView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stargazersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wachersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let forksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let issuesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let parentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setComponent()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
        setChildrenConstraint()
    }
    
    func setupLayout(_ value: DetailViewEntity) {
        titleLabel.text = value.name
        languageLabel.text = "Written in \(value.language )"
        stargazersLabel.text = "\(value.stargazersCount) stars"
        wachersLabel.text = "\(value.watchersCount) watchers"
        forksLabel.text = "\(value.forksCount) forks"
        issuesLabel.text = "\(value.openIssuesCount) open issues"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// Private
extension DetailView {
    private func setComponent(){
        addSubview(contentView)
        [avatarImageView, titleLabel, parentStackView].forEach{
            contentView.addSubview($0)
        }
        
        [languageLabel, itemStackView].forEach{
            parentStackView.addArrangedSubview($0)
        }
        
        [stargazersLabel, wachersLabel, forksLabel, issuesLabel].forEach{
            itemStackView.addArrangedSubview($0)
        }
    }
    
    //オートレイアウトの設定
    private func setConstraint(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setChildrenConstraint(){
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            
            parentStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            parentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            parentStackView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor)
        ])
    }
}

