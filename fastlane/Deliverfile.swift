public class Deliverfile: DeliverfileProtocol
{
    public var appIdentifier: String { return "com.devt.MW-EMR" }
    public var username: String { return "chaiwat.inplab@gmail.com" }
    public var screenshotsPath: String? { return "./fastlane/screenshots" }
    public var metadataPath: String? { return "./fastlane/metadata" }
    public var submitForReview: Bool { return true }
    public var force: Bool { return true }
    public var automaticRelease: Bool { return true }
    public var languages: [String]? { return [ "en-US"] }
    public var teamName: String? { return "Chaiwat Inplab" }
}
