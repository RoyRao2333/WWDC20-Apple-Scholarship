import Cocoa

class ReplyViewController: NSViewController {
    var isHashed = false, isEncrypted = false
    var messageString = ""
    let observer = NotificationCenter.default
    let noticeAbove = NSTextField.init()
    let noticeMid = NSTextField.init()
    let messageNotice = NSTextField.init()
    let typeField = NSTextField.init()
    let saveBtn = NSButton.init()
    let dragableBtn = DragableBtn.init()
    let containerHash = ContainerView.init(frame: .init(x: 25, y: 400, width: 150, height: 100))
    let containerHashText = ContainerLabel.init()
    let containerEncrypt = ContainerView.init(frame: .init(x: 225, y: 400, width: 150, height: 100))
    let containerEncryptText = ContainerLabel.init()
    let containerReply = ContainerView.init(frame: .init(x: 120, y: 250, width: 160, height: 50))
    let containerMessage = ContainerView.init(frame: .init(x: 100, y: 230, width: 200, height: 200))
    let arrowUp = NSImageView.init()
    let arrowRight = NSImageView.init()
    let containerReplyText = ContainerLabel.init()
    let nextBtn = NSButton.init()
    let cipherImage = NSImageView.init()
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

extension ReplyViewController {
    
    func setup() {
        guard let keyPairs = CryptoUtility.getKeyPair(size: 2048) else { return }
        EDElements.publicKey = keyPairs.0
        EDElements.privateKey = keyPairs.1
        
        observer.addObserver(self, selector: #selector(isAttached(_:)), name: .isAttached, object: nil)
        
        let contentView = self.view
        
        bobImage.frame = .init(x: 20, y: 630, width: 50, height: 50)
        bobImage.image = NSImage.init(named: "Bob")
        bobImage.image?.size = .init(width: 50, height: 50)
        contentView.addSubview(bobImage)
        
        noticeAbove.frame = .init(x: 80, y: 580, width: 300, height: 100)
        noticeAbove.stringValue = "Hi, it's Bob! Now that I've read Alice's message, it's my turn to reply to her! Our communication could be insecure because of the possibility of middlemen, we now use digital signature and digital certificate in our transmission. Let me show you the details!"
        noticeAbove.textColor = .systemBlue
        noticeAbove.isEditable = false
        noticeAbove.isBordered = false
        noticeAbove.backgroundColor = .clear
        contentView.addSubview(noticeAbove)
        
        noticeMid.frame = .init(x: 25, y: 520, width: 300, height: 20)
        noticeMid.stringValue = "First I need to hash my original message:"
        noticeMid.textColor = .systemBlue
        noticeMid.isEditable = false
        noticeMid.isBordered = false
        noticeMid.isHidden = true
        noticeMid.backgroundColor = .clear
        contentView.addSubview(noticeMid)
        
        arrowUp.frame = .init(x: 75, y: 330, width: 50, height: 50)
        arrowUp.image = NSImage.init(named: "ArrowUp")
        arrowUp.image?.size = .init(width: 50, height: 50)
        arrowUp.isHidden = true
        contentView.addSubview(arrowUp)
        
        arrowRight.frame = .init(x: 160, y: 425, width: 50, height: 50)
        arrowRight.image = NSImage.init(named: "ArrowRight")
        arrowRight.image?.size = .init(width: 50, height: 50)
        arrowRight.isHidden = true
        contentView.addSubview(arrowRight)

        messageNotice.frame = .init(x: 100, y: 530, width: 150, height: 20)
        messageNotice.stringValue = "What do I want to reply?"
        messageNotice.textColor = .systemBlue
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
        
        containerHash.isHidden = true
        contentView.addSubview(containerHash)
        containerEncrypt.isHidden = true
        contentView.addSubview(containerEncrypt)
        containerMessage.isHidden = true
        contentView.addSubview(containerMessage)
        containerReply.isHidden = true
        contentView.addSubview(containerReply)
        
        dragableBtn.frame = .init(x: 25, y: 270, width: 140, height: 30)
        dragableBtn.title = "Original Message"
        dragableBtn.image = NSImage.init(named: "MessageBtn")
        dragableBtn.image?.size = .init(width: 20, height: 20)
        dragableBtn.imagePosition = .imageLeading
        dragableBtn.bezelStyle = .inline
        dragableBtn.delegate = self
        dragableBtn.isHidden = true
        contentView.addSubview(dragableBtn)
        
        containerHashText.frame = .init(x: 25, y: 425, width: 150, height: 30)
        containerHashText.stringValue = "Hash"
        containerHashText.textColor = .systemOrange
        containerHashText.alignment = .center
        containerHashText.isEditable = false
        containerHashText.isSelectable = false
        containerHashText.isBordered = false
        containerHashText.backgroundColor = .clear
        containerHashText.isHidden = true
        contentView.addSubview(containerHashText)
        
        containerEncryptText.frame = .init(x: 225, y: 425, width: 150, height: 30)
        containerEncryptText.stringValue = "Encrypt"
        containerEncryptText.textColor = .systemOrange
        containerEncryptText.alignment = .center
        containerEncryptText.isEditable = false
        containerEncryptText.isBordered = false
        containerEncryptText.backgroundColor = .clear
        containerEncryptText.isHidden = true
        contentView.addSubview(containerEncryptText)
        
        containerReplyText.frame = .init(x: 100, y: 250, width: 200, height: 30)
        containerReplyText.stringValue = "Attach and reply"
        containerReplyText.textColor = .systemOrange
        containerReplyText.alignment = .center
        containerReplyText.isEditable = false
        containerReplyText.isBordered = false
        containerReplyText.backgroundColor = .clear
        containerReplyText.isHidden = true
        contentView.addSubview(containerReplyText)
        
        cipherImage.frame = .init(x: 20, y: 110, width: 70, height: 70)
        cipherImage.image = NSImage.init(named: "Paragraph")
        cipherImage.image?.size = .init(width: 70, height: 70)
        containerMessage.addSubview(cipherImage)
        
        nextBtn.frame = .init(x: 160, y: 50, width: 80, height: 20)
        nextBtn.title = "Next"
        nextBtn.bezelStyle = .rounded
        nextBtn.isHidden = true
        contentView.addSubview(nextBtn)
    }
    
    @IBAction func save_clicked(_ sender: NSButton) {
        arrowUp.isHidden = false
        messageString = typeField.stringValue
        EDElements.body = messageString.data(using: .utf8)!
        messageNotice.isHidden = true
        typeField.isHidden = true
        saveBtn.isHidden = true
        noticeAbove.stringValue = "Got it! I've got something to reply! Now I should hash and encrypt my message to make a signature!"
        dragableBtn.isHidden = false
        containerHash.isHidden = false
        containerEncrypt.isHidden = false
        containerHashText.isHidden = false
        containerEncryptText.isHidden = false
        noticeMid.isHidden = false
    }
    
    @IBAction func isAttached(_ notification: Notification) {
        if dragableBtn.container != nil {
            if dragableBtn.container == containerHash, !isHashed {
                isHashed = true
                noticeAbove.stringValue = "Message hashed!"
                noticeMid.stringValue = "Now I should encrypt my digest:"
                containerHash.isHidden = true
                containerHashText.isHidden = true
                dragableBtn.title = "Digest"
                dragableBtn.image = NSImage.init(named: "DigestBtn")
                dragableBtn.setFrameSize(.init(width: 90, height: 30))
                arrowRight.isHidden = false
                arrowUp.isHidden = true
            }
            if dragableBtn.container == containerEncrypt, !isEncrypted {
                if !isHashed {
                    noticeAbove.stringValue = "Oh, no!"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.noticeAbove.stringValue = "I don't think I should do that first!"
                    }
                    return
                }
                isEncrypted = true
                containerEncrypt.isHidden = true
                containerEncryptText.isHidden = true
                arrowRight.isHidden = true
                noticeAbove.stringValue = "Message hashed and encrypted! Now I have my digital signature!"
                noticeMid.stringValue = "Now I should attach it to the end of my message."
                dragableBtn.setFrameSize(.init(width: 140, height: 30))
                dragableBtn.title = "Digital Signature"
                dragableBtn.image = NSImage.init(named: "SignatureBtn")
                dragableBtn.imagePosition = .imageLeading
                dragableBtn.image?.size = .init(width: 20, height: 20)
                containerReply.isHidden = false
                containerReplyText.isHidden = false
                containerMessage.isHidden = false
                let signature = CryptoUtility.sign(data: EDElements.body!, priKey: EDElements.privateKey!, algorithm: .rsaSignatureMessagePSSSHA512)
                EDElements.signature = signature
            }
            if dragableBtn.container == containerReply, isEncrypted {
                dragableBtn.isHidden = true
                containerReplyText.stringValue = "Signature Attached!"
                noticeAbove.stringValue = "All done! It's time to get a digital certificate!"
                noticeMid.isHidden = true
                nextBtn.isHidden = false
                return
            }
        }
    }
    
}

extension ReplyViewController: NSTextFieldDelegate {
    
    func controlTextDidChange(_ obj: Notification) {
        if typeField.stringValue.count > 0 {
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
    }
    
}

extension ReplyViewController: DragableBtnDelegate {
    
    func buttonDragged(with event: NSEvent, item: DragableBtn) {
        let rawLoc = event.locationInWindow
        let location = NSPoint.init(x: rawLoc.x - (item.frame.width / 2),
                                    y: rawLoc.y - (item.frame.height / 2))
        item.setFrameOrigin(location)
        
        let attachFrame1 = containerHash.frame
        let attachFrame2 = containerEncrypt.frame
        let attachFrame3 = containerReply.frame
        if attachFrame1.contains(location) {
            item.container = containerHash
        } else if attachFrame2.contains(location) {
            item.container = containerEncrypt
        } else if attachFrame3.contains(location) {
            item.container = containerReply
        } else {
            item.container = nil
        }
        observer.post(name: .isAttached, object: nil)
    }
    
}
