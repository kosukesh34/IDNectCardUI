# IDNectCardUI

Reusable SwiftUI card UI for IDNect-style profile cards.

## English

### Features
- Flip card (front/back)
- QR code rendering
- Customizable colors, sizes, corner radius, and shimmer
- Optional logo and game list

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
    showsShimmer: true
)

IDNectCardView(
    data: data,
    style: style,
    showsQrEnlargeButton: true
)
```

### Customization
You can customize:
- Colors (`cardColor`, `textColor`)
- Size (`cardSize`, `qrSize`, `qrSmallSize`)
- Corner radius (`cornerRadius`)
- Logo (`logo`, `showsLogo`)
- Shimmer (`showsShimmer`, `shimmerDuration`)

---

## 日本語

### 特徴
- カードのフリップ（表/裏）
- QRコード描画
- 色・サイズ・角丸・シマーのカスタマイズ
- ロゴやゲーム一覧の表示

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
    showsShimmer: true
)

IDNectCardView(
    data: data,
    style: style,
    showsQrEnlargeButton: true
)
```

### カスタマイズ可能な項目
- 色（`cardColor`, `textColor`）
- サイズ（`cardSize`, `qrSize`, `qrSmallSize`）
- 角丸（`cornerRadius`）
- ロゴ（`logo`, `showsLogo`）
- シマー（`showsShimmer`, `shimmerDuration`）

## License
MIT
