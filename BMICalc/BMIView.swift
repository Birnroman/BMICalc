
import SwiftUI

struct BMIView: View {
  @State var textFieldAge = ""
  
  @State var textFieldHeight = ""
  @State var selectedUnitsOfHeight: UnitsOfHeight = .centimeters
  
  @State var textFieldWeight = ""
  @State var selectedUnitsOfWeight: UnitsOfWeight = .kilograms
  
  @State var bmi = 0.0
  @State var bmistatus: BMIStatus = .normalWeight
  @State var statusText: String = ""
  
  @State var deviationDescription: String = ""
  
  
  @State var tfBackground = Color(cgColor: #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1))
  @State var sheetIsVisible: Bool = false
  @State var gender: Gender = .male
  
  var body: some View {
    ZStack {
      Color.white.ignoresSafeArea()
      
      VStack {
        VStack(spacing: 12) {
          
          // Tabs
          genderView
          
          // Fields
          HStack {
            
            Text("Возраст")
              .frame(width: 100, alignment: .leading)
            TextField("25", text: $textFieldAge)
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

          }
          .padding(10)
          .overlay(
            RoundedRectangle(cornerRadius: 12)
              .stroke(AppColors.tfBorder, lineWidth: 1)
          )
          .onChange(of: textFieldHeight) { oldValue, newValue in
            if newValue.contains(",") {
              textFieldHeight = newValue.replacingOccurrences(of: ",", with: ".")
            }
          }
          
          HStack {
            
            Text("Вес")
              .frame(width: 100, alignment: .leading)
            TextField("70",text: $textFieldWeight)
              .frame(height: 42)
              .padding(.horizontal, 12)
              .background(tfBackground)
              .cornerRadius(6)

              .onChange(of: textFieldHeight, { oldValue, newValue in
                goBMI()
              })
              .onChange(of: textFieldWeight) { oldValue, newValue in
                if newValue.contains(",") {
                  textFieldWeight = newValue.replacingOccurrences(of: ",", with: ".")
                }
              }
            
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
                Text(bmiAppropiate(for: bmi) ? statusText : "")
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
          PersonalAdviceView(idealWeight: calculateIdealWeight(), deviation: deviationDescription)
          
        }
      }
    }
  }
  
  
  func goBMI() {
    
    guard var height = Double(textFieldHeight), var weight = Double(textFieldWeight) else { return }
    
    if selectedUnitsOfHeight == .feet {
      height = height * 30.48
    } else if selectedUnitsOfHeight == .inches {
      height = height * 2.54
    }
    
    if selectedUnitsOfWeight == .pounds {
      weight = weight * 0.45
    }
    
    let result = weight / ((height / 100) * (height / 100))
    bmi = bmiAppropiate(for: result) ? result : 0
    
    withAnimation {
      checkStatus(bmi: bmi)
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
  
  func calculateIdealWeight() -> (Double, Double, Double, UnitsOfWeight) {
    guard var height = Double(textFieldHeight), var weight = Double(textFieldWeight) else { return (0.0, 0.0, 0.0, .kilograms) }
    
    var units: UnitsOfWeight = .kilograms
    var minimumWeight: Double = 0.0
    var maximumWeight: Double = 0.0
    
    if selectedUnitsOfHeight == .feet {
      height = height * 30.48
    } else if selectedUnitsOfHeight == .inches {
      height = height * 2.54
    }
    
    
    if selectedUnitsOfWeight == .pounds {
      weight = weight * 0.45
      units = .pounds
      minimumWeight = (0.01 * height) * (0.01 * height) * 18.5 * 2.2
      maximumWeight = (0.01 * height) * (0.01 * height) * 24.9 * 2.2
    } else {
      units = .kilograms
      minimumWeight = (0.01 * height) * (0.01 * height) * 18.5
      maximumWeight = (0.01 * height) * (0.01 * height) * 24.9
    }
    
    deviationDescription = calculateDeviation(minimum: minimumWeight, maximum: maximumWeight, weight: weight, units: units)
    
    return (minimumWeight, maximumWeight, weight, units)
    
  }
  
  func calculateDeviation(minimum: Double, maximum: Double, weight: Double, units: UnitsOfWeight) -> String {
    var delta: Double = 0.0
    var description: String = ""
    
    if weight < minimum {
      delta = minimum - weight
      description = "Набрать \(String(format: "%.0f", delta)) \(units == .kilograms ? "кг" : "фунтов") можно, если следовать следующим рекомендациям:"
    } else if weight > maximum {
      delta = weight - maximum
      description = "Сбросить \(String(format: "%.0f", delta)) \(units == .kilograms ? "кг" : "фунтов") можно, если следовать следующим рекомендациям:"
    } else if weight >= minimum && weight <= maximum {
      description = "Для поддержания нормального веса, следуйте рекомендациям:"
    }
    
    return description
    
  }
}



#Preview {
  BMIView()
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

enum Gender {
  case male
  case female
}

enum UnitsOfHeight: String, CaseIterable {
  case centimeters = "см"
  case feet = "фут"
  case inches = "дюйм"
}

enum UnitsOfWeight: String, CaseIterable {
  case kilograms = "кг"
  case pounds = "фунт"
}

extension BMIView {
  var genderView: some View {
    HStack {
      Button {
        gender = .male
      } label: {
        Text("Мужчина")
          .frame(maxWidth: .infinity)
          .frame(height: 42)
          .padding(.horizontal)
          .background(gender == .male ? AppColors.blackBG : .white)
          .foregroundColor(gender == .male ? .white : AppColors.blackBG)
          .overlay(gender == .male ? RoundedRectangle(cornerRadius: 8)
            .stroke(AppColors.blackBG, lineWidth: 0) : RoundedRectangle(cornerRadius: 8)
            .stroke(AppColors.blackBG, lineWidth: 1.5))
          .cornerRadius(8)
      }
      
      Button {
        gender = .female
      } label: {
        Text("Женщина")
          .frame(maxWidth: .infinity)
          .frame(height: 42)
          .padding(.horizontal)
          .background(gender == .female ? AppColors.blackBG : .white)
          .foregroundColor(gender == .female ? .white : AppColors.blackBG)
          .overlay(gender == .female ? RoundedRectangle(cornerRadius: 8)
            .stroke(AppColors.blackBG, lineWidth: 0) : RoundedRectangle(cornerRadius: 8)
            .stroke(AppColors.blackBG, lineWidth: 1.5))
          .cornerRadius(8)
      }
      
    }
  }
}
