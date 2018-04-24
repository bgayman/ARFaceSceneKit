//
//  VirtualContentType.swift
//  ARFaceSceneKit
//
//  Created by B Gay on 4/22/18.
//  Copyright © 2018 B Gay. All rights reserved.
//

import Foundation

enum VirtualContentType: Int {
    case none
    case faceGeometry
    case glasses
    case nietzsche
    case chewbacca
    
    static let orderedValues: [VirtualContentType] = [.none, .faceGeometry
        , .glasses, .nietzsche, .chewbacca]
    
    var imageName: String {
        switch self {
        case .none:
            return "none"
        case .faceGeometry:
            return "faceGeometry"
        case .glasses:
            return "glasses"
        case .nietzsche:
            return "nietzsche"
        case .chewbacca:
            return "chewbacca"
        }
    }
}
