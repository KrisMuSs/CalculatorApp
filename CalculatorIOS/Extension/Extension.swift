
import SwiftUI

extension Color {
    static let orangeBut = Color("orangeCalc")
    static let darkGrayBut = Color("darkGrayCalc")
    static let grayBut = Color("grayCalc")
}

// MARK: Extension: Button to Operation
extension Buttons {
    func toOperation() -> Operation {
        switch self {
        case .plus:
            return .addition
        case .minus:
            return .subtract
        case .multiple:
            return .multiply
        case .divide:
            return .divide
        default:
            return .none
        }
    }
}
