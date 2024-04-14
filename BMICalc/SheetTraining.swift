
import SwiftUI

struct SheetTraining: View {
  
  @State var number: Int = 44
  
    var body: some View {
      if number > 40 {
        Text("Большое число")
      } else {
        Text("Маленькое число")
      }
    }
}

#Preview {
    SheetTraining()
}
