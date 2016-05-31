//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Hello,Swift"
let constStr = str

var a:Float?
var b:Float?
var c:Float?



let nameByParkingSpace = [13: "Alice", 27 : "Bob"]

for (space,name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
}

enum PieType: Int {
    case Apple
    case Cherry
    case Pecan
}
let favoritePie = PieType.Apple
let name: String
switch favoritePie {
case .Apple:
    name = "Apple"
case .Cherry:
    name = "Cherry"
case .Pecan:
    name = "Pecan"
}
print(name)


let osxVersion: Int = Int()

switch osxVersion {
case 0...8:
    print("a big cat")
case 9:
    print("Mavericks")
case 10:
    print("Yosemite")
default:
    print("Greetings, people of the future! What's new in 10. \(osxVersion)?")
}
let pieRawValue = PieType.Cherry.rawValue

if let pieType = PieType(rawValue: pieRawValue) {
pieType
}