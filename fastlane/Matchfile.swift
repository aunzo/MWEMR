class Matchfile: MatchfileProtocol {
    var gitUrl: String { return "git@github.com:blackraito/MWEMRCert.git" }
    var type: String { return "development" } // The default type, can be: appstore, adhoc, enterprise or development
    var appIdentifier: [String] { return ["com.devt.MW-EMR"] }
    
    var username: String { return "chaiwat.inplab@gmail.com" } // Your Apple Developer Portal username
}
