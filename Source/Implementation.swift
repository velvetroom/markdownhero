import Foundation

class Implementation:Parser {
    private let queue:DispatchQueue
    
    init() {
        self.queue = DispatchQueue(label:Constants.identifier, qos:DispatchQoS.background,
                                   attributes:DispatchQueue.Attributes.concurrent,
                                   autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                   target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    func parse(string:String, result:@escaping((NSAttributedString) -> Void)) {
        self.queue.async { [weak self] in
            guard let parsed:NSAttributedString = self?.parse(string:string) else { return }
            DispatchQueue.main.async { result(parsed) }
        }
    }
    
    private func parse(string:String) -> NSAttributedString {
        return NSAttributedString()
    }
}

private struct Constants {
    static let identifier:String = "markdownhero.parser"
}
