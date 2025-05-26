import SwiftUI
import UIKit

public struct DynamicHeightTextEditor: View {
    private let text: Binding<String>
    private let lineSpace: CGFloat
    private let placeholder: String

    // MARK: Initializer에서 계산을 통해 결정되는 프로퍼티
    private let maxLineCount: CGFloat
    private let uiFont: UIFont
    private let maxHeight: CGFloat

    @State private var currentTextEditorHeight: CGFloat = 0
    @State private var maxTextWidth: CGFloat = 0

    // MARK: - Initializer
    /// 파라미터 font = .body, lineSpace = 2 기본값 지정
    public init (
        text: Binding<String>,
        lineSpace: CGFloat = 2,
        maxLine: CGFloat,
        placeholder: String
    ) {
        // MARK: Required
        self.text = text
        self.lineSpace = lineSpace
        self.placeholder = placeholder

        // MARK: Calculated
        self.maxLineCount = (maxLine < 1 ? 1 : maxLine)
        self.uiFont = .systemFont(ofSize: 14)
        self.maxHeight = (maxLineCount * (uiFont.lineHeight + lineSpace))

        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 이 부분 수정
    }

    // MARK: - View
    public var body: some View {
        enabledEditor
    }
}

// MARK: - Calculate Line
private extension DynamicHeightTextEditor {
    /// 현재 text에 개행문자에 의한 라인 갯수가 몇 줄인지 계산합니다.
    var newLineCount: CGFloat {
        let currentText: String = text.wrappedValue
        let currentLineCount: Int = currentText
            .filter { $0 == "\n" }
            .count + 1
        let newLineCount: CGFloat = currentLineCount > maxLineCount.asInt
        ? maxLineCount
        : currentLineCount.asFloat

        return newLineCount
    }

    /// 개행 문자 기준으로 텍스트를 분리하고, 각 텍스트 길이가 Editor 길이를 초과하는지 체크하여 필요한 줄바꿈 수를 계산합니다.
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
                let currentTextWidth = label.frame.width
                counter += (currentTextWidth / maxTextWidth).asInt
            }

        return counter.asFloat
    }
}

// MARK: - Calculate Width / Height
private extension DynamicHeightTextEditor {
    /// textEditor 시작 높이를 설정합니다.
    func setTextEditorStartHeight() {
        currentTextEditorHeight = uiFont.lineHeight
    }

    /// text가 가질 수 있는 최대 길이를 설정합니다.
    func setMaxTextWidth(proxy: GeometryProxy) {
        maxTextWidth = proxy.size.width
    }

    /// line count를 통해 textEditor 현재 높이를 계산해서 업데이트합니다.
    func updateTextEditorCurrentHeight() {
        // 총 라인 갯수
        let totalLineCount = newLineCount + autoLineCount

        // 총 라인 갯수가 maxCount 이상이면 최대 높이로 고정
        guard totalLineCount < maxLineCount else {
            currentTextEditorHeight = maxHeight
            return
        }

        // 라인 갯수로 계산한 현재 Editor 높이
        let currentHeight = (totalLineCount * (uiFont.lineHeight + lineSpace)) - lineSpace

        // View의 높이를 결정하는 State 변수에 계산된 현재 높이를 할당하여 뷰에 반영
        currentTextEditorHeight = currentHeight
    }
}

// MARK: - Editor View
private extension DynamicHeightTextEditor {
    var enabledEditor: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                Text(placeholder)
                    .font(uiFont: uiFont)
                    .padding(.leading, 5)
                    .opacity(text.wrappedValue.isEmpty ? 1 : 0)

                TextEditor(text: text)
                    .scrollContentBackground(.hidden)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .scrollDisabled(newLineCount <= 1)
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
