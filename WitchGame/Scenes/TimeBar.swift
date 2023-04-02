//
//  TimeBar.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 02/04/23.
//

import SpriteKit

class TimerBar: SKNode {

    private var backgroundBar: SKSpriteNode
    private var progressBar: SKSpriteNode
    private var progress: CGFloat = 1.0

    init(size: CGSize, color: UIColor) {
        backgroundBar = SKSpriteNode(color: .gray, size: size)
        backgroundBar.position = CGPoint(x: -150, y: -size.height/2)
        progressBar = SKSpriteNode(color: color, size: CGSize(width: size.width, height: size.height - progress))
        progressBar.anchorPoint = CGPoint(x: 0.5, y: 0)
        progressBar.position = CGPoint(x: -150, y: -size.height/2)

        super.init()

        addChild(backgroundBar)
        addChild(progressBar)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateProgress(_ progress: CGFloat) {
        self.progress = progress

        let newHeight = backgroundBar.size.height * progress
        let newSize = CGSize(width: backgroundBar.size.width, height: newHeight)
        let newPosition = CGPoint(x: -150, y: -100)

        let resizeAction = SKAction.resize(toHeight: newHeight, duration: 10)
        let moveAction = SKAction.move(to: newPosition, duration: 10)
        progressBar.run(resizeAction)
        progressBar.run(moveAction)
    }
}


//class TimerBar: SKNode {
//
//    private let backgroundBar: SKSpriteNode
//    private let progressBar: SKSpriteNode
//
//    private let duration: TimeInterval
//    private var timeLeft: TimeInterval
//
//    init(size: CGSize, color: UIColor, duration: TimeInterval) {
//        backgroundBar = SKSpriteNode(color: .gray, size: size)
//        backgroundBar.position = CGPoint(x: -150, y: -size.height/2)
//
//        progressBar = SKSpriteNode(color: color, size: CGSize(width: size.width, height: size.height - 4))
//        progressBar.anchorPoint = CGPoint(x: 0.5, y: 0)
//        progressBar.position = CGPoint(x: -150, y: -size.height/2)
//
//        self.duration = duration
//        self.timeLeft = duration
//
//        super.init()
//
//        addChild(backgroundBar)
//        addChild(progressBar)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func start() {
//        let action = SKAction.sequence([
//            SKAction.scaleY(to: 0, duration: duration),
//            SKAction.run { [weak self] in self?.timeIsUp() }
//        ])
//        progressBar.run(action)
//    }
//
//    private func timeIsUp() {
//        // TODO: Handle time up event
//    }
//}
