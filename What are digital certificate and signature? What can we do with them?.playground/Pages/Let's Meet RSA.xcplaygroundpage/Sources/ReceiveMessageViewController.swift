import Cocoa
import PlaygroundSupport

class ReceiveMessageViewController: NSViewController {
    let observer = NotificationCenter.default
    let noticeAbove = NSTextField.init()
    let finishBtn = NSButton.init()
    let container = ContainerView.init(frame: .init(x: 100, y: 420, width: 200, height: 150))
    let arrowUp = NSImageView.init()
    let containerText = ContainerLabel.init()
    let decryptBtn = NSButton.init()
    let publicKey = DragableBtn.init()
    let privateKey = DragableBtn.init()
    let encryptedMessage = DragableBtn.init()
    let bobImage = NSImageView.init()
    
    init() {
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

extension ReceiveMessageViewController {
    
    func setup() {
        observer.addObserver(self, selector: #selector(isAttached(_:)), name: .isAttached, object: nil)
        
        let contentView = self.view
        
        bobImage.frame = .init(x: 20, y: 600, width: 50, height: 50)
        bobImage.image = NSImage.init(named: "Bob")
        bobImage.image?.size = .init(width: 50, height: 50)
        contentView.addSubview(bobImage)
        
        noticeAbove.frame = .init(x: 80, y: 600, width: 300, height: 50)
        noticeAbove.stringValue = "Hi, it's Bob again! I've already got Alice's cipher in hand! Now I should use my PRIVATE KEY to decrypt ALICE'S MESSAGE!"
        noticeAbove.textColor = .systemBlue
        noticeAbove.isEditable = false
        noticeAbove.isBordered = false
        noticeAbove.backgroundColor = .clear
        contentView.addSubview(noticeAbove)
        
        arrowUp.frame = .init(x: 175, y: 360, width: 50, height: 50)
        arrowUp.image = NSImage.init(named: "ArrowUp")
        arrowUp.image?.size = .init(width: 50, height: 50)
        contentView.addSubview(arrowUp)
        
        contentView.addSubview(container)
        
        decryptBtn.frame = .init(x: 150, y: 250, width: 100, height: 20)
        decryptBtn.title = "Decrypt"
        decryptBtn.bezelStyle = .rounded
        decryptBtn.isEnabled = false
        decryptBtn.target = self
        decryptBtn.action = #selector(decrypt(_:))
        contentView.addSubview(decryptBtn)
        
        containerText.frame = .init(x: 100, y: 480, width: 200, height: 30)
        containerText.stringValue = "Drag everything you need to decrypt"
        containerText.textColor = .systemOrange
        containerText.alignment = .center
        containerText.isEditable = false
        containerText.isBordered = false
        containerText.backgroundColor = .clear
        contentView.addSubview(containerText)
        
        publicKey.frame = .init(x: 20, y: 320, width: 100, height: 30)
        publicKey.title = "Public Key"
        publicKey.image = NSImage.init(named: "KeyBtn")
        publicKey.image?.size = .init(width: 20, height: 20)
        publicKey.imagePosition = .imageLeading
        publicKey.bezelStyle = .inline
        publicKey.delegate = self
        contentView.addSubview(publicKey)
        
        privateKey.frame = .init(x: 130, y: 320, width: 100, height: 30)
        privateKey.title = "Private Key"
        privateKey.image = NSImage.init(named: "KeyBtn")
        privateKey.image?.size = .init(width: 20, height: 20)
        privateKey.imagePosition = .imageLeading
        privateKey.bezelStyle = .inline
        privateKey.delegate = self
        contentView.addSubview(privateKey)
        
        encryptedMessage.frame = .init(x: 240, y: 320, width: 150, height: 30)
        encryptedMessage.title = "Encrypted Message"
        encryptedMessage.image = NSImage.init(named: "MessageBtn")
        encryptedMessage.image?.size = .init(width: 20, height: 20)
        encryptedMessage.imagePosition = .imageLeading
        encryptedMessage.bezelStyle = .inline
        encryptedMessage.delegate = self
        contentView.addSubview(encryptedMessage)
        
        finishBtn.frame = .init(x: 150, y: 50, width: 100, height: 20)
        finishBtn.title = "Finish"
        finishBtn.bezelStyle = .rounded
        finishBtn.isHidden = true
        finishBtn.target = self
        finishBtn.action = #selector(finish(_:))
        contentView.addSubview(finishBtn)
    }
    
    @IBAction func decrypt(_ sender: NSButton) {
        if encryptedMessage.isInContainer && privateKey.isInContainer {
            guard let data = EDElements.cipher else { return }
            noticeAbove.stringValue = "Got it! We've decrypted the message!"
            containerText.frame = .init(x: 110, y: 410, width: 190, height: 130)
            containerText.stringValue = String.init(data: CryptoUtility.decrypt(data: data, priKey: EDElements.privateKey!, algorithm: .rsaEncryptionOAEPSHA512)!,
                                                    encoding: .utf8)!
            containerText.alignment = .left
            publicKey.isHidden = true
            privateKey.isHidden = true
            encryptedMessage.isHidden = true
            decryptBtn.isHidden = true
            finishBtn.isHidden = false
            arrowUp.isHidden = true
        } else {
            noticeAbove.stringValue = "That's not right! Maybe I should try again."
        }
    }
    
    @IBAction func isAttached(_ notification: Notification) {
        if privateKey.isInContainer || publicKey.isInContainer || encryptedMessage.isInContainer {
            decryptBtn.isEnabled = true
        } else {
            decryptBtn.isEnabled = false
        }
    }
    
    @IBAction func finish(_ sender: NSButton) {
        EDElements.cipher = nil
        PlaygroundPage.current.finishExecution()
    }
    
}

extension ReceiveMessageViewController: DragableBtnDelegate {
    
    func buttonDragged(with event: NSEvent, item: DragableBtn) {
        let rawLoc = event.locationInWindow
        let location = NSPoint.init(x: rawLoc.x - (item.frame.width / 2),
                                    y: rawLoc.y - (item.frame.height / 2))
        item.setFrameOrigin(location)
        
        let attachFrame = NSRect.init(x: container.frame.origin.x - 10,
                                       y: container.frame.origin.y - 10,
                                       width: container.frame.width + 20,
                                       height: container.frame.height + 20)
        if attachFrame.contains(location) {
            item.isInContainer = true
        } else {
            item.isInContainer = false
        }
        observer.post(name: .isAttached, object: nil)
    }
    
}
