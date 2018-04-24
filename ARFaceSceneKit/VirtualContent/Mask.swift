//
//  Mask.swift
//  ARFaceSceneKit
//
//  Created by B Gay on 4/22/18.
//  Copyright © 2018 B Gay. All rights reserved.
//

import ARKit
import SceneKit

final class Mask: SCNNode, VirtualFaceContent {
    
    init(geometry: ARSCNFaceGeometry) {
        let material = geometry.firstMaterial!
        
        material.diffuse.contents = UIColor.lightGray
        material.lightingModel = .physicallyBased
        
        super.init()
        self.geometry = geometry
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    // MARK: VirtualFaceContent
    
    /// - Tag: SCNFaceGeometryUpdate
    func update(withFaceAnchor anchor: ARFaceAnchor) {
        let faceGeometry = geometry as! ARSCNFaceGeometry
        faceGeometry.update(from: anchor.geometry)
    }
}
