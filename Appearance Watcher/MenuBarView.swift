import SwiftUI

struct MenuBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var appearanceWatcher: AppearanceWatcher
    
    var body: some View {
        VStack {
            Text("Thank your for using Appearance Watcher 🙂").padding()
            Button("Run Script") {
                appearanceWatcher.runAppearanceChangeScript()
            }
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .padding()
        }
        .frame(width: 200)
    }
}
