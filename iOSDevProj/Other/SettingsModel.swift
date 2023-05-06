//
//  SettingsModel.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/2/23.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
