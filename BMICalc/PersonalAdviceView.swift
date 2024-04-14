
import SwiftUI

struct PersonalAdviceView: View {
  
  let bmi: Double = 0.0
  let height: Double = 0.0
  let weight: Double = 0.0
//  let status: BMIStatus = .normalWeight
//  let gender: 
  
    var body: some View {
      ZStack {
        AppColors.tfBorder.ignoresSafeArea()
        
        // scroll view
        ScrollView {
          // main vstack
          VStack(alignment: .leading, spacing: 24) {
            
            // recommend number vstack
            VStack(alignment: .leading, spacing: 0) {
              Text("\(Int(idealWeight().0))—\(Int(idealWeight().1)) кг")
                .font(.system(size: 50)).fontWeight(.semibold)
              Text("Ваш идеальный вес")
                .foregroundStyle(.black.opacity(0.4))
            }
            
            // recommend description text
            Text("Сбросить 2-3 лишних килограмма можно, если придерживаться следующих рекомендаций")

            // three advices vstack
            VStack(spacing: 8) {
              
              HStack(alignment: .top, spacing: 20) {
                Text("🥦")
                  .font(.title)
                  .frame(width: 28)
                Text("Ограничьте потребление слишком калорийных продуктов и сладостей, предпочтение отдавая овощам, фруктам, нежирным белкам.")
              }
              .padding(.all, 16)
              .background(Color.white)
              .cornerRadius(15)
              
              HStack(alignment: .top, spacing: 20) {
                Text("🧘🏻‍♀️")
                  .font(.title)
                  .frame(width: 28)
                Text("Увеличьте физическую активность: ходьба, занятия йогой или плавание могут помочь сжечь лишние килограммы")
              }
              .padding(.all, 16)
              .background(Color.white)
              .cornerRadius(15)
              
              HStack(alignment: .top, spacing: 20) {
                Text("📝")
                  .font(.title)
                  .frame(width: 28)
                Text("Сократите размер порций, избегайте переедания, следите за пищевым рационом, поддерживая здоровый образ жизни")
              }
              .padding(.all, 16)
              .background(Color.white)
              .cornerRadius(15)
            }
            
            
            // tableIMT
            VStack(alignment: .leading) {
              Text("Категории ИМТ:")
                .font(.title2).fontWeight(.semibold)

              VStack {
                CategoriesItemView()
                Divider()
                CategoriesItemView(range: "21-34")
                Divider()
                CategoriesItemView()
                Divider()
                CategoriesItemView(range: "21-34")
                Divider()
              }
            }
            
            // spacer
//            Spacer()
          }
          .padding()
        }
        
       
      }
    }
  func idealWeight() -> (Double, Double) {
    let minimumWeight: Double = (0.01 * height) * (0.01 * height) * 18.5
    let maximumWeight: Double = (0.01 * height) * (0.01 * height) * 24.8
    
    return (minimumWeight, maximumWeight)
  }
}

struct Category {
  let name: String
  let minimum: Double
  let maximum: Double
  
}

struct CategoriesItemView: View {
  
  @State var range: String = "<20"
  @State var name: String = "Недостаток веса"
  @State var color: Color = .gray
  
  var body: some View {
    HStack {
      HStack(spacing: 0) {
        Text(range)
          .frame(width: 80, alignment: .leading)
          .foregroundColor(.black.opacity(0.6))
        Text(name)
          .fontWeight(.medium)
      }

      Spacer()
      Circle().frame(width: 12)
        .foregroundColor(color)
    }
  }
}

#Preview {
    PersonalAdviceView()
}

#Preview {
  CategoriesItemView()
}
