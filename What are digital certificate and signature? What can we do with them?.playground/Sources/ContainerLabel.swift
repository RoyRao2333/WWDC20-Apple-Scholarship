import Cocoa

public class ContainerLabel: NSTextField {
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func hitTest(_ point: NSPoint) -> NSView? {
        return nil
    }
    
}
