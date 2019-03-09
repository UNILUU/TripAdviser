//
//  City.swift
//  TripAdvisor
//
//  Created by Xiaolu on 3/8/19.
//

import Foundation

struct City {
    var name: String?
    var contury : String?
    var description : String?
    var imageURL : String?
    
    init(_ value : [String]){
        for (index, value) in value.enumerated(){
            switch index {
            case 0:
                name = value
            case 1:
                contury = value
            case 2:
                imageURL = value
            case 3 :
                description = value
            default:
                return
            }
        }
    }
}
