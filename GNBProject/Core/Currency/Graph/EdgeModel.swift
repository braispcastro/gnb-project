//
//  EdgeModel.swift
//  GNBProject
//
//  Created by Brais Castro on 8/5/22.
//

import Foundation

public enum EdgeType {
    case directed
    case undirected
}

public struct Edge<T: Hashable> {
    public var source: Vertex<T>
    public var destination: Vertex<T>
    public let weight: Double?
}

extension Edge: Hashable {
  
    public var hashValue: Int {
        return "\(source)\(destination)\(weight)".hashValue
    }
  
    static public func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.source == rhs.source && lhs.destination == rhs.destination && lhs.weight == rhs.weight
    }
}
