import UIKit
import Foundation
var greeting = "Hello, playground"

var a=5;
var b=8;
print(" value of a is \(a)");
print(" value of b is \(b)");

// it runs code from 1 uptill where wwe have pressed the play button
//--------------FizzBuzz Fn Implementation

print("\n\n")
print(" Running FizzBuzz")
func runfizzbuzz(){
    
    for item in 1...100{
        
        if item % 3 == 0 && item % 5==0 {
            print("FizzBuzz")
        }else if item % 3 == 0 {
            print("Fizz")
        }else if item % 5 == 0 {
            print("Buzz")
        }
    }
    
    print(" Ending FizzBuzz")
}


//this is our comment
runfizzbuzz()
print("\n\n")

print(" Running Reverser Fn")
//--------------Reverser Fn Implementation
//var a1 = 5
//var b1 = 8
//reversing the numbers without using a 3rd variable




func exercise( a1 : inout Int, b1 : inout Int) {
    
  
   
    
    
    print(" was inside fn ")
    a1 = a1+b1;//tot
    b1 = a1-b1;//a1
    a1 = a1-b1//b1
    // var c = a
    // a = b
    // b = c
    
    print("a1: \(a1)")
    print("b1: \(b1)")
    

    print("\n\n")
}


 a = 5
 b = 8

print("initially a1: \(a)")
print("initially b1: \(b)")
exercise( a1 :&a,b1: &b)//passing be refernce

print(" Ending Reverser Fn")

print(" was outside fn ")
print("a1: \(a)")
print("b1: \(b)")
