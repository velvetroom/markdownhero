import UIKit

class Implementation:Parser {
    var font:UIFont
    private let cleaner:Cleaner
    private let queue:DispatchQueue
    
    init() {
        self.cleaner = Cleaner()
        self.font = UIFont.systemFont(ofSize:ParseConstants.font, weight:UIFont.Weight.regular)
        self.queue = DispatchQueue(label:ParseConstants.identifier, qos:DispatchQoS.background,
                                   attributes:DispatchQueue.Attributes.concurrent,
                                   autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                   target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func parse(string:String, result:@escaping((NSAttributedString) -> Void)) {
        let font:UIFont = self.font
        self.queue.async { [weak self] in
            guard
                let cleaned:String = self?.cleaner.clean(string:string),
                let parsed:NSAttributedString = self?.parse(string:cleaned, attributes:[
                    NSAttributedString.Key.font:font])
            else { return }
            DispatchQueue.main.async { result(parsed) }
        }
    }
    
    class func interpret(string:String, attributes:[NSAttributedString.Key:AnyObject]) -> NSAttributedString {
        for item:Interpreter in interpreters {
            if let result:NSAttributedString = item.parse(string:string, attributes:attributes) {
                return result
            }
        }
        return NSAttributedString(string:string, attributes:attributes)
    }
    
    private func parse(string:String, attributes:[NSAttributedString.Key:AnyObject]) -> NSAttributedString {
        return Implementation.interpret(string:string, attributes:attributes)
    }
    
    private static let interpreters:[Interpreter] = [
        TraitsInterpreter(character:Constants.boldItalics, trait:[UIFontDescriptor.SymbolicTraits.traitBold,
                                                                  UIFontDescriptor.SymbolicTraits.traitItalic]),
        TraitsInterpreter(character:Constants.bold, trait:UIFontDescriptor.SymbolicTraits.traitBold),
        TraitsInterpreter(character:Constants.italics, trait:UIFontDescriptor.SymbolicTraits.traitItalic)]
}

private struct ParseConstants {
    static let identifier:String = "markdownhero.parser"
    static let font:CGFloat = 14
}
