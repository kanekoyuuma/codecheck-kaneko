import UIKit


final class ListViewCell: UITableViewCell {
    
    let contents: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier )
        
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
    
    //オートレイアウトの設定
    private func setConstraint(){
        NSLayoutConstraint.activate([
            contents.topAnchor.constraint(equalTo: self.topAnchor),
            contents.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contents.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contents.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            languageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            languageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            languageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            languageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    func setData(_ value: ListViewCellEntity) {
        nameLabel.text = value.name
        languageLabel.text = value.language
    }
}

