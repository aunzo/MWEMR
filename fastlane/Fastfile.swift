// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
    func firebaseLane()
    {
        desc("Submit a new Beta Build to Firebase Distribute")
        
        incrementBuildNumber()
        
        buildApp(
            workspace: .userDefined(MWEMRWorkspace),
            scheme: "MW EMR",
            exportMethod: .userDefined(ExportMethod.adHoc.rawValue))
        
//        buildApp(
//            workspace: .userDefined(MWEMRWorkspace),
//            scheme: "MW EMR")
        
        firebaseAppDistribution(
            ipaPath: "./MW EMR.ipa",
            app: "1:65784865760:ios:e037a5b0ab0565818c0185",
            testers: "chaiwat.inp@dev-t.net, it@aircharterthailand.com, june.dissaya@gmail.com, siamlandit@gmail.com, sunisa@aircharterthailand.com",
            releaseNotes: "MWEMR application")
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
    
    let AppIdentifier = "com.devt.MW-EMR"
    let MWEMRWorkspace = "MWEMR.xcworkspace"
    
    enum ExportMethod: String
    {
        case appStore = "app-store"
        case adHoc =  "ad-hoc"
    }
}
