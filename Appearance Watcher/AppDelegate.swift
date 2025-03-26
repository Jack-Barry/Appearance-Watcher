import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    let appearanceWatcher = AppearanceWatcher()
    var statusItem: NSStatusItem!
    var popover: NSPopover!

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupMenuBar()
    }

    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.image = NSImage(systemSymbolName: "eyeglasses", accessibilityDescription: "Appearance Watcher")
        statusItem.button?.action = #selector(togglePopover(_:))

        popover = NSPopover()
        popover.contentViewController = NSHostingController(rootView: MenuBarView(appearanceWatcher: appearanceWatcher))
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}
