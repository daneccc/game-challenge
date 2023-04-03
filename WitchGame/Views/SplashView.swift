//
//  SplashView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 02/04/23.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @State var isActive: Bool = false
    let animationWitchView = LottieAnimationView()

    var body: some View {
        ZStack() {
            if self.isActive {
                MenuGameView()
            } else {
                LottieBackground(lottieName: "starsbg")
                    .ignoresSafeArea(.all)
                ZStack {
                    LottieBackground(lottieName: "witch-animation")
                        .frame(width: 350, height: 350)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
