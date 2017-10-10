//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Hello, Swift"
let constStr = str

let number = 42
var countingUp = ["one", "two"]
let secondElement = countingUp[1]

let nameByParkingSpace = [13: "Alice", 27: "Bob"]


var nextYear: Int
var bodyTemp: Float
var hasPet: Bool
var arrayOfInts: [Int]
var dictionaryOfCapitalsByCountry: [String:String]

var winningLotteryNumbers: Set<Int>

// Initializers
let emptyString = String()
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = Set<Float>()

let defaultNumber = Int()
let defaultBool = Bool()

let meaningOfLife = String(number)

let availableRooms = Set([205, 411, 412])

let defaultFloat = Float()
let floatFromLiteral = Float(3.14)
let easyPi = 3.14 // Defaults to a Double
let floatFromDouble = Float(easyPi)
let floatingPie: Float = 3.14

// Properties
// value associated with an instance of a type
countingUp.count

emptyString.isEmpty

// Instance Method
// function that is specific to a particular type and can be called on an instance of that type
countingUp.append("three")

// Optionals
var reading1: Float?
var reading2: Float?
var reading3: Float?

reading1 = 9.8
reading2 = 9.2
reading3 = 9.7

// Force unwrapping optional
//let avgReading = (reading1! + reading2! + reading3!) / 3

// Safer way to unwrap optional using optional binding
if let r1 = reading1, let r2 = reading2, let r3 = reading3 {
    let avgReading = (r1 + r2 + r3) / 3
    print(avgReading)
} else {
    let errorString = "Instrument reported a reading that was nil"
}

// Subscripting dictionaries
let space13Assignee: String? = nameByParkingSpace[13]
let space42Assignee: String? = nameByParkingSpace[42]

if let space13Assignee = nameByParkingSpace[13] {
    print("Key 13 is assigned in the dictionary")
}

// Loops and String Interpolation

let range = 0..<countingUp.count

//for i in range {
//    let string = countingUp[i]
//}
//
//for (i, string) in countingUp.enumerated() {
//
//}

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
}

// Enumerations and switch statement

// raw value is an integer type, values automatically increment
enum PieType: Int {
    case apple = 0
    case cherry // will be 1
    case pecan // will be 2
}

let favouritePie = PieType.apple

let name: String

switch favouritePie {
case .apple:
    name = "Apple"
case .cherry:
    name = "Cherry"
case .pecan:
    name = "Pecan"
}

let pieRawValue = PieType.pecan.rawValue

if let pieType = PieType(rawValue: pieRawValue) {
    print("Got a valid pie type")
}



















