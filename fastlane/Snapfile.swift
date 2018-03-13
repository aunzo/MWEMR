// Uncomment the lines below you want to change by removing the // in the beginning

class Snapshotfile: SnapshotfileProtocol {
    // A list of devices you want to take the screenshots from
    var devices: [String] { return [
        "iPad Pro (10.5-inch)",
        ]
    }

    // locales not supported in Swift yet
    var languages: [String] { return [
        "en-US",
        ]
    }

    // The name of the scheme which contains the UI Tests
     var scheme: String? { return "MWEMRUITest" }

    // Where should the resulting screenshots be stored?
     var outputDirectory: String { return "./fastlane/screenshots" }

    // Clear all previously generated screenshots before creating new ones
    // var clearPreviousScreenshots: Bool { return true }

    // Choose which project/workspace to use
    // var project: String? { return "./Project.xcodeproj" }
     var workspace: String? { return "./MWEMR.xcworkspace" }
}
