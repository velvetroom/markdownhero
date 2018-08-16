import UIKit

public protocol Parser {
    typealias Format = NSAttributedString.Key
    typealias Traits = UIFontDescriptor.SymbolicTraits
    var font:UIFont { get set }
    
    func parse(string:String) -> NSAttributedString
    func parse(string:String, result:@escaping((NSAttributedString) -> Void))
}
