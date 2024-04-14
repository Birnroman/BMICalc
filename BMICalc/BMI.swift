
import SwiftUI

struct BMI: View {
  @State var textFieldAge = ""
  @State var textFieldHeight = ""
  @State var textFieldWeight = ""
  @State var bmi = 0.0
  @State var bmistatus: BMIStatus = .normalWeight
  @State var statusText: String = ""
  @State var tfBackground = Color(cgColor: #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1))
  @State var sheetIsVisible: Bool = false
  
  var body: some View {
    ZStack {
      Color.white.ignoresSafeArea()
      
      VStack {
        VStack(spacing: 12) {
          
          // Tabs
          GenderSelectionView()
          
          // Fields
          HStack {
            
            Text("Возраст")
              .frame(width: 100, alignment: .leading)
            TextField(text: $textFieldAge) {
              Text("25")
            }
            .frame(height: 42)
            .padding(.horizontal, 12)
            .background(tfBackground)
            .cornerRadius(6)
          }
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .stroke(AppColors.tfBorder, lineWidth: 1)
          )
          
          
          HStack {
            
            Text("Рост")
              .frame(width: 100, alignment: .leading)
            TextField("170", text: $textFieldHeight)
              .frame(height: 42)
              .padding(.horizontal, 12)
              .background(tfBackground)
              .cornerRadius(6)
              .overlay(
                
                Menu(content: {
                  Button("mm") {}
                  Button("cm") {}
                }, label: {
                  HStack(spacing: 4) {
                    Text("см")
                      .font(.system(size: 15))
                    
                    Image(systemName: "chevron.down")
                      .font(.system(size: 11))
                      .padding(.top, 3)
                  }
                  .foregroundColor(AppColors.blackBG)
                }).padding(.trailing, 10),
                alignment: .trailing
              )
          }
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .stroke(AppColors.tfBorder, lineWidth: 1)
          )
          
          HStack {
            
            Text("Вес")
              .frame(width: 100, alignment: .leading)
            TextField("75.5",text: $textFieldWeight)
              .frame(height: 42)
              .padding(.horizontal, 12)
              .background(tfBackground)
              .cornerRadius(6)
              .overlay(
                
                Menu(content: {
                  Button("mm") {}
                  Button("cm") {}
                }, label: {
                  HStack(spacing: 4) {
                    Text("кг")
                      .font(.system(size: 15))
                    
                    Image(systemName: "chevron.down")
                      .font(.system(size: 11))
                      .padding(.top, 3)
                  }
                  .foregroundColor(AppColors.blackBG)
                }).padding(.trailing, 10),
                alignment: .trailing
              )
              .onChange(of: textFieldHeight, { oldValue, newValue in
                goBMI()
              })
            
          }
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .stroke(AppColors.tfBorder, lineWidth: 1)
          )
          .onChange(of: textFieldWeight, { oldValue, newValue in
            goBMI()
          })
          VStack {
            VStack(spacing: 64) {
              // top
              VStack(spacing: 12) {
                Text("Индекс массы тела:")
                  .font(.system(size: 18))
                  .fontWeight(.semibold)
                  .foregroundColor(.white.opacity(0.6))
                  .frame(height: 18)
                Text(String(format: "%.2f", bmi))
                  .font(.system(size: 65))
                  .fontWeight(.semibold)
                  .frame(height: 64)
                  .foregroundColor(.white)
                HStack(spacing: 4) {
                  Rectangle()
                    .cornerRadius(2)
                    .foregroundColor(AppColors.redBG)
                    .frame(maxWidth: bmistatus == .underweight ? .infinity : 0.07 * UIScreen.main.bounds.width)
                  Rectangle()
                    .cornerRadius(2)
                    .foregroundColor(AppColors.greenBG)
                    .frame(maxWidth: bmistatus == .normalWeight ? .infinity : 0.07 * UIScreen.main.bounds.width)
                  Rectangle()
                    .cornerRadius(2)
                    .foregroundColor(AppColors.lettucegreenBG)
                    .frame(maxWidth: bmistatus == .overWeight ? .infinity : 0.07 * UIScreen.main.bounds.width)
                  Rectangle()
                    .cornerRadius(2)
                    .foregroundColor(AppColors.yellowBG)
                    .frame(maxWidth: bmistatus == .obesityClass1 ? .infinity : 0.07 * UIScreen.main.bounds.width)
                  Rectangle()
                    .cornerRadius(2)
                    .foregroundColor(AppColors.orangeBG)
                    .frame(maxWidth: bmistatus == .obesityClass2 ? .infinity : 0.07 * UIScreen.main.bounds.width)
                  Rectangle()
                    .cornerRadius(2)
                    .foregroundColor(AppColors.redBG)
                    .frame(maxWidth: bmistatus == .obesityClass3 ? .infinity : 0.07 * UIScreen.main.bounds.width)
                }
                .frame(height: 8)
                .padding(.bottom, 15)
                Text(statusText)
                  .font(.system(size: 18))
                  .fontWeight(.semibold)
                  .foregroundColor(.white)
                  .frame(height: 18)

              }
            }
            .padding(28)
            .padding(.vertical, 15)
            .background(AppColors.blackBG)
            .cornerRadius(24)
          }
        }
        
        .padding(.horizontal, 20)
        .padding(.top, 12)
        Spacer()
        Button(action: {
          sheetIsVisible.toggle()
        }, label: {
          HStack {
            Text("Твоя идеальная форма")
              .font(.system(size: 17))
              .fontWeight(.semibold)
            Image(systemName: "chevron.right")
              .font(.system(size: 16))
          }
          .frame(height: 50)
          .frame(maxWidth: .infinity)


        })
        .foregroundColor(.black.opacity(0.6))
        .background(Color.black.opacity(0.05))
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .sheet(isPresented: $sheetIsVisible) {
          PersonalAdviceView()
        }
      }
    }
    
    
  }
  
  
  func goBMI() {
    
    
    withAnimation {
      if let height = Double(textFieldHeight), let weight = Double(textFieldWeight) {
        let result = weight / ((height / 100) * (height / 100))
        bmi = bmiAppropiate(for: result) ? result : 0
        checkStatus(bmi: bmi)
      }
    }
    
  }
  
  func bmiAppropiate(for number: Double) -> Bool {
    if number > 6 && number < 100 {
      return true
    } else {
      return false
    }
  }
  
  func checkStatus(bmi: Double) {
    
    
    if bmi < 18.5 {
      bmistatus = .underweight
    } else if bmi >= 18.5 && bmi < 24.9 {
      bmistatus = .normalWeight
    } else if bmi >= 24.9 && bmi < 29.9 {
      bmistatus = .overWeight
    } else if bmi >= 29.9 && bmi < 34.9 {
      bmistatus = .obesityClass1
    } else if bmi >= 34.9 && bmi < 39.9 {
      bmistatus = .obesityClass2
    } else {
      bmistatus = .obesityClass3
    }
    
    statusText = bmistatus.description
  }

}

#Preview {
  BMI()
}



enum BMIStatus {
  case underweight
  case normalWeight
  case overWeight
  case obesityClass1
  case obesityClass2
  case obesityClass3
  
  var description: String {
    switch self {
    case .underweight:
      return "Недостаток веса"
    case .normalWeight:
      return "Нормальный вес"
    case .overWeight:
      return "Избыточный вес"
    case .obesityClass1:
      return "Ожирение I степени"
    case .obesityClass2:
      return "Ожирение II степени"
      
    case .obesityClass3:
      return "Ожирение III степени"
      
    }
  }
}
