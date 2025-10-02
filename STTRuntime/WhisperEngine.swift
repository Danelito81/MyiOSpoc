import Foundation
final class WhisperEngine {
    private var ctx: UnsafeMutableRawPointer?
    init?(modelURL: URL) {
        let path = (modelURL.path as NSString).utf8String
        guard let ptr = whisper_init_from_file(path) else { return nil }
        self.ctx = ptr
    }
    deinit { if let c = ctx { whisper_free_ctx(c) } }
    func transcribeChunk(pcm: [Float]) -> String {
        guard let c = ctx else { return "" }
        if let s = whisper_process_short(c, pcm, Int32(pcm.count)) {
            return String(cString: s).trimmingCharacters(in: .whitespacesAndNewlines)
        } else { return "" }
    }
}
