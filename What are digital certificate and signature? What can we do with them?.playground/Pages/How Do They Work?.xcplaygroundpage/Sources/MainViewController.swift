import Cocoa

public class MainViewController: NSViewController {
    let gamePage_1 = ReplyViewController.init()
    let gamePage_2 = CertificateViewController.init()
    let gamePage_3 = VerifyViewController.init()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        let view = NSView.init(frame: .init(x: 0, y: 0, width: 400, height: 700))
        self.view = view
        view.wantsLayer = true
        view.layer?.backgroundColor = .clear
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainViewController {
    
    func setup() {
        gamePage_1.view.appearance = NSAppearance.init(named: .aqua)
        gamePage_2.view.appearance = NSAppearance.init(named: .aqua)
        gamePage_3.view.appearance = NSAppearance.init(named: .aqua)
        
        gamePage_1.nextBtn.target = self
        gamePage_1.nextBtn.action = #selector(nextPage(_:))
        gamePage_2.nextBtn.target = self
        gamePage_2.nextBtn.action = #selector(nextPage(_:))
        
        let contentView = self.view
        
        self.addChild(gamePage_1)
        self.addChild(gamePage_2)
        self.addChild(gamePage_3)
        contentView.addSubview(gamePage_1.view)
    }
    
    @IBAction func nextPage(_ sender: NSButton) {
        if sender == gamePage_1.nextBtn {
            transition(from: gamePage_1, to: gamePage_2, options: .crossfade, completionHandler: nil)
        } else if sender == gamePage_2.nextBtn {
            transition(from: gamePage_2, to: gamePage_3, options: .crossfade, completionHandler: nil)
        }
    }
    
}

extension Notification.Name {
    static let isAttached = Notification.Name.init("isAttached")
}
