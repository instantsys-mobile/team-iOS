import UIKit

//ASSIGNMENT SHEET


// Improvements:
// Capitalized textual comment's first letter
// Removed ;
// Command + ? for comments
// Command + A and Ctrl +I for indentation

/* Question: Write a program to check if a given year is a leap year or not. Consider the conditions for a leap year: a year is a leap year if it is divisible by 4, but not divisible by 100 unless it is also divisible by 400. */
/* Approach: Here I have created 2 types of program:
 1. Takes array of years as input,
 2. Takes an individual year value as input
 3. Makes use of a while loop to solve the problem */
func checkLeapYearsUsingWhileLoop(for years: [Int]) {
    
    var counter = 0
    
    print("\n USING WHILE LOOP \n")
    
    while counter != years.count {
        if years[counter] % 400 == 0 && years[counter] % 100 == 0 {
            print("\(years[counter]) is a leap year")
        } else if years[counter] % 4 == 0 && years[counter] % 100 != 0 {
            print("\(years[counter]) is a leap year")
        } else {
            print("\(years[counter]) is not a leap year")
        }
        
        counter += 1 // No ++
    }
}

func checkLeapYears(_ years: [Int]) {
    
    print("\n USING FOR LOOP \n")
    
    for year in years {
        if year % 400 == 0 && year % 100 == 0 {
            print("\(year) is a leap year")
        } else if year % 4 == 0 && year % 100 != 0 {
            print("\(year) is a leap year")
        } else {
            print("\(year) is not a leap year")
        }
    }
}

func checkLeapYear(for year: Int) -> Bool {
    
    print("\n USING INDIVIDUAL VALUES \n")
    
    if year % 400 == 0 && year % 100 == 0 {
        print("\(year) is a leap year")
        return true
    } else if year % 4 == 0 && year % 100 != 0 {
        print("\(year) is a leap year")
        return true
    } else {
        print("\(year) is not a leap year")
        return false
    }
}

// Making function calls using external labels
checkLeapYear(for: 2030) // For individual years

checkLeapYears([2000, 2004, 2008, 2012, 2016, 2020, 2024, 2028, 2032, 2036, 2040, 204, 2048, 2017])

checkLeapYearsUsingWhileLoop(for: [2000, 2004, 2008, 2012, 2016, 2020, 2024, 2028, 2032, 2036, 2040, 204, 2048, 2017])



/* Question: Write a function that takes an array of integers as input and returns a tuple containing the sum and average of the elements in the array. */
func findSumAndAvg(for values: [Int]) -> (sum: Int, avg: Int?) {
    // First calculating the sum
    var sum: Int = 0
    var avg: Int? = nil
    
    for value in values {
        sum += value
    }
    
    // Now, lets calculate the Avg
    avg = sum / (values.count)
    
    return (sum, avg) // Returning a tuple
}

// Invoking Function
var values = [2, 3, 4]
var result = findSumAndAvg(for: values)
print("")

// Checked for optional here using if let
if let average = result.avg {
    print("Sum of given array \(values) is \(result.sum) and avg is \(average) ")
} else {
    print("sum of given array \(values) is \(result.sum) and avg is nil")
}



/* Question: Create a program to find the frequency of each word in a given sentence and store the results in a dictionary. */
func findWordFrequency(sentence: String) -> [String: Int] {
    var resultDict: [String:Int] = [:] // Intialized Empty dictionsries
    let words = sentence.components(separatedBy: " ")
    
    for word in words { // Now, iterating over the array words which consists of all the words of sentence separated by separator:""
        resultDict[word, default: 0] += 1
    }
    
    return resultDict
}

let sentence = "repeat words repeat words word"
let resultDictionary = findWordFrequency(sentence: sentence)
print("")
print(resultDictionary)


/* Question: Implement a function to print the pattern of a right-angled triangle using asterisks (*)
 based on the input number of rows. (Both Left-Right Angled and Right-Right Angled) */
func printRightAngledTriangleFacingLeft(rows: Int) {
    for i in 1...rows {
        let stars = String(repeating: "*", count: i)
        
        print(stars)
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
    for i in 1...rows {
        let spaces = String(repeating: " ", count: rows - i)
        let stars = String(repeating: "*", count: i)
        
        print(spaces + stars, terminator: "")
        print("\n", terminator: "")
    }
}

// Making Function Call:
print("\nLeft Facing Right Angled Triangle:")
printRightAngledTriangleFacingLeft(rows: 5)

print("\nRight Facing Right Angled Triangle:")
printRightAngledTriangleFacingRight(rows: 5)
