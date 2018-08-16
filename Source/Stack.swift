import UIKit

class Stack {
    var items:[StackItem]
    
    init(font:UIFont) {
        self.items = [StackItem(interpreter:PlainInterpreter(), format:[Parser.Format.font:font])]
    }
    
    func canBeNext(interpreter:Interpreter) -> Bool {
        for index:Int in 0 ..< self.items.count - 1 {
            if interpreter === self.items[index].interpreter {
                return false
            }
        }
        return true
    }
    
    func add(interpreter:Interpreter) {
        if interpreter === self.items.last!.interpreter {
            self.items.removeLast()
        } else {
            self.items.append(StackItem(interpreter:interpreter, format:
                interpreter.update(format:self.items.last!.format)))
        }
    }
}
