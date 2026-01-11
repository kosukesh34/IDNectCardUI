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

### Custom Back Content
```swift
IDNectCardView(
    data: data,
    style: style,
    backContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 8) {
                Text("Member Card").font(.headline)
                Text("ID: 1234-5678")
                Text("Expires: 2027-12-31")
            }
            .padding(16)
        )
    }
)
```

### Front Content (Frame Only)
```swift
IDNectCardView(
    data: data,
    style: style,
    frontContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 8) {
                Text("Write anything here")
                Text("This replaces the default front layout.")
            }
            .padding(16)
        )
    }
)
```

### Front Content Examples

#### Membership Card
```swift
IDNectCardView(
    data: data,
    style: style,
    frontContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("MEMBER")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                    Spacer()
                    Text("GOLD").font(.caption2)
                }
                Text("Jane Doe").font(.title3).bold()
                Text("ID: 1234-5678").font(.footnote)
                Spacer()
                Text("Valid thru 12/2027").font(.caption)
            }
            .padding(16)
        )
    }
)
```

#### Game Card
```swift
IDNectCardView(
    data: data,
    style: style,
    frontContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "gamecontroller.fill")
                    Text("Game Pass").font(.headline)
                    Spacer()
                    Text("Lv. 42").font(.caption)
                }
                Text("Player: @jane").font(.subheadline)
                Text("Playtime: 148h").font(.footnote)
                Spacer()
                Text("Achievement: 87%").font(.caption)
            }
            .padding(16)
        )
    }
)
```

### UIKit Usage
```swift
import UIKit
import SwiftUI
import IDNectCardUI

let data = IDNectCardData(
    userName: "Jane Doe",
    userHandle: "@jane",
    userId: "jane_id",
    qrCodeString: "IDNect://user?id=uuid"
)

let cardView = IDNectCardView(data: data)
let hostingController = UIHostingController(rootView: cardView)
present(hostingController, animated: true)
```

### Flat Back (No 3D Flip)
```swift
let flatStyle = IDNectCardStyle(
    uses3DFlip: false,
    allowsFlipAnimation: false
)
```

### Back Content Examples

#### Business Card
```swift
IDNectCardView(
    data: data,
    style: style,
    backContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 8) {
                Text("Jane Doe").font(.title2).bold()
                Text("Product Designer").font(.subheadline)
                Divider()
                Text("jane@example.com")
                Text("+1 555-123-4567")
                Text("San Francisco, CA")
            }
            .padding(16)
        )
    }
)
```

#### Self Introduction
```swift
IDNectCardView(
    data: data,
    style: style,
    backContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 10) {
                Text("Hi! I'm Jane.").font(.headline)
                Text("I love indie games and UI design.").font(.subheadline)
                Text("Favorite titles: Hades, Hollow Knight").font(.footnote)
                Text("Let's connect!").font(.callout)
            }
            .padding(16)
        )
    }
)
```

#### Credit Card Style
```swift
let creditStyle = IDNectCardStyle(
    cardColor: .black,
    textColor: .white,
    cornerRadius: 20,
    showsShimmer: false,
    frontFaceBackgroundColor: .black,
    backFaceBackgroundColor: .black
)

IDNectCardView(
    data: data,
    style: creditStyle,
    backContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 12) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white.opacity(0.8))
                    .frame(height: 32)
                HStack {
                    Text("1234 5678 9012 3456").font(.headline)
                    Spacer()
                }
                HStack {
                    Text("JANE DOE").font(.subheadline)
                    Spacer()
                    Text("12/27").font(.subheadline)
                }
            }
            .padding(16)
        )
    }
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
- Animations (`showsShimmer`, `shimmerDuration`, `allowsFlipAnimation`, `flipAnimationDuration`, `uses3DFlip`)
- Back face visibility (`showsBackFace`)

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

### 裏面のカスタム表示
```swift
IDNectCardView(
    data: data,
    style: style,
    backContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 8) {
                Text("会員証").font(.headline)
                Text("ID: 1234-5678")
                Text("有効期限: 2027-12-31")
            }
            .padding(16)
        )
    }
)
```

### 表面のカスタム表示（枠だけ使う）
```swift
IDNectCardView(
    data: data,
    style: style,
    frontContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 8) {
                Text("ここに自由に記入できます")
                Text("デフォルトの表面レイアウトを置き換えます。")
            }
            .padding(16)
        )
    }
)
```

### 表面サンプル

#### 会員証
```swift
IDNectCardView(
    data: data,
    style: style,
    frontContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("MEMBER")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                    Spacer()
                    Text("GOLD").font(.caption2)
                }
                Text("Jane Doe").font(.title3).bold()
                Text("ID: 1234-5678").font(.footnote)
                Spacer()
                Text("有効期限: 2027/12").font(.caption)
            }
            .padding(16)
        )
    }
)
```

#### ゲームカード
```swift
IDNectCardView(
    data: data,
    style: style,
    frontContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "gamecontroller.fill")
                    Text("Game Pass").font(.headline)
                    Spacer()
                    Text("Lv. 42").font(.caption)
                }
                Text("Player: @jane").font(.subheadline)
                Text("プレイ時間: 148h").font(.footnote)
                Spacer()
                Text("達成率: 87%").font(.caption)
            }
            .padding(16)
        )
    }
)
```

### UIKitでの利用
```swift
import UIKit
import SwiftUI
import IDNectCardUI

let data = IDNectCardData(
    userName: "Jane Doe",
    userHandle: "@jane",
    userId: "jane_id",
    qrCodeString: "IDNect://user?id=uuid"
)

let cardView = IDNectCardView(data: data)
let hostingController = UIHostingController(rootView: cardView)
present(hostingController, animated: true)
```

### 3Dを使わない表示
```swift
let flatStyle = IDNectCardStyle(
    uses3DFlip: false,
    allowsFlipAnimation: false
)
```

### 裏面サンプル

#### 名刺
```swift
IDNectCardView(
    data: data,
    style: style,
    backContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 8) {
                Text("Jane Doe").font(.title2).bold()
                Text("プロダクトデザイナー").font(.subheadline)
                Divider()
                Text("jane@example.com")
                Text("+1 555-123-4567")
                Text("San Francisco, CA")
            }
            .padding(16)
        )
    }
)
```

#### 自己紹介
```swift
IDNectCardView(
    data: data,
    style: style,
    backContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 10) {
                Text("はじめまして、Janeです。").font(.headline)
                Text("インディーゲームとUIデザインが好きです。").font(.subheadline)
                Text("好きなタイトル: Hades, Hollow Knight").font(.footnote)
                Text("ぜひ繋がりましょう！").font(.callout)
            }
            .padding(16)
        )
    }
)
```

#### クレジットカード風
```swift
let creditStyle = IDNectCardStyle(
    cardColor: .black,
    textColor: .white,
    cornerRadius: 20,
    showsShimmer: false,
    frontFaceBackgroundColor: .black,
    backFaceBackgroundColor: .black
)

IDNectCardView(
    data: data,
    style: creditStyle,
    backContent: {
        AnyView(
            VStack(alignment: .leading, spacing: 12) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white.opacity(0.8))
                    .frame(height: 32)
                HStack {
                    Text("1234 5678 9012 3456").font(.headline)
                    Spacer()
                }
                HStack {
                    Text("JANE DOE").font(.subheadline)
                    Spacer()
                    Text("12/27").font(.subheadline)
                }
            }
            .padding(16)
        )
    }
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
- アニメーション（`showsShimmer`, `shimmerDuration`, `allowsFlipAnimation`, `flipAnimationDuration`, `uses3DFlip`）
- 裏面の非表示（`showsBackFace`）

## License
MIT
