import Foundation



//MARK: 1. Define a class called Circle with properties for radius and area. Implement a lazy property to calculate the area of the circle when accessed for the first time. Additionally, include a computed property to convert the area to square meters. Implement a read-only property to return the circumference of the circle. Add a property observer to update a separate property whenever the radius is set. Finally, create a type property to store the value of pi.


class Circle {
    // Type property for the value of pi
    static let pi = 3.14
    
    //Type properties are those proeprties which are associated with class rather than instances/objects

    // Stored property for the radius with a property observer
    var radius: Double {
        didSet { // didSet code block runs when ever radius changes
            // Update the area when the radius changes (after Changing), WillSet runs before Changing
            print("DID SET CALLED")
            
            self.areaCalculator()
        }
    }
    
    func areaCalculator() -> Double {
        self.area = Circle.pi * self.radius * self.radius
        print(self.area)
        return self.area
    }

    // Lazy stored property for the area
    lazy var area: Double = { // Lazy properties get initialized only when they are called thus saving system memory
        return Circle.pi * self.radius * self.radius
    }()

    // Computed property to convert the area to square meters (assuming the area is in square centimeters)
    var areaInSquareMeters: Double {
        return self.area / 10000
    }

    // Read-only computed property for the circumference
    var circumference: Double {
        // A computed property with a getter but no setter is known as a read-only computed property. A read-only computed property always returns a value, and can be accessed through dot syntax, but can’t be set to a different value.
        get {
            return 2 * Circle.pi * self.radius
        }
    }

    // Initializer
    init(radius: Double) {
        self.radius = radius
    }
}
print("Question 1:")

var objCircle = Circle(radius: 20)
objCircle.areaCalculator()

print(objCircle.areaInSquareMeters)

objCircle.radius = 10

print("")


//MARK: 2. Create a struct called TemperatureConverter with properties to store temperature values in both Celsius and Fahrenheit. Implement a property wrapper called TemperatureValidator to ensure that the temperature values are valid (e.g., Celsius temperature must be between -273.15°C and 100°C, Fahrenheit temperature must be between -459.67°F and 212°F). Include computed properties to convert between Celsius and Fahrenheit. Additionally, implement a type method to calculate the average temperature of an array of TemperatureConverter instances.

@propertyWrapper
struct TemperatureValidator {
    private var value: Double
    private let minTemperature: Double
    private let maxTemperature: Double
    
    var wrappedValue: Double {
        get {
            return self.value
        }
        
        set {
            self.value = newValue
            self.validate()
        }
    }
    
    // Initialize the wrapped value and set the minimum and maximum temperature range
    init(wrappedValue: Double, minTemperature: Double, maxTemperature: Double) {
        self.value = wrappedValue
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.validate()
    }
    
    // Validate the wrapped value and ensure it falls within the specified temperature range
    private mutating func validate() {
        if self.value < self.minTemperature {
            self.value = self.minTemperature
        } else if self.value > self.maxTemperature {
            self.value = self.maxTemperature
        }
    }
}

struct TemperatureConverter {
    @TemperatureValidator(minTemperature: -273.15, maxTemperature: 100)
    var celsius: Double = 0.0
       
    @TemperatureValidator(minTemperature: -459.67, maxTemperature: 212)
    var fahrenheit: Double = 0.0

    var celsiusToFahrenheit: Double { // Computed properties
        return (self.celsius * 9/5) + 32
    }

    var fahrenheitToCelsius: Double { // Computed properties
        return (self.fahrenheit - 32) * 5/9
    }

    // Type method to calculate the average temperature of an array of TemperatureConverter instances
    static func averageTemperature(of temperatures: [TemperatureConverter]) -> Double {
        guard !temperatures.isEmpty else { return 0 }
        
        let totalCelsius = temperatures.reduce(0) { $0 + $1.celsius }
        return totalCelsius / Double(temperatures.count)
    }
}

print("")
print("Question 2:")

var temperature = TemperatureConverter(celsius: 25, fahrenheit: 77)

temperature.celsius = -300
print("\nCelsius temperature after validation:", temperature.celsius)

temperature.fahrenheit = 300
print("Fahrenheit temperature after validation:", temperature.fahrenheit)

print("\nCelsius to Fahrenheit:", temperature.celsiusToFahrenheit)
print("Fahrenheit to Celsius:", temperature.fahrenheitToCelsius)

let temperatures = [TemperatureConverter(celsius: 20, fahrenheit: 68),
                    TemperatureConverter(celsius: 30, fahrenheit: 86),
                    TemperatureConverter(celsius: 10, fahrenheit: 50)]
print("\nAverage Celsius temperature:", TemperatureConverter.averageTemperature(of: temperatures)) // Output: 20.0
print("")


//MARK: 3. Define a base class called Shape with properties to represent the color and area of a shape. Create subclasses for different geometric shapes (Circle, Square, Triangle) that inherit from the Shape class. Implement instance methods in each subclass to calculate their respective areas and perimeters. Additionally, include class methods to create instances of each shape with random dimensions and colors.

// Base class
class Shape {
    var color: String
    var area: Double {  // Our computed property
        return 0
    }
    
    init(color: String) {
        self.color = color
    }
    
    func calculateArea() -> Double {
        return 0
    }
    
    func calculatePerimeter() -> Double {
        return 0
    }
    
    // Class method to create an instance of Circle with random radius and color
    static func createRandomCircle() -> CircleClass {
        let radius = Double.random(in: 1...10)
        let color = self.randomColor()
        return CircleClass(radius: radius, color: color)
    }
    
    // Class method to create an instance of Square with random side length and color
    static func createRandomSquare() -> Square {
        let sideLength = Double.random(in: 1...10)
        let color = self.randomColor()
        return Square(sideLength: sideLength, color: color)
    }
    
    // Class method to create an instance of Triangle with random base, height, and color
    static func createRandomTriangle() -> Triangle {
        let base = Double.random(in: 1...10)
        let height = Double.random(in: 1...10)
        let sideA = Double.random(in: 1...10)
        let sideB = Double.random(in: 1...10)
        let sideC = Double.random(in: 1...10)
        let color = self.randomColor()
        return Triangle(base: base, height: height, sideA: sideA, sideB: sideB, sideC: sideC, color: color)
    }
    
    // Helper function to generate a random color
    private static func randomColor() -> String {
        let colors = ["Red", "Blue", "Green", "Yellow", "Purple", "Orange"]
        return colors.randomElement() ?? "Black"
    }
}

// Circle subclass extending Shape Class
class CircleClass: Shape {
    var radius: Double
    
    override var area: Double { // Our computed property
        return Double.pi * self.radius * self.radius
    }
    
    init(radius: Double, color: String) {
        self.radius = radius
        super.init(color: color)
    }
    
    override func calculateArea() -> Double {
        return self.area
    }
    
    override func calculatePerimeter() -> Double {
        return 2 * Double.pi * self.radius
    }
}

// Square subclass extending Shape Class
class Square: Shape {
    var sideLength: Double
    
    override var area: Double {  // Our computed property
        return self.sideLength * self.sideLength
    }
    
    init(sideLength: Double, color: String) {
        self.sideLength = sideLength
        super.init(color: color)
    }
    
    override func calculateArea() -> Double {
        return self.area
    }
    
    override func calculatePerimeter() -> Double {
        return 4 * self.sideLength
    }
}

// Triangle subclass extending Shape Class
class Triangle: Shape {
    var base: Double
    var height: Double
    var sideA: Double
    var sideB: Double
    var sideC: Double
    
    override var area: Double {
        return 0.5 * self.base * self.height
    }
    
    init(base: Double, height: Double, sideA: Double, sideB: Double, sideC: Double, color: String) {
        self.base = base
        self.height = height
        self.sideA = sideA
        self.sideB = sideB
        self.sideC = sideC
        super.init(color: color)
    }
    
    override func calculateArea() -> Double {
        return self.area
    }
    
    override func calculatePerimeter() -> Double {
        return self.sideA + self.sideB + self.sideC
    }
}

print("Question 3:")
print("")

let randomCircle = Shape.createRandomCircle()
print("Random Circle - Radius: \(randomCircle.radius), Color: \(randomCircle.color), Area: \(randomCircle.area)")

let randomSquare = Shape.createRandomSquare()
print("Random Square - Side Length: \(randomSquare.sideLength), Color: \(randomSquare.color), Area: \(randomSquare.area)")

let randomTriangle = Shape.createRandomTriangle()
print("Random Triangle - Base: \(randomTriangle.base), Height: \(randomTriangle.height), Color: \(randomTriangle.color), Area: \(randomTriangle.area)")



//MARK: 4. Create a class called Vehicle with properties for make, model, and year. Implement instance methods to accelerate, brake, and honk the horn. Create subclasses for different types of vehicles (Car, Truck, Motorcycle) that inherit from the Vehicle class. Implement specialized methods in each subclass to handle features unique to each type of vehicle, such as towing capacity for trucks and handling characteristics for motorcycles.


// Base class for all vehicles
class Vehicle {
    var make: String
    var model: String
    var year: Int
    
    init(make: String, model: String, year: Int) {
        self.make = make
        self.model = model
        self.year = year
    }
    
    func accelerate() {
        print("Vehicle is accelerating.")
    }
    
    func brake() {
        print("Vehicle is slowing Down.")
    }
    
    func honkHorn() {
        print("Beep beep!")
    }
}

// Subclass for cars extending Vehicles
class Car: Vehicle {
    func turnOnHeadlights() {
        print("Headlights are on.")
    }
    
    func openSunroof() {
        print("Sunroof is open.")
    }
}

// Subclass for trucks extending Vehicles
class Truck: Vehicle {
    private var towingCapacity: Int
    
    init(make: String, model: String, year: Int, towingCapacity: Int) {
        self.towingCapacity = towingCapacity
        super.init(make: make, model: model, year: year) // Here, we have called the super i.e. Parent Class's method in order to initialize this instance and passed the make, model, year
    }
    
    override func honkHorn() {
        print("Beep beep from Truck as overrided from Vehicle!")
    }
    
    func tow() {
        print("Towing with capacity of \(towingCapacity) pounds.")
    }
}

// Subclass for motorcycles extending Vehicles class
class Motorcycle: Vehicle {
    
    func makeStunt() {
        print("Look, no hands!")
    }
    
    override func honkHorn() {
        print("Beep beep from Motorcycle as overrided from Vehicle!")
    }
    
    func turnDirection(_ dirn: String) {
        print("turn to \(dirn)")
    }
}

print("")
print("Question 4:")

// Implementation:
let myCar = Car(make: "Honda", model: "City", year: 2020)
myCar.accelerate()
myCar.turnOnHeadlights()

print("")

let myTruck = Truck(make: "TATA", model: "Trucker", year: 2018, towingCapacity: 5000)
myTruck.brake()
myTruck.tow()
myTruck.honkHorn()

print("")

let myMotorcycle = Motorcycle(make: "Harley-Davidson", model: "Model 10", year: 2021)
myMotorcycle.honkHorn()
myMotorcycle.turnDirection("Left")


print("")

