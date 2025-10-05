import Foundation

/// Minimal stub för att ersätta whisper.cpp-anropen så att projektet bygger.
/// Byt senare mot en riktig implementation (t.ex. Apple Speech eller whisper.cpp via SPM).
final class WhisperEngine {

    /// Behåller signaturen `init?(path:)` om den anropas någonstans.
    init?(path: String) {
        // Ingen modell krävs i stubben – alltid returnera en instans.
    }

    deinit {
        // Ingen native-resurs att frigöra i stubben.
    }

    /// Behåller signaturen `transcribe(pcm:)` om den används i pipeline.
    /// Returnerar nil (ingen transkription) – downstream-kod ska tåla detta i PoC.
    func transcribe(pcm: [Float]) -> String? {
        return nil
    }
}
