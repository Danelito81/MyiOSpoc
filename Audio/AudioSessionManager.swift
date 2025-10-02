import AVFoundation
final class AudioSessionManager {
    func configureForMonitoring() throws {
        let s = AVAudioSession.sharedInstance()
        try s.setCategory(.playAndRecord, mode: .voiceChat, options: [.defaultToSpeaker, .allowBluetoothA2DP, .mixWithOthers])
        try s.setActive(true, options: .notifyOthersOnDeactivation)
    }
}
