import UIKit

class ListView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var repositorySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        return searchBar
    }()

    var repositoryTable: UITableView = {
        let table = UITableView()
        table.register(ListViewCell.self, forCellReuseIdentifier: ListViewController.identifyCell)
        table.rowHeight = 80
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setComponent()
    }
    
    private func setComponent(){
        addSubview(contentView)
        
        [repositorySearchBar, repositoryTable].forEach{
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
        setChildrenConstraint()
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
                repositorySearchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                repositorySearchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                repositorySearchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

                repositoryTable.topAnchor.constraint(equalTo: repositorySearchBar.bottomAnchor, constant: 400),
                repositoryTable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
                repositoryTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                repositoryTable.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                repositoryTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

