import Cocoa

class SendMessageViewController: NSViewController {
    private var messageString = ""
    let observer = NotificationCenter.default
    let noticeAbove = NSTextField.init()
    let noticeBelow = NSTextField.init()
    let messageNotice = NSTextField.init()
    let typeField = NSTextField.init()
    let saveBtn = NSButton.init()
    let nextBtn = NSButton.init()
    let container1 = ContainerView.init(frame: .init(x: 140, y: 400, width: 130, height: 30))
    let container2 = ContainerView.init(frame: .init(x: 220, y: 200, width: 150, height: 30))
    let arrowUp = NSImageView.init()
    let arrowDown = NSImageView.init()
    let container1Label = ContainerLabel.init()
    let container2Label = ContainerLabel.init()
    let dragableBtn = DragableBtn.init()
    let sendText = NSTextField.init()
    let aliceImage = NSImageView.init()
    
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

extension SendMessageViewController {
    
    func setup() {
        observer.addObserver(self, selector: #selector(isAttached(_:)), name: .isAttached, object: nil)
        
        let contentView = self.view
        
        aliceImage.frame = .init(x: 20, y: 610, width: 50, height: 50)
        aliceImage.image = NSImage.init(named: "Alice")
        aliceImage.image?.size = .init(width: 50, height: 50)
        contentView.addSubview(aliceImage)
        
        noticeAbove.frame = .init(x: 80, y: 600, width: 200, height: 60)
        noticeAbove.stringValue = "Hi, I'm Alice. I've received the public key Bob gave me, now I can send my message! You'll help me, right?"
        noticeAbove.textColor = .systemPink
        noticeAbove.isEditable = false
        noticeAbove.isBordered = false
        noticeAbove.backgroundColor = .clear
        contentView.addSubview(noticeAbove)
        
        arrowUp.frame = .init(x: 175, y: 280, width: 50, height: 50)
        arrowUp.image = NSImage.init(named: "ArrowUp")
        arrowUp.image?.size = .init(width: 50, height: 50)
        arrowUp.isHidden = true
        contentView.addSubview(arrowUp)
        
        arrowDown.frame = .init(x: 250, y: 280, width: 50, height: 50)
        arrowDown.image = NSImage.init(named: "ArrowDown")
        arrowDown.image?.size = .init(width: 50, height: 50)
        arrowDown.isHidden = true
        contentView.addSubview(arrowDown)
        
        noticeBelow.frame = .init(x: 30, y: 400, width: 350, height: 20)
        noticeBelow.stringValue = "Now I have to use                                          to encrypt it!"
        noticeBelow.textColor = .systemPink
        noticeBelow.isEditable = false
        noticeBelow.isBordered = false
        noticeBelow.backgroundColor = .clear
        noticeBelow.isHidden = true
        contentView.addSubview(noticeBelow)
        
        messageNotice.frame = .init(x: 100, y: 520, width: 150, height: 20)
        messageNotice.stringValue = "What do I want to send?"
        messageNotice.textColor = .systemPink
        messageNotice.isEditable = false
        messageNotice.isBordered = false
        messageNotice.backgroundColor = .clear
        contentView.addSubview(messageNotice)
        
        typeField.frame = .init(x: 100, y: 500, width: 200, height: 20)
        typeField.focusRingType = .none
        typeField.delegate = self
        contentView.addSubview(typeField)
        
        saveBtn.frame = .init(x: 160, y: 450, width: 80, height: 20)
        saveBtn.title = "Save"
        saveBtn.bezelStyle = .rounded
        saveBtn.isEnabled = false
        saveBtn.target = self
        saveBtn.action = #selector(save_clicked(_:))
        contentView.addSubview(saveBtn)
        
        sendText.frame = .init(x: 50, y: 200, width: 350, height: 20)
        sendText.stringValue = "Drag message here to send:"
        sendText.textColor = .systemOrange
        sendText.isEditable = false
        sendText.isBordered = false
        sendText.backgroundColor = .clear
        sendText.isHidden = true
        contentView.addSubview(sendText)
        
        container1.isHidden = true
        contentView.addSubview(container1)
        container2.isHidden = true
        contentView.addSubview(container2)
        
        container1Label.frame = .init(x: 0, y: 0, width: 130, height: 23)
        container1Label.stringValue = "Drag key here"
        container1Label.textColor = .systemOrange
        container1Label.alignment = .center
        container1Label.isEditable = false
        container1Label.isBordered = false
        container1Label.backgroundColor = .clear
        container1.addSubview(container1Label)
        
        container2Label.frame = .init(x: 0, y: 0, width: 150, height: 23)
        container2Label.stringValue = "Drag Message here"
        container2Label.textColor = .systemOrange
        container2Label.alignment = .center
        container2Label.isEditable = false
        container2Label.isBordered = false
        container2Label.backgroundColor = .clear
        container2.addSubview(container2Label)
        
        dragableBtn.frame = .init(x: 140, y: 200, width: 130, height: 30)
        dragableBtn.title = "Bob's Public Key"
        dragableBtn.image = NSImage.init(named: "KeyBtn")
        dragableBtn.image?.size = .init(width: 20, height: 20)
        dragableBtn.imagePosition = .imageLeading
        dragableBtn.bezelStyle = .inline
        dragableBtn.delegate = self
        dragableBtn.isHidden = true
        contentView.addSubview(dragableBtn)
        
        nextBtn.frame = .init(x: 160, y: 50, width: 80, height: 20)
        nextBtn.title = "Next"
        nextBtn.bezelStyle = .rounded
        nextBtn.isHidden = true
        contentView.addSubview(nextBtn)
    }
    
    @IBAction func save_clicked(_ sender: NSButton) {
        messageString = typeField.stringValue
        messageNotice.isHidden = true
        typeField.isHidden = true
        saveBtn.isHidden = true
        noticeAbove.stringValue = "Got it! I've got something to send! Now I must encrypt it before I can send it to Bob!"
        dragableBtn.isHidden = false
        noticeBelow.isHidden = false
        container1.isHidden = false
        arrowUp.isHidden = false
    }
    
    @IBAction func isAttached(_ notification: Notification) {
        if container1.itemWithin == dragableBtn {
            arrowUp.isHidden = true
            arrowDown.isHidden = false
            container1.removeFromSuperview()
            container1.setFrameOrigin(.init(x: 0, y: 700))
            noticeBelow.frame = .init(x: 100, y: 350, width: 200, height: 50)
            noticeAbove.stringValue = "Great! Now I've encrypted this message! I can safely send it now!"
            noticeBelow.isHidden = true
            dragableBtn.title = "Encrypted Message"
            dragableBtn.image = NSImage.init(named: "MessageBtn")
            dragableBtn.image?.size = .init(width: 20, height: 20)
            dragableBtn.imagePosition = .imageLeading
            dragableBtn.setFrameSize(.init(width: 150, height: 30))
            container2.isHidden = false
            sendText.isHidden = false
            let cipher = CryptoUtility.encrypt(data: messageString.data(using: .utf8)!, pubKey: EDElements.publicKey!, algorithm: .rsaEncryptionOAEPSHA512)
            EDElements.cipher = cipher
        } else if container2.itemWithin == dragableBtn {
            sendText.frame = .init(x: 30, y: 200, width: 350, height: 20)
            noticeAbove.stringValue = "Nice! I've sent my message to Bob! Thanks for your help!"
            noticeBelow.isHidden = true
            dragableBtn.isHidden = true
            container2.isHidden = true
            sendText.isHidden = true
            nextBtn.isHidden = false
            arrowDown.isHidden = true
        }
    }
    
}

extension SendMessageViewController: NSTextFieldDelegate {
    
    func controlTextDidChange(_ obj: Notification) {
        if typeField.stringValue.count > 0 {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
    }
    
}

extension SendMessageViewController: DragableBtnDelegate {
    
    func buttonDragged(with event: NSEvent, item: DragableBtn) {
        let rawLoc = event.locationInWindow
        let location = NSPoint.init(x: rawLoc.x - (item.frame.width / 2),
                                    y: rawLoc.y - (item.frame.height / 2))
        item.setFrameOrigin(location)
        
        let attachFrame1 = NSRect.init(x: container1.frame.origin.x - 10,
                                       y: container1.frame.origin.y - 10,
                                       width: container1.frame.width + 20,
                                       height: container1.frame.height + 20)
        let attachFrame2 = NSRect.init(x: container2.frame.origin.x - 10,
                                      y: container2.frame.origin.y - 10,
                                      width: container2.frame.width + 20,
                                      height: container2.frame.height + 20)
        if attachFrame1.contains(location) {
            item.setFrameOrigin(container1.frame.origin)
            container1.itemWithin = item
        } else if attachFrame2.contains(location) {
            item.setFrameOrigin(container2.frame.origin)
            container2.itemWithin = item
        } else {
            if container1.itemWithin == item {
                container1.itemWithin = nil
            } else if container2.itemWithin == item {
                container2.itemWithin = nil
            }
        }
        observer.post(name: .isAttached, object: nil)
    }
    
}
