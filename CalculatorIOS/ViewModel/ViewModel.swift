

import SwiftUI

class ViewModel: ObservableObject{
    
    //MARK: Property
    @Published var value = "0"
    @Published var number:Double = 0.0
    @Published var currentOperation:Operation = .none
    
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: - Methods
 
    // MARK: Tap Button Method
    func didTap(item: Buttons) {
        
     if let lastChar = value.last,
                "+-*/".contains(lastChar) &&
            "+-*/".contains(item.rawValue) {
         if String(lastChar) != item.rawValue{
             value = String(value.dropLast()) + item.rawValue
         }
     }
        else{
            switch item {
            case .clear:
                value = "0"
                
            case .equal:
                // Error if thr number equal 3.233e+09
                if (Double(value) == nil){
                    if let lastChar = value.last,
                       !"+-*/.".contains(lastChar) {
                        value = formatResult(Сalculating(value))
                    }
                }
                
            case .negative:
                if let currentValue = Double(value){
                    value = formatResult(-currentValue)
                    currentOperation = .none
                }
            case .percent:
                let components = value.split(whereSeparator: { !$0.isNumber && $0 != "." })
                if let lastComponent = components.last, let lastNumber = Double(lastComponent) {
                    let modStr = String(value.dropLast(formatResult(lastNumber).count))
                    let lastNumber = formatResult(lastNumber / 100)
                    value = modStr + lastNumber
                }
                
            default:
                if (value == "0") && ("+-*/.".contains(item.rawValue)){
                    
                }
                else if value == "0"{
                    value = item.rawValue
                    
                }
                else {
                    value += item.rawValue
                }
                
                
            }
        }
    }
    
    // MARK: СalculatingExpression
      func Сalculating(_ expression: String) -> Double {
          var numbers: [Double] = []
          var operations: [Character] = []
          var currentNumber = ""

          
          for (index, char) in expression.enumerated() {
              if char.isNumber || char == "." {
                  currentNumber.append(char)
              } else if "+-*/".contains(char) {
                  if index == 0 && char == "-" {
                      currentNumber.append(char)
                      continue
                  }
                  if let number = Double(currentNumber) {
                      numbers.append(number)
                  }
                  operations.append(char)
                  currentNumber = ""
              }
          }

          if let number = Double(currentNumber) {
              numbers.append(number)
          }

          var index = 0
          while index < operations.count {
              if operations[index] == "*" || operations[index] == "/" {
                  let left = numbers[index]
                  let right = numbers[index + 1]
                  let result: Double

                  if operations[index] == "*" {
                      result = left * right
                  } else {
                      result = left / right
                  }
                  numbers[index] = result
                  numbers.remove(at: index + 1)
                  operations.remove(at: index)
              } else {
                  index += 1
              }
          }

          index = 0
          while index < operations.count {
              let left = numbers[index]
              let right = numbers[index + 1]
              let result = operations[index] == "+" ? left + right : left - right
              numbers[index] = result
              numbers.remove(at: index + 1)
              operations.remove(at: index)
          }

          return numbers.first ?? 0
      }

    // MARK: Remove Last "0" Method
    func formatResult(_ result: Double) -> String {
        return String(format: "%g", result)
    }
    
    //MARK: Size of buttons
    /*
     spacing – расстояние между кнопками и расстояние от экрана до кнопки
     (12 пикселей)
     totalSpacing - рассчитывается как количество зазоров × ширина одного зазора, где количество зазоров — 5 (между 4 кнопками в ряду и по краям).
     totalColumns – количество кнопок в строке (4 кнопки в одной строке).
     screenWidth – ширина экрана устройства.
     Общая ширина кнопки равна доступной ширине экрана без учёта зазоров, разделённой на количество кнопок в ряду.
     */
    func buttonWidth(item: Buttons) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let zeroTotalSpacing: CGFloat = 4 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        if item == .zero{
            return (screenWidth - zeroTotalSpacing) / totalColumns * 2
        }
        
        return (screenWidth - totalSpacing) / totalColumns
    }
    
    // т.к высота у всех кнопок одинаковая, входного параметра не будет
    func buttonHeight() -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpacing) / totalColumns
    }
}
