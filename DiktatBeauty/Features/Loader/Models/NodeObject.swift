//
//  NodeObject.swift
//  DiktatBeauty
//
//  Created by Loris Pinna on 15/05/2019.
//  Copyright © 2019 Loris Pinna. All rights reserved.
//

import Foundation

struct NodeObject: Decodable {
    var name: String
    var title: String
    var text: String
    var layers: [NodeObjectNodes]
}

struct NodeObjectNodes: Decodable {
    var id: String
    var type: String
    var material: String
    var position: [Float]
    var rotation: [Float]
    var size: [Float]
    var opacity: Float
    var animation: String?
    var hidden_default: Bool
    var click_event: [NodeObjectNodesClick]
}

struct NodeObjectNodesClick: Decodable {
    var apply: String
    var on: String
    var duration: Float
    var delay: Float
}
