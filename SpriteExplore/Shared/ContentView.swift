//
//  ContentView.swift
//  Created by jht2 on 2/6/22.

import SwiftUI
import SceneKit
import SpriteKit
import UIKit

let spriteLen = 80.0
let frameSize = CGSize(width: 300, height: 600)
let spriteSize = CGSize(width: frameSize.width/4, height: frameSize.width/4)

struct ContentView: View {
  let scene = Self.buildScene()
  
  var body: some View {
    SpriteView(scene: scene)
      .frame(width: frameSize.width, height: frameSize.height)
      .border(Color.primary)
  }
  
  static func buildScene() -> BouncingSquares {
    let scene = BouncingSquares()
    scene.size = CGSize(width: frameSize.width, height: frameSize.height)
    scene.scaleMode = .fill
    
    scene.populate()
    return scene
  }
}

class BouncingSquares: SKScene {
  //  let colors:[NSColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemPurple, .systemPink]
  //  let colors:[UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemPurple, .systemPink]
  let colors:[UIColor] = [.systemRed, .systemYellow, .systemGreen, .white]
  var moving = false
  
  func populate() {
    let n = 3
    for index in 0..<n {
      let square = SKSpriteNode(color: colors[self.children.count % colors.count], size: spriteSize)
      // let square = SKSpriteNode(imageNamed: "icon-on-gray-1024")

      // square.position = CGPoint(x: .random(in: 0...frameSize.width), y: .random(in: 0...frameSize.height))
      // let x = CGFloat(index) * spriteSize.width + spriteSize.width/2 + spriteSize.width/2
      let x = CGFloat(index+1) * spriteSize.width
      let y = frame.height - spriteSize.width/2
      square.position = CGPoint(x: x, y: y)
      square.physicsBody = SKPhysicsBody(rectangleOf: spriteSize)
      addChild(square)
    }
    
    configureSquares()
  }
  
  func configureSquares() {
    for square in children {
      let w = frameSize.width
      let h = frameSize.height
      square.physicsBody?.velocity = moving ? CGVector(dx: .random(in: -w...w), dy: .random(in: -h...h)) : .zero
      square.physicsBody?.restitution = moving ? 1.0 : 0.0
      square.physicsBody?.linearDamping = moving ? 0.0 : 1.0
      square.physicsBody?.angularDamping = moving ? 0.0 : 1.0
      square.physicsBody?.friction = moving ? 0.0 : 1.0
    }
    
    physicsWorld.gravity = moving ? .zero : CGVector(dx: 0, dy: -9.8)
  }
  
  override func didMove(to view: SKView) {
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    physicsWorld.gravity = .zero
  }
  
  //  override func mouseDown(with event: NSEvent) {
  //    self.moving.toggle()
  //    configureSquares()
  //  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.moving.toggle()
    configureSquares()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

// https://swiftui-lab.com/companion/
// SpriteView
