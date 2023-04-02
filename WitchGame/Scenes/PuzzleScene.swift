import SpriteKit

class PuzzleScene: SKScene {
    
    // MARK: - Properties
    
    var pieces: [SKSpriteNode] = []
    var placeholders: [SKSpriteNode] = []
    var pieceMoved: SKSpriteNode?
    var pieceMovedInitialPosition: CGPoint?
    //var correctPositions: [CGPoint] = []
    var correctPositions: [SKSpriteNode] = []
    //var filledPlaceholders: [CGPoint] = []
    var count: Int = 0
    
    var scrollView: UIScrollView!

    
    // MARK: - View Lifecycle
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        let timerBar = TimerBar(size: CGSize(width: 10, height: 150), color: .red)
//        addChild(timerBar)
//        timerBar.updateProgress(0.3)
        
//        let timerBar = TimerBar(size: CGSize(width: 20, height: 100), color: .green, duration: 60)
//        addChild(timerBar)
//        timerBar.start()
        
        setupScene()
        setupPlaceholders()
        setupPieces()
    }
    
    // MARK: - Setup Methods
    
    private func setupScene() {
//        let background = SKSpriteNode(imageNamed: "puzzle-background")
//        background.anchorPoint = .zero
//        addChild(background)

        backgroundColor = .white

    }
    
    private func setupPieces() {
        let piecePositions = [(80, [1,2,3]), (130, [4,5,6]), (160, [7,8,9])]
        let pieceSize = CGSize(width: 50, height: 50)

        for (x, nums) in piecePositions {
            for num in nums {
                let piece = SKSpriteNode(imageNamed: "piece\(num)")
                piece.size = pieceSize
                piece.position = CGPoint(x: x, y: 130 - (60 * (num % 3)))
                addChild(piece)
                pieces.append(piece)
            }
        }
    }
    private func setupPlaceholders() {
        let margin: CGFloat = 50
        let padding: CGFloat = 10
        let size = CGSize(width: 50, height: 50)
//        let startX = (view!.bounds.width - (size.width * 3 + padding * 2 + margin)) / 2 + size.width / 2 + margin
//        let startY = (view!.bounds.height - (size.height * 3 + padding * 2 + margin)) / 2 + size.height / 2 + margin
        
        for i in 0..<3 {
            for j in 0..<3 {
                let placeholder = SKSpriteNode(color: .gray, size: size)
//                            placeholder.position = CGPoint(x: startX + CGFloat(i % 3) * (size.width + padding),
//                                                            y: startY - CGFloat(i / 3) * (size.height + padding))
                placeholder.position = CGPoint(x: -100 + (60 * j), y: 50 - (60*i))
                addChild(placeholder)
                placeholders.append(placeholder)
                correctPositions.append(placeholder)
            }
        }
    }
    
    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = nodes(at: location).first
        
        if let piece = node as? SKSpriteNode, pieces.contains(piece) {
            pieceMoved = piece
            pieceMovedInitialPosition = piece.position
            pieceMoved!.zPosition = 1
            playSelectPiece(filename: "clickselect", fileExtension: "mp3")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let piece = pieceMoved {
            let touch = touches.first!
            let location = touch.location(in: self)
            piece.position = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let piece = pieceMoved {
            let id = pieces.firstIndex(of: piece)!
            let correctPosition = correctPositions[id]
            let distance = hypot(piece.position.x - correctPosition.position.x, piece.position.y - correctPosition.position.y)
            print("INFERNO \(distance)")
            if distance < CGFloat(20.0) {
                piece.position = correctPosition.position
                count += 1
                print("infernoooo")
            } else {
                piece.position = pieceMovedInitialPosition!
                print("ceu")

            }
            pieceMoved = nil
            playSelectPiece(filename: "drop", fileExtension: "mp3")
            
            if(count == 9) {
                print("TERMINOU")
                // Create an SKSpriteNode for the ball
                let ball = SKSpriteNode(imageNamed: "witch")

                // Set the ball's position and size
                ball.position = CGPoint(x: -50, y:0)
                ball.size = CGSize(width: 100, height: 100)

                // Add the ball to the scene
                addChild(ball)

                // Create an SKAction to spin the ball
                let spin = SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1.0))

                // Run the spin action on the ball
                ball.run(spin)
            }
        }
    }
}
