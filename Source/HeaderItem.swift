import UIKit

struct HeaderItem {
    let match:String
    let increment:CGFloat
    let weight:UIFont.Weight
    
    init(match:String, increment:CGFloat, weight:UIFont.Weight) {
        self.match = match
        self.increment = increment
        self.weight = weight
    }
}
