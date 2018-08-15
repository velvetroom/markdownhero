import UIKit

public protocol Parser {
    var font:UIFont { get set }
    
    func parse(string:String, result:@escaping((NSAttributedString) -> Void))
}
