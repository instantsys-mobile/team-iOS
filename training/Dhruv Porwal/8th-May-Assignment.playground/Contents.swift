import Foundation


//Structs have memberwise initializers by default and classes need to have initializers declared if variables haven't been initialized and made optional

//Default Initializer:

struct Rectangle {
    var width = 0.0
    var height = 0.0
}
let defaultRect = Rectangle()

//Parameterized Initializer: You can define an initializer with parameters to provide initial values for the properties when creating an instance.

struct Wall {
    var length: Double
    var height: Double
    
    init(length: Double, height: Double) {
        self.length = length
        self.height = height
    }
}
let wall = Wall(length: 10.5, height: 8.6)


struct Point {
    var x: Double
    var y: Double
    
    init() {
        self.x = 0.0
        self.y = 0.0
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}
let origin = Point()
let specificPoint = Point(x: 5.0, y: 5.0)


//Convenience Initializer: A convenience initializer is a secondary initializer that must call another initializer from the same class.

class Circle {
    var radius: Double
    var circumference: Double
    var name: String
    
    init(radius: Double, circumference: Double, name: String) {
        self.radius = radius
        self.circumference = 2 * Double.pi * radius
    }
    
    convenience init(radius: Double, circumference: Double) {
        self.init(radius: radius, circumference: circumference, name: "Constant")
        
    }
}
let circle = Circle(radius: 20.0, circumference: 30.0)


// Failable Initializer: A failable initializer can return nil after initialization if something goes wrong.

struct User {
    var username: String
    
    init?(username: String) {
        if username.isEmpty {
            return nil
        }
        self.username = username
    }
}
let user = User(username: "")



// Swift automatically deallocates your instances when they’re no longer needed, to free up resources. Swift handles the memory management of instances through automatic reference counting (ARC)


class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}


// Required Initializers

// Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:

class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

// We must also write the required modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain. You don’t write the override modifier when overriding a required designated initializer:
// We don’t write the override modifier when overriding a required designated initializer


//Setting a Default Property Value with a Closure or Function

class MockClass {
    let someProperty: Int = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        let value = 0
        return value
    }()
}

//Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.


//Initializer Delegation for Value Type

//Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.

//Value types (structures and enumerations) don’t support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves. Classes, however, can inherit from other classes

// If we define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it’s a structure) for that type. This constraint prevents a situation in which additional essential setup provided in a more complex initializer is accidentally circumvented by someone using one of the automatic initializers.


// Designated Initializers and Convenience Initializer



//Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

/*
Swift applies the following three rules for delegation calls between initializers:

Rule 1
A designated initializer must call a designated initializer from its immediate superclass.

Rule 2
A convenience initializer must call another initializer from the same class.

Rule 3
A convenience initializer must ultimately call a designated initializer.

A simple way to remember this is:

Designated initializers must always delegate up.

Convenience initializers must always delegate across.

These rules are illustrated in the figure below:

*/
