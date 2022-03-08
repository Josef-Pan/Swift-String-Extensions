import Foundation
// Extensions to acess String directly by integer index, or integer Range
// eg. string[2], string[2..<5], string[2...5], string[...5], string[..<5], string[2...]
// Safe even integers exceeding boundaries
extension String{
    subscript (ix: Int) -> Character { // 🔴Using of this function needs to make sure the ix is legal
        get {
            let index = self.index(self.startIndex, offsetBy: ix)
            return self[index]
        }
        set {
            let index = self.index(self.startIndex, offsetBy: ix)
            self.replaceSubrange(index...index, with: String(newValue))
        }
        
    }
    subscript (r: Range<Int>) -> String{ // ✅ Safe to use Range from any kind of indices
        get {
            let lowerBound  = min(max(r.lowerBound, 0), self.count-1) // Keep starting idx between 0 and boundary
            let upperBound  = max(min(r.upperBound, self.count-1), 0) // Keep ending idx between 0 and boundary
            let startIndex = self.index(self.startIndex, offsetBy: lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    subscript (r: ClosedRange<Int>) -> String{ // ✅ Safe to use Range from any kind of indices
        get {
            let lowerBound  = min(max(r.lowerBound, 0), self.count-1) // Keep starting idx between 0 and boundary
            let upperBound  = max(min(r.upperBound, self.count-1), 0) // Keep ending idx between 0 and boundary
            let startIndex = self.index(self.startIndex, offsetBy: lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[startIndex...endIndex])
        }
    }
    subscript (r: PartialRangeUpTo<Int>) -> String{ // ✅ Safe to use Range from any kind of indices
        get {
            let upperBound  = max(min(r.upperBound, self.count-1), 0) // Keep starting idx between 0 and boundary
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    subscript (r: PartialRangeThrough<Int>) -> String{ // ✅ Safe to use Range from any kind of indices
        get {
            let upperBound  = max(min(r.upperBound, self.count-1), 0) // Keep ending idx between 0 and boundary
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[startIndex...endIndex])
        }
    }
    subscript (r: PartialRangeFrom<Int>) -> String{ // ✅ Safe to use Range from any kind of indices
        get {
            let lowerBound  = min(max(r.lowerBound, 0), self.count-1) // Keep starting idx between 0 and boundary
            let startIndex = self.index(self.startIndex, offsetBy: lowerBound)
            return String(self[startIndex...])
        }
    }
}

