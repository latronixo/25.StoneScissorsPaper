//
//  ContentView.swift
//  25.StoneScissorsPaper
//
//  Created by Валентин on 21.05.2025.
//

import SwiftUI

struct ContentView: View {
    //варианты жестов
    private var moves = ["🪨", "📜", "✂"]
    //жесты-победители
    private var winningMoves = ["📜", "✂", "🪨"]
    
    //жест приложения
    @State private var appMove = ""
    @State private var score = 0
    @State private var shouldWin = false
    
    var body: some View {
        VStack {
            Text("Ваш ход:")
                .font(.title.bold())
            Spacer()
            HStack{
                ForEach(moves, id: \.self) { move in
                    Button {
                        moveTapped(move)
                    } label: {
                        Text(move)
                            .font(.system(size: 100))
                    }
                }
            }
            Spacer()
        }
        .padding(10)
        .onAppear{
            nextRound()
            shouldWin = Bool.random()
        }
        VStack {
            Text("Ваш счет: \(score)")
            Text("Ход приложения:")
            HStack{
                Text(appMove)
                    .font(.system(size: 100))
            }
            Text("Вам нужно:")

            Spacer()

        }
    }
    private func moveTapped(_ userMove: String) {
        let indexUserMove = moves.firstIndex(of: userMove)
        let indexAppMove = moves.firstIndex(of: appMove)
        if indexUserMove == indexAppMove {
            print("победа")
        } else {
            print("поражение")
        }
        nextRound()
        //print ("индекс выбранного пользователем жеста \(indexUserMove)")
    }
    
    private func nextRound() {
        appMove = moves[Int.random(in: 0...2)]
        shouldWin.toggle()
        print(appMove)
    }
}
    
#Preview {
    ContentView()
}
