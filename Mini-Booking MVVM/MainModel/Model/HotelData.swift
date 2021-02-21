//
//  HotelData.swift
//  Mini-Booking MVVM
//
//  Created by Tatyana Korotkova on 19.02.2021.
//

import Foundation

enum HotelData{
    case initial
    case loading([Hotel])
    case success([Hotel])
    case error([Hotel])
    
    struct Hotel : Decodable{
        let id: Int
        let name: String?
        let address: String?
        let stars: Float?
        let distance: Float?
        let suites_availability: String?
        var stringID: Int?
    }
}
