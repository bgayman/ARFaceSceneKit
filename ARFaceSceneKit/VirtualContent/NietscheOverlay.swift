//
//  NietscheOverlay.swift
//  ARFaceSceneKit
//
//  Created by B Gay on 4/22/18.
//  Copyright © 2018 B Gay. All rights reserved.
//

import ARKit
import SceneKit

final class NietscheOverlay: SCNNode, VirtualFaceContent {
    
    var initialBrowPosition = SCNVector3(0, 0, 0)
    var initialNostrelPosition = SCNVector3(0, 0, 0)
    var initialMustachePosition = SCNVector3(0, 0, 0)
    
    private lazy var mask = childNode(withName: "Mask", recursively: true)!
    private lazy var eyeRightNode = self.mask.childNode(withName: "EyeLeft", recursively: true)!
    private lazy var eyeLeftNode = self.mask.childNode(withName: "EyeRight", recursively: true)!
    private lazy var noseNode = self.mask.childNode(withName: "Nose", recursively: true)!
    private lazy var nostrelRightNode = self.mask.childNode(withName: "NostrelLeft", recursively: true)!
    private lazy var nostrelLeftNode = self.mask.childNode(withName: "NostrelRight", recursively: true)!
    private lazy var eyebrowRightNode = self.mask.childNode(withName: "EyebrowLeft", recursively: true)!
    private lazy var eyebrowLeftNode = self.mask.childNode(withName: "EyebrowRight", recursively: true)!
    private lazy var earLeftNode = self.mask.childNode(withName: "EarRight", recursively: true)!
    private lazy var earRightNode = self.mask.childNode(withName: "EarLeft", recursively: true)!
    private lazy var mustacheLeftNode = self.mask.childNode(withName: "MustacheRight", recursively: true)!
    private lazy var mustacheRightNode = self.mask.childNode(withName: "MustacheLeft", recursively: true)!
    private lazy var headNode = self.mask.childNode(withName: "Head", recursively: true)!
    
    var blendShapes: [ARFaceAnchor.BlendShapeLocation: Any] = [:] {
        didSet {
            guard let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
                let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float,
                let jawOpen = blendShapes[.jawOpen] as? Float,
                let browDownLeft = blendShapes[.browDownLeft] as? Float,
                let browDownRight = blendShapes[.browDownRight] as? Float,
                let cheekPuff = blendShapes[.cheekPuff] as? Float,
                let noseSneerLeft = blendShapes[.noseSneerLeft] as? Float,
                let noseSneerRight = blendShapes[.noseSneerRight] as? Float,
                let browInnerUp = blendShapes[.browInnerUp] as? Float,
                let smileLeft = blendShapes[.mouthSmileLeft] as? Float,
                let smileRight = blendShapes[.mouthSmileRight] as? Float,
                let frownLeft = blendShapes[.mouthFrownLeft] as? Float,
                let frownRight = blendShapes[.mouthFrownRight] as? Float
                else { return }
            eyeLeftNode.scale.z = (1 - eyeBlinkLeft)
            eyeRightNode.scale.z = (1 - eyeBlinkRight)
            headNode.scale.z = 1.0 + (0.25 * jawOpen)
            headNode.scale.x = 1.0 + (0.20 * cheekPuff)
            headNode.scale.y = 1.0 + (0.20 * cheekPuff)
            
            eyebrowLeftNode.position.z = initialBrowPosition.z + 0.15 * browInnerUp
            eyebrowRightNode.position.z = initialBrowPosition.z + 0.15 * browInnerUp
            earLeftNode.position.z = 0.15 * browInnerUp
            earRightNode.position.z = 0.15 * browInnerUp
            eyebrowLeftNode.rotation = SCNVector4(0, 1, 0, Float.pi / 8 * browDownLeft)
            eyebrowLeftNode.rotation = SCNVector4(0, 1, 0, Float.pi / 8 * browDownRight)
            nostrelLeftNode.position.z = initialNostrelPosition.z + 0.1 * noseSneerLeft
            nostrelRightNode.position.z = initialNostrelPosition.z + 0.1 * noseSneerRight
            mustacheLeftNode.rotation = SCNVector4(0, 1, 0, Float.pi / 8 * frownLeft)
            mustacheRightNode.rotation = SCNVector4(0, 1, 0, Float.pi / 8 * frownRight)
            mustacheLeftNode.rotation = SCNVector4(0, 1, 0, Float.pi / 8 * -smileLeft)
            mustacheRightNode.rotation = SCNVector4(0, 1, 0, Float.pi / 8 * -smileRight)
            eyebrowLeftNode.rotation = SCNVector4(0, 1, 0, Float.pi / 8 * browDownRight)
        }
    }
    
    override init() {
        
        super.init()
        let faceOverlayContent = loadedContentForAsset(named: "Nietsche")
        addChildNode(faceOverlayContent)
        initialBrowPosition = eyebrowLeftNode.position
        initialNostrelPosition = nostrelLeftNode.position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    // MARK: VirtualFaceContent
    func update(withFaceAnchor anchor: ARFaceAnchor) {
        blendShapes = anchor.blendShapes
    }
}
