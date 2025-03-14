import SwiftUI

struct MenuBarView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Text("Thank your for using Appearance Watcher 🙂").padding()
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .padding()
        }
        .frame(width: 200)
    }
}
