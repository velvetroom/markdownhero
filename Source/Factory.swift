import Foundation

public class Factory {
    public class func makeParser() -> Parser {
        return Implementation()
    }
    
    private init() { }
}
