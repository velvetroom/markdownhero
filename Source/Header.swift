import UIKit

class Header {
    private let items:[HeaderItem]
    private let font:UIFont
    
    init(font:UIFont) {
        self.items = [HeaderItem(match:"### ", increment:Constants.h3),
                      HeaderItem(match:"## ", increment:Constants.h2),
                      HeaderItem(match:"# ", increment:Constants.h1)]
        self.font = font
    }
    
    func parse(string:String, nonHeader:((String) -> NSAttributedString)) -> NSAttributedString {
        return self.parse(string:string, items:self.items, nonHeader:nonHeader)
    }
    
    private func parse(string:String, items:[HeaderItem], nonHeader:((String) -> NSAttributedString)) -> NSAttributedString {
        if items.isEmpty {
            return nonHeader(string)
        }
        var items:[HeaderItem] = items
        let item:HeaderItem = items.removeFirst()
        let mutable:NSMutableAttributedString = NSMutableAttributedString()
        var components:[String] = string.components(separatedBy:item.match)
        let first:String = components.removeFirst()
        if !first.isEmpty {
            mutable.append(self.parse(string:first, items:items, nonHeader:nonHeader))
        }
        for component:String in components {
            if let index:String.Index = component.index(of:"\n") {
                mutable.append(self.head(item:item, string:String(component.prefix(upTo:index))))
                mutable.append(
                    self.parse(string:String(component.suffix(from:index)), items:items, nonHeader:nonHeader))
            } else {
                mutable.append(self.head(item:item, string:component))
            }
        }
        return mutable
    }
    
    private func head(item:HeaderItem, string:String) -> NSAttributedString {
        return NSAttributedString(string:string, attributes:[NSAttributedStringKey.font:
            UIFont.systemFont(ofSize:self.font.pointSize + item.increment, weight:UIFont.Weight.heavy)])
    }
}

private struct Constants {
    static let h1:CGFloat = 15.0
    static let h2:CGFloat = 10.0
    static let h3:CGFloat = 4.0
}
