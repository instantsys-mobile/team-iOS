//
//  main.swift
//  NewProjectTesting
//
//  Created by DhruvPorwal on 15/05/24.
//

import Foundation


let customer1 = TestingClass()

print(customer1.firstName)
customer1.usedCreditCardToPay()
customer1.usedNetBankingToPay()

var subClassObject = TestingSubClass(extraProperty: 10, firstName: "Alice", lastName: "Brown")

subClassObject.firstName = "Alice"
subClassObject.lastName = "Brown"

print(subClassObject.firstName)

subClassObject.usedNetBankingToPay()


let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let reversedNames = names.sorted() { $0 > $1 }



print(reversedNames)


let numbers = [16, 58, 510]
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let strings = numbers.map ({ (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
})

print(strings)

//A Delegate is a common design pattern used in cocoa and cocoa touch frameworks, where one class delegates the responsibility for implementing some functionality to another class

// A delegate is a simple one-to-one communication
//Delegates are implemented using a protocol declaration and so we will declare a protocol which the delegate will implement.


// Delegate Pattern implemented using protocol

var delegate = DeveloperClass()
var objectA = ManagerClass(_delegate: delegate)

objectA.addsTowNumbers()



// Delegate Pattern implemented using model to model

var objectB = ManagerClassA(_developer: DeveloperClassA())
objectB.addTwoNumber(x: 10, y: 20)

                           

                          

