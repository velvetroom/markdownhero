import UIKit

protocol Traits:AnyObject {
    var match:[String] { get }
    
    func update(format:[Parser.Format:AnyObject]) -> [Parser.Format:AnyObject]
}

extension Traits {
    func update(original:[Parser.Format:AnyObject], traits:Parser.Traits) -> [Parser.Format:AnyObject] {
        guard
            let font:UIFont = original[Parser.Format.font] as? UIFont,
            let descriptor:UIFontDescriptor = font.fontDescriptor.withSymbolicTraits(
                [font.fontDescriptor.symbolicTraits, traits])
        else { return original }
        let newFont:UIFont = UIFont(descriptor:descriptor, size:font.pointSize)
        var updated:[Parser.Format:AnyObject] = original
        updated[Parser.Format.font] = newFont
        return updated
    }
}
