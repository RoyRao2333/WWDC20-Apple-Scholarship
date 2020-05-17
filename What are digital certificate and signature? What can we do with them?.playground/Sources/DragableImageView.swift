import Cocoa

public protocol DragableImageViewDelegate: NSObjectProtocol {
    func imageViewDragged(with event: NSEvent, item: DragableImageView)
}

public class DragableImageView: NSImageView {
    public weak var delegate: DragableImageViewDelegate?
    public var isDragged = false
    public var isDragable = true
    public var isInContainer = false
    
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
            delegate?.imageViewDragged(with: event, item: self)
        }
    }
    
    public override func mouseUp(with event: NSEvent) {
        isDragged = false
    }
    
}
