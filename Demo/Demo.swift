import UIKit
import MarkdownHero

class Demo:UIViewController {
    private let parser:Parser
    private weak var label:UILabel!
    
    init() {
        self.parser = Parser()
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLabel()
        self.loadExample()
    }
    
    private func addLabel() {
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.label = label
        self.view.addSubview(label)
        label.topAnchor.constraint(equalTo:self.view.topAnchor, constant:80.0).isActive = true
        label.leftAnchor.constraint(equalTo:self.view.leftAnchor, constant:20.0).isActive = true
        label.rightAnchor.constraint(equalTo:self.view.rightAnchor, constant:20.0).isActive = true
    }
    
    private func loadExample() {
        let url:URL = Bundle(for:Demo.self).url(forResource:"Demo", withExtension:"md")!
        let data:Data
        do { try data = Data.init(contentsOf:url, options:Data.ReadingOptions.mappedRead) } catch { return }
        let string:String = String(data:data, encoding:String.Encoding.utf8)!
        self.parser.parse(string:string) { [weak self] (result:NSAttributedString) in
            self?.label.attributedText = result
        }
    }
}
