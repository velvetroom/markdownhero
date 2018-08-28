import UIKit

class ItalicsInterpreter:Interpreter {
    let match = ["*", "_"]
    
    func update(font:UIFont) -> UIFont {
        guard let descriptor = UIFontDescriptor(name:font.familyName, size:font.pointSize).withSymbolicTraits(
            [font.fontDescriptor.symbolicTraits, .traitItalic])
            else { return font }
        return UIFont(descriptor:descriptor, size:font.pointSize)
    }
}
