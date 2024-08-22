//
//  Cell.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

struct Cell {
    let row, column: Int
}

extension Cell {
    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }
}

extension Cell: Equatable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.row == rhs.row && lhs.column == rhs.column
    }
}

extension Cell {
    static func + (lhs: consuming Cell, rhs: consuming Cell) -> Cell {
        Cell(lhs.row + rhs.row, lhs.column + rhs.column)
    }
}
