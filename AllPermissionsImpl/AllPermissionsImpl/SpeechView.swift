//
//  SpeechView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import Speech

class SpeechManager: ObservableObject {
    @Published var speechRecognitionAllowed = false
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    
    func transcribeSpeech(audioURL: URL, completion: @escaping (String?) -> Void) {
        let request = SFSpeechURLRecognitionRequest(url: audioURL)
        speechRecognizer?.recognitionTask(with: request) { result, error in
            guard let result = result else {
                completion(nil)
                return
            }
            if result.isFinal {
                completion(result.bestTranscription.formattedString)
            }
        }
    }
}

struct SpeechView: View {
    @ObservedObject var speechManager: SpeechManager
    @StateObject private var viewModel = AudioManagerViewModel()
    @State private var transcription = ""
    
    init(speechManager: SpeechManager = SpeechManager()) {
        self.speechManager = speechManager
    }
    
    var body: some View {
        VStack {
            if SFSpeechRecognizer.authorizationStatus() == .authorized {
                TextField("Speak something...", text: $transcription).padding()
                Button(action: {
                    viewModel.recordAndStop()
                }) {
                    Text(viewModel.isRecording ? "Stop Recording" : "Start Recording")
                }.padding()
                Text("Transcription: \(transcription)").padding()
            } else {
                Button("Grant Speech Recognition Permission") {
                    SFSpeechRecognizer.requestAuthorization { status in }
                }.padding()
                Button("Open Settings") {
                    openSettings()
                }
            }
        }
        .onReceive(viewModel.$recordingURL) { newRecordingURL in
            guard let newRecordingURL = newRecordingURL else {
                return
            }
            speechManager.transcribeSpeech(audioURL: newRecordingURL) { transcription in
                if let transcription = transcription {
                    print("Transcripting")
                    self.transcription = transcription
                } else {
                    print("Issue")
                }
            }
        }
    }
    
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL)
    }
}

struct SpeechView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechView()
    }
}
