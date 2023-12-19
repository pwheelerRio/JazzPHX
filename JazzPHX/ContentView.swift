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
    @State private var selectedTabIndex = 0
    
//    @State private var isPlaying = false
//    @State private var iconAnimate = false
    
    var body: some View {
        ZStack {
            TabView {
                LiveRadioTab()
                    .tag(0)
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
                    .onAppear(perform: {
                        selectedTabIndex = 0
                        print(selectedTabIndex)
                    })
                
                JazzEventsTab()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "music.mic")
                        Text("Live Music Scene")
                    }
                    .onAppear(perform: {
                        selectedTabIndex = 1
                        print(selectedTabIndex)
                    })
                
                SupportTab ()
                    .tag(2)
                    .tabItem {
                        Image(systemName: "radio")
                        Text("Support KJZZ")
                    }
                    .onAppear(perform: {
                        selectedTabIndex = 2
                        print(selectedTabIndex)
                    })
            }
            .environmentObject(ourPlayerManager)
            // needs to be here to be accessible to all of the children of the TabView.
            
            PlayPauseButton()
                .environmentObject(ourPlayerManager)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .offset(x: selectedTabIndex == 1 ? -100 : (selectedTabIndex == 2 ? 130 : 0), y: selectedTabIndex == 0 ? -210 : -40)
                .animation(.easeInOut, value: selectedTabIndex)
            // This is a demonstration of movement and animation in response to tabIndex.
        }
        .onAppear {
            ourPlayerManager.setupPlayer()
        }
    }
}

struct PlayPauseButton: View {
    @EnvironmentObject var ourPlayerManager: PlayerManager
    
    var body: some View {
        Button(action: {
            ourPlayerManager.togglePlayPause()
        }) {
            Image(systemName: ourPlayerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .font(.system(size: 100))
//              .foregroundColor(isPlaying ? .red : .blue)
                .foregroundColor(Color(red: 0.15, green: 0.62, blue: 0.82, opacity: 1.0))
        }
        .symbolEffect(.bounce, value: ourPlayerManager.isPlaying)
    }
}

struct LiveRadioTab: View {
    @EnvironmentObject var ourPlayerManager: PlayerManager
    @State private var isListening = false
    
    var body: some View {
            GeometryReader { geometry in
                VStack {
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
                    
                    Text("This is only placeholder text meant to represent the Teaser information from the website promoting upcoming programming content, and/or Now Playing Information/Artwork. Moving forward, the logos and play button will be pulled out of zSpace and floated 'above' this content.")
                        .font(.title)
                        .padding()
                        .frame(maxHeight: geometry.size.height / 4) // Set maximum height
                    
                    Spacer() // Spacer to push content to the top
                    
                    Text("Listen Now!")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.bottom, 320) // Add bottom padding
                        .scaleEffect(ourPlayerManager.isPlaying ? 0.0 : 1.0) // Scale effect
                        .animation(.easeInOut, value: ourPlayerManager.isPlaying ) // Animation type
                }
            }
        }

}



struct JazzEventsTab: View {
    @EnvironmentObject var ourPlayerManager: PlayerManager
    var body: some View {
        VStack {
            Text("Tab would display information about local live music scene/events")
                .font(.title)
                .padding()
//            Button(action: {
//                ourPlayerManager.togglePlayPause()
////                print("Button Action")
////                print(ourPlayerManager.isPlaying)
//            }) {
//                Image(systemName: ourPlayerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
//                    .font(.system(size: 100))
////                    .foregroundColor(isPlaying ? .red : .blue)
//                    .foregroundColor(Color(red: 0.15, green: 0.62, blue: 0.82, opacity: 1.0))
//                // TODO - should be able to animate the play button too
//            }
//            .padding()
//            .symbolEffect(.bounce, value: ourPlayerManager.isPlaying)
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
//        .onAppear(perform: {
//            print(selectedTabIndex)
//        })
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
