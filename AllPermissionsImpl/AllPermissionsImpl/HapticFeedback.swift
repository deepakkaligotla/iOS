//
//  HapticFeedback.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 21/04/24.
//

import SwiftUI
import CoreHaptics
import AVFoundation

struct HapticFeedback: View {
    @State private var engine: CHHapticEngine?
    @State private var advancedPatternPlayer: CHHapticAdvancedPatternPlayer?
    @State private var isVibrating: Bool = false
    @State private var vibratingIntensityLevel: CGFloat = 0.5
    
    func setup() {
        let audioSession = AVAudioSession.sharedInstance()
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics, var engine = try? CHHapticEngine(audioSession: audioSession) else { return }
        self.engine = engine
        engine.resetHandler = { try? engine.start() }
        try? engine.start()
    }
    
    func playFromAHAP(fileName: String) {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "ahap") else {
            print("AHAP file not found")
            return
        }

        do {
            let pattern = try CHHapticPattern(contentsOf: fileURL)
            self.advancedPatternPlayer = try engine?.makeAdvancedPlayer(with: pattern)
            self.advancedPatternPlayer?.loopEnabled = true
            self.advancedPatternPlayer?.loopEnd = pattern.duration
            self.advancedPatternPlayer?.playbackRate = 1.0
        } catch {
            print("Error playing haptic from AHAP: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            Button {
                DispatchQueue.main.async {
                    self.playFromAHAP(fileName: "AHAP/Sunflower")
                    if self.isVibrating {
                        try! advancedPatternPlayer?.stop(atTime: CHHapticTimeImmediate)
                        self.engine?.stop()
                    } else {
                        try! self.engine?.start()
                        try! advancedPatternPlayer?.start(atTime: CHHapticTimeImmediate)
                    }
                    self.isVibrating.toggle()
                }
            } label: {
                Image(systemName: self.isVibrating ? "waveform.slash" : "waveform.path").font(.system(size: 80))
                Text(self.isVibrating ? "Stop Vibrating" : "Start Vibrating")
            }
            
            VStack {
                Text("\(Int(self.vibratingIntensityLevel*100))%")
                HStack {
                    Button(action: {
                        self.vibratingIntensityLevel = max(0, self.vibratingIntensityLevel - 0.1)
                    }) {
                        VStack {
                            Image(systemName: "waveform.badge.minus")
                                .font(.system(size: 40))
                            Text("Decrease Intensity")
                                .font(.caption)
                        }
                    }
                    .disabled(vibratingIntensityLevel <= 0)
                    
                    Button(action: {
                        self.vibratingIntensityLevel = min(1, self.vibratingIntensityLevel + 0.1)
                    }) {
                        VStack {
                            Image(systemName: "waveform.badge.plus")
                                .font(.system(size: 40))
                            Text("Increase Intensity")
                                .font(.caption)
                        }
                    }
                    .disabled(vibratingIntensityLevel >= 1)
                }
            }
        }
        .onAppear {
            self.setup()
        }
    }
}

struct HapticFeedback_Previews: PreviewProvider {
    static var previews: some View {
        HapticFeedback()
    }
}
