//
//  ContentView.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var game = Game(rows: 18, columns: 18)
    private let start = Date()
    private let spacing: CGFloat = 4
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            TimelineView(.animation(minimumInterval: 0.4, paused: game.isGameOver)) { context in
                let time = context.date.timeIntervalSince1970 - start.timeIntervalSince1970
                
                VStack(spacing: spacing) {
                    Components.ScoreLabel(score: game.score.value)
                    ForEach(0..<game.rows, id: \.self) { row in
                        HStack(spacing: spacing) {
                            ForEach(0..<game.columns, id: \.self) { column in
                                Components.CellView(
                                    block: blockFactory(from: Cell(row, column))
                                )
                            }
                        }
                    }
                    .matrix(time: time)
                }
                .onChange(of: time) { game.update() }
            }
            .padding()
        }
        .padding(24)
        .overlay(gameOver)
        .background(.black)
        .onAppear(perform: game.reset)
        .gesture(direction)
        .statusBarHidden()
    }
    
    private var direction: some Gesture {
        DragGesture()
            .onEnded { game.redirect(translating: $0.translation) }
    }
    
    @ViewBuilder
    private var gameOver: some View {
        if game.isGameOver {
            RoundedRectangle(cornerRadius: 16)
                .fill(.black.opacity(0.7))
            
            VStack {
                Components.GameOverLabel()
                    .matrix(time: 0)
                Components.GameOverButton(reset: game.reset)
                    .matrix(time: 0)
            }
            .monospaced()
            .bold()
        }
    }
    
    private func blockFactory(from cell: Cell) -> (Color, Bool) {
        if game.snake(cell) {
            (.white, false)
        } else if game.food(cell) {
            (.blue, true)
        } else {
            (.black, false)
        }
    }
}

#Preview {
    ContentView()
}
