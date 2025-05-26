import Foundation
import SwiftUI

extension CGFloat {
    var asInt: Int {
        guard !self.isNaN else { return .zero }
        switch self {
        case .infinity, .nan:
            return .zero
        default:
            return Int(self)
        }
    }
}

extension Int {
    var asFloat: CGFloat {
        return CGFloat(self)
    }
}

extension View {
    nonisolated public func font(uiFont: UIFont) -> some View {
        self.font(.init(uiFont))
    }
}

extension Font {
    init(_ uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
}
