import Foundation

class Cleaner {
    private let items:[CleanerItem]
    
    init() {
        self.items = [CleanerItem(match:"  ", replace:" "), CleanerItem(match:"\n\n", replace:"\n")]
    }
    
    func clean(string:String) -> String {
        var cleaned:String = string
        self.items.forEach { (item:CleanerItem) in
            while cleaned.contains(item.match) {
                cleaned = cleaned.replacingOccurrences(of:item.match, with:item.replace)
            }
        }
        return cleaned
    }
}
