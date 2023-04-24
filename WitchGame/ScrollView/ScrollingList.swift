//
//  ScrollingList.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 03/04/23.
//

import SpriteKit

// MARK: - Scrolling list protocol
protocol ScrollListDelegate {
    func selectedRowNode(node: SKSpriteNode)
}


// MARK: - Scrolling list alignment modes
enum ScrollListHorizontalAlignmentMode {
    case Center
    case Left
    case Right
}

class ScrollingList: SKSpriteNode, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    let scrollNode: SKNode
    var rows = [SKSpriteNode]()  // THE TILES
    var touchY: CGFloat = 0
    var touchX: CGFloat = 0
    let cropNode: SKCropNode
    var horizontalAlignmentMode: ScrollListHorizontalAlignmentMode = .Center
    var verticalMargin: CGFloat = 10
    var scrollingListHeight: CGFloat = 0
    var scrollMin: CGFloat
    var scrollMax: CGFloat
    
    var delegate: ScrollListDelegate?
    
    var touchXPosition: CGFloat?
    var isTouchingSreen: Bool?
    
    var longpressStarted: Bool = false
    var pieceMoved: SKSpriteNode?
    var pieceMovedInitialPosition: CGPoint?
//    var placeholders: [SKSpriteNode] = []
//    var correctPositions: [SKSpriteNode] = []


    
    // MARK: - Init
    
    init(size: CGSize) {
        scrollNode = SKNode()
        cropNode = SKCropNode()
        scrollMin = ((size.height / 2))
        scrollMax = size.height / -2
        
        super.init(texture: nil, color: UIColor.red, size: size)
        
        setup()
        setupScrollNode()
        //setupPlaceholders()
        setupCropNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup
    
    func setup() {
        isUserInteractionEnabled = true
    }
    
    func setupScrollNode() {
        scrollNode.position.y = scrollMin
    }
    
    func setupCropNode() {
        let mask = SKSpriteNode(color: UIColor.orange, size: size)
        cropNode.maskNode = mask
        addChild(cropNode)
        cropNode.addChild(scrollNode)
    }
    
    
    
    
    // MARK: - Touch
    
    var previousY: CGFloat = 0
    var previousX: CGFloat = 0
    
    var selectedNode: SKNode?
    
    var timer: Timer?
    @objc func longPressHandler() {
        print("long press!")
        longpressStarted = true
    }
    var possibleNodeLongPressed: SKSpriteNode? {
        didSet {
            timer?.invalidate()
            timer = nil
            if possibleNodeLongPressed != nil {
                timer = Timer(fireAt: .now + 1.5, interval: 1, target: self, selector: #selector(longPressHandler), userInfo: nil, repeats: false)
                RunLoop.main.add(timer!, forMode: .default)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        let touch = touches.first!
        let location = touch.location(in: self)
        
        touchY = location.y
        previousY = scrollNode.position.y
        
        touchX = location.x
        previousX = scrollNode.position.x
        
        let rowNode = atPoint(location) as? SKSpriteNode
        
        guard let delegate = delegate, let node = rowNode else {
            return
        }

        possibleNodeLongPressed = node


//        selectedNode = rowNode
//        selectedNode?.alpha = 0.5

        // MARK: - tentando fazer a peça se mover no plano XY
        
        let nodeAux: SKSpriteNode = node

        if longpressStarted {
            let rowNode = atPoint(location) as? SKSpriteNode
            if let index = rows.firstIndex(where: { $0 === rowNode}) {
                //rows.remove(at: index)
                print("\(rows.contains(where: { $0 === rowNode}))")
                rowNode?.alpha = 0.5
                rows.append(nodeAux)
                setupRows()
                print("\(index) removido ???")
                //longpressStarted = false
            }
            
            if let piece = rowNode {
                pieceMoved = piece
                pieceMovedInitialPosition = piece.position
                pieceMoved!.zPosition = 1
                playSelectPiece(filename: "clickselect", fileExtension: "mp3")
                let newScale = pieceMoved!.xScale + 0.1 // Scale by 1.5x
                let resizeAction = SKAction.scale(to: newScale, duration: 0.2)
                pieceMoved?.run(resizeAction)
            }
        }
        
        
        delegate.selectedRowNode(node: node)

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        let touch = touches.first!
        let location = touch.location(in: self)
        
        var y = location.y - touchY + previousY // + scrollNode.position.y
        var x = location.x - touchX + previousX
        
        if y < scrollMin {
            y = scrollMin
        } else if y > scrollMax {
            y = scrollMax
        }
        
        scrollNode.position.y = y
        
        
        let rowNode = atPoint(location) as? SKSpriteNode
        guard let delegate = delegate, let node = rowNode else {
            return
        }
//        if selectedNode?.position.x != previousX {
//            selectedNode = rowNode
//            selectedNode?.alpha = 0.5
//        }
        if longpressStarted {
            if let piece = pieceMoved {
                let touch = touches.first!
                let location = touch.location(in: self)
                piece.position = location
            }
        }
//        selectedNode?.position.x = x

//        let rowNode = atPoint(location) as? SKSpriteNode
//        rowNode?.position.x = x
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        print("Touches ended at Scrolling List")
        isTouchingSreen = false
        
        let touch = touches.first!
        let location = touch.location(in: self)
        
        let dy = abs(location.y - touchY)
        
        if dy > 10 { return }
        
        let rowNode = atPoint(location) as? SKSpriteNode
        
        guard let delegate = delegate, let node = rowNode else {
            return
        }
        
        if node == possibleNodeLongPressed {
            possibleNodeLongPressed = nil
        }
        if longpressStarted {
            print("entrou no touches ended")
//            if let piece = pieceMoved {
//                let id = rows.firstIndex(of: piece)!
//                //let correctPosition = correctPositions[id]
//                let distance = hypot(piece.position.x - correctPosition.position.x, piece.position.y - correctPosition.position.y)
//                print("Distance \(distance)")
//                if distance < CGFloat(20.0) {
//                    piece.position = correctPosition.position
//                    print("correto?")
//                } else {
//                    piece.position = pieceMovedInitialPosition!
//                    print("errado?")
//                    
//                }
//            }
            pieceMoved = nil
        }
        longpressStarted = false

        
        delegate.selectedRowNode(node: node)
    }
    
    
    
    // MARK: - Update
    
//    override func update(currentTime: CFTimeInterval) {
//        if touchingScreen {
//            if touchXPosition > CGRectGetMidX(self.frame) {
//                // move character to the right.
//            }
//            else {
//                // move character to the left.
//            }
//        }
//        else { // if no touches.
//            // move character back to middle of screen. Or just do nothing.
//        }
//    }
    
    // TODO: Make the list spring and coast...
    
    
    
    
    // MARK: - Utility Methods
    
    func addNode(node: SKSpriteNode) {
        scrollNode.addChild(node)
        rows.append(node)
        print(node.frame)
        setupRows()
    }
    
    func setupRows() {
        var totalY: CGFloat = 0 // -(rows[0].size.height / 2 + verticalMargin)
        for row in rows {
            positionRowHorizontal(row: row)
            row.position.y = totalY - row.size.height / 2
            totalY -= row.size.height + verticalMargin
        }
        
        scrollingListHeight = -totalY + rows.last!.size.height + verticalMargin
        
        setScrollLimits()
    }
    

    
    func setScrollLimits() {
        scrollMin = size.height / 2
        scrollMax = scrollingListHeight - size.height // - scrollingListHeight // + scrollMin
    }
    
    func positionRowHorizontal(row: SKSpriteNode) {
        switch horizontalAlignmentMode {
        case .Center:
            row.position.x = 0
        case .Left:
            row.position.x = size.width / -5 + row.size.width  / 2 + 10// UIScreen.main.bounds.width
        case .Right:
            row.position.x = size.width / 5 - row.size.width  / 2 - 10
            
//            let teste1 = size.width/2
//            let teste2 = row.size.width/2
//            let teste = size.width / 2 - row.size.width  / 2
        }
    }
    
    
//    private func setupPlaceholders() {
//        let margin: CGFloat = 50
//        let padding: CGFloat = 10
//        let size = CGSize(width: 50, height: 50)
//        //        let startX = (view!.bounds.width - (size.width * 3 + padding * 2 + margin)) / 2 + size.width / 2 + margin
//        //        let startY = (view!.bounds.height - (size.height * 3 + padding * 2 + margin)) / 2 + size.height / 2 + margin
//
//        for i in 0..<3 {
//            for j in 0..<3 {
//                let placeholder = SKSpriteNode(color: .gray, size: size)
//                //                            placeholder.position = CGPoint(x: startX + CGFloat(i % 3) * (size.width + padding),
//                //                                                            y: startY - CGFloat(i / 3) * (size.height + padding))
//                placeholder.position = CGPoint(x: -100 + (60 * j), y: 50 - (60*i))
//                addChild(placeholder)
//                placeholders.append(placeholder)
//                correctPositions.append(placeholder)
//            }
//        }
//    }
}


// longpress = true
// copia = node
// 
