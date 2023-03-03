import SwiftUI

struct TicTacToeView: View {
    
    @State private var isPlaying = true
    @State private var moves: [String] = Array(repeating: "", count: 9)
    @State private var gameOver = false
    @State private var message = ""
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                
                ForEach(0..<9, id: \.self) { index in
                    
                    ZStack {
                        
                        Color.blue
                        
                        Color.black
                            .opacity(moves[index] == "" ? 1 : 0)
                        
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .opacity(moves[index] != "" ? 1 : 0)
                    }
                    .frame(width: getSpace(), height: getSpace())
                    .cornerRadius(15)
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0
                    )
                    .onTapGesture {
                        withAnimation(Animation.easeIn(duration: 0.5)) {
                            if moves[index] == "" {
                                moves[index] = isPlaying ? "X" : "O"
                                isPlaying.toggle()
                            }
                        }
                    }
                }
            }
            .padding(15)
        }
        .onChange(of: moves, perform: { value in
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Game over"), message: Text(message), dismissButton: .default(Text("Play again"), action: {
                
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        })
    }
    
    private func getSpace() -> CGFloat {
        let width = UIScreen.main.bounds.width - 60
        return width / 3
    }
    
    private func checkWinner() {
        if checkMoves(player: "X") {
            message = "Player X won!"
            gameOver.toggle()
        } else if checkMoves(player: "O") {
            message = "Player O won!"
            gameOver.toggle()
        } else {
            let status = moves.contains { (value) -> Bool in
                return value == ""
            }
            
            if !status {
                message = "Draw"
                gameOver.toggle()
            }
        }
    }
    
    private func checkMoves(player: String) -> Bool {
        //check horizontal
        for i in stride(from: 0, to: 9, by: 3) {
            if moves[i] == player, moves[i+1] == player, moves[i+2] == player {
                return true
            }
        }
        
        //check vertical
        for i in 0...2 {
            if moves[i] == player, moves[i+3] == player, moves[i+6] == player {
                return true
            }
        }
        
        //check diagonal
        if moves[0] == player, moves[4] == player, moves[8] == player {
            return true
        }
        
        if moves[2] == player, moves[4] == player, moves[6] == player {
            return true
        }
        return false
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
