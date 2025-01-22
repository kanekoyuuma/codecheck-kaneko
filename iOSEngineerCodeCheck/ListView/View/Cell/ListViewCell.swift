import UIKit


final class ListViewCell: UITableViewCell {
    
    let contents: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemMint
        return view
    }()
    
    let spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier )
        
        [ contents, spacingView ].forEach {
            addSubview($0)
        }
        
        addSubview(contents)
        
        [ nameLabel, languageLabel ].forEach {
            contents.addSubview($0)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
    func setData(_ value: ListViewCellEntity) {
        nameLabel.text = value.name
        languageLabel.text = value.language
    }
}

// MARK: Private
extension ListViewCell {
    //オートレイアウトの設定
    private func setConstraint(){
        NSLayoutConstraint.activate([
            contents.topAnchor.constraint(equalTo: self.topAnchor),
            contents.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contents.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            spacingView.topAnchor.constraint(equalTo: contents.bottomAnchor),
            spacingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            spacingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            spacingView.heightAnchor.constraint(equalToConstant: 5),
            spacingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            
            languageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            languageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            languageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            languageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }
}
