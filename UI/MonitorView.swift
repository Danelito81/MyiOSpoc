import SwiftUI

struct MonitorView: View {
    @State private var isRunning = false
    @State private var risk: Double = 0
    @State private var transcriptPreview: String = ""

    private let audio = AudioCapture()
    private let speech: WhisperEngine
    private let detector = RiskDetector()

    init?(modelURL: URL) {
        guard let eng = WhisperEngine(modelURL: modelURL) else { return nil }
        self.speech = eng
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Skyddsläge")
                .font(.title.bold())

            Circle()
                .fill(risk >= 0.85 ? Color.red : (risk >= 0.65 ? Color.orange : Color.green))
                .frame(width: 120, height: 120)
                .overlay(Text(riskLabel).foregroundColor(.white).bold())

            Text(transcriptPreview)
                .font(.callout)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

            Button(isRunning ? "Stoppa skydd" : "Starta skydd") {
                isRunning ? stop() : start()
            }
            .buttonStyle(.borderedProminent)
            .font(.title3)
        }
        .padding()
        .background(risk >= 0.85 ? Color.red.opacity(0.15) : Color.clear)
        .onChange(of: risk) { newRisk in
            if newRisk >= 0.85 {
                Haptics.warnStrong()
                Voice.warn()
            } else if newRisk >= 0.65 {
                Haptics.warnSoft()
            }
        }
    }

    private var riskLabel: String {
        risk >= 0.85 ? "HÖG" : (risk >= 0.65 ? "MED" : "LÅG")
    }

    private func start() {
        do {
            try AudioSessionManager().configureForMonitoring()
            audio.onChunk = { pcm in
                if let text = speech.transcribeChunk(pcm: pcm), !text.isEmpty {
                    transcriptPreview = String((transcriptPreview + " " + text).suffix(160))
                    let res = detector.append(text)
                    DispatchQueue.main.async {
                        risk = res.risk
                    }
                }
            }
            try audio.start()
            isRunning = true
        } catch {
            print("Start error: \(error)")
        }
    }

    private func stop() {
        audio.stop()
        detector.reset()
        risk = 0
        isRunning = false
    }
}
