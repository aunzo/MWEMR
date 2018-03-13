class Deliverfile: DeliverfileProtocol
{
    var appIdentifier: String { return "com.devt.MW-EMR" }
    var username: String { return "chaiwat.inplab@gmail.com" }
    var screenshotsPath: String? { return "./fastlane/screenshots" }
    var metadataPath: String? { return "./fastlane/metadata" }
    var submitForReview: Bool { return true }
    var force: Bool { return true }
    var automaticRelease: Bool { return true }
    var languages: [String]? { return [ "en-US"] }
    var teamName: String? { return "Chaiwat Inplab" }
}
