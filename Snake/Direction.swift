//
//  Direction.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

import struct CoreGraphics.CGSize

enum Direction: CaseIterable {
    case up, down, left, right
    
    var delta: Cell {
        switch self {
        case .up:    Cell(-1,  0)
        case .down:  Cell( 1,  0)
        case .left:  Cell( 0, -1)
        case .right: Cell( 0,  1)
        }
    }
    
    mutating func change(to new: Direction) {
        guard (self == .up    && new != .down ) ||
              (self == .down  && new != .up   ) ||
              (self == .left  && new != .right) ||
              (self == .right && new != .left ) else { return }
        self = new
    }
    
    mutating func change(translating translation: CGSize) {
        self.change(
            to: abs(translation.width) > abs(translation.height) ?
            translation.width  < 0 ? .left : .right :
            translation.height < 0 ? .up   : .down
        )
    }
}
