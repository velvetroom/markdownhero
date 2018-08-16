import UIKit

protocol Interpreter:AnyObject {
    var match:[String] { get }
    
    func update(font:UIFont) -> UIFont
}

extension Interpreter {
    func update(font:UIFont, traits:UIFontDescriptorSymbolicTraits) -> UIFont {
        guard let descriptor:UIFontDescriptor = font.fontDescriptor.withSymbolicTraits(traits) else { return font }
        return UIFont(descriptor:descriptor, size:font.pointSize)
    }
}
