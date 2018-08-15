import Foundation

class Cleaner {
    private let table:[(String, String)]
    
    init() {
        self.table = [(Constants.publicBoldUnderscore, String(Constants.bold)),
                      (Constants.publicBoldStar, String(Constants.bold)),
                      (Constants.publicItalicStar, String(Constants.italics)),
                      (Constants.publicItalicUnderscore, String(Constants.italics)),
                      ("\(Constants.bold)\(Constants.italics)", String(Constants.boldItalics)),
                      ("\(Constants.italics)\(Constants.bold)", String(Constants.boldItalics))]
    }
    
    func clean(string:String) -> String {
        var cleaned:String = string
        self.table.forEach { (item:(String, String)) in
            cleaned = cleaned.replacingOccurrences(of:item.0, with:item.1)
            print(cleaned)
        }
        return cleaned
    }
}
