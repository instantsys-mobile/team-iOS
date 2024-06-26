//
//  ItemsListViewController.swift
//  MVVM_with_API_calls
//
//  Created by DhruvPorwal on 16/06/24.
//

import UIKit

class ItemsListViewController: UIViewController {
    @IBOutlet weak var itemstableView: UITableView!
    private var viewModel = ItemsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
}

extension ItemsListViewController {
    
    func config() {
        itemstableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        itemstableView.estimatedRowHeight = 80.0
        self.itemstableView.dataSource = self
        self.itemstableView.delegate = self
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchproducts()
    }
    // For DataBinding i.e. communication bw the View and View model
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            
            guard let self else {return}
            
            switch event {
            case .loading: break
            case .stopLoading: break
            case .dataLoaded:
                print(self.viewModel.products)
                DispatchQueue.main.async {
                    self.itemstableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

extension ItemsListViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product // This should trigger productSettingUp() in ItemTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return a specific height for the row based on your custom logic
        return 200.0
    }
    
}
