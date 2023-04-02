//
//  MenuView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 31/03/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack {
            HStack {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 50) {
                        CharacterButtonView()
                        MenuButtonView(title: "Puzzle 01", imageName: "puzzle1")
                        MenuButtonView(title: "Puzzle 02", imageName: "puzzle1")
                        MenuButtonView(title: "Puzzle 03", imageName: "puzzle1")
                        MenuButtonView(title: "Puzzle 04", imageName: "puzzle1")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image("menu-background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
    }
    
}

struct CharacterButtonView: View {
    var body: some View {
        VStack {
            Image("text1")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(.top)
            Image("witch")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(25)
                .padding(.bottom, 10)
            Button(action: {}) {
                Text("Achievements")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .tint(.red)
        }
        .frame(width: 150)
    }
}

struct MenuButtonView: View {
    let title: String
    let imageName: String
    
    var body: some View {
        VStack {
            Spacer()

            Text(title)
                .foregroundColor(.red)
            Button(action: {}) {
                Image(imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .cornerRadius(25)
            }
            Button(action: {}) {
                Text("Play")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .tint(.red)
            Button(action: {}) {
                Text("Details")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .tint(.red)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
