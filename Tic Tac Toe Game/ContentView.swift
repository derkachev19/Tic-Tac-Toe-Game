import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            header
                .padding(.top, 24)
                .padding(.horizontal, 15)
            Spacer()
            TicTacToeView()
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    private var header: some View {
        Text("Tic Tac Toe")
            .font(.system(size: 30))
            .fontWeight(.heavy)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
