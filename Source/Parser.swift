import UIKit

public class Parser {
    private static let identifier = "markdownhero.parser"
    private static let font:CGFloat = 14
    
    public var font:UIFont
    private let traits:[Interpreter]
    private let cleaner:Cleaner
    private let queue:DispatchQueue
    
    public init() {
        traits = [BoldInterpreter(), ItalicsInterpreter()]
        cleaner = Cleaner()
        font = UIFont.systemFont(ofSize:Parser.font, weight:.ultraLight)
        queue = DispatchQueue(label:Parser.identifier, qos:.background, attributes:.concurrent,
                              autoreleaseFrequency:.inherit, target:.global(qos:.background))
    }
    
    public func parse(string:String, result:@escaping((NSAttributedString) -> Void)) {
        queue.async { [weak self] in
            guard let parsed = self?.parse(string:string) else { return }
            DispatchQueue.main.async { result(parsed) }
        }
    }
    
    public func parse(string:String) -> NSAttributedString {
        let header = Header(font:font)
        return Scaping(font:font).parse(string:string) { (nonScaping) -> NSAttributedString in
            header.parse(string:cleaner.clean(string:nonScaping)) { (nonHeader) -> NSAttributedString in
                return traits(string:nonHeader, stack:Stack(font:font))
            }
        }
    }
    
    private func traits(string:String, stack:Stack) -> NSAttributedString {
        let mutable:NSMutableAttributedString = NSMutableAttributedString()
        let attributes:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font:stack.items.last!.font]
        if let position:Position = self.next(string:string, stack:stack) {
            stack.add(interpreter:position.interpreter)
            mutable.append(NSAttributedString(string:String(string.prefix(upTo:position.index.lowerBound)),
                                              attributes:attributes))
            mutable.append(self.traits(string:String(string.suffix(from:position.index.upperBound)), stack:stack))
        } else {
            mutable.append(NSAttributedString(string:string, attributes:attributes))
        }
        return mutable
    }
    
    private func next(string:String, stack:Stack) -> Position? {
        var character:Position?
        self.traits.forEach { (item:Interpreter) in
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
