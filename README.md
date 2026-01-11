# IDNectCardUI

Reusable SwiftUI card UI for IDNect-style profile cards.

## English

### Features
- Flip card (front/back)
- QR code rendering
- Code128 barcode rendering
- Customizable colors, sizes, corner radius, and shimmer
- Optional logo and game list
- Customizable fonts, shadows, gradients, and profile link placement

### Installation (Swift Package Manager)
Add this repository in Xcode:

- File > Add Packages...
- Paste the repository URL
- Add `IDNectCardUI`

### Quick Start
```swift
import IDNectCardUI

let games = [
    IDNectCardGame(name: "Example Game", image: UIImage(named: "Example"))
]

let data = IDNectCardData(
    userName: "Jane Doe",
    userHandle: "@jane",
    userId: "jane_id",
    qrCodeString: "IDNect://user?id=uuid",
    codeType: .qr,
    profileURL: "https://example.com/profile/jane",
    games: games,
    isLoading: false,
    logo: Image("IDNect"),
    showsLogo: true
)

let style = IDNectCardStyle(
    cardColor: .black,
    textColor: .white,
    cornerRadius: 24,
    cardSize: CGSize(width: 360, height: 220),
    showsShimmer: true,
    allowsFlipAnimation: true
)

IDNectCardView(
    data: data,
    style: style,
    showsQrEnlargeButton: true
)
```

### Barcode Example (Code128)
```swift
let data = IDNectCardData(
    userName: "Jane Doe",
    userHandle: "@jane",
    userId: "jane_id",
    qrCodeString: "ID-NECT-0001",
    codeType: .code128,
    profileURL: "https://example.com/profile/jane"
)
```

### Customization
You can customize:
- Colors (`cardColor`, `textColor`, `codeForegroundColor`, `codeBackgroundColor`)
- Size (`cardSize`, `qrSize`, `qrSmallSize`, `codeSize`, `codeSmallSize`)
- Corner radius (`cornerRadius`, `codeCornerRadius`, `logoCornerRadius`)
- Background & gradients (`backgroundGradientColors`, `highlightGradientColors`)
- Shadows (`shadowColor`, `shadowRadius`, `secondaryShadowColor`)
- Fonts (`userHandleFont`, `userNameFont`, `userIdFont`, `gameNameFont`, `profileLinkFont`)
- Logo (`logo`, `showsLogo`, `logoSize`, `logoPadding`)
- Profile link position (`profileLinkAlignment`, `profileLinkPadding`, `showProfileLink`)
- Face backgrounds (`frontFaceBackgroundColor`, `backFaceBackgroundColor`)
- Animations (`showsShimmer`, `shimmerDuration`, `allowsFlipAnimation`, `flipAnimationDuration`)

---

## 日本語

### 特徴
- カードのフリップ（表/裏）
- QRコード描画
- Code128バーコード描画
- 色・サイズ・角丸・シマーのカスタマイズ
- ロゴやゲーム一覧の表示
- フォント、影、グラデーション、URL位置のカスタマイズ

### インストール（Swift Package Manager）
Xcodeでこのリポジトリを追加してください：

- File > Add Packages...
- リポジトリURLを貼り付け
- `IDNectCardUI` を追加

### 使い方
```swift
import IDNectCardUI

let games = [
    IDNectCardGame(name: "Example Game", image: UIImage(named: "Example"))
]

let data = IDNectCardData(
    userName: "Jane Doe",
    userHandle: "@jane",
    userId: "jane_id",
    qrCodeString: "IDNect://user?id=uuid",
    codeType: .qr,
    profileURL: "https://example.com/profile/jane",
    games: games,
    isLoading: false,
    logo: Image("IDNect"),
    showsLogo: true
)

let style = IDNectCardStyle(
    cardColor: .black,
    textColor: .white,
    cornerRadius: 24,
    cardSize: CGSize(width: 360, height: 220),
    showsShimmer: true,
    allowsFlipAnimation: true
)

IDNectCardView(
    data: data,
    style: style,
    showsQrEnlargeButton: true
)
```

### バーコード例（Code128）
```swift
let data = IDNectCardData(
    userName: "Jane Doe",
    userHandle: "@jane",
    userId: "jane_id",
    qrCodeString: "ID-NECT-0001",
    codeType: .code128,
    profileURL: "https://example.com/profile/jane"
)
```

### カスタマイズ可能な項目
- 色（`cardColor`, `textColor`, `codeForegroundColor`, `codeBackgroundColor`）
- サイズ（`cardSize`, `qrSize`, `qrSmallSize`, `codeSize`, `codeSmallSize`）
- 角丸（`cornerRadius`, `codeCornerRadius`, `logoCornerRadius`）
- 背景・グラデーション（`backgroundGradientColors`, `highlightGradientColors`）
- 影（`shadowColor`, `shadowRadius`, `secondaryShadowColor`）
- フォント（`userHandleFont`, `userNameFont`, `userIdFont`, `gameNameFont`, `profileLinkFont`）
- ロゴ（`logo`, `showsLogo`, `logoSize`, `logoPadding`）
- URL表示位置（`profileLinkAlignment`, `profileLinkPadding`, `showProfileLink`）
- 表裏背景（`frontFaceBackgroundColor`, `backFaceBackgroundColor`）
- アニメーション（`showsShimmer`, `shimmerDuration`, `allowsFlipAnimation`, `flipAnimationDuration`）

## License
MIT
