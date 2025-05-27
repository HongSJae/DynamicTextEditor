# DynamicTextEditor

`DynamicTextEditor`는 사용자의 입력에 따라 높이가 자동으로 조절되는 SwiftUI 기반의 TextEditor Component입니다.
  
> 카카오톡 앱의 채팅화면에 TextField와 같이 동적으로 Height가 변하는 TextEditor

## ✨ Features

- ✅ 최대 줄 수 설정 가능
- ✅ placeholder 텍스트 지원
- ✅ 동적으로 height가 변하는 TextEditor
- ✅ Custom Font 적용 가능
---

## 🛠 Requirements

- iOS 15+
- SwiftUI

---

## 📦 Installation

### Swift Package Manager (SPM)

```swift
dependencies: [
    .package(url: "https://github.com/your-id/DynamicTextEditor.git", branch: "main")
]
```
---

## 🚀 Usage

```swift
import SwiftUI

@State private var text: String = ""

var body: some View {
    DynamicTextEditor("메시지를 입력하세요", text: $text)
}
```
## 🎛 Modifier API

DynamicTextEditor는 SwiftUI의 Modifier 스타일 API로 다양한 속성을 설정할 수 있습니다.
### 🔤 `setFont(uiFont:)`

사용할 UIFont를 설정합니다.

```swift
DynamicTextEditor("입력", text: $text)
    .setFont(uiFont: .systemFont(ofSize: 16, weight: .medium))
```

### 📏 `setMaxLineCount(_:)`

최대 줄 수를 설정합니다. 기본값은 5입니다.

```swift
DynamicTextEditor("입력", text: $text)
    .setMaxLineCount(3)
````

### 🎨 `setForegroundColor(_:)`

텍스트 색상을 설정합니다. 기본값은 .black입니다.

```swift
DynamicTextEditor("입력", text: $text)
    .setForegroundColor(.gray)
```

🧪 커스텀 예시

```swift
DynamicTextEditor("댓글을 입력하세요", text: $text)
    .setFont(uiFont: .systemFont(ofSize: 14))
    .setMaxLineCount(4)
    .setForegroundColor(.blue)
```
