import Cocoa

public class ContainerView: NSView {
    public var itemWithin: NSButton?
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = .clear
        self.layer?.borderWidth = 2
        self.layer?.borderColor = NSColor.gray.cgColor
        self.layer?.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
