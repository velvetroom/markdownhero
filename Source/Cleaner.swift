import Foundation

class Cleaner {
    private let items = [CleanerItem(match:"  ", replace:" "),
                         CleanerItem(match:"\n\n\n", replace:"\n\n"),
                         CleanerItem(match:"\n- ", replace:"\n• "),
                         CleanerItem(match:"\n+ ", replace:"\n• "),
                         CleanerItem(match:"\n* ", replace:"\n• ")]
    
    func clean(string:String) -> String {
        var cleaned = string
        items.forEach { (item) in
            while cleaned.contains(item.match) {
                cleaned = cleaned.replacingOccurrences(of:item.match, with:item.replace)
            }
        }
        return cleaned
    }
}
