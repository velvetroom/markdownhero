import Foundation

struct Position {
    var interpreter:Interpreter
    var index:Range<String.Index>
    
    init(interpreter:Interpreter, index:Range<String.Index>) {
        self.interpreter = interpreter
        self.index = index
    }
}
