// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile
{
    var fastlaneVersion: String { return "2.204.2" }
    
//    func beforeAll()
//    {
//        snapshot()
//    }
    
//    func takeScreenLane()
//    {
//        snapshot(
//            devices: ["iPad Pro (10.5-inch)"],
//            languages: ["en-US"],
//            outputDirectory: "./fastlane/screenshots",
//            appIdentifier: AppIdentifier,
//            scheme: "MWEMRUITest")
//    }
    
    func certsLane()
    {
        desc("Fetch all certificates")
        
        match(
            type: "adhoc",
            forceForNewDevices: true)
        
        match(
            type: "development",
            forceForNewDevices: true)
        
        match(
            type: "appstore")
    }
    
    func firebaseLane()
    {
        desc("Submit a new Beta Build to Firebase Distribute")
        
        incrementBuildNumber()
        
        buildApp(
            workspace: .userDefined(MWEMRWorkspace),
            scheme: "MW EMR",
            exportMethod: .userDefined(ExportMethod.adHoc.rawValue))
        
        firebaseAppDistribution(
            ipaPath: "./MW EMR.ipa",
            app: "1:65784865760:ios:e037a5b0ab0565818c0185",
            testers: "Chaiwat.inp@dev-t.net",
            releaseNotes: "MWEMR application")
    }
    
//    func releaseLane()
//    {
//        desc("Deploy a new version to the App Store")
//
//        incrementBuildNumber()
//
//        gym(
//            workspace: MWEMRWorkspace,
//            scheme: "MW EMR",
//            configuration: "Release",
//            exportMethod: ExportMethod.appStore.rawValue)
//
//        deliver()
//    }
}

let AppIdentifier = "com.devt.MW-EMR"
let MWEMRWorkspace = "MWEMR.xcworkspace"

enum ExportMethod: String
{
    case appStore = "app-store"
    case adHoc =  "ad-hoc"
}
