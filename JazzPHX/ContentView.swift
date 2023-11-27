//
//  ContentView.swift
//  JazzPHX
//
//  Created by Patrick Wheeler on 11/22/23.
//

import SwiftUI
import AVKit

//var myVariable: Int = 10
var streamPlayer: AVPlayer?
let jazzStreamURL = URL(string: "https://kjzz.streamguys1.com/kjzzhd2_mp3_128")!

struct ContentView: View {
    
    @State private var isPlaying = false
    @State private var iconAnimate = false
    
    var body: some View {
        TabView {
            LiveRadioTab()
                .tabItem {
                    Image(systemName: "music.note.list")
//                        .symbolEffect(.bounce, value: iconAnimate  )
//                        .onTapGesture {
//                            iconAnimate.toggle()
//                        }
                        // this does not appear to do anything.
                    // TODO - how do I animate these?
                    Text("Jazz Radio")
                }
               
            
            JazzEventsTab()
                .tabItem {
                    Image(systemName: "music.mic")
                    Text("Live Music Scene")
                }
            
            SupportTab ()
                .tabItem {
                    Image(systemName: "radio")
                    Text("Support KJZZ")
                }
        }
    }
}

struct LiveRadioTab: View {
    
    // TODO - music plays when navigating to other tabs, but stops when user returns to Live Radio tab.
    
    @State private var isPlaying = false
    
    var body: some View {
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
                    .foregroundColor(isPlaying ? .red : .blue)
                // TODO - should be able to animate the play button too
            }
            .padding()
        }
        .onAppear {
            setupStreamPlayer()
        }
        .onChange(of: isPlaying) {
            if isPlaying {
//                print("Play")
                streamPlayer?.play()
            } else {
//                print("Stop")
                streamPlayer?.pause()
            }
        }
    }
    
    func setupStreamPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            streamPlayer = AVPlayer(url: jazzStreamURL)
        } catch { 
            print("Error setting up audio session")
        }
    }
}

struct JazzEventsTab: View {
    
    var body: some View {
        VStack {
            Text("Tab would display information about local live music scene/events")
                .font(.title)
                .padding()
        }
    }
}

struct SupportTab: View {
    
    var body: some View {
        VStack {
            Text("Tab would give information about station and supporting KJZZ")
                .font(.title)
                .padding()
        }
    }
}

// part of tutorial
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
// part of template
#Preview {
    ContentView()
}
