import Foundation

struct StackItem {
    let interpreter:Interpreter
    let format:[Parser.Format:AnyObject]
    
    init(interpreter:Interpreter, format:[Parser.Format:AnyObject]) {
        self.interpreter = interpreter
        self.format = format
    }
}
