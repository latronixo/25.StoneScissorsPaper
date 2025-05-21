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
    //жесты-проигрывающие
    private var losingMoves = ["✂", "🪨", "📜"]
    
    @State private var appMove = ""         //жест, который рандомно "выбросит" приложение
    @State private var score = 0            //очки
    @State private var shouldWin = false    //флаг, определяющий задание: пользователю нужно выйграть или проиграть?
    @State private var round = 1            //номер раунда
    @State private var showAlert = false    //флаг отображения алерта
    
    //Text, пишуший задание: пользователю нужно выйграть или проиграть?
    struct taskText: View {
        let shouldWin: Bool
        
        var body: some View {
            if shouldWin {
                Text("выиграть")
                    .foregroundStyle(.blue)
            } else {
                Text("проиграть")
                    .foregroundStyle(.red)
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Ваш счет: \(score)")
                    .font(.largeTitle.bold())
                Text("Ход приложения:")
                Text(appMove)
                    .font(.system(size: 100))
                Spacer()
                Text("Вам нужно:")
                taskText(shouldWin: shouldWin)
                    .font(.largeTitle)
                Spacer()
            }
            
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
                    .alert("Игра окончена! Ваш счет: \(String(score))", isPresented: $showAlert){
                        Button("OK") {
                            if round == 10 {
                                round = 0
                                score = 0
                            }
                        }
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

    }
    
    //событие выбора пользователя
    private func moveTapped(_ userMove: String) {
        let indexAppMove = moves.firstIndex(of: appMove)    //определяем индекс массива выбора приложения в массиве жестов
        var indexUserMove: Int?                             //индекс массива выбора пользователя
        
        //если задание в том, чтобы выиграть, то определяем индекс массива в массиве победителей
        if shouldWin {
            indexUserMove = winningMoves.firstIndex(of: userMove)
        } else {
            //если же задание в том, чтобы проиграть, то определяем индекс массива в массиве проигрывающих
            indexUserMove = losingMoves.firstIndex(of: userMove)
        }
        
        //если пользователь верно справился с заданием, то инкриминируем счет, и наоборот
        score += indexUserMove == indexAppMove ? 1 : -1

        if round == 10 {
            showAlert = true    //показываем алерт с текущим счетом
//            round = 0
//            score = 0
        } else {
            nextRound()
        }

        //
        //print ("индекс выбранного пользователем жеста \(indexUserMove)")
    }
    
    private func nextRound() {
        
        round += 1
        appMove = moves[Int.random(in: 0...2)]
        shouldWin.toggle()
        print("приложение загадало \(appMove), shouldWin = \(shouldWin)")
    }
}
    
#Preview {
    ContentView()
}
