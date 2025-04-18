//
//  MicrophoneView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import AVFoundation
import Foundation
import Combine
import UIKit

struct MicrophoneView: View {
    @StateObject private var viewModel = AudioManagerViewModel()
    @State private var recordingCurrentTime: String = "00:00"
    @State private var playbackProgress: Double = 0
    @State private var playbackCurrentTime: String = "00:00"
    @State private var playbackRemainingTime: String = "-00:00"
    
    var body: some View {
        NavigationView {
            VStack(spacing: .zero) {
                PlaybackView(
                    audioURL: $viewModel.recordingURL,
                    isPlaying: $viewModel.isPlaying,
                    progress: $playbackProgress,
                    currentTime: $playbackCurrentTime,
                    remainedTime: $playbackRemainingTime,
                    action: { viewModel.playAndStop() },
                    onForward: { viewModel.forwardPlayback() },
                    onRewind: { viewModel.rewindPlayback() },
                    onTrash: { viewModel.deleteRecording() }
                )
                .padding(.horizontal, 24)
                Spacer()
                VStack(spacing: 10) {
                    if viewModel.isRecording {
                        Text(recordingCurrentTime)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white.opacity(0.6))
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 6) {
                                ForEach(0..<viewModel.avgPowers.count, id: \.self) { index in
                                    let power = CGFloat(viewModel.avgPowers[index])
                                    ZStack {
                                        Rectangle()
                                            .fill(Color.red)
                                            .frame(width: 1.5)
                                            .frame(height: power == 0 ? 1.5 : power * 52)
                                    }
                                    .frame(height: 52)
                                }
                            }
                        }
                        .rotationEffect(.degrees(180))
                        .frame(height: 52)
                        .opacity(viewModel.isRecording ? 1 : 0)
                    }
                    
                    RecorderButton(isRecording: $viewModel.isRecording) {
                        viewModel.recordAndStop()
                    }
                }
                .padding(.bottom, 30)
                .animation(.easeInOut, value: viewModel.isRecording)
            }
            .padding(.top, 16)
            .navigationTitle("Permission Impl Microphone")
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(viewModel.audioManager.recordingCurrentTimePublisher) { timeInMiniutesAndSeconds in
                recordingCurrentTime = timeInMiniutesAndSeconds
            }
            .onReceive(viewModel.audioManager.playbackProgressPublisher) { progress in
                playbackProgress = progress
            }
            .onReceive(viewModel.audioManager.playbackCurrentTimePublisher) { duration in
                playbackCurrentTime = duration
            }
            .onReceive(viewModel.audioManager.playbackRemainingTimePublisher) { duration in
                playbackRemainingTime = duration
            }
            .onReceive(viewModel.audioManager.recordingPowerPublisher) { avgPowers in
                withAnimation(.linear(duration: 0.1)) {
                    viewModel.avgPowers = Array(avgPowers.reversed())
                }
            }
            .onAppear {
                viewModel.prepare()
            }
            .alert(isPresented: $viewModel.isPermissionAlertPresented) {
                Alert(
                    title: Text("Microphone Access Required"),
                    message: Text("Please enable microphone access in Settings to use this feature."),
                    dismissButton: .cancel()
                )
            }
        }
    }
}

func showMicrophonePermissionAlert(on viewController: UIViewController) {
    let alertController = UIAlertController(
        title: "Microphone Access Required",
        message: "Please enable microphone access in Settings to use this feature.",
        preferredStyle: .alert
    )
    
    alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    alertController.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }))
    
    DispatchQueue.main.async {
        viewController.present(alertController, animated: true)
    }
}

struct PlaybackView: View {
    @Binding var audioURL: URL?
    @Binding var isPlaying: Bool
    @Binding var progress: Double
    @Binding var currentTime: String
    @Binding var remainedTime: String
    var action: () -> Void
    var onForward: () -> Void
    var onRewind: () -> Void
    var onTrash: () -> Void
    
    private var date: String? {
        guard let audioURL,
              let values = try? audioURL.resourceValues(forKeys: [.creationDateKey]),
              let creationDate = values.creationDate
        else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: creationDate)
    }
    
    var body: some View {
        ZStack {
            if let audioURL {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 12) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(audioURL.lastPathComponent)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                            
                            if let date {
                                Text(date)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white.opacity(0.6))
                            }
                        }
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 8) {
                        ProgressView(value: progress)
                            .progressViewStyle(.linear)
                        
                        HStack(spacing: .zero) {
                            Text(currentTime)
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.6))
                            Spacer()
                            Text(remainedTime)
                                .font(.system(size: 12))
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                    
                    HStack(spacing: 30) {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 24, height: 24)
                        
                        Spacer()
                        
                        Button {
                            onRewind()
                        } label: {
                            Image(systemName: "gobackward.5")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                        .frame(width: 24, height: 24)
                        
                        PlayerButton(isPlaying: $isPlaying) {
                            action()
                        }
                        
                        Button {
                            onForward()
                        } label: {
                            Image(systemName: "goforward.5")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                        .frame(width: 24, height: 24)
                        
                        Spacer()
                        
                        Button {
                            onTrash()
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.accentColor)
                        }
                        .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
}

struct PlayerButton: View {
    @Binding var isPlaying: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
        }
        .frame(width: 20, height: 20)
        .buttonStyle(CustomButtonStyle())
        .animation(.easeOut, value: isPlaying)
    }
    
    fileprivate struct CustomButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
}

struct RecorderButton: View {
    @Binding var isRecording: Bool
    var action: () -> Void
    
    private var itemSize: CGFloat {
        isRecording ? 20 : 40
    }
    
    private var cornerRadius: CGFloat {
        isRecording ? 4 : 24
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: itemSize, height: itemSize)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
            .frame(width: 52, height: 52)
            .background(Color.black)
            .overlay(
                RoundedRectangle(cornerRadius: 26)
                    .strokeBorder(Color.white, lineWidth: 3)
            )
        }
        .buttonStyle(CustomButtonStyle())
        .animation(.easeOut, value: isRecording)
    }
    
    fileprivate struct CustomButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
        }
    }
}

class AudioManagerViewModel: ObservableObject {
    private(set) var audioManager: AudioManager!
    
    @Published var recordingURL: URL?
    @Published var isRecording: Bool = false
    @Published var isPlaying: Bool = false
    @Published var avgPowers: [Float] = []
    @Published var isPermissionAlertPresented: Bool = false
    
    init() {
        audioManager = AudioManager(delegate: self)
        Task { try? await audioManager.updateOrientation(interfaceOrientation: .portrait) }
    }
    
    func prepare() {
        do {
            try audioManager.configureRecorder()
            audioManager.resetPlayback()
        } catch {
            askRecordingPermission()
        }
    }
    
    func recordAndStop() {
        isRecording ? audioManager.stopRecording() : audioManager.record()
    }
    
    func playAndStop() {
        isPlaying ? audioManager.pausePlayback() : audioManager.play()
    }
    
    func forwardPlayback() {
        audioManager.forwardPlayback(by: 5)
    }
    
    func rewindPlayback() {
        audioManager.rewindPlayback(by: 5)
    }
    
    func deleteRecording() {
        audioManager.deleteRecording()
        audioManager.resetPlayback()
        recordingURL = nil
    }
    
    private func askRecordingPermission() {
        if AVAudioApplication.shared.recordPermission == AVAudioApplication.recordPermission.undetermined {
            AVAudioApplication.requestRecordPermission { [weak self] _ in
                self?.prepare()
            }
        } else {
            isPermissionAlertPresented = true
        }
    }
}

extension AudioManagerViewModel: AudioManagerDelegate {
    func audioManagerDidChangeRecordingState(_ audioManager: AudioManager, state: AudioRecorderManager.RecordingState) {
        Task {
            await MainActor.run {
                isRecording = state == .recording
            }
        }
    }
    
    func audioManagerDidChangePlaybackState(_ audioManager: AudioManager, state: AudioManager.PlaybackState) {
        Task {
            await MainActor.run {
                isPlaying = state == .playing
            }
        }
    }
    
    func audioManagerDidFinishRecording(_ audioManager: AudioManager, at location: URL) {
        recordingURL = location
        avgPowers = []
    }
    
    func audioManagerDidFinishPlaying(_ audioManager: AudioManager) {}
    
    func audioManagerLastRecordingLocation(_ audioManager: AudioManager, location: URL) {
        recordingURL = location
    }
}

extension FileManager {
    var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func urlInDocumentsDirectory(named: String) -> URL {
        return documentsDirectory.appendingPathComponent(named)
    }
}

extension NotificationCenter {
    public func post(notification: MyNotification, object anObject: Any? = nil) {
        self.post(name: notification.name, object: anObject)
    }
    
    public func publisher(for aName: MyNotification) -> Publisher {
        self.publisher(for: aName.name)
    }
}

extension View {
    public func onReceive(_ notification: MyNotification, perform action: @escaping NotificationCompletion) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: notification)) { output in
            action(output)
        }
    }
}

extension UIInterfaceOrientation {
    var inputOrientation: AVAudioSession.StereoOrientation {
        return AVAudioSession.StereoOrientation(rawValue: rawValue)!
    }
}

public typealias NotificationOutput = NotificationCenter.Publisher.Output
public typealias NotificationCompletion = (NotificationOutput) -> Void

public enum MyNotification: String, NotificationName {
    case soundControlKitRequiredToStopAudioPlayback
    case soundControlKitRequiredToStopAllAudioPlayback
    
    public var key: String {
        self.rawValue
    }
}

public protocol NotificationName {
    var name: Notification.Name { get }
}

extension NotificationName where Self: RawRepresentable, RawValue == String {
    public var name: Notification.Name {
        get {
            Notification.Name(rawValue)
        }
    }
}

class AudioManager: AudioRecorderManager {
    private(set) var playbackState: PlaybackState = .stopped {
        didSet {
            handlePlaybackStateChange(playbackState)
        }
    }
    
    var player: AVAudioPlayer?
    let placbackCurrentTimeSubject = PassthroughSubject<String, Never>()
    let playbackRemainingTimeSubject = PassthroughSubject<String, Never>()
    let playbackProgressSubject = PassthroughSubject<Double, Never>()
    var subscriptions: Set<AnyCancellable> = []
    public weak var delegate: AudioManagerDelegate?
    
    public var playbackCurrentTimePublisher: AnyPublisher<String, Never> {
        placbackCurrentTimeSubject.eraseToAnyPublisher()
    }
    
    public var playbackRemainingTimePublisher: AnyPublisher<String, Never> {
        playbackRemainingTimeSubject.eraseToAnyPublisher()
    }
    
    public var playbackProgressPublisher: AnyPublisher<Double, Never> {
        playbackProgressSubject.eraseToAnyPublisher()
    }
    
    public init(delegate: AudioManagerDelegate? = nil) {
        self.delegate = delegate
        super.init()
        
        bind()
        
        guard let recordingURL else { return }
        delegate?.audioManagerLastRecordingLocation(self, location: recordingURL)
        try? initializeAudioPlayer()
        
        guard let player else { return }
        let remainedDuration = formatRemainingTime(
            currentTime: player.currentTime,
            duration: player.duration
        )
        playbackRemainingTimeSubject.send(remainedDuration)
    }
    
    public override func record() {
        stopPlayback()
        updatePlaybackTimeAttributes()
        super.record()
    }
    
    public override func record() async {
        stopPlayback()
        updatePlaybackTimeAttributes()
        await super.record()
    }
    
    public func play() {
        guard state != .recording else { return }
        try? configurePlaybackAudioSession()
        if player == nil {
            try? initializeAudioPlayer()
        }
        
        if timer == nil {
            startTimerToTrackAudioPlayer()
        }
        
        player?.play()
        playbackState = .playing
    }
    
    public func pausePlayback() {
        player?.pause()
        playbackState = .paused
    }
    
    public func stopPlayback() {
        stopTimer()
        player?.stop()
        player?.currentTime = .zero
        playbackState = .stopped
    }
    
    public func forwardPlayback(by seconds: TimeInterval) {
        guard let player else { return }
        let newTime = min(player.currentTime + seconds, player.duration)
        player.currentTime = newTime
        updatePlaybackTimeAttributes()
    }
    
    public func rewindPlayback(by seconds: TimeInterval) {
        guard let player else { return }
        let newTime = max(player.currentTime - seconds, 0)
        player.currentTime = newTime
        updatePlaybackTimeAttributes()
    }
    
    public func resetPlayback() {
        stopPlayback()
        try? initializeAudioPlayer()
        updatePlaybackTimeAttributes()
    }
    
    override func audioRecorderDidChangeState(_ state: RecordingState) {
        super.audioRecorderDidChangeState(state)
        delegate?.audioManagerDidChangeRecordingState(self, state: state)
    }
    
    override func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder) {
        super.audioRecorderDidFinishRecording(recorder)
        guard let recordingURL else { return }
        delegate?.audioManagerDidFinishRecording(self, at: recordingURL)
        resetPlayback()
    }
    
    private func bind() {
        NotificationCenter.default
            .publisher(for: .soundControlKitRequiredToStopAudioPlayback)
            .sink { [weak self] notification in
                guard let self,
                      let url = notification.object as? URL,
                      let recordingURL, url == recordingURL
                else { return }
                self.stopPlayback()
            }
            .store(in: &subscriptions)
        NotificationCenter.default
            .publisher(for: .soundControlKitRequiredToStopAllAudioPlayback)
            .sink { [weak self] _ in
                self?.stopPlayback()
            }
            .store(in: &subscriptions)
    }
    
    private func initializeAudioPlayer() throws {
        guard let url = recordingURL else { return }
        let session = AVAudioSession.sharedInstance()
        do {
            try? session.overrideOutputAudioPort(.speaker)
            player = try AVAudioPlayer(contentsOf: url)
            player?.isMeteringEnabled = true
            player?.delegate = self
            player?.prepareToPlay()
        } catch {
            throw PlaybackError.unableToInitializeAudioPlayer
        }
    }
    
    private func handlePlaybackStateChange(_ state: PlaybackState) {
        delegate?.audioManagerDidChangePlaybackState(self, state: state)
    }
    
    private func startTimerToTrackAudioPlayer() {
        timer = Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] timer in
                guard let self, self.playbackState == .playing else { return }
                updatePlaybackTimeAttributes()
            }
    }
    
    private func updatePlaybackTimeAttributes() {
        guard let player else { return }
        let progress = player.currentTime / player.duration
        let currentTime = formatTime(player.currentTime)
        let remainingTime = formatRemainingTime(currentTime: player.currentTime, duration: player.duration)
        playbackProgressSubject.send(progress)
        placbackCurrentTimeSubject.send(currentTime)
        playbackRemainingTimeSubject.send(remainingTime)
    }
    
    private func updateRemainingTime() {
        guard let player else { return }
        let remainingTime = formatRemainingTime(
            currentTime: player.currentTime,
            duration: player.duration
        )
        playbackRemainingTimeSubject.send(remainingTime)
    }
    
    private func formatRemainingTime(currentTime: TimeInterval, duration: TimeInterval) -> String {
        let minutes = abs((Int(currentTime) / 60) - (Int(duration) / 60))
        let seconds = abs((Int(currentTime) % 60) - (Int(duration) % 60))
        return String(format: "-%02d:%02d", minutes, seconds)
    }
}

extension AudioManager: AVAudioPlayerDelegate {
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playbackProgressSubject.send(1)
        playbackState = .stopped
        player.currentTime = 0
        player.prepareToPlay()
        placbackCurrentTimeSubject.send("00:00")
        updateRemainingTime()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.playbackProgressSubject.send(0)
        }
        delegate?.audioManagerDidFinishPlaying(self)
    }
}

extension AudioManager {
    public enum PlaybackError: Error {
        case unableToInitializeAudioPlayer
    }
    public enum PlaybackState {
        case playing
        case paused
        case stopped
    }
}

protocol AudioManagerDelegate: AnyObject {
    func audioManagerDidChangeRecordingState(_ audioManager: AudioManager, state: AudioManager.RecordingState)
    func audioManagerDidChangePlaybackState(_ audioManager: AudioManager, state: AudioManager.PlaybackState)
    func audioManagerDidFinishRecording(_ audioManager: AudioManager, at location: URL)
    func audioManagerDidFinishPlaying(_ audioManager: AudioManager)
    func audioManagerLastRecordingLocation(_ audioManager: AudioManager, location: URL)
}

extension AudioManagerDelegate {
    public func audioManagerDidChangeRecordingState(_ audioManager: AudioManager, state: AudioManager.RecordingState) {}
    public func audioManagerDidChangePlaybackState(_ audioManager: AudioManager, state: AudioManager.PlaybackState) {}
    public func audioManagerDidFinishPlaying(_ audioManager: AudioManager) {}
    public func audioManagerLastRecordingLocation(_ audioManager: AudioManager, location: URL) {}
}

class AudioRecorderManager: AudioSessionManager {
    private(set) var state: RecordingState = .stopped {
        didSet {
            audioRecorderDidChangeState(state)
        }
    }
    private var isStereoSupported: Bool = false {
        didSet {
            try? setupAudioRecorder()
        }
    }
    private var recorder: AVAudioRecorder?
    private let recordingFileName = "recording_\(Date()).aac"
    private let recordingCurrentTimeSubject = PassthroughSubject<String, Never>()
    private let recordingPowerSubject = PassthroughSubject<[Float], Never>()
    private var avgPowers: [Float] = []
    var timer: AnyCancellable?
    public var recordingCurrentTimePublisher: AnyPublisher<String, Never> {
        recordingCurrentTimeSubject.eraseToAnyPublisher()
    }
    
    public var recordingPowerPublisher: AnyPublisher<[Float], Never> {
        recordingPowerSubject.eraseToAnyPublisher()
    }
    
    public var recordingURL: URL? {
        let url = FileManager.default.urlInDocumentsDirectory(named: recordingFileName)
        return FileManager.default.fileExists(atPath: url.path) ? url : nil
    }
    
    public var isRecordPremissionGranted: Bool {
        return AVAudioApplication.shared.recordPermission == .granted
    }
    
    public override init() {
        super.init()
    }
    
    public func configureRecorder() throws {
        guard isRecordPremissionGranted else {
            throw RecorderError.microphonePermissionRequired
        }
        
        try configurePlayAndRecordAudioSession()
        try enableBuiltInMicrophone()
        try setupAudioRecorder()
        Task {
            try? await updateOrientation(interfaceOrientation: .portrait)
        }
    }
    
    private func setupAudioRecorder() throws {
        let tempDir = FileManager.default.temporaryDirectory
        let fileURL = tempDir.appendingPathComponent(recordingFileName)
        do {
            let audioSettings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVLinearPCMIsNonInterleaved: false,
                AVSampleRateKey: 44_100.0,
                AVNumberOfChannelsKey: isStereoSupported ? 2 : 1,
                AVLinearPCMBitDepthKey: 16,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]
            recorder = try AVAudioRecorder(url: fileURL, settings: audioSettings)
        } catch {
            throw RecorderError.unableToCreateAudioRecorder
        }
        
        recorder?.delegate = self
        recorder?.isMeteringEnabled = true
        recorder?.prepareToRecord()
    }
    
    public func updateOrientation(
        withDataSourceOrientation orientation: AVAudioSession.Orientation = .front,
        interfaceOrientation: UIInterfaceOrientation
    ) async throws {
        guard state != .recording else { return }
        let session = AVAudioSession.sharedInstance()
        guard let preferredInput = session.preferredInput,
              let dataSources = preferredInput.dataSources,
              let newDataSource = dataSources.first(where: { $0.orientation == orientation }),
              let supportedPolarPatterns = newDataSource.supportedPolarPatterns else {
            return
        }
        
        do {
            if #available(iOS 14.0, *) {
                isStereoSupported = supportedPolarPatterns.contains(.stereo)
                if isStereoSupported {
                    try newDataSource.setPreferredPolarPattern(.stereo)
                }
            }
            try preferredInput.setPreferredDataSource(newDataSource)
            if #available(iOS 14.0, *) {
                try session.setPreferredInputOrientation(interfaceOrientation.inputOrientation)
            }
        } catch {
            throw RecorderError.unableToSelectDataSource(name: newDataSource.dataSourceName)
        }
    }
    
    public func record() {
        guard state != .recording && isRecordPremissionGranted else { return }
        try? configurePlayAndRecordAudioSession()
        startRecordingTimer()
        recorder?.record()
        state = .recording
    }
    
    public func record() async {
        guard state != .recording && isRecordPremissionGranted else { return }
        try? configurePlayAndRecordAudioSession()
        if state == .stopped {
            await sendFeedbackNotification()
        }
        
        if timer == nil {
            startRecordingTimer()
        }
        recorder?.record()
        state = .recording
    }
    
    public func pauseRecording() {
        guard state == .recording else { return }
        recorder?.pause()
        state = .paused
    }
    
    public func stopRecording() {
        recorder?.stop()
        state = .stopped
        avgPowers = []
        stopTimer()
    }
    
    public func deleteRecording() {
        stopRecording()
        recorder?.deleteRecording()
        NotificationCenter.default.post(notification: .soundControlKitRequiredToStopAllAudioPlayback)
    }
    
    func audioRecorderDidChangeState(_ state: RecordingState) {}
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder) {}
    
    @objc func updateAveragePower() {
        guard let recorder else { return }
        recorder.updateMeters()
        var avgPower: Float = 0.0
        if isStereoSupported {
            let powerChannel0 = recorder.averagePower(forChannel: 0)
            let powerChannel1 = recorder.averagePower(forChannel: 1)
            avgPower = (powerChannel0 + powerChannel1) / 200.0 + 0.5
        } else {
            let powerChannel0 = recorder.averagePower(forChannel: 0)
            avgPower = (powerChannel0 + 50.0) / 100.0
        }
        let value = round(avgPower * 10) / 10
        avgPowers.append(value)
        recordingPowerSubject.send(avgPowers)
    }
    
    private func startRecordingTimer() {
        timer = Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] timer in
                guard let self, let recorder, self.state == .recording else { return }
                let timeInMinutesAndSeconds = self.formatTime(recorder.currentTime)
                self.recordingCurrentTimeSubject.send(timeInMinutesAndSeconds)
                self.updateAveragePower()
            }
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    func formatTime(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func sendFeedbackNotification() async {
        let generator = await UINotificationFeedbackGenerator()
        await generator.prepare()
        await generator.notificationOccurred(.success)
        try? await Task.sleep(nanoseconds: 100_000_000)
    }
}

extension AudioRecorderManager: AVAudioRecorderDelegate {
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        let destURL = FileManager.default.urlInDocumentsDirectory(named: recordingFileName)
        try? FileManager.default.removeItem(at: destURL)
        try? FileManager.default.moveItem(at: recorder.url, to: destURL)
        recorder.prepareToRecord()
        avgPowers = []
        state = .stopped
        audioRecorderDidFinishRecording(recorder)
    }
}

extension AudioRecorderManager {
    enum RecorderError: Error {
        case unableToCreateAudioRecorder
        case unableToSelectDataSource(name: String)
        case microphonePermissionRequired
    }
    enum RecordingState {
        case stopped
        case paused
        case recording
    }
}

class AudioSessionManager: NSObject {
    public func configurePlayAndRecordAudioSession() throws {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setActive(true)
        } catch {
            throw AudioSessionError.configurationFailed
        }
    }
    
    public func configurePlaybackAudioSession() throws {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            throw AudioSessionError.configurationFailed
        }
    }
    
    public func enableBuiltInMicrophone() throws {
        let audioSession = AVAudioSession.sharedInstance()
        let availableInputs = audioSession.availableInputs
        guard let builtInMicInput = availableInputs?.first(where: { $0.portType == .builtInMic }) else {
            throw AudioSessionError.missingBuiltInMicrophone
        }
        do {
            try audioSession.setPreferredInput(builtInMicInput)
        } catch {
            throw AudioSessionError.unableToSetBuiltInMicrophone
        }
    }
}

extension AudioSessionManager {
    public enum AudioSessionError: Error {
        case configurationFailed
        case missingBuiltInMicrophone
        case unableToSetBuiltInMicrophone
    }
}

struct MicrophoneView_Previews: PreviewProvider {
    static var previews: some View {
        MicrophoneView()
    }
}
