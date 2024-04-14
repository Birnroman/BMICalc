
import Foundation
struct BMIModel {
  func calculateBMI(weight: Double, height: Double) -> Double {
    return weight / (height * height)
  }
}
