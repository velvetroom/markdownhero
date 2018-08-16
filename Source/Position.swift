import Foundation

struct Position {
    let interpreter:Interpreter
    let index:Range<String.Index>
    
    init(interpreter:Interpreter, index:Range<String.Index>) {
        self.interpreter = interpreter
        self.index = index
    }
}
