import UIKit

public class Hero {
    public var font = UIFont.systemFont(ofSize:14, weight:.light)
    private let traits:[Interpreter] = [BoldInterpreter(), ItalicsInterpreter()]
    private let cleaner = Cleaner()
    private let queue = DispatchQueue(label:String(), qos:.background, attributes:.concurrent,
                                      target:.global(qos:.background))
    
    public init() { }
    
    public func parse(string:String, result:@escaping((NSAttributedString) -> Void)) {
        queue.async { [weak self] in
            guard let parsed = self?.parse(string:string) else { return }
            DispatchQueue.main.async { result(parsed) }
        }
    }
    
    public func parse(string:String) -> NSAttributedString {
        let header = Header(font:font)
        return Escaping(font:font).parse(string:string) { nonScaping -> NSAttributedString in
            header.parse(string:cleaner.clean(string:nonScaping)) { nonHeader -> NSAttributedString in
                return traits(string:nonHeader, stack:Stack(font:font))
            }
        }
    }
    
    private func traits(string:String, stack:Stack) -> NSAttributedString {
        let mutable = NSMutableAttributedString()
        let font = stack.items.last!.font
        if let position = next(string:string, stack:stack) {
            stack.add(interpreter:position.interpreter)
            mutable.append(NSAttributedString(string:String(string.prefix(upTo:position.index.lowerBound)),
                                              attributes:[.font:font]))
            mutable.append(traits(string:String(string.suffix(from:position.index.upperBound)), stack:stack))
        } else {
            mutable.append(NSAttributedString(string:string, attributes:[.font:font]))
        }
        return mutable
    }
    
    private func next(string:String, stack:Stack) -> Position? {
        return traits.reduce(into:nil) { character, item in
            guard
                stack.canBeNext(interpreter:item),
                let interpreterIndex = next(string:string, interpreter:item)
            else { return }
            if character == nil || (character != nil && interpreterIndex.lowerBound < character!.index.lowerBound) {
                character = Position(interpreter:item, index:interpreterIndex)
            }
        }
    }
    
    private func next(string:String, interpreter:Interpreter) -> Range<String.Index>? {
        return interpreter.match.reduce(into:nil) { index, item in
            guard let range = string.range(of:item) else { return }
            if index == nil || (index != nil && range.lowerBound < index!.lowerBound) {
                index = range
            }
        }
    }
}
