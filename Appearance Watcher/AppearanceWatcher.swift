import AppKit
import Combine

class AppearanceWatcher: ObservableObject {
    private var appearanceObservation: AnyCancellable?
    private var changeHandler = AppearanceChangeHandler()
    private var currentAppearance: AppearanceTypes?

    init() {
        observeAppearance()
    }

    deinit {
        appearanceObservation?.cancel()
    }
    
    private func observeAppearance() {
        appearanceObservation = NSApp.publisher(for: \.effectiveAppearance)
            .sink { newAppearance in
                self.handleAppearanceChange(newAppearance)
                
            }
    }
    
    private func handleAppearanceChange(_ appearance: NSAppearance) {
        let nextAppearance = getAppearanceType(appearance: appearance.name)
        if (nextAppearance != self.currentAppearance) {
            print("Appearance is changing to: \(nextAppearance)")
            self.currentAppearance = nextAppearance
            self.changeHandler.handleAppearanceChange(appearance: nextAppearance)
        }
    }
    
    private func getAppearanceType(appearance: NSAppearance.Name) -> AppearanceTypes {
        switch appearance {
        case .darkAqua, .accessibilityHighContrastDarkAqua, .accessibilityHighContrastVibrantDark, .vibrantDark:
            return AppearanceTypes.dark
        case .aqua, .accessibilityHighContrastAqua, .accessibilityHighContrastVibrantLight, .vibrantLight:
            return AppearanceTypes.light
        default:
            return AppearanceTypes.unknown
        }
    }
}

class AppearanceChangeHandler {
    private let fileManager = FileManager.default
    
    private var appearanceChangeScriptPath: URL {
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDir.appendingPathComponent("Appearance Watcher").appendingPathComponent("handle_appearance_change.sh")
    }
    
    func getOnAppearanceChangeScriptURL() -> URL? {
        let defaultURL = appearanceChangeScriptPath
        if fileManager.fileExists(atPath: defaultURL.path) {
            return defaultURL
        } else {
            print("Default script path is invalid or file does not exist.")
            return nil
        }
    }
    
    func handleAppearanceChange(appearance: AppearanceTypes) {
        guard let scriptURL = getOnAppearanceChangeScriptURL() else {
            print("No script found.")
            return
        }
 
        do {
            let process = Process()
            process.executableURL = URL(fileURLWithPath: "/bin/zsh")
            process.arguments = ["-c", "\"\(scriptURL.path)\" \(appearance.rawValue)"]
            try process.run()
            process.waitUntilExit()
        } catch {
            print("Failed to execute: \(error)")
        }
    }
}
