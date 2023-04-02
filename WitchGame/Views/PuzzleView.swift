//
//  PuzzleView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 01/04/23.
//

import SwiftUI
import SpriteKit

struct PuzzleView: View {
    var body: some View {
        ZStack() {
            LottieBackground(lottieName: "starsbg")
                .ignoresSafeArea(.all)
            GeometryReader { geo in
                ZStack {
                    SpriteView(scene: PuzzleScene(size: CGSize(width: geo.size.height, height: geo.size.height)))
                        .frame(width: geo.size.width, height: geo.size.height)
                    
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
