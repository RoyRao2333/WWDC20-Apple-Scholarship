import Cocoa
import PlaygroundSupport

public class IntroViewController: NSViewController {
    let titleStr = NSTextField.init()
    var timer = Timer.init()
    var count = 0
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        let view = NSView.init(frame: .init(x: 0, y: 0, width: 400, height: 700))
        self.view = view
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension IntroViewController {
    
    func setup() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(changeTitle(_:)), userInfo: nil, repeats: true)
        timer.fire()
        
        let contentView = self.view
        titleStr.frame = .init(x: 0, y: 0, width: 300, height: 100)
        titleStr.stringValue = "Welcome To My Guide!" + "\n" + "Ready To Learn Something New?"
        titleStr.font = NSFont.init(name: "Helvetica", size: 20)
        titleStr.backgroundColor = .clear
        titleStr.textColor = .orange
        titleStr.isEditable = false
        titleStr.isBordered = false
        contentView.addSubview(titleStr)
        titleStr.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStr.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleStr.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    @IBAction func changeTitle(_ sender: Any?) {
        switch self.count {
        case 0:
            count += 1
            break
        case 1:
            titleStr.stringValue = "In this guide, you'll learn about:" + "\n" + "- RSA algorithm and its usage" + "\n" + "- Digital Signature" +
                "\n" + "- Digtal Certificate"
            count += 1
            break
        case 2:
            titleStr.stringValue = "Already itching to try?" + "\n" + "Here We Go!"
            count += 1
            break
        default:
            timer.invalidate()
            PlaygroundPage.current.finishExecution()
        }
    }
    
}
