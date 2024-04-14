import SwiftUI

struct TriangleTrainView: View {
  
  @State var number = Int.random(in: 0...46)
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        Text("\(number)")
          .font(.system(size: 88))
          .foregroundStyle(.white)
        HStack(spacing: 0) {
          Rectangle().fill(Color.white.opacity(0.1))
            .frame(height: 16)
          Rectangle().fill(Color.white.opacity(0.4))
            .frame(height: 16)
          Rectangle().fill(Color.white.opacity(0.8))
            .frame(height: 16)
        }
        
        GeometryReader { geometry in
          Image(systemName: "triangle.fill")
            .foregroundColor(.white)
            .frame(width: 20, height: 20)
            .position(x: CGFloat(number) / 46 * geometry.size.width)
            .offset(x: number == 0 ? 10 : 0)
            .offset(x: number >= 46 ? -10 : 0)
        }
        
        Button(action: {
          number = Int.random(in: 0...46)
        }) {
          Text("Гоушки!")
            .font(.title)
        }
        .padding()
      }
      .padding()
    }
  }
}
#Preview {
    TriangleTrainView()
}
