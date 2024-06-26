import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            
            /// Set the separator style to none to remove default cell separators
            self.tableView.separatorStyle = .none
            /// Set the content inset to add spacing at the top and bottom
            self.tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            
            /// Registered our cell programmatically here
            self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            self.tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "buttonCell")
        }
    }
    
    private let viewModel: TableViewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.delegate = self
    }
}

//MARK: Tableview data source and delegate handling
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            // Returning the desired height for the button cell
            return 50
        } else {
            // Returning the height for other cells
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            guard let buttonCell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as? ButtonTableViewCell
            else {
                return ButtonTableViewCell(style: .default, reuseIdentifier: "buttonCell")
            }
            
            buttonCell.setupUI()
            buttonCell.delegate = self
            
            return buttonCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
            else {
                return CustomTableViewCell(style: .default, reuseIdentifier: "CustomTableViewCell")
            }
            
            cell.setupUI(data: self.viewModel.dataSource[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 2 {
            // Instantiate KeyboardHandlingVC from storyboard so remember to add storyboard id here
            self.viewModel.didTapOnTableViewCell(indexPath: indexPath)
        }
    }
}

extension TableViewController: ButtonTableViewCellDelegate {
    func didTapButton() {
        // Handle button tap action here
        self.viewModel.didTapButton()
    }
}

extension TableViewController: TableViewModelDelegate {
    
    func pushViewController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
