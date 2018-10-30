import Foundation

class Cleaner {
    private let items = [CleanerItem(match:"  ", replace:" "),
                         CleanerItem(match:"\n\n\n", replace:"\n\n"),
                         CleanerItem(match:"\n- ", replace:"\n• "),
                         CleanerItem(match:"\n+ ", replace:"\n• "),
                         CleanerItem(match:"\n* ", replace:"\n• ")]
    
    func clean(string:String) -> String {
        return items.reduce(into:startsWithList(string:string)) { cleaned, item in
            while cleaned.contains(item.match) {
                cleaned = cleaned.replacingOccurrences(of:item.match, with:item.replace)
            }
        }
    }
    
    private func startsWithList(string:String) -> String {
        var string = string
        if string.count > 2 {
            let prefix = string.prefix(2)
            if prefix == "- " || prefix == "+ " || prefix == "* " {
                string = "• " + string.suffix(string.count - 2)
            }
        }
        return string
    }
}
