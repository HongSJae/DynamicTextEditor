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
    @MainActor
    func toUIFont() -> UIFont {
        // SwiftUI Font를 실제로 렌더링해서 정보 추출
        let uiFont = UIFont.systemFont(ofSize: 17) // 기본값
        
        // UIHostingController를 이용한 트릭
        let hostingController = UIHostingController(rootView:
            Text("Sample")
                .font(self)
                .hidden()
        )
        
        // 뷰를 렌더링하고 폰트 정보 추출
        hostingController.view.layoutIfNeeded()
        if let res = extractFontFromView(hostingController.view)  {
            print("custom: \(res.fontName)")
            return res
        }
        print("default")
        return uiFont
    }
    
    @MainActor
    private func extractFontFromView(_ view: UIView) -> UIFont? {
        // 재귀적으로 UILabel 찾아서 폰트 추출
        if let label = view as? UILabel {
            return label.font
        }
        
        for subview in view.subviews {
            if let font = extractFontFromView(subview) {
                return font
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
