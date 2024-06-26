
import Foundation
import UIKit

struct FoodItems
{
    var image: UIImage
    var label: String
}

struct CodeModel {
    
    
    let items: [FoodItems] = [
        FoodItems(image: UIImage(named: "salad.jpeg")!, label: "Salad"),FoodItems(image: UIImage(named: "steak.jpeg")!, label: "Steak"),FoodItems(image: UIImage(named: "shrimp.jpeg")!, label: "Shrimp"),FoodItems(image: UIImage(named: "rice.jpeg")!, label: "Rice")]
    
}
