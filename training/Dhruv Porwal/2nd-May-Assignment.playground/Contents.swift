import UIKit

/* Question: Implement a function to print the pattern of a right-angled triangle using asterisks (*)
 based on the input number of rows. (Both Left-Right Angled and Right-Right Angled) */
func printRightAngledTriangleFacingLeft(rows: Int) {
    // Using Loops
    var i: Int = 0
    
    for i in stride(from: i, through: rows, by: 1) {
        var j: Int = 0
        
        for j in stride(from: j, through: i, by: 1) {
            print("*", terminator: "")
        }
        
        print(" ") // We don't need \n here but only using " " moves us to next line in swift
    }

}

//func printRightAngledTriangleFacingLeft(rows: Int) {
//    for i in 1...rows {
//        for j in 1...i {
//            print("* ", terminator: "")
//        }
//        print("\n", terminator: "")
//    }
//}

func printRightAngledTriangleFacingRight(rows: Int) {
    for i in 0...rows {
        for j in stride(from: rows, to: i, by: -1) {
            print("", terminator: " ")
        }
        
        for k in 0...i {
            print("*", terminator: "") // here separator won't matter as we are printing only a single item in each print operation.So, separator won't be working
        }
        print(" ") // We don't need \n here but only using " " moves us to next line in swift
    }
}

// Making Function Call:
print("\nRight Facing Right Angled Triangle:")
printRightAngledTriangleFacingLeft(rows: 5)

print("\nLeft Facing Right Angled Triangle:")
printRightAngledTriangleFacingRight(rows: 5)


//print(1,2,3,4,5,separator: "/ " ,terminator: ", ") // Terminator is added only at last of an individual print stmt while separtor is added after each item of within a single print


// A closure function to
struct Student {
    let name: String
    var score: Int
}

// A categorization function which provides us a list of only those students who have more than 10 as their score
let array = [Student(name: "testSubject1", score: 10),
            Student(name: "testSubject2", score: 20),
            Student(name: "testSubject3", score: 20),
            Student(name: "testSubject4", score: 10)]

func topStudentFilter(student: Student) -> Bool {
    return student.score > 10
}

func topStudentFilterFA(student: [Student]) -> [Student] {
    return student.filter { $0.score > 10 } // closures aways in {}
    
}

let topStudent = array.filter(topStudentFilter) // here, we are passing it as a closure

let topSA = topStudentFilterFA(student: array) // here, we are passing it as a fn

print("")
for s in topSA {
    print(s.name)
}

//


// 2nd May Assignment
//1. Create a function called filterStrings that takes an array of strings and a predicate function as parameters. The predicate function should determine whether each string in the array meets a certain condition (e.g., length greater than 5 characters), and the filterStrings function should return an array containing only the strings that satisfy the condition.

//Predicate functions are functions that return a single TRUE or FALSE based on some property.
func filterStrings(dataSet incomingData: [String], predicate: (String) -> Bool) -> [String] {
    
    var result: [String] = [] // Initialized Result Array here
    
    for data in incomingData {
        if predicate(data) {
            result.append(data)
        }
    }
    
    return result
}

func checkLengthGreaterThanFive(_ data: String) -> Bool {
    return data.count > 5
}

let inputData = ["len3", "length6", "length6", "length6", "len3", "le2"]

var resultData = filterStrings(dataSet: inputData, predicate: checkLengthGreaterThanFive)

print("")
if !resultData.isEmpty {
    resultData.forEach { print($0, terminator: " ") }
}


//MARK: Question 2: Write a program that calculates the factorial of a given integer using recursion. Implement a function called calculateFactorial that takes an integer as input and returns its factorial.

func findFactorial(for data: Int) -> Int {
    if data == 0 { return 1 }
    
    var result: Int = 1 // Initialized Result Array here
    
    for x in stride(from: data, through: 1 , by: -1) {
        result *= x
    }
    
    return result
}

var factorial = findFactorial(for: 5)

print("\n")
print(factorial)

