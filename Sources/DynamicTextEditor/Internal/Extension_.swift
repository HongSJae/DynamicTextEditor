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

extension Font {
    /// SwiftUI Font → UILabel을 통해 UIFont 추출
    @MainActor
    func toUIFont() -> UIFont {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body) // 기본값

        let hosting = UIHostingController(rootView: Text(" ").font(self))
        hosting.loadViewIfNeeded()
        
        if let labelInside = findLabel(in: hosting.view) {
            print("findLabel:", labelInside.font.fontName)
            return labelInside.font
        }
        print("default:", label.font.fontName)
        return label.font
    }

    @MainActor
    /// UILabel 탐색 (View hierarchy 순회)
    private func findLabel(in view: UIView) -> UILabel? {
        if let label = view as? UILabel {
            return label
        }
        for subview in view.subviews {
            if let found = findLabel(in: subview) {
                return found
            }
        }
        return nil
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
