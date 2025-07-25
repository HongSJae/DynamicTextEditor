import SwiftUI

public extension DynamicTextEditor {

    /// TextEditor에 사용할 UIFont를 설정합니다.
    ///
    /// - Parameter uiFont: 적용할 `UIFont` 객체
    /// - Returns: 설정된 폰트를 적용한 새로운 `DynamicTextEditor` 뷰
    ///
    /// - Example:
    /// ```swift
    /// DynamicTextEditor("입력", text: $text)
    ///     .setFont(uiFont: .systemFont(ofSize: 16, weight: .bold))
    /// ```
    func setFont(uiFont: UIFont) -> Self {
        var view = self
        view.uiFont = uiFont
        return view
    }

    /// TextEditor의 최대 줄 수를 설정합니다.
    ///
    /// - Parameter maxLineCount: 최대 줄 수 (1 이상)
    /// - Returns: 설정된 줄 수를 적용한 새로운 `DynamicTextEditor` 뷰
    ///
    /// - Example:
    /// ```swift
    /// DynamicTextEditor("입력", text: $text)
    ///     .setMaxLineCount(3)
    /// ```
    func setMaxLineCount(_ maxLineCount: Int) -> Self {
        var view = self
        view.maxLine = CGFloat(maxLineCount)
        return view
    }

    /// 텍스트 색상을 설정합니다.
    ///
    /// - Parameter color: 적용할 전경색(`Color`)
    /// - Returns: 설정된 색상을 적용한 새로운 `DynamicTextEditor` 뷰
    ///
    /// - Example:
    /// ```swift
    /// DynamicTextEditor("입력", text: $text)
    ///     .setTextColor(.gray)
    /// ```
    func setTextColor(_ color: Color) -> Self {
        var view = self
        view.foregroundColor = color
        return view
    }

    /// Placeholder 색상을 설정합니다.
    ///
    /// - Parameter color: 적용할 전경색(`Color`)
    /// - Returns: 설정된 Placeholder 색상을 적용한 새로운 `DynamicTextEditor` 뷰
    ///
    /// - Example:
    /// ```swift
    /// DynamicTextEditor("입력", text: $text)
    ///     .setPlaceholderColor(.black)
    /// ```
    func setPlaceholderColor(_ color: Color) -> Self {
        var view = self
        view.placeholderColor = color
        return view
    }
}
