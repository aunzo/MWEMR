public class Matchfile: MatchfileProtocol {
    public var gitUrl: String { return "git@github.com:blackraito/MWEMRCert.git" }
    public var type: String { return "development" } // The default type, can be: appstore, adhoc, enterprise or development
    public var appIdentifier: [String] { return ["com.devt.MW-EMR"] }
    
    public var username: String { return "chaiwat.inplab@gmail.com" } // Your Apple Developer Portal username
}
