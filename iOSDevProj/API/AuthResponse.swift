//
//  AuthResponse.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 4/26/23.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}

