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
//                        .foregroundColor(Color(red: 1, green: 0.0, blue: 0.82, opacity: 1.0))
                    
                    Text("Jazz Radio")
                }
               
            
            JazzEventsTab()
                .tabItem {
                    Image(systemName: "music.mic")
//                        .foregroundColor(Color(red: 0.15, green: 0.0, blue: 0.82, opacity: 1.0))
                    Text("Live Music Scene")
                }
            
            SupportTab ()
                .tabItem {
                    Image(systemName: "radio")
//                        .foregroundColor(Color(red: 0.15, green: 0.62, blue: 0.82, opacity: 1.0))
                    Text("Support KJZZ")
                }
        }
    }
}

struct LiveRadioTab: View {
    
    @State private var isPlaying = false
//    print("struct declared")
    
    var body: some View {
        VStack {
//            Text("Jazz PHX")
//                .font(.title)
//                .padding()
//            
            HStack {
                Spacer()
                    .frame(width: 40)
                Image("KJZZ_HD2")
                    .resizable()
                    .scaledToFit()
                Image("JazzPHX")
                    .resizable()
                    .scaledToFit()
                Spacer()
                    .frame(width: 40)
            }
            Button(action: {
                self.isPlaying.toggle()
                
//                print("Button Action")
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 100))
//                    .foregroundColor(isPlaying ? .red : .blue)
                    .foregroundColor(Color(red: 0.15, green: 0.62, blue: 0.82, opacity: 1.0))
                // TODO - should be able to animate the play button too
            }
            .padding()
            .symbolEffect(.bounce, value: isPlaying)
        }
        .onAppear {
//            print("onAppear")
//            print("Checking rate \(String(describing: streamPlayer?.rate))")
            if (streamPlayer?.rate == nil || streamPlayer?.rate == 0.0) {
//                print("rate check is true")
                setupStreamPlayer()
                // setup used to be called outside of this IF which resulted in setup being called every time user returned to this tab, which would stop an already-playing stream
            }
        }
        .onChange(of: isPlaying) {
            if isPlaying {
//                print("Play change")
                streamPlayer?.play()
            } else {
//                print("Stop change")
                streamPlayer?.pause()
            }
        }
    }
    
    func setupStreamPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            streamPlayer = AVPlayer(url: jazzStreamURL)
//            print("setup called")
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
