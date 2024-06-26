import UIKit
import Foundation

//MARK: 1. Define an enumeration called Shape to represent different geometric shapes (Circle, Square, Rectangle, Triangle). Each shape should have associated values to represent its properties (e.g., radius for Circle, width and height for Rectangle). Implement methods inside the enum to calculate the area and perimeter of each shape.

enum Shape {
    case circle(radius: Double)
    case square(side: Double)
    case rectangle(width: Double, height: Double)
    case triangle(base: Double, height: Double, sideA: Double, sideB: Double)
    // sideC is base of our triangle only
    
    // Here we have different cases and associated types which would be used to calculate the area and perimeter later on
    
    // Functions inside structs, classes, enums are known as methods
    
    //  The basic formula for the area of a triangle is equal to half the product of its base and height, i.e., A = 1/2 × b × h. This formula is applicable to all types of triangles, whether it is a scalene triangle, an isosceles triangle, or an equilateral triangle.
    
    // We would be using self here as we are already within the enum so working on its current instance
    
    func area() -> Any { // We could have used Double also to return
        switch self {
        case .circle(let radius):
            return Double.pi * radius * radius
        case .square(let side):
            return side * side
        case .rectangle(let width, let height):
            return width * height
        case .triangle(let base, let height, _ , _):
            return base * height / 2
            
    // We have used _ here to ignore the sides because we don't need them while caluclating area
            
    // Accessing the property pi of Double for 3.14
            
    // Let has been used here to capture the values and then using them within the block of code
        }
    }
    
    func perimeter() -> Any {
        switch self {
        case .circle(let radius):
            return 2 * Double.pi * radius
        case .square(let side):
            return 4 * side
        case .rectangle(let width, let height):
            return 2 * (width + height)
        case .triangle(let base, _, let sideA, let sideB):
            // Assuming sideC is equal to base for our triangle
            let sideC = base
            return sideA + sideB + sideC
        }
    }
}

print("Question 1 Output:")

// Example usage:
let circle = Shape.circle(radius: 5)
print("Circle area: \(circle.area())")
print("Circle perimeter: \(circle.perimeter())")
print("")

let equilateralTriangle = Shape.triangle(base: 20, height: 30, sideA: 20, sideB: 20) // now, we can omit sideC from here as we have removed it from params of enum triangle and allocating value to it inside the enum method directly
print("Triangle area: \(equilateralTriangle.area())")
print("Triangle perimeter: \(equilateralTriangle.perimeter())")
print("")



//MARK: 2. Create a struct called Contact to represent a person's contact information, including name, phone number, and email address. Implement a method to display the contact information and a method to take all the information.

// Define a struct to represent contact information
struct Contact {
    var name: String // These have been declared as var because they can be mutated/changed further in program
    var phoneNumber: String
    var emailAddress: String
    
    // Method to display the contact information
    func displayContactInfo() -> String {
        return "Name: \(self.name)\nPhone Number: \(self.phoneNumber)\nEmail Address: \(self.emailAddress)"
    }
    
    // Method to update the contact information with optional parameters for name, phone number and email address
    mutating func updateContactInfo(name: String? = nil, phoneNumber: String? = nil, emailAddress: String? = nil) {
        // Default value is nil/null here
        if let newName = name {
            self.name = newName
        }
        // Update phoneNumber only if a new value is provided
        if let newPhoneNumber = phoneNumber {
            self.phoneNumber = newPhoneNumber
        }
        // Update emailAddress only if a new value is provided
        if let newEmailAddress = emailAddress {
            self.emailAddress = newEmailAddress
        }
    }
}

print("Question 2 Output:")

// This object of structure should be var to mutate its proprties
var newContact = Contact(name: "nameOfSubject", phoneNumber: "phoneNumberOfSubject", emailAddress: "emailOfSubject")

print(newContact.displayContactInfo())

// So, by making use of optionals we can just change 1 or 2 properties while not having to re-enter the old unchanged properties as optional allows us the freedom to assign or not assign any property according to our own needs when ever-where ever we need to
newContact.updateContactInfo(name: "hey", phoneNumber: "hey")

print("")
print(newContact.displayContactInfo())
print("")



//MARK: 3. Define a class called Playlist to represent a music playlist. Each playlist should have a name, an array of songs, and methods to add a song, remove a song, and shuffle the playlist.

// Class for Song
class Song {
    var title: String
    var artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

// Class for Playlist
class Playlist {
    var name: String
    var songs: [Song] // Array of type Song
    
    init(name: String) {
        self.name = name
        self.songs = [] // Initialized the array of songs with empty array
    }
    
    // Method to add a song to the playlist
    func addSong(_ song: Song) {
        self.songs.append(song)
    }
    
    // Method to remove a song from the playlist
    func removeSong(_ song: Song) {
        self.songs.removeAll(where: { $0.artist == song.artist && $0.title == song.title })
    }
    
    // Method to shuffle the playlist
    func shuffle() {
        self.songs.shuffle()
    }
    
    // Method to display the playlist
    func displayPlaylist() -> String {
        var displayString = "Playlist: \(name)\n"
        
        for song in self.songs {
            displayString += "- \(song.title) by \(song.artist)\n"
        }
        
        return displayString
    }
}

print("Question 3 Output:")

// Implementation:
let playlist = Playlist(name: "My Playlist")
let song1 = Song(title: "Shape of You", artist: "Ed Sheeran")
let song2 = Song(title: "Believer", artist: "Imagine Dragons")
let song3 = Song(title: "Faded", artist: "Alan Walker")
let song4 = Song(title: "Tum Hi Aana", artist: "Jubin Nautiyal")
let song5 = Song(title: "Perfect", artist: "Ed Sheeran")

playlist.addSong(Song(title: "new song", artist: "new artist"))
playlist.addSong(song1)
playlist.addSong(song2)
playlist.addSong(song3)
playlist.addSong(song5)

print(playlist.displayPlaylist())

playlist.removeSong(song1)

print("\nAfter removing a song:")
print(playlist.displayPlaylist())


print("\nAfter adding a song:")
playlist.addSong(song4)
print(playlist.displayPlaylist())


print("\nAfter shuffling the playlist:")
playlist.shuffle()
print(playlist.displayPlaylist())



