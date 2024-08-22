//
//  Game.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

import SwiftUI

final class Game: ObservableObject {
    @Published private(set) var rows: Int
    @Published private(set) var columns: Int
    @Published private(set) var isGameOver = false

    private(set) var food = Food(placemark: nil)
    private(set) var score = Score(value: 0)
    private var direction: Direction = .up

    private let center: Cell
    let snake: Snake
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        center = Cell(rows >> 1, columns >> 1)
        snake = Snake(capacity: (rows * columns) >> 1)
    }
    
    func update() {
        guard let head = snake.head, !isGameOver else { return }
        let newHead = head + direction.delta
        if snake.isCollided(by: newHead, at: (rows, columns)) || snake.isSelfCollided(at: newHead) {
            gameOver()
            return
        }
        snake.grow(by: newHead)
        food.hitTest(at: head) ? respawnFood() : snake.shrink()
        objectWillChange.send()
    }
    
    func reset() {
        isGameOver = false
        score = score.reset()
        direction = Direction.allCases.randomElement() ?? .up
        snake.reset(to: center)
        respawnFood()
    }

    func redirect(translating translation: CGSize) {
        direction.change(translating: translation)
    }
    
    private func feed() {
        food = food.reset()
        respawnFood()
        score = score.increase()
    }
    
    private func gameOver() {
        snake.reset(to: center)
        isGameOver = true
    }
    
    private func respawnFood() {
        food = food.spawn(inside: (rows, columns), while: snake.contains(cell:))
    }
}
