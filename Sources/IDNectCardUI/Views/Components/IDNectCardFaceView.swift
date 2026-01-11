import SwiftUI

struct IDNectCardFaceView: View {
    let face: IDNectCardFace
    let data: IDNectCardData
    let style: IDNectCardStyle
    let showsQrEnlargeButton: Bool
    let onTapQrEnlarge: (() -> Void)?

    init(
        face: IDNectCardFace,
        data: IDNectCardData,
        style: IDNectCardStyle,
        showsQrEnlargeButton: Bool = false,
        onTapQrEnlarge: (() -> Void)? = nil
    ) {
        self.face = face
        self.data = data
        self.style = style
        self.showsQrEnlargeButton = showsQrEnlargeButton
        self.onTapQrEnlarge = onTapQrEnlarge
    }

    var body: some View {
        switch face {
        case .front:
            frontFace
        case .back:
            backFace
        }
    }

    private var frontFace: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: style.cornerRadius)
                .fill(style.frontFaceBackgroundColor)
                .frame(width: style.cardSize.width, height: style.cardSize.height)
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: style.codeContainerCornerRadius)
                        .fill(style.codeContainerColor)
                        .frame(width: style.codeContainerSize.width, height: style.codeContainerSize.height)
                        .shadow(color: style.codeContainerShadowColor, radius: style.codeContainerShadowRadius, x: style.codeContainerShadowOffset.width, y: style.codeContainerShadowOffset.height)
                    IDNectCodeImage(
                        code: data.qrCodeString,
                        type: data.codeType,
                        size: style.codeSize,
                        cornerRadius: style.codeCornerRadius,
                        foregroundColor: style.codeForegroundColor,
                        backgroundColor: style.codeBackgroundColor
                    )
                }
                .padding(.top, 15)

                Text(data.userHandle)
                    .font(style.userHandleFont)
                    .foregroundColor(style.textColor)
                    .shadow(color: style.textShadowColor, radius: style.textShadowRadius, x: style.textShadowOffset.width, y: style.textShadowOffset.height)
                    .padding(.bottom, 15)
            }
            .frame(width: style.cardSize.width, height: style.cardSize.height)

            if showsQrEnlargeButton {
                Button(action: { onTapQrEnlarge?() }) {
                    Image(systemName: "viewfinder")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(style.textColor.opacity(0.8))
                        .padding()
                }
            }
        }
    }

    private var backFace: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: style.cornerRadius)
                .fill(style.backFaceBackgroundColor)
                .frame(width: style.cardSize.width, height: style.cardSize.height)
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(data.userName)
                        .font(style.userNameFont)
                    Text("@\(data.userId)")
                        .font(style.userIdFont)
                    Spacer()
                }
                .foregroundColor(style.textColor)
                .shadow(color: style.textShadowColor.opacity(0.7), radius: style.textShadowRadius, x: style.textShadowOffset.width, y: style.textShadowOffset.height)

                Spacer()
                IDNectCardGameListView(games: data.games, isLoading: data.isLoading, textColor: style.textColor, font: style.gameNameFont, size: style.gameListSize)
            }
            .padding(12)

            if style.showProfileLink {
                IDNectCardProfileLink(urlString: data.profileURL, textColor: style.textColor, font: style.profileLinkFont)
                    .frame(maxWidth: .infinity, alignment: style.profileLinkAlignment)
                    .padding(style.profileLinkPadding)
            }

            HStack {
                Spacer()
                VStack {
                    Spacer()
                    IDNectCodeImage(
                        code: data.qrCodeString,
                        type: data.codeType,
                        size: style.codeSmallSize,
                        cornerRadius: style.codeCornerRadius,
                        foregroundColor: style.codeForegroundColor,
                        backgroundColor: style.codeBackgroundColor
                    )
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .frame(width: style.cardSize.width, height: style.cardSize.height)
    }
}
