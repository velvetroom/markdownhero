import UIKit

class Implementation:Parser {
    var font:UIFont
    private let interpreters:[InterpreterProtocol]
    private let cleaner:Cleaner
    private let queue:DispatchQueue
    
    init() {
        self.interpreters = [BoldInterpreter(), ItalicsInterpreter()]
        self.cleaner = Cleaner()
        self.font = UIFont.systemFont(ofSize:ParseConstants.font, weight:UIFont.Weight.regular)
        self.queue = DispatchQueue(label:ParseConstants.identifier, qos:DispatchQoS.background,
                                   attributes:DispatchQueue.Attributes.concurrent,
                                   autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                   target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func parse(string:String, result:@escaping((NSAttributedString) -> Void)) {
        let stack:[StackItem] = [StackItem(interpreter:PlainInterpreter(), font:self.font)]
        self.queue.async { [weak self] in
            guard
                let cleaned:String = self?.cleaner.clean(string:string),
                let parsed:NSAttributedString = self?.parse(string:cleaned, stack:stack)
            else { return }
            DispatchQueue.main.async { result(parsed) }
        }
    }
    
    private func parse(string:String, stack:[StackItem]) -> NSAttributedString {
        print("\nstring:\(string)\nstack:\(stack)\n")
        
        var stack:[StackItem] = stack
        if let character:InterpreterCharacter = self.next(string:string) {
            if character == stack.last {
                stack.removeLast()
                
            } else {
                let mutable:NSMutableAttributedString = NSMutableAttributedString()
                let prefix:String = String(string.prefix(upTo:closest!.lowerBound))
                if !prefix.isEmpty {
                    mutable.append(NSAttributedString(string:prefix, attributes:attributes))
                }
                stack.append(next)
                let suffix:String = String(string.suffix(from:closest!.upperBound))
                mutable.append(self.parse(string:suffix, stack:stack, font:font))
                return mutable
            }
        } else {
            return NSAttributedString(string:string, attributes:[NSAttributedString.Key.font:stack.last!.font])
        }
    }
    
    private func next(string:String) -> InterpreterCharacter? {
        var character:InterpreterCharacter?
        self.interpreters.forEach { (item:InterpreterProtocol) in
            guard let interpreterIndex:Range<String.Index> = self.next(string:string, interpreter:item) else { return }
            if character == nil || (character != nil && interpreterIndex.lowerBound < character!.index.lowerBound) {
                character = InterpreterCharacter(interpreter:item, index:interpreterIndex)
            }
        }
        return character
    }
    
    private func next(string:String, interpreter:InterpreterProtocol) -> Range<String.Index>? {
        var index:Range<String.Index>?
        interpreter.match.forEach { (item:String) in
            guard let range:Range<String.Index> = string.range(of:item) else { return }
            if index == nil || (index != nil && range.lowerBound < index!.lowerBound) {
                index = range
            }
        }
        return index
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
