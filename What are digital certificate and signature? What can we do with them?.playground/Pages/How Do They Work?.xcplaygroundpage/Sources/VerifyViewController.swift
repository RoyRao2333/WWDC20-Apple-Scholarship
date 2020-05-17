import Cocoa
import PlaygroundSupport

class VerifyViewController: NSViewController {
    let observer = NotificationCenter.default
    let noticeAbove = NSTextField.init()
    let noticeMid = NSTextField.init()
    let containerEnvelope = ContainerView.init(frame: .init(x: 100, y: 350, width: 200, height: 200))
    let containerDecrypt = ContainerView.init(frame: .init(x: 100, y: 150, width: 200, height: 100))
    let containerDecryptLabel = ContainerLabel.init()
    let revealLabel = ContainerLabel.init()
    let cipherImage = NSImageView.init()
    let signatureImage = DragableImageView.init()
    let certificateImage = DragableImageView.init()
    let messageDiscr = ContainerLabel.init()
    let signatureDiscr = ContainerLabel.init()
    let certificateDiscr = ContainerLabel.init()
    let actionBtn = NSButton.init()
    let aliceDigestBtn = DragableBtn.init()
    let bobInfoBtn = NSButton.init()
    let finishBtn = NSButton.init()
    let letterImage = NSImageView.init()
    let aliceImage = NSImageView.init()
    let arrowDown = NSImageView.init()
    
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

extension VerifyViewController {
    
    func setup() {
        observer.addObserver(self, selector: #selector(isAttached(_:)), name: .isAttached, object: nil)
        
        let contentView = self.view
        
        aliceImage.frame = .init(x: 20, y: 630, width: 50, height: 50)
        aliceImage.image = NSImage.init(named: "Alice")
        aliceImage.image?.size = .init(width: 50, height: 50)
        contentView.addSubview(aliceImage)
        
        noticeAbove.frame = .init(x: 80, y: 600, width: 250, height: 80)
        noticeAbove.stringValue = "Alice here! I've received Bob's message, let's find out what's in there!"
        noticeAbove.textColor = .systemPink
        noticeAbove.isEditable = false
        noticeAbove.isBordered = false
        noticeAbove.backgroundColor = .clear
        contentView.addSubview(noticeAbove)
        
        noticeMid.frame = .init(x: 20, y: 570, width: 350, height: 30)
        noticeMid.stringValue = "Now I need to                       the message body."
        noticeMid.textColor = .systemOrange
        noticeMid.isEditable = false
        noticeMid.isBordered = false
        noticeMid.isHidden = true
        noticeMid.backgroundColor = .clear
        contentView.addSubview(noticeMid)
        
        arrowDown.frame = .init(x: 100, y: 275, width: 50, height: 50)
        arrowDown.image = NSImage.init(named: "ArrowDown")
        arrowDown.image?.size = .init(width: 50, height: 50)
        arrowDown.isHidden = true
        contentView.addSubview(arrowDown)
        
        revealLabel.frame = .init(x: 10, y: 10, width: 180, height: 180)
        revealLabel.stringValue = ""
        revealLabel.isEditable = false
        revealLabel.isBordered = false
        revealLabel.isHidden = true
        revealLabel.backgroundColor = .clear
        containerEnvelope.addSubview(revealLabel)
        
        containerEnvelope.isHidden = true
        contentView.addSubview(containerEnvelope)
        containerDecrypt.isHidden = true
        contentView.addSubview(containerDecrypt)
        
        containerDecryptLabel.frame = .init(x: 0, y: 30, width: 200, height: 30)
        containerDecryptLabel.stringValue = "Drag here to decrypt"
        containerDecryptLabel.font = NSFont.init(name: "Helvetica", size: 15)
        containerDecryptLabel.alignment = .center
        containerDecryptLabel.isEditable = false
        containerDecryptLabel.isBordered = false
        containerDecryptLabel.backgroundColor = .clear
        containerDecryptLabel.isHidden = true
        containerDecrypt.addSubview(containerDecryptLabel)
        
        letterImage.frame = containerEnvelope.frame
        letterImage.image = NSImage.init(named: "Letter")
        letterImage.image?.size = .init(width: 200, height: 200)
        contentView.addSubview(letterImage)
        
        cipherImage.frame = .init(x: 120, y: 460, width: 70, height: 70)
        cipherImage.image = NSImage.init(named: "Paragraph")
        cipherImage.image?.size = .init(width: 70, height: 70)
        cipherImage.isHidden = true
        contentView.addSubview(cipherImage)
        
        messageDiscr.frame = .init(x: 20, y: 90, width: 70, height: 20)
        messageDiscr.stringValue = "Body"
        messageDiscr.textColor = .brown
        messageDiscr.alignment = .center
        messageDiscr.isEditable = false
        messageDiscr.isBordered = false
        messageDiscr.backgroundColor = .clear
        containerEnvelope.addSubview(messageDiscr)
        
        certificateImage.frame = .init(x: 230, y: 470, width: 60, height: 60)
        certificateImage.image = NSImage.init(named: "CertificateAttach")
        certificateImage.image?.size = .init(width: 60, height: 60)
        certificateImage.isHidden = true
        certificateImage.isDragable = false
        certificateImage.delegate = self
        contentView.addSubview(certificateImage)
        
        certificateDiscr.frame = .init(x: 125, y: 100, width: 80, height: 20)
        certificateDiscr.stringValue = "Certificate"
        certificateDiscr.textColor = .brown
        certificateDiscr.alignment = .center
        certificateDiscr.isEditable = false
        certificateDiscr.isBordered = false
        certificateDiscr.backgroundColor = .clear
        containerEnvelope.addSubview(certificateDiscr)
        
        signatureImage.frame = .init(x: 210, y: 370, width: 80, height: 80)
        signatureImage.image = NSImage.init(named: "SignatureAttach")
        signatureImage.image?.size = .init(width: 80, height: 80)
        signatureImage.isHidden = true
        signatureImage.isDragable = false
        signatureImage.delegate = self
        contentView.addSubview(signatureImage)
        
        signatureDiscr.frame = .init(x: 110, y: 0, width: 80, height: 20)
        signatureDiscr.stringValue = "Signature"
        signatureDiscr.textColor = .brown
        signatureDiscr.alignment = .center
        signatureDiscr.isEditable = false
        signatureDiscr.isBordered = false
        signatureDiscr.backgroundColor = .clear
        containerEnvelope.addSubview(signatureDiscr)
        
        aliceDigestBtn.frame = .init(x: 160, y: 280, width: 120, height: 30)
        aliceDigestBtn.title = "Alice's Digest"
        aliceDigestBtn.bezelStyle = .inline
        aliceDigestBtn.image = NSImage.init(named: "DigestBtn")
        aliceDigestBtn.image?.size = .init(width: 20, height: 20)
        aliceDigestBtn.imagePosition = .imageLeading
        aliceDigestBtn.delegate = self
        aliceDigestBtn.isHidden = true
        aliceDigestBtn.isDragable = false
        contentView.addSubview(aliceDigestBtn)
        
        bobInfoBtn.frame = .init(x: 30, y: 5, width: 140, height: 30)
        bobInfoBtn.title = "Bob's Public Key"
        bobInfoBtn.bezelStyle = .inline
        bobInfoBtn.image = NSImage.init(named: "KeyBtn")
        bobInfoBtn.image?.size = .init(width: 20, height: 20)
        bobInfoBtn.imagePosition = .imageLeading
        bobInfoBtn.isHidden = true
        containerDecrypt.addSubview(bobInfoBtn)
        
        actionBtn.frame = .init(x: 160, y: 300, width: 80, height: 20)
        actionBtn.title = "Open"
        actionBtn.bezelStyle = .rounded
        actionBtn.target = self
        actionBtn.action = #selector(actionBtn_clicked(_:))
        contentView.addSubview(actionBtn)
        
        finishBtn.frame = .init(x: 160, y: 50, width: 80, height: 20)
        finishBtn.title = "Finish"
        finishBtn.bezelStyle = .rounded
        finishBtn.isHidden = true
        finishBtn.target = self
        finishBtn.action = #selector(finish(_:))
        contentView.addSubview(finishBtn)
    }
    
    @IBAction func finish(_ sender: NSButton) {
        PlaygroundPage.current.finishExecution()
    }
    
    @IBAction func actionBtn_clicked(_ sender: NSButton) {
        
        if actionBtn.title == "Open" {
            noticeMid.isHidden = false
            actionBtn.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.actionBtn.isEnabled = true
                self.actionBtn.animator().setFrameOrigin(.init(x: 100, y: 580))
            }
            cipherImage.isHidden = false
            signatureImage.isHidden = false
            certificateImage.isHidden = false
            containerEnvelope.isHidden = false
            letterImage.isHidden = true
            actionBtn.title = "Hash"
            noticeAbove.stringValue = "Yes! Before I read the message, I need to be sure whether this message is truely came from Bob! So now I should hash the message BODY first to get a digest."
        } else if actionBtn.title == "Hash" {
            noticeMid.stringValue = "Drag CERTIFICATE image down to the container and click DECRYPT CERTIFICATE:"
            actionBtn.animator().setFrameOrigin(.init(x: 130, y: 100))
            signatureImage.isDragable = true
            certificateImage.isDragable = true
            aliceDigestBtn.isHidden = false
            aliceDigestBtn.isDragable = true
            arrowDown.isHidden = false
            actionBtn.frame = .init(x: 130, y: 100, width: 140, height: 20)
            actionBtn.title = "Decrypt Certificate"
            actionBtn.isEnabled = false
            containerDecrypt.isHidden = false
            containerDecryptLabel.isHidden = false
            noticeAbove.stringValue = "Now I get the digest! Then we should decrypt Bob's CERTIFICATE and get his public key!"
        } else if actionBtn.title == "Decrypt Certificate" {
            if certificateImage.isInContainer, !signatureImage.isInContainer && !aliceDigestBtn.isInContainer {
                let keyData = CryptoUtility.exportKeyToData(key: EDElements.publicKey!)!
                let isVerified = CryptoUtility.verify(data: keyData,
                                                    signature: EDElements.certificate!,
                                                    pubKey: EDElements.caKeyPair!.0,
                                                    algorithm: .rsaSignatureMessagePSSSHA512)
                if !isVerified {
                    print("Decryption failed.")
                    return
                } else {
                    print("Decryption Succeeded. Certicifate verified.")
                }
                
                noticeMid.stringValue = "Drag SIGNATURE image down to the container and click DECRYPT SIGNATURE:"
                noticeAbove.stringValue = "Now we get Bob's public key from the certificate! Now we can use it to decrypt Bob's SIGNATURE, then I can determine whether this message is came from Bob!"
                certificateDiscr.isHidden = true
                certificateImage.removeFromSuperview()
                bobInfoBtn.isHidden = false
                actionBtn.title = "Decrypt Signature"
                actionBtn.isEnabled = false
            } else {
                noticeAbove.stringValue = "That's not right!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.noticeAbove.stringValue = "I should decrypt Bob's certificate to get his public key first!"
                }
            }
        } else if actionBtn.title == "Decrypt Signature" {
            if signatureImage.isInContainer, !aliceDigestBtn.isInContainer {
                signatureImage.removeFromSuperview()
                bobInfoBtn.frame = .init(x: 40, y: 5, width: 120, height: 30)
                bobInfoBtn.title = "Bob's Digest"
                bobInfoBtn.image = NSImage.init(named: "DigestBtn")
                bobInfoBtn.image?.size = .init(width: 20, height: 20)
                bobInfoBtn.imagePosition = .imageLeading
                actionBtn.frame = .init(x: 160, y: 100, width: 80, height: 20)
                actionBtn.title = "Compare"
                signatureDiscr.isHidden = true
                containerDecryptLabel.stringValue = "Drag here to compare"
                noticeMid.stringValue = "Drag ALICE'S DIGEST button down to the container and click COMPARE:"
                noticeAbove.stringValue = "Now we've decrypted the signature and got Bob's digest! Now we should compare my digest with Bob's digest!"
            } else {
                noticeAbove.stringValue = "That's not right!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.noticeAbove.stringValue = "I should decrypt Bob's signature to get his digest now!"
                }
            }
        } else if actionBtn.title == "Compare" {
            if aliceDigestBtn.isInContainer {
                aliceDigestBtn.removeFromSuperview()
                bobInfoBtn.isHidden = true
                let originalData = EDElements.body!
                let isTheSame = CryptoUtility.verify(data: originalData, signature: EDElements.signature!,
                                                     pubKey: EDElements.publicKey!,
                                                     algorithm: .rsaSignatureMessagePSSSHA512)
                if isTheSame  {
                    actionBtn.animator().setFrameOrigin(.init(x: 140, y: 280))
                    arrowDown.isHidden = true
                    containerDecryptLabel.stringValue = "They're exactly the same!"
                    noticeMid.stringValue = "Now I can REVEAL Bob's message!"
                    noticeAbove.stringValue = "What a relief! This message must came from Bob! Now Let's read Bob's message!"
                    actionBtn.title = "Reveal"
                } else {
                    noticeAbove.stringValue = "They're not the same!"
                }
            } else {
                noticeAbove.stringValue = "That's not right!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.noticeAbove.stringValue = "Now I should compare my digest with Bob's!"
                }
            }
        } else if actionBtn.title == "Reveal" {
            messageDiscr.isHidden = true
            cipherImage.isHidden = true
            actionBtn.isHidden = true
            revealLabel.isHidden = false
            noticeMid.isHidden = true
            let body = String.init(data: EDElements.body!, encoding: .utf8)!
            revealLabel.stringValue = body
            containerDecrypt.isHidden = true
            finishBtn.isHidden = false
        }
        
    }
    
    @IBAction func isAttached(_ notification: Notification) {
        if actionBtn.title == "Decrypt Signature" || actionBtn.title == "Decrypt Certificate" {
            if aliceDigestBtn.isInContainer || signatureImage.isInContainer || certificateImage.isInContainer {
                actionBtn.isEnabled = true
            } else {
                actionBtn.isEnabled = false
            }
        }
    }
    
}

extension VerifyViewController: DragableBtnDelegate {
    
    func buttonDragged(with event: NSEvent, item: DragableBtn) {
        let rawLoc = event.locationInWindow
        let location = NSPoint.init(x: rawLoc.x - (item.frame.width / 2),
                                    y: rawLoc.y - (item.frame.height / 2))
        item.setFrameOrigin(location)
        
        let attachFrame = containerDecrypt.frame
        if attachFrame.contains(location) {
            item.isInContainer = true
        } else {
            item.isInContainer = false
        }
        observer.post(name: .isAttached, object: nil)
    }
    
}

extension VerifyViewController: DragableImageViewDelegate {
    
    func imageViewDragged(with event: NSEvent, item: DragableImageView) {
        let rawLoc = event.locationInWindow
        let location = NSPoint.init(x: rawLoc.x - (item.frame.width / 2),
                                    y: rawLoc.y - (item.frame.height / 2))
        item.setFrameOrigin(location)
        
        let attachFrame = containerDecrypt.frame
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
