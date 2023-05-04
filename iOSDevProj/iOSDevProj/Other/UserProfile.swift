//
//  UserProfile.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 5/1/23.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [UserImage]
}

struct UserImage: Codable {
    let url: String
}

//{
//    country = US;
//    "display_name" = "Omar Hegazy";
//    email = "omarhegazy78@gmail.com";
//    "explicit_content" =     {
//        "filter_enabled" = 0;
//        "filter_locked" = 0;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/user/12135596551";
//    };
//    followers =     {
//        href = "<null>";
//        total = 20;
//    };
//    href = "https://api.spotify.com/v1/users/12135596551";
//    id = 12135596551;
//    images =     (
//                {
//            height = "<null>";
//            url = "https://scontent-iad3-2.xx.fbcdn.net/v/t1.18169-1/1935814_905259232927582_1248916725354892436_n.jpg?stp=dst-jpg_p320x320&_nc_cat=111&ccb=1-7&_nc_sid=0c64ff&_nc_ohc=Pswx11P8nlIAX-KSLP-&_nc_ht=scontent-iad3-2.xx&edm=AP4hL3IEAAAA&oh=00_AfBUJbacaNV1hWmDbGET6bwfBvhqzprwauk-_Go6SrXzdg&oe=647A1F87";
//            width = "<null>";
//        }
//    );
//    product = premium;
//    type = user;
//    uri = "spotify:user:12135596551";
//}
