//
//  CacheManager.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 15.01.23.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url:String, _ data:Data?) {
        
        // Store the image data and use the url as the key
        cache[url] = data
    }
    
    static func getVideoCache(_ url:String) -> Data? {
        
        // Try to get a data to the specified url
        return cache[url]
        
    }
}
