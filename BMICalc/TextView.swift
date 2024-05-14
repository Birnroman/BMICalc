//
//  TextView.swift
//  BMICalc
//
//  Created by Rum Gersy on 02.05.2024.
//

import SwiftUI


struct TextView: View {
  
  @State var isCompleted: Bool = true
  
    var body: some View {
      isCompleted ? Text("Да") : Text("Нет")
    }
}

#Preview {
    TextView()
}
