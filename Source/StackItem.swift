import UIKit

struct StackItem {
    let interpreter:Interpreter
    let font:UIFont
    
    init(interpreter:Interpreter, font:UIFont) {
        self.interpreter = interpreter
        self.font = font
    }
}
