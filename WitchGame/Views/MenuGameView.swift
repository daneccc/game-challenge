//
//  ContentView.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 31/03/23.
//

import SwiftUI
import Combine

struct MenuGameView: View {
    let buttonSize: CGFloat = 30
    
    @State var isPlaying = false
    @State var isBlocked = false
    
    @State var volume: Float = 1.0
    @State var showSlider = false
    @State private var isShowingSlider = false
    let userDefaults = UserDefaults.standard
    let isPlayingKey = "isPlayingKey"
    let isBlockedKey = "isBlockedKey"
    
    
    var body: some View {
        NavigationView {
            ZStack {
                LottieBackground(lottieName: "starsbg")
                    .ignoresSafeArea(.all)
                VStack() {
                    CustomNavBar(left: {
                        NavigationLink(destination: CharacterView()) {
                            Image("witch")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .padding(.leading, 15)
                        }
                    }, center: {
                        Image("logo1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 353, height: 106)
                    }, right: {
                        Button(action: {
                            if self.isPlaying {
                                stopAudioLooping()
                                isPlaying = false
                            } else {
                                playAudioLooping(filename: "music", fileExtension: "mp3")
                                isPlaying = true
                            }
                            userDefaults.set(isPlaying, forKey: isPlayingKey)
                        }, label: {
                            Image(systemName: self.isPlaying ? "speaker.fill" : "speaker.slash.fill")
                                .foregroundColor(.white)
                                .opacity(0.8)
                                .font(.system(size: 50))
                                .padding(.bottom, 10)
                        })
                        .buttonStyle(.plain)
                        .onAppear(perform: {
                            if let savedIsPlaying = userDefaults.value(forKey: isPlayingKey) as? Bool {
                                isPlaying = savedIsPlaying
                                if isPlaying {
                                    playAudioLooping(filename: "music", fileExtension: "mp3")
                                }
                            }
                        })
                    })
                    
                    .padding(.top, 10)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 40) {
                            ForEach(1...4, id: \.self) { index in
                                PuzzleButtonView(title: "Puzzle 0\(index)", imageName: "puzzle1", isLocked: self.isBlocked)
                            }
                        }
                        .padding(.leading, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MenuGameView()
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}

struct CustomNavBar<Left, Center, Right>: View where Left: View, Center: View, Right: View {
    let left: () -> Left
    let center: () -> Center
    let right: () -> Right
    init(@ViewBuilder left: @escaping () -> Left, @ViewBuilder center: @escaping () -> Center, @ViewBuilder right: @escaping () -> Right) {
        self.left = left
        self.center = center
        self.right = right
    }
    var body: some View {
        ZStack {
            HStack {
                left()
                Spacer()
            }
            center()
            HStack {
                Spacer()
                right()
            }
        }
    }
}

struct PuzzleButtonView: View {
    let title: String
    let imageName: String
    let isLocked: Bool
    @GestureState private var isPressing = false
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .foregroundColor(.white)
            
            NavigationLink(destination: PuzzleSceneView()) {
                Image(imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .cornerRadius(25)
                    .overlay(
                        Image("play")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .opacity(isPressing ? 0 : 1)
                    )
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 1)
                    .updating($isPressing) { value, state, transaction in
                        state = value
                    }
            )
            .buttonStyle(.plain)
            Button(action: {}) {
                Text("Details")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .foregroundColor(.white)
            .tint(.purple)
        }
    }
}

struct SliderView: View {
    @Binding var volume: Float
    @Binding var isShowingSlider: Bool
    var body: some View {
        VStack {
            Slider(value: $volume, in: 0...1, onEditingChanged: { _ in
                updateVolume(volume: volume)
            })
            .accentColor(.purple)
            .padding()
            
            Button(action: {
                isShowingSlider = false
            }, label: {
                Text("Done")
            })
            .padding()
        }
        .navigationTitle("Volume")
    }
}
