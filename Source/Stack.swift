import UIKit

class Stack {
    var items:[StackItem]
    
    init(font:UIFont) {
        items = [StackItem(interpreter:PlainInterpreter(), font:font)]
    }
    
    func canBeNext(interpreter:Interpreter) -> Bool {
        for index in 0 ..< items.count - 1 {
            if interpreter === items[index].interpreter {
                return false
            }
        }
        return true
    }
    
    func add(interpreter:Interpreter) {
        if interpreter === items.last!.interpreter {
            items.removeLast()
        } else {
            items.append(StackItem(interpreter:interpreter, font:interpreter.update(font:items.last!.font)))
        }
    }
}
