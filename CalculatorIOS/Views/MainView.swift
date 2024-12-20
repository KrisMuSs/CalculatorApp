

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack{
            // MARK: Background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 12){
                Spacer()
                // MARK: Display
                HStack{
                    Spacer()
                    
                    Text(viewModel.value)
                        .foregroundColor(.white)
                        .font(.system(size: 90))
                        .fontWeight(.light)
                        .padding(.horizontal, 28)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                }//HStack
                
                // MARK: Buttons
                ForEach(viewModel.buttonsArray, id: \.self) { row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button {
                                viewModel.didTap(item: item)
                                
                            } label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: viewModel.buttonWidth(item: item),
                                        height: viewModel.buttonHeight())
                                    .foregroundColor(item.buttonFonColor)
                                    .background(item.buttonColor)
                                    .cornerRadius(40)
                                    .font(.system(size: 35))
                                
                            }

                        }
                    }
                }
             
                
                
            }//VStack
            .padding(.bottom)
        }//ZStack
        
        
    }

    
}

#Preview {
    MainView()
        .environmentObject(ViewModel())
}
