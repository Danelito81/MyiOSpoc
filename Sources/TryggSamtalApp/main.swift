import SwiftUI

@main
struct TryggSamtalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("TryggSamtal uploaded to TestFlight! SUCCESS!")
            .font(.largeTitle)
            .padding()
    }
}
