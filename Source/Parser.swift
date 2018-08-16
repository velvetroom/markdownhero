import UIKit

public protocol Parser {
    typealias Format = NSAttributedStringKey
    typealias Traits = UIFontDescriptorSymbolicTraits
    var font:UIFont { get set }
    
    func parse(string:String, result:@escaping((NSAttributedString) -> Void))
}
