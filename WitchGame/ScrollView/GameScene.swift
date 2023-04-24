//
//  GameScene.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 03/04/23.
//

import SpriteKit

class GameScene: SKScene, ScrollListDelegate {
    
    let list: ScrollingList
    let label: SKLabelNode
        
    var placeholders: [SKSpriteNode] = []
    var correctPositions: [SKSpriteNode] = []
    
    // MARK: - Scrolling Delegate
    
    // ScrollingList sends it's delegate this message along with the node that
    // tapped when a tap occurs.
    
    func selectedRowNode(node: SKSpriteNode) {
        // Check the node name to decide what to do here...
        print("Selected Row: \(node.name)")
        if node.name != nil {
            label.text = node.name
            //node.position = CGPoint(x: 0, y: 0)
        }
    }
    
    
    
    // MARK: - Init
    
    override init(size: CGSize) {
        
        // Create a ScrollingList of size
        list = ScrollingList(size: CGSize(width:  UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        // Set the Alignment mode: .Left, .Right, .Center
        list.horizontalAlignmentMode = .Right
        // Set the background Color
        list.color = UIColor.brown
        
        // This label is used to show the effect of tapping a row
        label = SKLabelNode(fontNamed: "Helvetica")
        
        // Must call super.init()
        super.init(size: size)
        
        // Set up the label and the list
        //setupLabel()
        setupPlaceholders()
        setupList()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Setup
    
    func setupLabel() {
        // Setup Label
        addChild(label)
        label.position = CGPoint(x: size.width / 2, y: size.height / 2 - 250)
        label.text = "????"
    }
    
    func setupList() {
        // Assign this class as the delegate for the List, for tap on rows.
        list.delegate = self
        // Add the list to this scene
        addChild(list)
        // Position the list. THe reference point is in the center.
        list.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        // Generate some rows to appear in the list
        // The size for each row. Comment the two lines below to make all of the rows the same size.
        var rowSize = CGSize(width: 300, height: 40)
        
        // Make 20 rows.
        for i in 0...8 {
            // Set the color of a row
            let hue: CGFloat = 1 / 20 * CGFloat(i)
            let color = UIColor(hue: hue, saturation: 0.8, brightness: 0.8, alpha: 1)
            
            // Randomize the size of a row
            // rowSize.height = CGFloat(arc4random() % 40) + 30
            // rowSize.width = CGFloat(arc4random() % 60) + 240
            
            // Make a Sprite node row
//            let sprite = SKSpriteNode(color: color, size: rowSize)
            let sprite = SKSpriteNode(imageNamed: "piece\(i+1)")
            sprite.size = CGSize(width: 45, height: 90)
            // Give the row a name. This will help with handling taps on a row.
            sprite.name = "row-\(i)"
            
            //sprite.removeFromParent()
            
            // Add the row to the list
            list.addNode(node: sprite)
        }
    }
    
    
    // MARK: - View Lifecycle
    
//    override func didMoveToView(view: SKView) {
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
    }
    
    
    
    
    // MARK: - Touches
    
    //override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
        
    }
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        
    }
    
    
    
    // MARK: - Update
   
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
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
   
}
