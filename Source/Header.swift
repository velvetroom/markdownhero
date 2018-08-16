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
    
    func parse(string:String, items:[HeaderItem], nonHeader:((String) -> NSAttributedString)) -> NSAttributedString {
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
            if let index:String.Index = component.firstIndex(of:"\n") {
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
        let font:UIFont
        if let descriptor:UIFontDescriptor = self.font.fontDescriptor.withSymbolicTraits(
            [self.font.fontDescriptor.symbolicTraits, Parser.Traits.traitBold]) {
            font = UIFont(descriptor:descriptor, size:self.font.pointSize + item.increment)
        } else {
            font = self.font
        }
        return NSAttributedString(string:string, attributes:[Parser.Format.font:font])
    }
}

private struct Constants {
    static let h1:CGFloat = 4.0
    static let h2:CGFloat = 3.0
    static let h3:CGFloat = 2.0
}
