//
//  Components.swift
//  Snake
//
//  Created by Astemir Eleev on 21/8/24.
//

import SwiftUI

enum Components {
    struct CellView: View {
        let block: (color: Color, animating: Bool)
        var body: some View {
            Rectangle()
                .foregroundColor(block.color)
                .phaseAnimator([1, 1.27, 0.95]) { view, phase in
                    view
                        .scaleEffect(block.animating ? phase : 1)
                        .opacity(block.animating ? (phase == 1 ? 0.7 : 1) : 1)
                }
                .border(.white, width: 0.5)
                .aspectRatio(1, contentMode: .fit)
        }
    }

    struct ScoreLabel: View {
        let score: Int
        var body: some View {
            Text("Score: \(score)")
                .padding(.bottom, 24)
                .font(.headline)
                .fontDesign(.monospaced)
                .foregroundColor(.white)
                .matrix(time: 0)
        }
    }
    
    struct GameOverLabel: View {
        var body: some View {
            Text("Game Over!")
                .padding()
                .font(.largeTitle)
                .shadow(radius: 4)
                .foregroundColor(.white)
                .transition(.opacity.combined(with: .scale))
        }
    }

    struct GameOverButton: View {
        let reset: () -> ()
        var body: some View {
            Button(action: reset) {
                Text("Restart")
            }
            .buttonStyle(.borderedProminent)
            .backgroundStyle(.black)
        }
    }
}
