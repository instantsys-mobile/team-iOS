
import UIKit

class SearchController: UIViewController {
    
    private let reusableIdentifier = "UserTableViewCell"
    // MARK: - Properties
    var tableview = UITableView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    // MARK: - Helpers
    func configureTableView() {
        tableview.frame = view.bounds // Set table view's frame to match the view controller's bounds
        tableview.dataSource = self // Set data source
        tableview.delegate = self // Set delegate (if you plan to implement UITableViewDelegate methods)
        view.addSubview(tableview)
        view.backgroundColor = .white
        tableview.register(UserSearchCell.self, forCellReuseIdentifier: reusableIdentifier)
    }
}

// MARK: - UITableViewDataSource
extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // how many rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! UserSearchCell // configuring each cell/ row what they gonna contain
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    
}


extension SearchController: UITableViewDelegate {
    
}
