//
//  ContentView.swift
//  WatchRangers Watch App
//
//  Created by Victor Castro on 30/01/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State var avp: AVAudioPlayer?
    @State var timer: Timer?
    @State var separate: Double = 30
    @State var widthDino: Double = 90
    
    var body: some View {
        ZStack {
            GeometryReader { (geometry) in
                
                Image("r-dino")
                    .resizable()
                    .frame(width: widthDino, height: widthDino, alignment: .center)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    .animation(.easeIn(duration: 0.5), value: widthDino)
                
                Image("r-top")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .position(x: geometry.size.width / 2, y: (geometry.size.height / 2) - separate)
                    .animation(.easeInOut(duration: 0.5), value: separate)
                
                Image("r-bottom")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .position(x: geometry.size.width / 2, y: (geometry.size.height / 2) + separate)
                    .animation(.easeInOut(duration: 0.5), value: separate)
            }
        }
        .background(.black)
        .onTapGesture {
            separate += 10
            widthDino = 80
            playNotificacion()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                separate = 30
                widthDino = 90
            })
            
        }
    }
    
    func playNotificacion() {
        if self.timer == nil {
            guard let url = Bundle.main.url(forResource: "ranger-notificacion", withExtension: "mp3") else { return }
            try? avp = AVAudioPlayer(contentsOf: url)
            avp?.play()
        } else {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
