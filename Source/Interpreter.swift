import UIKit

protocol Interpreter:AnyObject {
    var match:[String] { get }
    
    func update(font:UIFont) -> UIFont
}
