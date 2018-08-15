import Foundation

public protocol Parser {
    func parse(string:String, result:@escaping((NSAttributedString) -> Void))
}
