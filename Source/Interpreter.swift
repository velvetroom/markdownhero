import UIKit

protocol Interpreter {
    func parse(string:String, attributes:[NSAttributedString.Key:AnyObject]) -> NSAttributedString?
}

extension Interpreter {
    func separatedBy(string:String, character:Character, attributes:[NSAttributedString.Key:AnyObject],
                     updated:[NSAttributedString.Key:AnyObject]) -> NSAttributedString? {
        let components:[String.SubSequence] = string.split(
            separator:character, maxSplits:2, omittingEmptySubsequences:false)
        if components.count > 2 {
            let mutable:NSMutableAttributedString = NSMutableAttributedString()
            if !components[0].isEmpty {
                mutable.append(Implementation.interpret(string:String(components[0]), attributes:attributes))
            }
            mutable.append(Implementation.interpret(string:String(components[1]), attributes:updated))
            if !components[2].isEmpty {
                mutable.append(Implementation.interpret(string:String(components[2]), attributes:attributes))
            }
            return mutable
        }
        return nil
    }
    
    func updated(attributes:[NSAttributedString.Key:AnyObject],
                 traits:UIFontDescriptor.SymbolicTraits) -> [NSAttributedString.Key:AnyObject] {
        guard
            let original:UIFont = attributes[NSMutableAttributedString.Key.font] as? UIFont,
            let descriptor:UIFontDescriptor = original.fontDescriptor.withSymbolicTraits([
                original.fontDescriptor.symbolicTraits, traits])
        else { return attributes }
        let font:UIFont = UIFont(descriptor:descriptor, size:original.pointSize)
        var updated:[NSAttributedString.Key:AnyObject] = attributes
        updated[NSMutableAttributedString.Key.font] = font
        return updated
    }
}
