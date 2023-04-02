//
//  PuzzleGameView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 02/04/23.
//

import SwiftUI
import SpriteKit

struct PuzzleGameView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 300)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 600, height: 300)
            .ignoresSafeArea()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleGameView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
