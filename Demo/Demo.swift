import UIKit
import MarkdownHero

class Demo:UIViewController {
    private let parser:Parser
    private weak var label:UILabel!
    
    init() {
        parser = Parser()
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLabel()
        loadExample()
    }
    
    private func addLabel() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        view.addSubview(label)
        self.label = label
        label.topAnchor.constraint(equalTo:view.topAnchor, constant:80).isActive = true
        label.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        label.rightAnchor.constraint(equalTo:view.rightAnchor, constant:20).isActive = true
    }
    
    private func loadExample() {
        let url = Bundle(for:Demo.self).url(forResource:"Demo", withExtension:"md")!
        let data:Data
        do { try data = Data.init(contentsOf:url, options:.mappedRead) } catch { return }
        let string = String(data:data, encoding:.utf8)!
        parser.parse(string:string) { [weak self] (result) in
            self?.label.attributedText = result
        }
    }
}
