import Cocoa

class PreparationViewController: NSViewController {
    let noticeAbove = NSTextField.init()
    let noticeMid = NSTextField.init()
    let generateBtn = NSButton.init()
    let privateKey = NSButton.init()
    let publicKey = NSButton.init()
    let nextBtn = NSButton.init()
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

extension PreparationViewController {
    
    func setup() {
        let contentView = self.view
        
        bobImage.frame = .init(x: 20, y: 610, width: 50, height: 50)
        bobImage.image = NSImage.init(named: "Bob")
        bobImage.image?.size = .init(width: 50, height: 50)
        contentView.addSubview(bobImage)
        
        noticeAbove.frame = .init(x: 80, y: 600, width: 300, height: 60)
        noticeAbove.stringValue = "Hi, I'm Bob. I'm having a conversation with Alice onlice, but I need to make sure our communication is secure. Thus I'm using RSA algorithm in our communication. Let's see how it works!"
        noticeAbove.textColor = .systemBlue
        noticeAbove.isEditable = false
        noticeAbove.isBordered = false
        noticeAbove.backgroundColor = .clear
        contentView.addSubview(noticeAbove)
        
        noticeMid.frame = .init(x: 75, y: 500, width: 300, height: 20)
        noticeMid.stringValue = "First I need a pair of public and private keys:"
        noticeMid.textColor = .systemBlue
        noticeMid.isEditable = false
        noticeMid.isBordered = false
        noticeMid.backgroundColor = .clear
        contentView.addSubview(noticeMid)
        
        generateBtn.frame = .init(x: 140, y: 450, width: 120, height: 20)
        generateBtn.title = "Generate Keys"
        generateBtn.bezelStyle = .rounded
        generateBtn.target = self
        generateBtn.action = #selector(generate(_:))
        contentView.addSubview(generateBtn)
        
        nextBtn.frame = .init(x: 160, y: 50, width: 80, height: 20)
        nextBtn.title = "Next"
        nextBtn.bezelStyle = .rounded
        nextBtn.isHidden = true
        contentView.addSubview(nextBtn)
        
        privateKey.frame = .init(x: 70, y: 300, width: 100, height: 30)
        privateKey.title = "Private Key"
        privateKey.bezelStyle = .inline
        privateKey.image = NSImage.init(named: "KeyBtn")
        privateKey.image?.size = .init(width: 20, height: 20)
        privateKey.imagePosition = .imageLeading
        privateKey.alphaValue = 0
        privateKey.isEnabled = false
        privateKey.target = self
        privateKey.action = #selector(chooseToSend(_:))
        contentView.addSubview(privateKey)
        
        publicKey.frame = .init(x: 230, y: 300, width: 100, height: 30)
        publicKey.title = "Public Key"
        publicKey.bezelStyle = .inline
        publicKey.image = NSImage.init(named: "KeyBtn")
        publicKey.image?.size = .init(width: 20, height: 20)
        publicKey.imagePosition = .imageLeading
        publicKey.alphaValue = 0
        publicKey.isEnabled = false
        publicKey.target = self
        publicKey.action = #selector(chooseToSend(_:))
        contentView.addSubview(publicKey)
    }
    
    @IBAction func generate(_ sender: NSButton) {
        privateKey.animator().alphaValue = 1
        privateKey.isEnabled = true
        publicKey.animator().alphaValue = 1
        publicKey.isEnabled = true
        generateBtn.isHidden = true
        noticeMid.isHidden = true
        noticeAbove.stringValue = "Great! Now I have the keys! Now I should send my PUBLIC KEY to Alice so that she can decrypt my message!"
        guard let keyPairs = CryptoUtility.getKeyPair(size: 2048) else { return }
        EDElements.publicKey = keyPairs.0
        EDElements.privateKey = keyPairs.1
    }
    
    @IBAction func chooseToSend(_ sender: NSButton) {
        if sender == publicKey {
            noticeAbove.stringValue = "That's correct! Thanks for your help!"
            privateKey.isHidden = true
            nextBtn.isHidden = false
        } else {
            noticeAbove.stringValue = "Oh, no! I think I should send my PUBLIC KEY!"
            nextBtn.isHidden = true
        }
    }
    
}
