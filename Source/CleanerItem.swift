import Foundation

struct CleanerItem {
    var match:String
    var replace:String
    
    init(match:String, replace:String) {
        self.match = match
        self.replace = replace
    }
}
