import Cocoa

public protocol DragableBtnDelegate: NSObjectProtocol {
    func buttonDragged(with event: NSEvent, item: DragableBtn)
}

public class DragableBtn: NSButton {
    public weak var delegate: DragableBtnDelegate?
    public var isDragged = false
    public var isInContainer = false
    public weak var container: ContainerView?
    public var isDragable = true
    
    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func mouseDown(with event: NSEvent) {
        isDragged = true
    }
    
    public override func mouseDragged(with event: NSEvent) {
        if isDragable, isDragged {
            delegate?.buttonDragged(with: event, item: self)
        }
    }
    
    public override func mouseUp(with event: NSEvent) {
        isDragged = false
    }
    
}
