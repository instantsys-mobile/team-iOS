import UIKit

struct Parts {
    var name: String?
    var price: Int?
}

class WorkShop {
    // Nothing to initialize as no proeprty is there
    func findParts(name: String) -> Parts? { // findParts is returning us an optional part can or cannot have value
        
        if name == "keyboard" {
            return Parts(name: "keyboard", price: 400)
        } else if name == "mouse" {
            return Parts(name: "mouse", price: 250)
        }
        
        return nil
    }
}

func returnUnwrapped(parts: Parts?) -> (x: String?, y: Int?)? {
    if let part = parts {
        if let name = part.name {
            if let price = part.price {
                return (x:name, y:price)
            }
        }
    }
    return nil
}

var objWorkShop = WorkShop()

//OPTIONAL BINDING
if let parts = objWorkShop.findParts(name: "cybertron") {
    if let price = parts.price { // Basically if any value is optional then we are binding it with any variable
        print("\(price) of \(returnUnwrapped(parts: parts)!.x!)\n") // Forceful unwrapping
    } else {
        print("Price Not Found\n")
    }
} else {
    print("Part Not Found\n")
}

//OPTIONAL CHAINING REDUCES THIS BURDEN BY REMOVING THE IF STATEMENTS
if let partsPrice = objWorkShop.findParts(name: "keyboard")?.price {
    print("Price is \(partsPrice) for the item\n")
} else {
    print("Parts price not found\n")
}
// When it would get executed, first of all objWorkShop.findParts(name: "keyboard") would get executed and in the result of that it is going to find price



//In Protocols loose coupling is preferred
protocol Car {
    func applyBreaks()
    func start()
    func stop()
    func hornSound()
}

class Mercedes: Car {
    
    var voltage: Int?
    
    init?(_voltage: Int){ // Making use of a Failable Constructor but Why? -> because if the required voltage range won't get met by the car, it(constructor) won't be creating an object, ~= is used to match patterns and check if a value lies within a range or not
        guard 50...100 ~= _voltage else {
            print("Required Voltage is not in the correct range\n")
            return nil
        }
        
        self.voltage = _voltage
    }
    
    func applyBreaks() {
        print("Applied Breaks\n")
    }
    
    func start() {
        print("Started Car\n")
    }
    
    func stop() {
        print("Let's Stop for a meal\n")
    }
    
    func hornSound() {
        print("Sound Horn for traffic issuen")
    }
}


class Audi: Car {
    
    func applyBreaks() {
        print("Applied Breaks\n")
    }
    
    func start() {
        print("Started Car\n")
    }
    
    func stop() {
        print("Let's Stop for a meal\n")
    }
    
    func hornSound() {
        print("Sound Horn for traffic issues\n")
    }
}

class Person {
    func drivecar(car: Car) {
        car.start()
        
        print("I am driving a \(car)\n")
    }
}

let objPerson = Person()
let objAudi = Audi()

if let objMerc = Mercedes(_voltage: 60) {
    objPerson.drivecar(car: objMerc)
}

objPerson.drivecar(car: objAudi)



//MARK: Initializer Requirements in Protocols
// Protocols can specify that conforming types must implement certain initializers. This is done by defining the initializer in the protocol without an implementation:

protocol SomeProtocol {
    init(someParameter: Int)
}


// Class Implementations of Protocol Initializer Requirements
// When a class conforms to a protocol with initializer requirements, it must implement those initializers. The required keyword is used to indicate that every subclass of this class must also provide an implementation of this initializer:
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

// Required Initializers
// The required modifier ensures that all subclasses of the class conforming to the protocol also conform to the protocol by providing the required initializer.

// Final Classes
// If a class is marked with the final modifier, it cannot be subclassed, and therefore, you don’t need to use the required modifier for protocol initializer implementations:

final class SomeFinalClass: SomeProtocol {
    init(someParameter: Int) {
        // initializer implementation goes here
    }
}


// Overriding Initializers
// If a subclass overrides a superclass’s designated initializer and also conforms to a protocol, you use both the required and override modifiers:

//class SomeSubClass: SomeSuperClass, SomeProtocol {
//    required override init() {
//        // initializer implementation goes here
//    }
//}


// Failable Initializer Requirements
// Protocols can also define failable initializer requirements, which can be satisfied by either a failable (init?) or nonfailable (init) initializer in the conforming type:

protocol FailableProtocol {
    init?(someParameter: Int)
}

class SomeConformingClass: FailableProtocol {
     required init?(someParameter: Int) {
        // failable initializer implementation goes here
    }
}


// A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer (init!).

// Protocols define what initializers must be implemented by conforming types, and classes that conform to these protocols must provide these initializers. The required modifier is used to ensure that all subclasses also meet these requirements, and the override modifier is used when a subclass is overriding a superclass’s initializer. Failable initializer requirements provide flexibility in initialization, allowing for the possibility of initialization failure.



// Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type.

// the delegate pattern is a common way to enable one object to communicate back to another object.

// Define the protocol that the delegate will conform to
protocol TaskDelegate: AnyObject {
    // You can limit protocol adoption to class types (and not structures or enumerations) by adding the AnyObject protocol to a protocol’s inheritance list.
    
    // AnyObject is a protocol to which all classes implicitly conform. In fact, the standard library contains a type alias AnyClass representing AnyObject. Type .
    
    func taskDidComplete()
}

// Define the class that will use the delegate
class Task {
    // Define a delegate property
    var delegate: TaskDelegate?

    func completeTask() {
        print("Task completed")
        // Notify the delegate that the task has completed
        delegate?.taskDidComplete()
    }
}

// Extend the class that will become the delegate
class TaskManager: TaskDelegate {
    func startTask() {
        let task = Task()
        task.delegate = self
        task.completeTask()
    }

    // Conform to the protocol by implementing the required method
    func taskDidComplete() {
        print("The task manager was notified that the task did complete.")
    }
}

// Example usage
let manager = TaskManager()
manager.startTask()
