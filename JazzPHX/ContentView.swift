//
//  ContentView.swift
//  JazzPHX
//
//  Created by Patrick Wheeler on 11/22/23.
//

import SwiftUI
import AVKit

var myVariable: Int = 10
var streamPlayer: AVPlayer?
let audioURL = URL(string: "https://kjzz.streamguys1.com/kjzzhd2_mp3_128")!

struct ContentView: View {
    
    @State private var isPlaying = false
    
    
    var body: some View {
//        var streamPlayer: AVPlayer?
        
        VStack {
            Text("Jazz PHX")
                .font(.title)
                .padding()
            
            
            Button(action: {
                self.isPlaying.toggle()
                
                print(isPlaying)
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(isPlaying ? .red : .green)
            }
            .padding()
        }
        .onAppear {
            //            self.setupAudioPlayer()
            //            self.audioPlayer = try! AVAudioPlayer
            
//            setupStreamPlayer()
            
            myVariable = 12
            print(myVariable)
            
            setupStreamPlayer()
            print(myVariable)
        }
        .onChange(of: isPlaying) {
            //            setupAudioPlayer()
            if isPlaying {
                print("Play")
                streamPlayer?.play()
            } else {
                print("Stop")
                streamPlayer?.pause()
            }
        }
    }
    
    func setupStreamPlayer() {
        myVariable = 15
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            streamPlayer = AVPlayer(url: audioURL)
    } catch { }
        
    }
    //    private func setupAudioPlayer() {
    //        let playerItem = AVPlayerItem(url: URL(string: "https://kjzz.streamguys1.com/kjzzhd2_mp3_128")!)
    //        print(audioURL)
    //        let player = AVPlayer(playerItem: playerItem)
    //
    //        if isPlaying {
    //            print("Play")
    //            player.play()
    //        } else {
    //            print("Stop")
    //            player.pause()
    //        }
    //    }
    //
    
}

// part of tutorial
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// part of template
#Preview {
    ContentView()
}
