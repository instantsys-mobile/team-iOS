//
//  ItemsLisrViewModel.swift
//  MVVM_with_API_calls
//
//  Created by DhruvPorwal on 16/06/24.
//

import Foundation


final class ItemsListViewModel {
    
    var products: [ItemModel] = []
    var eventHandler: ((_ event : Event) ->  Void)? // This Closure will Do Data Binding For Us
    func fetchproducts() {
        self.eventHandler?(.loading)
        APIHelper.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                print(products)
                self.products = products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

// For View Binding create an extension

extension ItemsListViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(_ error: Error?)
    }
}
