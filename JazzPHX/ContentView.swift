//
//  ContentView.swift
//  JazzPHX
//
//  Created by Patrick Wheeler on 11/22/23.
//

import SwiftUI
import AVKit

let jazzStreamURL = URL(string: "https://kjzz.streamguys1.com/kjzzhd2_mp3_128")!

class PlayerManager: ObservableObject {
    // should enable sharing of a single player object between all three tabs
    
    @Published var isPlaying = false
    @Published var streamPlayer: AVPlayer?
    
    func togglePlayPause() {
        isPlaying.toggle()
        
        if isPlaying {
            streamPlayer?.play()
        } else {
            streamPlayer?.pause()
        }
    }
    
    func setupPlayer() {
        guard streamPlayer == nil else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            streamPlayer = AVPlayer(url: jazzStreamURL)
        } catch {
            print("Error setting up audio session")
        }
    }
}

//var streamPlayer: AVPlayer?

struct ContentView: View {
    @StateObject var ourPlayerManager = PlayerManager()
    
//    @State private var isPlaying = false
//    @State private var iconAnimate = false
    
    var body: some View {
        TabView {
            LiveRadioTab()
//                .environmentObject(ourPlayerManager)
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
        .onAppear {
            ourPlayerManager.setupPlayer()
        }
        .environmentObject(ourPlayerManager)
        // needs to be here to be accessible to all of the children of the TabView
    }
}

struct LiveRadioTab: View {
    @EnvironmentObject var ourPlayerManager: PlayerManager
    
//    @State private var isPlaying = false
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
                ourPlayerManager.togglePlayPause()
                
//                print("Button Action")
            }) {
                Image(systemName: ourPlayerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 100))
//                    .foregroundColor(isPlaying ? .red : .blue)
                    .foregroundColor(Color(red: 0.15, green: 0.62, blue: 0.82, opacity: 1.0))
                // TODO - should be able to animate the play button too
            }
            .padding()
            .symbolEffect(.bounce, value: ourPlayerManager.isPlaying)
        }
//        .onAppear {
//            print("onAppear")
//            print("Checking rate \(String(describing: streamPlayer?.rate))")
//            if (streamPlayer?.rate == nil || streamPlayer?.rate == 0.0) {
//                print("rate check is true")
//                setupStreamPlayer()
                // setup used to be called outside of this IF which resulted in setup being called every time user returned to this tab, which would stop an already-playing stream
            }
        }
//        .onChange(of: isPlaying) {
//            if isPlaying {
////                print("Play change")
//                streamPlayer?.play()
//            } else {
////                print("Stop change")
//                streamPlayer?.pause()
//            }
//        }

    
//    func setupStreamPlayer() {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//            streamPlayer = AVPlayer(url: jazzStreamURL)
////            print("setup called")
//        } catch {
//            print("Error setting up audio session")
//        }
//    }


struct JazzEventsTab: View {
    @EnvironmentObject var ourPlayerManager: PlayerManager
    var body: some View {
        VStack {
            Text("Tab would display information about local live music scene/events")
                .font(.title)
                .padding()
            Button(action: {
                ourPlayerManager.togglePlayPause()
//                print("Button Action")
//                print(ourPlayerManager.isPlaying)
            }) {
                Image(systemName: ourPlayerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 100))
//                    .foregroundColor(isPlaying ? .red : .blue)
                    .foregroundColor(Color(red: 0.15, green: 0.62, blue: 0.82, opacity: 1.0))
                // TODO - should be able to animate the play button too
            }
            .padding()
            .symbolEffect(.bounce, value: ourPlayerManager.isPlaying)
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

// STATUS - this was good progress, as I made a single player accessible from any tab, and from separate buttons on each tab.
//  Next, I am actually going to pull the play button out of the tabs, and place it 'over' them in zSpace via a zStack. This will enable me to animate the button to different locations based on the selected tab.
//  In fact, I think I will do the same for the logos.
//  Then, the logos and button can be centered on the front page, and then the logos can animate to the top of the screen and the button to the bottom, as we visit the other tabs.
