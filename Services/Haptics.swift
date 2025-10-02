import UIKit
import AVFoundation
enum Haptics {
    static func warnSoft() { UIImpactFeedbackGenerator(style: .medium).impactOccurred() }
    static func warnStrong() { UINotificationFeedbackGenerator().notificationOccurred(.error) }
}
enum Voice {
    static func warn() {
        let utt = AVSpeechUtterance(string: "Varning. Detta samtal kan vara ett bedrägeri. Lägg på.")
        utt.voice = AVSpeechSynthesisVoice(language: "sv-SE")
        AVSpeechSynthesizer().speak(utt)
    }
}
