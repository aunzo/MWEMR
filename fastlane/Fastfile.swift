// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
	func releaseLane() {
	desc("Push a new release build to the App Store")
		buildApp(workspace: "MWEMR.xcworkspace", scheme: "MW EMR")
		uploadToAppStore(username: "chaiwat.inplab@gmail.com", app: "com.devt.MW-EMR")
	}
}
