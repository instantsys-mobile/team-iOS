import UIKit


//Basic Operators

//Unary operators operate on a single target (such as -a). Unary prefix operators appear immediately before their target (such as !b), and unary postfix operators appear immediately after their target (such as c!).
//
//Binary operators operate on two targets (such as 2 + 3) and are infix because they appear in between their two targets.
//
//Ternary operators operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional operator (a ? b : c).

//a ? b : c if(a== true) then b else c

let b = 10 // = this is defined as assignment operator
let (x, y) = (1, 2) // here, (x,y) is the tuple

/*
1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5
*/

//Comparison Operators in

//Equal to (a == b)
//
//Not equal to (a != b)
//
//Greater than (a > b)
//
//Less than (a < b)
//
//Greater than or equal to (a >= b)
//
//Less than or equal to (a <= b)

//increment/ decrement using += or -=

//COMPARISON OF TUPLES:

//(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" aren't compared
//(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
//(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"


("blue", -1) < ("purple", 1)        // OK, evaluates to true

//("blue", true) < ("purple", false)        // OK, evaluates to true
//("blue", false) < ("purple", true)  // Error because < can't compare Boolean values

//These cannot be compared because true and false aren't comparable

//The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.

//("blue", false) < ("purple", true)

//while moving from left to right we are first of all comparing numerical values

//You can compare two tuples if they have the same type and the same number of values. Tuples are compared from left to right, one value at a time

//Optionals Basics:

//a != nil ? a! : b


let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil


var colorNameToUse = userDefinedColorName ?? defaultColorName

//forceful unwrapping a!

//if let unwrapping

var a :String? = "hey"
if let value = a{
    
    print("as expected value of a is \(value)")
}else{
    print("value of a is nil")
}


//Ranges in swift
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}


//Half ranges
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}

//One-Sided Ranges
for name in names[2...] {
    print(name)
}
// Brian
// Jack

//The half-open range operator also has a one-sided form
for name in names[..<2] {
    print(name)
}

for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian


//.conrtains() function to check presence of elements in array

//range.contains(7)   // false
//range.contains(4)   // true
//range.contains(-1)


//Logical NOT (!a)
//
//Logical AND (a && b)
//
//Logical OR (a || b)


// logical NOT operator
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}

let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

//combining logical operators:

//we promote combining of logical operators

if( true && (2 == 3 && 4 == 4)) {
    print("all the best")
}
   
   print("Hey")

var 😀 = 23

print(😀)




//declarartion of Strings:
let someString = "Some string literal value"

let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?\" he asked.

\"Begin at the beginning," the King said gravely, \"and go on \
till you come to the end; then stop."
"""


/*
The escaped special characters \0 (null character), \\ (backslash), \t (horizontal tab), \n (line feed), \r (carriage return), \" (double quotation mark) and \' (single quotation mark)
*/


//for special characters
print("\u{1F496}")



print(threeMoreDoubleQuotationMarks)

var multiplier = 3
print("Write an interpolated string in Swift using \(multiplier).")
print(#"6 times 7 is \#(6 * 7)."#)


//Special Characters in String Literalsin page link




var wiseWords = " \"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"



print(#"Line \u{1F496} "#)

let threeMoreDoubleQuotationMarks = " Here are three more double quotes: \" \" \" "
print(threeMoreDoubleQuotationMarks)

//or

let t2hreeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#

let t3hreeMoreDoubleQuotationMarks =
"Line 1 \n Line 2"

let t4hreeMoreDoubleQuotationMarks =
#"Line 1 \#n Line 2"#//if we want tu use this special character


//Initializing an Empty Stringin



//You can place a string literal within extended delimiters to include special characters in a string without invoking their effect.
var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax
// these two strings are both empty, and are equivalent to each other

if emptyString.isEmpty {
    print("Nothing to see here")
}
// Prints "Nothing to see here"


//String Mutabilityin

//var variableString = "Horse"
//variableString += " and carriage"
//// variableString is now "Horse and carriage"
//
//
//let constantString = "Highlander"
//constantString += " and another Highlander"


//Strings Are Value Typesin


//in swift strings are not array of characters in direct sense
var fan : String = "Value 1"
var fan2 = fan
print(fan2)
//wrong
//print(fan2[6]) wrong
//
//As mentioned above, different characters can require different amounts of memory to store, so in order to determine which Character is at a particular position, you must iterate over each Unicode scalar from the start or end of that String. For this reason, Swift strings can’t be indexed by integer values.
//
//Use the startIndex property to access the position of the first Character of a String. The endIndex property is the position after the last character in a String. As a result, the endIndex property isn’t a valid argument to a string’s subscript. If a String is empty, startIndex and endIndex are equal.


var greeting = "Hello"

print(greeting[greeting.startIndex])
//subscript is get only

greeting = "r"

print(greeting[greeting.startIndex])

//Counting Characters

var word = "hey"
word.count


greeting = "Halo"

greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u

greeting = "Hello"
let index = greeting.index(greeting.startIndex, offsetBy: 4)//after startingIndex from 1st position
print(greeting[index])
// o

     /*The endIndex property is the position after the last character in a String. As a result, the endIndex property isn’t a valid argument to a string’s subscript. If a String is empty, startIndex and endIndex are equal.*/

greeting[greeting.index(before: greeting.endIndex)]
//
for ind in greeting.indices {
    print(" \(ind) \(greeting[ind]) ", terminator: "")
}
// Prints "G u t e n   T a g ! "
//
//You can use the startIndex and endIndex properties and the index(before:), index(after:), and index(_:offsetBy:) methods on any type that conforms to the Collection protocol. This includes String, as shown here, as well as collection types such as Array, Dictionary, and Set.


//Prefix and Suffix Equality

let dramaPlay = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    
]



var sceneCount = 0
for scene in dramaPlay {
    if scene.hasPrefix("Act 1 ") {
        sceneCount += 1
    }
}
print("There are \(sceneCount) scenes in Act 1")
// Prints "There are 5 scenes in Act 1"

//Substrings


let minutes = 60


let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: 1) {
    
    print(tickMark)
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
}

//let temperatureInCelsius = 200
//
//enum TemperatureError : Error{
//    case boiling
//    case hot
//    case moderate
//    case cool
//}
//let weatherAdvice = if temperatureInCelsius > 100 {
//    throw TemperatureError.boiling
//} else {
//    "It's a reasonable temperature."
//}

let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")



let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}



let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}


let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}



let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) isn't a vowel or a consonant")
}




let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}




let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)




let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}




switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
    "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) isn't a vowel or a consonant")
}


let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
case 9:
    description += " 2nd "
default:
    description += " an integer."
}
print(description)


func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }


    print("Hello \(name)!")


    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }


    print("I hope the weather is nice in \(location).")
}


greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."




//

//making use of guard let to unwrap an optional also

//func greet(person: [String: String]) {
//    guard let name = person["name"] else {
//        return
//    }
//    print("Hello \(name)!")
//    //accessing the data of key "name" through person
//    guard let location = person["location"] else {
//        print("I hope the weather is nice near you.")
//        return
//    }
//
//    print("I hope the weather is nice in \(location).")
//}


greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."


let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0


gameLoop: while square != finalSquare {
    diceRoll += 1 // gameLoop -> is the name assigned to while loop
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}


//top most block performed at last
var score = 3
if score < 100 {
    score += 100
defer {
        score -= 100
        print("\(score) is in defer block which is a top")
    }
    
    defer {
            score -= 20
        print("\(score) is in defer block 2 which is on 2nd Last position")
    }
    
    defer {
            score -= 20
        print("\(score) is in defer block 3 which is bottom")
    }
    // Other code that uses the score with its bonus goes here.
    print(score)
}

if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}
