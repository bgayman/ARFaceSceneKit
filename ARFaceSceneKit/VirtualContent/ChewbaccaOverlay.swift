//
//  ChewbaccaOverlay.swift
//  ARFaceSceneKit
//
//  Created by B Gay on 4/22/18.
//  Copyright © 2018 B Gay. All rights reserved.
//

import SceneKit
import ARKit

final class ChewbaccaOverlay: SCNReferenceNode, VirtualFaceContent {
    
    private lazy var jawNode = childNode(withName: "Jaw", recursively: true)!
    private var audio = [SCNAudioSource]()
    private var isPlaying = false
    private var isExpanded = false
    
    init() {
        guard let url = Bundle.main.url(forResource: "chewbaccaFinal", withExtension: "scn", subdirectory: "Models.scnassets")
            else { fatalError("missing expected bundle resource") }
        super.init(url: url)!
        self.load()
        audio = [SCNAudioSource(fileNamed: "Baahh.m4a")!, SCNAudioSource(fileNamed: "Rawww.m4a")!, SCNAudioSource(fileNamed: "Wahh.m4a")!]
        audio.forEach {
            $0.loops = false
            $0.load()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) has not been implemented")
    }
    
    /// - Tag: BlendShapeAnimation
    var blendShapes: [ARFaceAnchor.BlendShapeLocation: Any] = [:] {
        didSet {
            guard let jawOpen = blendShapes[.jawOpen] as? Float else { return }
            jawNode.eulerAngles.x = Float.pi * 0.25 * jawOpen
            if jawOpen > 0.25 {
                if !isExpanded {
                    playAudio()
                }
                isExpanded = true
            } else {
                isExpanded = false
            }
        }
    }
    
    /// - Tag: ARFaceGeometryBlendShapes
    func update(withFaceAnchor faceAnchor: ARFaceAnchor) {
        blendShapes = faceAnchor.blendShapes
    }
    
    private func playAudio() {
        guard isPlaying == false else { return }
        removeAllAudioPlayers()
        let rand = Int(arc4random_uniform(3))
        let audioPlayer = SCNAudioPlayer(source: audio[rand])
        audioPlayer.didFinishPlayback = { [weak self] in
            self?.isPlaying = false
        }
        isPlaying = true
        addAudioPlayer(audioPlayer)
        
    }
}
