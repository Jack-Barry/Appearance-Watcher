import SwiftUI

@main
struct Appearance_WatcherApp: App {
    @StateObject private var appearanceObserver = AppearanceWatcher()
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
