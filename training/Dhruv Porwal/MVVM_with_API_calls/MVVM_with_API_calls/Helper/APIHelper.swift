
import Foundation
import UIKit

enum APIResponseErrors: Error {
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case message(_ error: Error?)
    case network(Error?)
}

//  making use of type alias
typealias Handler = (Result<[ItemModel],APIResponseErrors>) -> Void
// Used to generally give alt names to data types or like closuresnabove

final class APIHelper {
    static let shared = APIHelper()
    private init() {}
    
    func fetchProducts(completionHandler: @escaping Handler) {
        guard let url = URL(string: Constants.API.productURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) { dataFromAPICall, responseFromAPICall, errorFromAPICall in
            
            guard let data = dataFromAPICall, errorFromAPICall == nil else
            {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let response = responseFromAPICall as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else { // checking that status Code should be b/w 200 and 209
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            do {// JSONDecoder transforms data to model
                let products = try JSONDecoder().decode([ItemModel].self, from: data)
                completionHandler(.success(products) ) // In case of .success case of Result
            } catch {
                completionHandler(.failure(.message(error)))
                completionHandler(.failure(.network(error)))
                
            }
        }.resume() // remember to write always to start the URLSession method
    }
    
    
}
