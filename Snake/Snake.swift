//
//  Snake.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

@dynamicCallable
final class Snake {
    private var values: ContiguousArray<Cell>
    
    var head: Cell? {
        values.first
    }
    
    init(capacity: Int) {
        values = []
        values.reserveCapacity(capacity)
    }
    
    func contains(cell: Cell) -> Bool {
        values.contains { $0.row == cell.row && $0.column == cell.column }
    }
    
    func isSelfCollided(at cell: Cell) -> Bool {
        values.contains(where: { $0 == cell })
    }
    
    func isCollided(by head: Cell, at wall: (Int, Int)) -> Bool {
        !(0..<wall.0).contains(head.row) || !(0..<wall.1).contains(head.column)
    }
    
    func grow(by newHead: Cell) {
        values.insert(newHead, at: 0)
    }
    
    func shrink() {
        values.removeLast()
    }
    
    func reset(to center: Cell) {
        values.removeAll(keepingCapacity: true)
        values.append(center)
    }
    
    func dynamicallyCall(withArguments args: [Cell]) -> Bool  {
        guard let cell = args.first else {
            return false
        }
        return contains(cell: cell)
    }
}
