//
//  NetWorkManager.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 02/08/2018.
//  Copyright © 2018 Rafael Zilião. All rights reserved.
//

import Foundation
import Moya

public final class NetworkManager {
    static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    static let shared = NetworkManager()
    static let provider = MoyaProvider<MovieApi>()
    
    fileprivate init () {
        
    }
    
}
