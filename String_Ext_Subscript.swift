import UIKit


/// Common extensions of Swift String
/// This file will be constantly updated with new features

extension String {
    /// Generate a random string from letters, containing from 1 to max_length chars
    /// chars include all letters, all digits, and SPACE
    static func radomString(min_length:Int, max_length: Int) ->String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 "
        let max = Swift.min(max_length, letters.count)
        let length = Int.random(in: min_length...max) //minimum 1, maximum max_length or letters.count
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func widthWithFont(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightWithFont(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return size.height
    }
    
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound ? nsString.substring(with: result.range(at: $0)) : ""
            }
        }
    }
    
    var containsSpecialCharacter: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    var allDigits: Bool {
        let regex = "[0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    var isPostCode: Bool { // Australian Postcode
        let regex = "[0-9]{4}"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    // Australian Fixed Line Phone, - or space allowed in between digits
    // 2 area code + 8 digits
    var isFixedLinePhoneNumber: Bool {
        let regex = "0[0-9 \\-()]{9,}" // First digit should be 0
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        let countDigits = self.filter { "0123456789".contains($0)}.count
        return testString.evaluate(with: self) && countDigits == 10
    }
    // Australian Mobile Phone Number, - or space allowed in between digits
    // 0 MMM NNN PPP, second digit can be required to be 4
    var isMobilePhoneNumber: Bool {
        let regex = "0[0-9 \\-()]{9,}" // First digit should be 0
        //let regex = "04[0-9 \\-()]{8,}" // First 2 digits should be 04, use this regex if 04 is required
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        let countDigits = self.filter { "0123456789".contains($0)}.count
        return testString.evaluate(with: self) && countDigits == 10
    }
    
    var isStreetAddress: Bool {
        //let regex = "[A-Za-z0-9\\-, .#]{6,}" // too strict
        let regex = ".{7,}" // Any string longer than 7
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    var isEmail: Bool {
        let regex = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    /// Use integer index to get or set character of the string
    ///  Like common array operations, the user is responsible to make sure index is legal
    /// - Parameter ix: index
    /// - Returns: Character
    subscript (ix: Int) -> Character { // 🔴 Using of this function needs to make sure the ix is legal
        get {
            let index = self.index(self.startIndex, offsetBy: ix)
            return self[index]
        }
        set {
            let index = self.index(self.startIndex, offsetBy: ix)
            self.replaceSubrange(index...index, with: String(newValue))
        }
        
    }
    
    /// Use integer range to get a slice from String
    ///  lower bound and upper bound are checked, so it is safe even it exceeds string length
    /// - Parameter r: Range, eg.  2..<10, 0..<5
    /// - Returns: String
    subscript (r: Range<Int>) -> String{ // ✅ Safe to use Range from any indices, even exceeding boundary
        get {
            // Keep starting idx between 0 and boundary
            let lowerBound  = min(max(r.lowerBound, 0), self.count-1)
            // Keep ending idx between 0 and boundary
            let upperBound  = max(min(r.upperBound, self.count-1), 0)
            let startIndex = self.index(self.startIndex, offsetBy: lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /// Use integer range to get a slice from String
    ///  lower bound and upper bound are checked, so it is safe even it exceeds string length
    /// - Parameter r: ClosedRange, eg.  2...10, 0...5
    /// - Returns: String
    subscript (r: ClosedRange<Int>) -> String{
        // ✅  Safe to use Range from any indices, even exceeding boundary
        get {
            // Keep starting idx between 0 and boundary
            let lowerBound  = min(max(r.lowerBound, 0), self.count-1)
            // Keep ending idx between 0 and boundary
            let upperBound  = max(min(r.upperBound, self.count-1), 0)
            let startIndex = self.index(self.startIndex, offsetBy: lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[startIndex...endIndex])
        }
    }
    
    /// Use integer range to get a slice from String
    ///  lower bound and upper bound are checked, so it is safe even it exceeds string length
    /// - Parameter r: PartialRangeUpTo, eg.  ..<10, ..<5
    /// - Returns: String
    subscript (r: PartialRangeUpTo<Int>) -> String{
        // ✅  Safe to use Range from any indices, even exceeding boundary
        get {
            let upperBound  = max(min(r.upperBound, self.count-1), 0) // Keep starting idx between 0 and boundary
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /// Use integer range to get a slice from String
    ///  lower bound and upper bound are checked, so it is safe even it exceeds string length
    /// - Parameter r: PartialRangeThrough, eg.  ...10, ...5
    /// - Returns: String
    subscript (r: PartialRangeThrough<Int>) -> String{
        // ✅ Safe to use Range from any indices, even exceeding boundary
        get {
            // Keep ending idx between 0 and boundary
            let upperBound  = max(min(r.upperBound, self.count-1), 0)
            
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[startIndex...endIndex])
        }
    }
    /// Use integer range to get a slice from String
    ///  lower bound and upper bound are checked, so it is safe even it exceeds string length
    /// - Parameter r: PartialRangeFrom, eg.  0..., 5..., 100...
    /// - Returns: String
    subscript (r: PartialRangeFrom<Int>) -> String{
        // ✅ Safe to use Range from any indices, even exceeding boundary
        get {
            // Keep starting idx between 0 and boundary
            let lowerBound  = min(max(r.lowerBound, 0), self.count-1)
            let startIndex = self.index(self.startIndex, offsetBy: lowerBound)
            return String(self[startIndex...])
        }
    }
    
}

