import AVFoundation
final class AudioCapture {
    private let engine = AVAudioEngine()
    private var input: AVAudioInputNode { engine.inputNode }
    private let inputBus: AVAudioNodeBus = 0
    private let targetSampleRate: Double = 16000.0
    private var converter: AVAudioConverter!
    var onChunk: (([Float]) -> Void)?
    func start() throws {
        let inFormat = input.inputFormat(forBus: inputBus)
        let outFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: targetSampleRate, channels: 1, interleaved: false)!
        converter = AVAudioConverter(from: inFormat, to: outFormat)
        let frameCount: AVAudioFrameCount = 2048
        var pcmBuffer = [Float]()
        input.installTap(onBus: inputBus, bufferSize: frameCount, format: inFormat) { (buffer, _) in
            let outBuffer = AVAudioPCMBuffer(pcmFormat: outFormat, frameCapacity: AVAudioFrameCount(outFormat.sampleRate * 2))!
            let inputBlock: AVAudioConverterInputBlock = { _, outStatus in
                outStatus.pointee = .haveData; return buffer
            }
            _ = self.converter.convert(to: outBuffer, error: nil, withInputFrom: inputBlock)
            guard let ptr = outBuffer.floatChannelData?.pointee else { return }
            let count = Int(outBuffer.frameLength)
            pcmBuffer.append(contentsOf: UnsafeBufferPointer(start: ptr, count: count))
            let minSamples = Int(self.targetSampleRate * 1.0)
            if pcmBuffer.count >= minSamples {
                let chunk = Array(pcmBuffer.prefix(minSamples))
                pcmBuffer.removeFirst(minSamples)
                self.onChunk?(chunk)
            }
        }
        try engine.start()
    }
    func stop() { input.removeTap(onBus: inputBus); engine.stop() }
}
