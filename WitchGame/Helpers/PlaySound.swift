//
//  PlaySound.swift
//  WitchGame
//
//  Created by Daniele Cavalcante on 01/04/23.
//

import AVFoundation
import SwiftUI

var music: AVAudioPlayer!
var pieceSelected: AVAudioPlayer!
var pieceDropped: AVAudioPlayer!

func updateVolume(volume: Float) {
    music.volume = volume
    
}

func stopAudioLooping() {
    music?.stop()
}

func playAudioLooping(filename: String, fileExtension: String) {
    guard let musicURL = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
        return
    }
    do {
        music = try AVAudioPlayer(contentsOf: musicURL)
        music?.numberOfLoops = -1
        music?.play()
    } catch {
        print("Error playing sound: \(error.localizedDescription)")
    }
}

func playSelectPiece(filename: String, fileExtension: String) {
    do {
        let sound = Bundle.main.path(forResource: filename, ofType: fileExtension)
        pieceSelected = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        pieceSelected?.play()
    } catch {
        print("Error loading sound file: \(error.localizedDescription)")
    }
}
