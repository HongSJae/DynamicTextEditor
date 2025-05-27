import SwiftUI
import UIKit

/// 사용자의 입력에 따라 높이가 자동으로 조절되는 TextEditor입니다.
///
/// SwiftUI의 `TextEditor`를 기반으로 하며, 최대 줄 수를 설정할 수 있고,
/// 플레이스홀더도 지원합니다.
///
/// - Features:
///   - 동적 높이 조절
///   - 플레이스홀더 지원
///   - 최대 줄 수 제한
///
/// - Example:
/// ```swift
/// @State private var text: String = ""
///
/// var body: some View {
///     DynamicTextEditor("내용을 입력하세요", text: $text)
/// }
/// ```
public struct DynamicTextEditor: View {
    
    /// TextEditor의 폰트입니다. 기본값은 `.systemFont(ofSize: 14)`입니다.
    var uiFont: UIFont = .systemFont(ofSize: 14)

    /// 표시할 최대 줄 수입니다. 기본값은 `5`이며, `1`보다 작게 설정할 경우 `1`로 처리됩니다.
    var maxLine: CGFloat = 5

    /// 텍스트의 Foreground Color입니다. 기본값은 `.black`입니다.
    var foregroundColor: Color = .black

    private let text: Binding<String>
    private let placeholder: String

    private var maxHeight: CGFloat {
        maxLineCount * uiFont.lineHeight
    }

    private var maxLineCount: CGFloat {
        maxLine < 1 ? 1 : maxLine
    }

    @State private var currentTextEditorHeight: CGFloat = 0
    @State private var maxTextWidth: CGFloat = 0

    /// `DynamicTextEditor` 생성자
    ///
    /// - Parameters:
    ///   - placeholder: 비어 있을 때 표시할 플레이스홀더 텍스트
    ///   - text: 사용자 입력을 바인딩할 문자열
    public init (
        _ placeholder: String,
        text: Binding<String>
    ) {
        self.text = text
        self.placeholder = placeholder

        // 기본 TextView 인셋 제거
        UITextView.appearance().textContainerInset = .zero
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                Text(placeholder)
                    .foregroundStyle(foregroundColor)
                    .font(uiFont: uiFont)
                    .padding(.leading, 5)
                    .opacity(text.wrappedValue.isEmpty ? 1 : 0)

                TextEditor(text: text)
                    .scrollContentBackground(.hidden)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .scrollDisabled(newLineCount <= 1)
                    .foregroundStyle(foregroundColor)
                    .font(uiFont: uiFont)
                    .frame(maxHeight: currentTextEditorHeight)
            }
            .onAppear {
                setTextEditorStartHeight()
                setMaxTextWidth(proxy: proxy)
            }
            .onChange(of: text.wrappedValue) { _ in
                updateTextEditorCurrentHeight()
            }
        }
        .frame(maxHeight: currentTextEditorHeight)
    }
}

// MARK: - 라인 계산 관련
private extension DynamicTextEditor {
    
    /// 개행 문자 기반 줄 수 계산
    var newLineCount: CGFloat {
        let lineCount = text.wrappedValue.filter { $0 == "\n" }.count + 1
        return lineCount > maxLineCount.asInt ? maxLineCount : lineCount.asFloat
    }

    /// 자동 줄바꿈 줄 수 계산 (텍스트 길이 기준)
    var autoLineCount: CGFloat {
        var counter: Int = 0
        text
            .wrappedValue
            .components(separatedBy: "\n")
            .forEach { line in
                let label = UILabel()
                label.font = uiFont
                label.text = line
                label.sizeToFit()
                let width = label.frame.width
                counter += (width / maxTextWidth).asInt
            }

        return counter.asFloat
    }
}

// MARK: - 뷰 레이아웃 설정
private extension DynamicTextEditor {
    
    /// 에디터 초기 높이 설정 (1줄)
    func setTextEditorStartHeight() {
        currentTextEditorHeight = uiFont.lineHeight
    }

    /// 사용 가능한 최대 텍스트 너비 설정
    func setMaxTextWidth(proxy: GeometryProxy) {
        maxTextWidth = proxy.size.width
    }

    /// 현재 텍스트 길이에 맞춰 에디터 높이 갱신
    func updateTextEditorCurrentHeight() {
        let totalLineCount = newLineCount + autoLineCount

        if totalLineCount >= maxLineCount {
            currentTextEditorHeight = maxHeight
        } else {
            currentTextEditorHeight = totalLineCount * uiFont.lineHeight
        }
    }
}
