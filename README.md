# string_subscript_integer
Access String by integer subscripts instead of the complex String.Index

Swift is a great language. But in acessing String to get slices, I prefer Python's way. I understand Swift's idea is to return a String Slice instead of a String object to avoid copying. But in most cases, the Strings we need to process are very short and cost of copying is very low.

To facilitate myself in my projects, I designed those extensions.

🔴 Sorry, negative indices like Python are not supported. This is just to conform to Swift conventions, although it is easy to realise.

Example:

import UIKit

var greeting = "Hello playground!"
print("Using extension \(greeting[1])")   // Should return "e"

greeting[1]="a"                           // Change the "e" to German style "a", which is "Hallo"

print("Using extension subscript changing e to a \(greeting)")

print( greeting[-100..<100] )                    // Will print the whole string, -100 < 0, that's fine, 100 >= greeting.count, also fine 

print( greeting[0...5], "💚" ,greeting[0...100]) // Will print first 6 chars, and then the whole string

print( greeting[..<5], "💚" ,greeting[..<200] )  // Will print first 5 chars, and then the whole string

print( greeting[...5], "💚" ,greeting[...300] )  // Will print first 5 chars, and then the whole string

print( greeting[5...], "💚" ,greeting[300...] )  // Will print from 6th char, and then nothing, the starting index exceeds boundary 
