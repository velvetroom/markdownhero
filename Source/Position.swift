import Foundation

struct Position {
    let interpreter:Traits
    let index:Range<String.Index>
    
    init(interpreter:Traits, index:Range<String.Index>) {
        self.interpreter = interpreter
        self.index = index
    }
}
