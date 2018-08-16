import UIKit

class Implementation:Parser {
    var font:UIFont
    private let interpreters:[Interpreter]
    private let cleaner:Cleaner
    private let queue:DispatchQueue
    
    init() {
        self.interpreters = [BoldInterpreter(), ItalicsInterpreter()]
        self.cleaner = Cleaner()
        self.font = UIFont.systemFont(ofSize:Constants.font, weight:UIFont.Weight.regular)
        self.queue = DispatchQueue(label:Constants.identifier, qos:DispatchQoS.background,
                                   attributes:DispatchQueue.Attributes.concurrent,
                                   autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                   target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func parse(string:String, result:@escaping((NSAttributedString) -> Void)) {
        let stack:Stack = Stack(font:self.font)
        self.queue.async { [weak self] in
            guard
                let cleaned:String = self?.cleaner.clean(string:string),
                let parsed:NSAttributedString = self?.parse(string:cleaned, stack:stack)
            else { return }
            DispatchQueue.main.async { result(parsed) }
        }
    }
    
    private func parse(string:String, stack:Stack) -> NSAttributedString {
        let mutable:NSMutableAttributedString = NSMutableAttributedString()
        let attributes:[Parser.Format:AnyObject] = stack.items.last!.format
        if let position:Position = self.next(string:string, stack:stack) {
            stack.add(interpreter:position.interpreter)
            mutable.append(NSAttributedString(string:String(string.prefix(upTo:position.index.lowerBound)),
                                              attributes:attributes))
            mutable.append(self.parse(string:String(string.suffix(from:position.index.upperBound)), stack:stack))
        } else {
            mutable.append(NSAttributedString(string:string, attributes:attributes))
        }
        return mutable
    }
    
    private func next(string:String, stack:Stack) -> Position? {
        var character:Position?
        self.interpreters.forEach { (item:Interpreter) in
            guard
                stack.canBeNext(interpreter:item),
                let interpreterIndex:Range<String.Index> = self.next(string:string, interpreter:item)
            else { return }
            if character == nil || (character != nil && interpreterIndex.lowerBound < character!.index.lowerBound) {
                character = Position(interpreter:item, index:interpreterIndex)
            }
        }
        return character
    }
    
    private func next(string:String, interpreter:Interpreter) -> Range<String.Index>? {
        var index:Range<String.Index>?
        interpreter.match.forEach { (item:String) in
            guard let range:Range<String.Index> = string.range(of:item) else { return }
            if index == nil || (index != nil && range.lowerBound < index!.lowerBound) {
                index = range
            }
        }
        return index
    }
}

private struct Constants {
    static let identifier:String = "markdownhero.parser"
    static let font:CGFloat = 14
}
