//
//  PuzzleSixView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 02/04/23.
//

import SwiftUI
import SpriteKit

struct PuzzleSceneView: View {
    @State private var gameStarted = false
    
    var body: some View {
        GeometryReader { geo in
            LottieBackground(lottieName: "starsbg")
                .ignoresSafeArea(.all)
            ZStack {
                SpriteView(scene: PuzzleScene(size: CGSize(width: geo.size.height, height: geo.size.height)))
//                    .frame(width: geo.size.width, height: geo.size.height + 20)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    // .padding(.top, 20)
                    .disabled(!gameStarted) // Disable SpriteView when game is not started
                    .navigationBarBackButtonHidden()
                    .edgesIgnoringSafeArea(.leading)
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button("Start") {
                            gameStarted = true
                        }
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .opacity(gameStarted ? 0 : 1) // Hide VStack when game is started
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct PuzzleSixView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleSceneView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
