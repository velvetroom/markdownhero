import UIKit

protocol InterpreterProtocol {
    var match:[String] { get }
    
    func attributes(original:[NSAttributedString.Key:AnyObject]) -> [NSAttributedString.Key:AnyObject]
}

extension InterpreterProtocol {
    func update(original:[NSAttributedString.Key:AnyObject],
                traits:UIFontDescriptor.SymbolicTraits) -> [NSAttributedString.Key:AnyObject] {
        guard
            let font:UIFont = original[NSMutableAttributedString.Key.font] as? UIFont,
            let descriptor:UIFontDescriptor = font.fontDescriptor.withSymbolicTraits([
                font.fontDescriptor.symbolicTraits, traits])
        else { return original }
        let newFont:UIFont = UIFont(descriptor:descriptor, size:font.pointSize)
        var updated:[NSAttributedString.Key:AnyObject] = original
        updated[NSMutableAttributedString.Key.font] = newFont
        return updated
    }
}
