import UIKit

class BoldInterpreter:Interpreter {
    let match = ["**", "__"]
    
    func update(font:UIFont) -> UIFont {
        guard let descriptor = UIFontDescriptor(name:font.familyName, size:font.pointSize).withSymbolicTraits(
            [font.fontDescriptor.symbolicTraits, .traitBold])
        else { return font }
        return UIFont(descriptor:descriptor, size:font.pointSize)
    }
}
