import SwiftUI
struct HomeView: View {
    @State private var showMonitor = false
    var body: some View {
        VStack(spacing: 20) {
            Text("TryggSamtal").font(.largeTitle.bold())
            Text("1) Sätt samtalet på högtalare\n2) Tryck Starta skydd\n3) Följ varningar")
                .multilineTextAlignment(.center)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            Button("Starta skydd") { showMonitor = true }.buttonStyle(.borderedProminent)
        }
        .padding()
        .sheet(isPresented: $showMonitor) {
            if let url = Bundle.main.url(forResource: "ggml-base", withExtension: "bin", subdirectory: "Models") {
                MonitorView(modelURL: url)!
            } else { MissingModelView() }
        }
    }
}
struct MissingModelView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Saknar modell").font(.title.bold())
            Text("Lägg till Whisper-modellen i Resources/Models/ som ggml-base.bin och markera Target Membership.")
                .multilineTextAlignment(.center)
        }.padding()
    }
}
