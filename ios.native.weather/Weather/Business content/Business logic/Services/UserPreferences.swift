//
//  UserPreferences.swift
//  Weather
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7531 PerseusRealDeal.
//
//  See LICENSE for details. All rights reserved.
//

import Foundation

class UserPreferences {
    static func registerSettingsBundle(with attributes: [String: String]) {
        let bundle_name                    = attributes["Name"]
        let bundle_extension               = attributes["Extension"]
        let bundle_RootPlist               = attributes["RootPlist"]!
        let bundle_PreferencesItems        = attributes["PreferencesItems"]!
        let bundle_PreferenceKey           = attributes["PreferenceKey"]!
        let bundle_PreferenceDefaultValue  = attributes["PreferenceDefaultValue"]!

        guard let settingsBundleURL = Bundle.main.url(forResource: bundle_name,
                                                    withExtension: bundle_extension)
        else { return }

        guard let settingsData = try? Data(contentsOf:
                                    settingsBundleURL.appendingPathComponent(bundle_RootPlist))
        else { return }

        guard let settingsPlist = try? PropertyListSerialization.propertyList(
                from: settingsData,
                options: [],
                format: nil) as? [String: Any],
            let settingsPreferences = settingsPlist?[bundle_PreferencesItems] as? [[String: Any]]
        else { return }

        var defaultsToRegister = [String: Any]()

        settingsPreferences.forEach { preference in

            if let key = preference[bundle_PreferenceKey] as? String {
                defaultsToRegister[key] = preference[bundle_PreferenceDefaultValue]
            }
        }

        Settings.userDefaults.register(defaults: defaultsToRegister)

    }

    static func setVersionAndBuildNumberUp() {
        if let version = Bundle.main.object(forInfoDictionaryKey:
                                            "CFBundleShortVersionString") as? String {
            Settings.userDefaults.setValue(version, forKey: "version_preference")
        }

        if let build = Bundle.main.object(forInfoDictionaryKey:
                                            "CFBundleVersion") as? String {
            Settings.userDefaults.setValue(build, forKey: "build_preference")
        }
    }
}
