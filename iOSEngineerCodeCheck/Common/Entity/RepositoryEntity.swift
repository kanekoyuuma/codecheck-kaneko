struct RepositoryEntity: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let name: String?
        let owner: Owner?
        let language: String?
        let stargazersCount: Int?
        let watchersCount: Int?
        let forksCount: Int?
        let openIssuesCount: Int?
        
        private enum CodingKeys: String, CodingKey {
            case name = "full_name"
            case owner = "owner"
            case language = "language"
            case stargazersCount = "stargazers_count"
            case watchersCount = "watchers_count"
            case forksCount = "forks_count"
            case openIssuesCount = "open_issues_count"
        }
        
        struct Owner: Codable {
            let avatarUrl: String?
            
            private enum CodingKeys: String, CodingKey {
                case avatarUrl = "avatar_url"
            }
        }
    }
}
