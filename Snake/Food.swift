//
//  Food.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

@dynamicCallable
struct Food {
    let placemark: Cell?
    
    consuming func reset() -> Food {
        Food(placemark: nil)
    }
    
    consuming func spawn(inside boundary: (rows: Int, columns: Int), while predicate: (Cell) -> Bool) -> Food {
        var position: Cell
        repeat {
            position = Cell(
                Int.random(in: 0..<boundary.rows),
                Int.random(in: 0..<boundary.columns)
            )
        } while predicate(position)
        return Food(placemark: position)
    }
    
    func hitTest(at cell: Cell) -> Bool {
        if let food = placemark, food.row == cell.row && food.column == cell.column {
            true
        } else {
            false
        }
    }
    
    func dynamicallyCall(withArguments args: [Cell]) -> Bool  {
        guard let cell = args.first else {
            return false
        }
        return hitTest(at: cell)
    }
}
