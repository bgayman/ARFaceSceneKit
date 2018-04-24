//
//  VirtualFaceContent.swift
//  ARFaceSceneKit
//
//  Created by B Gay on 4/22/18.
//  Copyright © 2018 B Gay. All rights reserved.
//

import SceneKit
import ARKit

protocol VirtualFaceContent {
    func update(withFaceAnchor: ARFaceAnchor)
}

typealias VirtualFaceNode = VirtualFaceContent & SCNNode

func loadedContentForAsset(named resourceName: String) -> SCNNode {
    let url = Bundle.main.url(forResource: resourceName, withExtension: "scn", subdirectory: "Models.scnassets")!
    let node = SCNReferenceNode(url: url)!
    node.load()
    return node
}
