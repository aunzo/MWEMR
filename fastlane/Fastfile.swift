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
    var fastlaneVersion: String { return "2.80.0" }
    
//    func beforeAll()
//    {
//        snapshot()
//    }
    
    func takeScreenLane()
    {
        snapshot(
            devices: ["iPad Pro (10.5-inch)"],
            languages: ["en-US"],
            outputDirectory: "./fastlane/screenshots",
            appIdentifier: AppIdentifier,
            scheme: "MWEMRUITest")
    }
    
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
    
    func fabricLane()
    {
        desc("Submit a new Beta Build to Frbric. This will also make sure the profile is up to date")
        incrementBuildNumber()
        
        let exportOptions: [String: Any] = [ "provisioningProfiles": [ AppIdentifier: "match AppStore com.devt.MW-EMR" ] ]
        
        gym(
            workspace: MWEMRWorkspace,
            scheme: "MW EMR",
            clean: true,
            configuration: "Release",
            exportMethod: ExportMethod.adHoc.rawValue,
            exportOptions: exportOptions,
            exportXcargs: "-allowProvisioningUpdates",
            xcargs: "-allowProvisioningUpdates")
        crashlytics(
            apiToken: "cf7357b13e13fc8ea0f1347cfce7eef3723dcdb6",
            buildSecret: "304daa17d7b6c21f4361a772edb368650821292cce4f86d687a69bf807ebb108",
            notes: "build for enterprise use",
            emails: "angkan@aircharterthailand.com,Chaiwat.inp@dev-t.net")
    }
    
    func releaseLane()
    {
        desc("Deploy a new version to the App Store")
        
        incrementBuildNumber()
        
        gym(
            workspace: MWEMRWorkspace,
            scheme: "MW EMR",
            configuration: "Release",
            exportMethod: ExportMethod.appStore.rawValue)
        
        deliver()
    }
}

let AppIdentifier = "com.devt.MW-EMR"
let MWEMRWorkspace = "MWEMR.xcworkspace"

enum ExportMethod: String
{
    case appStore = "app-store"
    case adHoc =  "ad-hoc"
}
