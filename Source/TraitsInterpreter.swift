import UIKit

class TraitsInterpreter:Interpreter {
    private let character:Character
    private let trait:UIFontDescriptor.SymbolicTraits
    
    init(character:Character, trait:UIFontDescriptor.SymbolicTraits) {
        self.character = character
        self.trait = trait
    }
    
    func parse(string:String, attributes:[NSAttributedString.Key:AnyObject]) -> NSAttributedString? {
        return self.separatedBy(string:string, character:self.character, attributes:attributes, updated:
            self.updated(attributes:attributes, traits:self.trait))
    }
}
