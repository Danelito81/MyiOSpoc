import Foundation

/// Minimal stub för att ersätta whisper.cpp-anropen så att projektet bygger.
/// Matchar de API-signaturer som används i MonitorView.swift.
final class WhisperEngine {

    // Behåll en referens om du vill använda den senare
    private let modelURL: URL?

    /// Init som MonitorView anropar: `WhisperEngine(modelURL: URL)`
    convenience init?(modelURL: URL) {
        self.init(url: modelURL)
    }

    /// Bakom kulisserna – valfri init som accepterar URL (stubbar alltid in)
    private init?(url: URL?) {
        self.modelURL = url
        // I en riktig implementation skulle vi ladda modellen här.
        // Stubben lyckas alltid, så vi returnerar en instans.
    }

    /// Kompatibilitet om någon annan del råkar kalla `init?(path: String)`
    convenience init?(path: String) {
        self.init(url: URL(fileURLWithPath: path))
    }

    deinit {
        // Ingen nativ resurs i stubben.
    }

    /// MonitorView förväntar sig denna metod.
    /// Returnera nil i PoC-stubben. Downstream-kod bör tåla nil (ingen text).
    func transcribeChunk(pcm: [Float]) -> String? {
        return nil
    }

    /// Finns med om annan kod använder detta namn.
    func transcribe(pcm: [Float]) -> String? {
        return nil
    }
}
