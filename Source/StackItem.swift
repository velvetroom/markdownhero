import Foundation

struct StackItem {
    var interpreter:Interpreter
    var format:[Parser.Format:AnyObject]
    
    init(interpreter:Interpreter, format:[Parser.Format:AnyObject]) {
        self.interpreter = interpreter
        self.format = format
    }
}
