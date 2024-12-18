

import SwiftUI

struct MainView: View {
    
    //MARK: Property
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack{
            // MARK: Background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 12){
                // MARK: Display
                HStack{
                    Spacer()
                    Text("0")
                        .foregroundColor(.white)
                        .font(.system(size: 90))
                        .fontWeight(.light)
                        .padding(.horizontal, 28)
                    
                }//HStack
                
                // MARK: Buttons
                ForEach(buttonsArray, id: \.self) { row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button {
                                // позже
                            } label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .foregroundColor(item.buttonFonColor)
                                    .background(item.buttonColor)
                                    .cornerRadius(40)
                                    .font(.system(size: 35))
                                
                            }

                        }
                    }
                }
                
            }//VStack
            
        }//ZStack
        
        
    }
    //MARK: button Width and Height
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

#Preview {
    MainView()
}
