import Foundation

public class Factory {
    class func makeParser() -> Parser {
        return Implementation()
    }
    
    private init() { }
}
