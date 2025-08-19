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

### 기본 예시
```swift
import SwiftUI
import DynamicTextEditor

@State var text: String = ""

var body: some View {
    DynamicTextEditor("내용을 입력해주세요.", text: $text)
}
```

<img src="GIFs/Default_DynamicTextEditor.gif" width="300"/> 

### 카카오톡 클론 코딩 예시
```swift
import SwiftUI
import DynamicTextEditor

@State var text: String = ""

var body: some View {
    ...
    HStack(alignment: .bottom, spacing: 16) {
        DynamicTextEditor(
            "메시지 입력",
            text: $text
        )
        .setFont(uiFont: .systemFont(ofSize: 16))
        .setMaxLineCount(8)
        .setTextColor(.black)
        .setPlaceholderColor(.gray)
        .frame(minHeight: 24)

        emojiButton()
    }
    .padding(.vertical, 6)
    .padding(.horizontal, 8)
    .background(Color.textField_BG)
    .cornerRadius(20)
    ...
}
```

<img src="GIFs/DynamicTextEditor_clone_kakaotalk.gif" width="300"/> 

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

### 🎨 `setTextColor(_:)`

텍스트 색상을 설정합니다. 기본값은 '.black'입니다.

```swift
DynamicTextEditor("입력", text: $text)
    .setTextColor(.gray)
```

### 👤 `setPlcaeholderColor(_:)`

텍스트 색상을 설정합니다. 기본값은 '.gray'입니다.

```swift
DynamicTextEditor("입력", text: $text)
    .setPlaceholderColor(.black)
```

🧪 커스텀 예시

```swift
DynamicTextEditor("댓글을 입력하세요", text: $text)
    .setFont(uiFont: .systemFont(ofSize: 14))
    .setMaxLineCount(4)
    .setTextColor(.blue)
    .setPlaceholder(.red)
```
