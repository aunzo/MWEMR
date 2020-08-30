import Foundation
/**
 Release your beta builds with Firebase App Distribution

 - parameters:
   - ipaPath: Path to your IPA file. Optional if you use the _gym_ or _xcodebuild_ action
   - apkPath: Path to your APK file
   - app: Your app's Firebase App ID. You can find the App ID in the Firebase console, on the General Settings page
   - firebaseCliPath: The absolute path of the firebase cli command
   - groups: The groups used for distribution, separated by commas
   - groupsFile: The groups used for distribution, separated by commas
   - testers: Pass email addresses of testers, separated by commas
   - testersFile: Pass email addresses of testers, separated by commas
   - releaseNotes: Release notes for this build
   - releaseNotesFile: Release notes file for this build
   - firebaseCliToken: Auth token for firebase cli
   - debug: Print verbose debug output

 Release your beta builds with Firebase App Distribution
*/
func firebaseAppDistribution(ipaPath: String = "MW EMR.ipa",
                             apkPath: String? = nil,
                             app: String,
                             firebaseCliPath: String = "/usr/local/bin/firebase",
                             groups: String? = nil,
                             groupsFile: String? = nil,
                             testers: String? = nil,
                             testersFile: String? = nil,
                             releaseNotes: String? = nil,
                             releaseNotesFile: String? = nil,
                             firebaseCliToken: String? = nil,
                             debug: Bool = false) {
  let command = RubyCommand(commandID: "", methodName: "firebase_app_distribution", className: nil, args: [RubyCommand.Argument(name: "ipa_path", value: ipaPath),
                                                                                                           RubyCommand.Argument(name: "apk_path", value: apkPath),
                                                                                                           RubyCommand.Argument(name: "app", value: app),
                                                                                                           RubyCommand.Argument(name: "firebase_cli_path", value: firebaseCliPath),
                                                                                                           RubyCommand.Argument(name: "groups", value: groups),
                                                                                                           RubyCommand.Argument(name: "groups_file", value: groupsFile),
                                                                                                           RubyCommand.Argument(name: "testers", value: testers),
                                                                                                           RubyCommand.Argument(name: "testers_file", value: testersFile),
                                                                                                           RubyCommand.Argument(name: "release_notes", value: releaseNotes),
                                                                                                           RubyCommand.Argument(name: "release_notes_file", value: releaseNotesFile),
                                                                                                           RubyCommand.Argument(name: "firebase_cli_token", value: firebaseCliToken),
                                                                                                           RubyCommand.Argument(name: "debug", value: debug)])
  _ = runner.executeCommand(command)
}
