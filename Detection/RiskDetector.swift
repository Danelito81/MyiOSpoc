import Foundation
final class RiskDetector {
    private var buffer = ""
    private var lastRisk: Double = 0
    func append(_ text: String) -> (risk: Double, flags: [String]) {
        guard !text.isEmpty else { return (lastRisk, []) }
        buffer.append(" " + text.lowercased())
        if buffer.count > 3000 { buffer.removeFirst(buffer.count - 3000) }
        var flags: [String] = []; var risk = 0.0
        if Keywords.critical.contains(where: { buffer.suffix(600).contains($0) }) {
            risk = max(risk, 0.9); flags.append("critical")
        }
        let pressureHits = Keywords.pressure.filter { buffer.suffix(1200).contains($0) }.count
        if pressureHits >= 2 { risk = max(risk, 0.7); flags.append("pressure") }
        if Keywords.regexAccount.firstMatch(in: String(buffer.suffix(1000)), options: [], range: NSRange(location: 0, length: min(1000, buffer.count))) != nil {
            risk = max(risk, 0.7); flags.append("account_pattern")
        }
        let final = max(risk, lastRisk * 0.8); lastRisk = final
        return (final, flags)
    }
    func reset() { buffer.removeAll(); lastRisk = 0 }
}
