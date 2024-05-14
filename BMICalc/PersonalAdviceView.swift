
import SwiftUI

struct PersonalAdviceView: View {
  
  @State var idealWeight: (Double, Double, Double, UnitsOfWeight) = (minimum: 0.0, maximum: 0.0, yourWeight: 0.0, units: .kilograms)
  
  @State var deviation: String = ""
  
  var body: some View {
    ZStack {
      AppColors.blackBG.ignoresSafeArea()
      
      // scroll view
      ScrollView {
        // main vstack
        VStack(alignment: .leading, spacing: 28) {
          
          // recommend number vstack
          VStack(alignment: .leading, spacing: 0) {
            
            if idealWeight.3 == .kilograms {
              Text("\(String(format: "%.1f", idealWeight.0))—\(String(format: "%.1f", idealWeight.1)) кг")
                .font(.system(size: 50)).fontWeight(.semibold).foregroundStyle(Color.white)

            } else {
              Text("\(String(format: "%.1f", idealWeight.0))—\(String(format: "%.1f", idealWeight.1)) фунтов")
                .font(.system(size: 50)).fontWeight(.semibold).foregroundStyle(Color.white)
            }
            Text("Ваш идеальный вес")
              .foregroundStyle(.white.opacity(0.5))

          }
          
          // recommend description text
          Text(deviation)
            .font(.title2)
            .foregroundStyle(Color.white)
          
          // three advices vstack
          VStack(spacing: 8) {
            
            HStack(alignment: .top, spacing: 20) {
              Text("🥦")
                .font(.title)
                .frame(width: 28)
              Text("Ограничьте потребление слишком калорийных продуктов и сладостей, предпочтение отдавая овощам, фруктам, нежирным белкам.")
            }
            .padding(.all, 16)
            .background(Color.white.opacity(0.03))
            .cornerRadius(15)
            
            HStack(alignment: .top, spacing: 20) {
              Text("🧘🏻‍♀️")
                .font(.title)
                .frame(width: 28)
              Text("Увеличьте физическую активность: ходьба, занятия йогой или плавание могут помочь сжечь лишние килограммы")
            }
            .padding(.all, 16)
            .background(Color.white.opacity(0.03))
            .cornerRadius(15)
            
            HStack(alignment: .top, spacing: 20) {
              Text("📝")
                .font(.title)
                .frame(width: 28)
              Text("Сократите размер порций, избегайте переедания, следите за пищевым рационом, поддерживая здоровый образ жизни")
            }
            .padding(.all, 16)
            .background(Color.white.opacity(0.03))

            .cornerRadius(15)
          }
          .foregroundColor(.white)
          
          
          // tableIMT
          VStack(alignment: .leading, spacing: 20) {
            Text("Категории ИМТ:")
              .font(.title2).fontWeight(.semibold)
            
            VStack(spacing: 16) {
              CategoriesItemView(range: "< 18.5", color: AppColors.redBG)
              Divider().background(Color.white.opacity(0.4))
              CategoriesItemView(range: "18.5—24.8", decription: "Нормальный вес", color: AppColors.greenBG)
              Divider().background(Color.white.opacity(0.4))
              CategoriesItemView(range: "24.9—29.8", decription: "Избыточный вес", color: AppColors.lettucegreenBG)
              Divider().background(Color.white.opacity(0.4))
              CategoriesItemView(range: "29.9—34.8", decription: "Ожирение I степени", color: AppColors.yellowBG)
              Divider().background(Color.white.opacity(0.4))
              CategoriesItemView(range: "34.9—39.8", decription: "Ожирение II степени", color: AppColors.orangeBG)
              Divider().background(Color.white.opacity(0.4))
              CategoriesItemView(range: "> 39.8", decription: "Ожирение III степени", color: AppColors.redBG)
            }
          }
          .foregroundColor(.white)

          
        }
        .padding()
      }
      .onAppear {
        deviation = calculateDeviation(minimum: idealWeight.0, maximum: idealWeight.1, weight: idealWeight.2, units: idealWeight.3)
      }
      
    }
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

struct Category {
  let name: String
  let minimum: Double
  let maximum: Double
  
}

struct CategoriesItemView: View {
  
  @State var range: String = "< 18,5"
  @State var decription: String = "Недостаток веса"
  @State var color: Color = .gray
  
  var body: some View {
    HStack {
      HStack(spacing: 0) {
        Text(range)
          .frame(width: 100, alignment: .leading)
          .foregroundColor(.white.opacity(0.6))
        Text(decription)
          .fontWeight(.medium)
      }
      
      Spacer()
      Circle().frame(width: 10)
        .foregroundColor(color)
    }
  }
}

#Preview {
  PersonalAdviceView()
}

//#Preview {
//  CategoriesItemView()
//}
