//
//  Score.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

struct Score {
    let value: Int
    
    consuming func increase() -> Score {
        Score(value: value + 10)
    }
    
    consuming func reset() -> Score{
        Score(value: 0)
    }
}
