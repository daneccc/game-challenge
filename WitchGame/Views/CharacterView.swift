//
//  CharacterView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 01/04/23.
//

import SwiftUI
import Lottie

struct CharacterView: View {
    var body: some View {
        ZStack {
            LottieBackground(lottieName: "starsbg")
                .ignoresSafeArea(.all)
            HStack {
                Image("witch")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFit()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LottieBackground: UIViewRepresentable {
    typealias UIViewType = UIView
    let animationView = LottieAnimationView()
    var lottieName: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieBackground>) -> UIView {
        let view = UIView(frame: .zero)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieBackground>) {
        animationView.animation = LottieAnimation.named(lottieName)
        animationView.play()
    }
}


struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}




