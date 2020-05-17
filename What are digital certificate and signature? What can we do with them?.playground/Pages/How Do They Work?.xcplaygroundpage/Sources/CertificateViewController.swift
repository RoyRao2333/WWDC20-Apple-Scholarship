import Cocoa

class CertificateViewController: NSViewController {
    var isGotCertificate = false
    let observer = NotificationCenter.default
    let noticeAbove = NSTextField.init()
    let noticeBelow = NSTextField.init()
    let nextBtn = NSButton.init()
    let getBtn = NSButton.init()
    let certificateContainer = ContainerView.init(frame: .init(x: 50, y: 200, width: 300, height: 300))
    let messageLabel = ContainerLabel.init()
    let certificateContent = NSTextField.init()
    let certificateIcon = NSImageView.init()
    let publicKeyImage = NSImageView.init()
    let messageContainer = ContainerView.init(frame: .init(x: 100, y: 400, width: 200, height: 200))
    let arrowUp = NSImageView.init()
    let messageImage = NSImageView.init()
    let messageDiscr = ContainerLabel.init()
    let signatureAttach = NSImageView.init()
    let signatureDiscr = ContainerLabel.init()
    let certificateAttach = DragableImageView.init()
    let certificateDiscr = ContainerLabel.init()
    let sendBtn = NSButton.init()
    let letterImage = NSImageView.init()
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

extension CertificateViewController {
    
    func setup() {
        observer.addObserver(self, selector: #selector(isAttached(_:)), name: .isAttached, object: nil)
        
        let contentView = self.view
        
        bobImage.frame = .init(x: 20, y: 630, width: 50, height: 50)
        bobImage.image = NSImage.init(named: "Bob")
        bobImage.image?.size = .init(width: 50, height: 50)
        contentView.addSubview(bobImage)
        
        noticeAbove.frame = .init(x: 80, y: 600, width: 200, height: 80)
        noticeAbove.stringValue = "Now I should go to CA certificate authorization center and apply for my certificate."
        noticeAbove.textColor = .systemBlue
        noticeAbove.isEditable = false
        noticeAbove.isBordered = false
        noticeAbove.backgroundColor = .clear
        contentView.addSubview(noticeAbove)
        
        arrowUp.frame = .init(x: 175, y: 340, width: 50, height: 50)
        arrowUp.image = NSImage.init(named: "ArrowUp")
        arrowUp.image?.size = .init(width: 50, height: 50)
        arrowUp.isHidden = true
        contentView.addSubview(arrowUp)
        
        noticeBelow.frame = .init(x: 50, y: 270, width: 200, height: 20)
        noticeBelow.stringValue = "Drag the certificate up and attach:"
        noticeBelow.textColor = .systemOrange
        noticeBelow.isEditable = false
        noticeBelow.isBordered = false
        noticeBelow.isHidden = true
        noticeBelow.backgroundColor = .clear
        contentView.addSubview(noticeBelow)
        
        certificateContainer.alphaValue = 0
        contentView.addSubview(certificateContainer)
        messageContainer.isHidden = true
        contentView.addSubview(messageContainer)
        
        messageLabel.frame = .init(x: 20, y: 20, width: 160, height: 160)
        messageLabel.stringValue = ""
        messageLabel.font = NSFont.init(name: "Helvetica", size: 15)
        messageLabel.isEditable = false
        messageLabel.isBordered = false
        messageLabel.isHidden = true
        messageLabel.backgroundColor = .clear
        messageContainer.addSubview(messageLabel)
        
        certificateContent.frame = .init(x: 20, y: 20, width: 260, height: 260)
        certificateContent.stringValue = "Bob's Info:" + "\n" + "   Name" + "\n" + "   Department" + "\n" + "   ......" + "\n" + "\n" +
            "Certificate Info:" + "\n" + "   Expiration Date" + "\n" + "   Serial Number" + "\n" + "   ......" + "\n" + "\n" +
            "Bob's Public Key:"
        certificateContent.font = NSFont.init(name: "Helvetica", size: 17)
        certificateContent.isEditable = false
        certificateContent.isBordered = false
        certificateContent.backgroundColor = .clear
        certificateContainer.addSubview(certificateContent)
        
        certificateIcon.frame = .init(x: 200, y: 200, width: 80, height: 80)
        certificateIcon.image = NSImage.init(named: "CertificateIcon")
        certificateIcon.image?.size = .init(width: 80, height: 80)
        certificateContainer.addSubview(certificateIcon)
        
        publicKeyImage.frame = .init(x: 60, y: 5, width: 50, height: 50)
        publicKeyImage.image = NSImage.init(named: "PublicKey")
        certificateContainer.addSubview(publicKeyImage)
        
        letterImage.frame = messageContainer.frame
        letterImage.image = NSImage.init(named: "Letter")
        letterImage.image?.size = .init(width: 200, height: 200)
        letterImage.isHidden = true
        contentView.addSubview(letterImage)
        
        certificateAttach.frame = .init(x: 250, y: 250, width: 80, height: 80)
        certificateAttach.image = NSImage.init(named: "CertificateAttach")
        certificateAttach.image?.size = .init(width: 80, height: 80)
        certificateAttach.delegate = self
        certificateAttach.isHidden = true
        certificateAttach.isDragable = true
        contentView.addSubview(certificateAttach)
        
        certificateDiscr.frame = .init(x: 250, y: 230, width: 80, height: 20)
        certificateDiscr.stringValue = "Certificate"
        certificateDiscr.textColor = .brown
        certificateDiscr.alignment = .center
        certificateDiscr.isEditable = false
        certificateDiscr.isBordered = false
        certificateDiscr.isHidden = true
        certificateDiscr.backgroundColor = .clear
        contentView.addSubview(certificateDiscr)
        
        signatureAttach.frame = .init(x: 20, y: 20, width: 70, height: 70)
        signatureAttach.image = NSImage.init(named: "SignatureAttach")
        signatureAttach.image?.size = .init(width: 70, height: 70)
        signatureAttach.isHidden = true
        messageContainer.addSubview(signatureAttach)
        
        signatureDiscr.frame = .init(x: 20, y: 0, width: 70, height: 20)
        signatureDiscr.stringValue = "Signature"
        signatureDiscr.textColor = .brown
        signatureDiscr.alignment = .center
        signatureDiscr.isEditable = false
        signatureDiscr.isBordered = false
        signatureDiscr.backgroundColor = .clear
        messageContainer.addSubview(signatureDiscr)
        
        messageImage.frame = .init(x: 20, y: 110, width: 80, height: 80)
        messageImage.image = NSImage.init(named: "Paragraph")
        messageImage.image?.size = .init(width: 80, height: 80)
        messageImage.isHidden = true
        messageContainer.addSubview(messageImage)
        
        messageDiscr.frame = .init(x: 20, y: 90, width: 80, height: 20)
        messageDiscr.stringValue = "Body"
        messageDiscr.textColor = .brown
        messageDiscr.alignment = .center
        messageDiscr.isEditable = false
        messageDiscr.isBordered = false
        messageDiscr.backgroundColor = .clear
        messageContainer.addSubview(messageDiscr)
        
        getBtn.frame = .init(x: 100, y: 150, width: 200, height: 20)
        getBtn.title = "Get Your Certificate"
        getBtn.bezelStyle = .rounded
        getBtn.target = self
        getBtn.action = #selector(getCertificate(_:))
        contentView.addSubview(getBtn)
        
        sendBtn.frame = .init(x: 160, y: 300, width: 80, height: 20)
        sendBtn.title = "Send"
        sendBtn.bezelStyle = .rounded
        sendBtn.target = self
        sendBtn.action = #selector(sendBtn_clicked(_:))
        sendBtn.isHidden = true
        contentView.addSubview(sendBtn)
        
        nextBtn.frame = .init(x: 150, y: 50, width: 100, height: 20)
        nextBtn.title = "Next"
        nextBtn.bezelStyle = .rounded
        nextBtn.isHidden = true
        contentView.addSubview(nextBtn)
    }
    
    @IBAction func sendBtn_clicked(_ sender: NSButton) {
        noticeAbove.stringValue = "Great! I've already sent my message to Alice! Good job!"
        letterImage.isHidden = true
        sendBtn.isHidden = true
        nextBtn.isHidden = false
    }
    
    @IBAction func getCertificate(_ sender: NSButton) {
        if !isGotCertificate {
            guard let caKeyPair = CryptoUtility.getKeyPair(size: 2048) else { return }
            EDElements.caKeyPair = caKeyPair
            let keyStr = CryptoUtility.exportKeyToData(key: EDElements.publicKey!)!
            guard let certificate = CryptoUtility.sign(data: keyStr, priKey: caKeyPair.1, algorithm: .rsaSignatureMessagePSSSHA512) else { return }
            EDElements.certificate = certificate
            
            certificateContainer.animator().alphaValue = 1
            noticeAbove.stringValue = "Great! Now I have my own digital certificate now! Our communications are more secure!"
            getBtn.frame = .init(x: 150, y: 150, width: 100, height: 20)
            getBtn.title = "Save"
            isGotCertificate = true
        } else {
            arrowUp.isHidden = false
            certificateContainer.isHidden = true
            getBtn.isHidden = true
            noticeAbove.stringValue = "Now it's time to attach it to my message and send it to Alice!"
            noticeBelow.isHidden = false
            certificateDiscr.isHidden = false
            messageContainer.isHidden = false
            certificateAttach.isHidden = false
            signatureAttach.isHidden = false
            messageImage.isHidden = false
        }
    }
    
    @IBAction func isAttached(_ notification: Notification) {
        if certificateAttach.isInContainer {
            noticeBelow.isHidden = true
            messageContainer.isHidden = true
            certificateAttach.isHidden = true
            certificateDiscr.isHidden = true
            sendBtn.isHidden = false
            letterImage.isHidden = false
            arrowUp.isHidden = true
            noticeAbove.stringValue = "Nice! I've attached my certificate to my message and encapsulated the contents! Now I can send it to Alice!"
        }
    }
    
}

extension CertificateViewController: DragableImageViewDelegate {
    
    func imageViewDragged(with event: NSEvent, item: DragableImageView) {
        let rawLoc = event.locationInWindow
        let location = NSPoint.init(x: rawLoc.x - (item.frame.width / 2),
                                    y: rawLoc.y - (item.frame.height / 2))
        item.setFrameOrigin(location)
        
        let attachFrame = NSRect.init(x: messageContainer.frame.origin.x - 10,
                                      y: messageContainer.frame.origin.y - 10,
                                      width: messageContainer.frame.width + 20,
                                      height: messageContainer.frame.height + 20)
        if attachFrame.contains(location) {
            item.isInContainer = true
        } else {
            if item.isInContainer {
                item.isInContainer = false
            }
        }
        observer.post(name: .isAttached, object: nil)
    }
    
}

extension String {
    
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
    
}
