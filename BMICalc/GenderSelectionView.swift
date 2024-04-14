
import SwiftUI

struct GenderSelectionView: View {
  
  let buttons = ["Мужчина", "Женщина"]
  @State public var buttonSelected: Int = 0
  
  var body: some View {
    HStack {
      ForEach(0..<buttons.count) { button in
        Button(action: {
          tabSelect(button: button)
        }, label: {
          Text(buttons[button])
            .frame(maxWidth: .infinity)
            .frame(height: 42)
            .padding(.horizontal)
            .background(self.buttonSelected == button ? AppColors.blackBG : Color.white)
            .foregroundColor(self.buttonSelected == button ? Color.white : Color.black)
            .overlay(self.buttonSelected == button ? RoundedRectangle(cornerRadius: 8)
              .stroke(AppColors.blackBG, lineWidth: 0) : RoundedRectangle(cornerRadius: 8)
              .stroke(AppColors.blackBG, lineWidth: 2))
            .cornerRadius(8.0)
        })
      }
    }
    .fontWeight(.semibold)
  }
  
  func tabSelect(button: Int) {
    self.buttonSelected = button
  }
}

#Preview {
  GenderSelectionView()
}
