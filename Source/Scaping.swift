import UIKit

class Scaping {
    private let font:UIFont
    
    init(font:UIFont) {
        self.font = font
    }
    
    func parse(string:String, nonScaped:((String) -> NSAttributedString)) -> NSAttributedString {
        var components:[String] = string.components(separatedBy:Constants.scaping)
        let mutable:NSMutableAttributedString = NSMutableAttributedString()
        for index:Int in 0 ..< components.count {
            if index % 2 == 0 {
                mutable.append(nonScaped(components[index]))
            } else {
                mutable.append(NSAttributedString(string:components[index], attributes:[Parser.Format.font:self.font]))
            }
        }
        return mutable
    }
}

private struct Constants {
    static let scaping:String = "```"
}
