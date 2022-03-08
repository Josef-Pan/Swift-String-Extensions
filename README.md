# string_subscript_integer
Access String by integer subscripts instead of the complex String.Index

Swift is a great language. But in acessing String to get slices, I prefer Python's way. I understand Swift's idea is to return a String Slice instead of a String object to avoid copying. But in most cases, the Strings we need to process are very short and cost of copying is very low.

To facilitate myself in my projects, I designed those extensions.

Example:

import UIKit

var greeting = "Hello playground!"

print( greeting[-100..<100] )                       // Will print the whole string

print( greeting[0...5], "💚" ,greeting[0...100])    // Will print first 6 chars, and then the whole string

print( greeting[..<5], "💚" ,greeting[..<200] )     // Will print first 5 chars, and then the whole string

print( greeting[...5], "💚" ,greeting[...300] )     // Will print first 5 chars, and then the whole string

print( greeting[5...], "💚" ,greeting[300...] )     // Will print from 5th char, and then nothing, the starting index exceeds boundary 
