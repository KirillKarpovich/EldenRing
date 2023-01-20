//
//  Boss.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 20.01.23.
//

import Foundation

struct Boss: Decodable, Equatable {
    
    let name: String
    let image: String?
    let description: String
    let location: String

}
