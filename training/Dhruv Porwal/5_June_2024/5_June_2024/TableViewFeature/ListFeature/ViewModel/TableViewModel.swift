//
//  TableViewModel.swift
//  5_June_2024
//
//  Created by KunalBhandari on 17/06/24.
//

import Foundation
import UIKit

protocol TableViewModelDelegate: AnyObject {
    func pushViewController(viewController: UIViewController)
}

class TableViewModel {
    var dataSource: [DataModel]
    weak var delegate: TableViewModelDelegate?
    
    init() {
        self.dataSource = [
            DataModel(date: "20/05/2024", time: "12:00 PM", photo1: "skyscraper", photo2: "img2skyscraper", address1: "123 Main St, City1, Country1", address2: "456 Elm St, City2, Country2"),
            DataModel(date: "21/05/2024", time: "12:00 PM", photo1: "skyscraper", photo2: "img2skyscraper", address1: "123 Main St, City1, Country1", address2: "456 Elm St, City2, Country2"),
            DataModel(date: "22/05/2024", time: "12:00 PM", photo1: "skyscraper", photo2: "img2skyscraper", address1: "123 Main St, City1, Country1", address2: "456 Elm St, City2, Country2"),
            DataModel(date: "23/05/2024", time: "12:00 PM", photo1: "skyscraper", photo2: "img2skyscraper", address1: "123 Main St, City1, Country1", address2: "456 Elm St, City2, Country2"),
            DataModel(date: "24/05/2024", time: "12:00 PM", photo1: "skyscraper", photo2: "img2skyscraper", address1: "123 Main St, City1, Country1", address2: "456 Elm St, City2, Country2"),
            DataModel(date: "20/05/2024", time: "12:00 PM", photo1: "skyscraper", photo2: "img2skyscraper", address1: "123 Main St, City1, Country1", address2: "456 Elm St, City2, Country2")
        ]
    }
    
    func didTapOnTableViewCell(indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "KeyboardHandlingVC") as? KeyboardHandlingVC else { return }
        self.delegate?.pushViewController(viewController: detailViewController)
    }
    
    func didTapButton() {
        guard let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginFormVC") as? LoginFormVC else { return }
        self.delegate?.pushViewController(viewController: loginVC)
    }
}
