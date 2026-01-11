import SwiftUI
import UIKit
import CoreImage.CIFilterBuiltins

public struct IDNectCardGame: Identifiable, Equatable {
    public let id: String
    public let name: String
    public let image: UIImage?

    public init(id: String = UUID().uuidString, name: String, image: UIImage? = nil) {
        self.id = id
        self.name = name
        self.image = image
    }
}

public struct IDNectCardData {
    public var userName: String
    public var userHandle: String
    public var userId: String
    public var qrCodeString: String
    public var profileURL: String?
    public var games: [IDNectCardGame]
    public var isLoading: Bool
    public var logo: Image?
    public var showsLogo: Bool

    public init(
        userName: String,
        userHandle: String,
        userId: String,
        qrCodeString: String,
        profileURL: String? = nil,
        games: [IDNectCardGame] = [],
        isLoading: Bool = false,
        logo: Image? = nil,
        showsLogo: Bool = false
    ) {
        self.userName = userName
        self.userHandle = userHandle
        self.userId = userId
        self.qrCodeString = qrCodeString
        self.profileURL = profileURL
        self.games = games
        self.isLoading = isLoading
        self.logo = logo
        self.showsLogo = showsLogo
    }
}

public struct IDNectCardStyle {
    public var cardColor: Color
    public var textColor: Color
    public var cornerRadius: CGFloat
    public var cardSize: CGSize
    public var qrSize: CGFloat
    public var qrSmallSize: CGFloat
    public var logoSize: CGFloat
    public var showsShimmer: Bool
    public var shimmerDuration: Double

    public init(
        cardColor: Color = Color(red: 0.792, green: 0.702, blue: 0.443),
        textColor: Color = .white,
        cornerRadius: CGFloat = 25,
        cardSize: CGSize = CGSize(width: 350, height: 220),
        qrSize: CGFloat = 120,
        qrSmallSize: CGFloat = 45,
        logoSize: CGFloat = 45,
        showsShimmer: Bool = true,
        shimmerDuration: Double = 5.0
    ) {
        self.cardColor = cardColor
        self.textColor = textColor
        self.cornerRadius = cornerRadius
        self.cardSize = cardSize
        self.qrSize = qrSize
        self.qrSmallSize = qrSmallSize
        self.logoSize = logoSize
        self.showsShimmer = showsShimmer
        self.shimmerDuration = shimmerDuration
    }
}

public enum IDNectCardFace {
    case front
    case back
}

public struct IDNectCardView: View {
    @Binding private var isFlipped: Bool

    private let data: IDNectCardData
    private let style: IDNectCardStyle
    private let showsQrEnlargeButton: Bool
    private let onTapQrEnlarge: (() -> Void)?
    private let onFlip: ((Bool) -> Void)?

    @State private var rotation: Double
    @State private var shimmerProgress: CGFloat = -1.5

    public init(
        data: IDNectCardData,
        style: IDNectCardStyle = IDNectCardStyle(),
        isFlipped: Binding<Bool> = .constant(false),
        showsQrEnlargeButton: Bool = false,
        onTapQrEnlarge: (() -> Void)? = nil,
        onFlip: ((Bool) -> Void)? = nil
    ) {
        self.data = data
        self.style = style
        self._isFlipped = isFlipped
        self.showsQrEnlargeButton = showsQrEnlargeButton
        self.onTapQrEnlarge = onTapQrEnlarge
        self.onFlip = onFlip
        self._rotation = State(initialValue: isFlipped.wrappedValue ? 180 : 0)
    }

    public var body: some View {
        ZStack {
            IDNectCardBackgroundView(style: style, shimmerProgress: $shimmerProgress)
            if data.showsLogo && !isFlipped {
                IDNectCardLogoView(logo: data.logo, size: style.logoSize)
            }
            ZStack {
                IDNectCardFaceView(
                    face: .front,
                    data: data,
                    style: style,
                    showsQrEnlargeButton: showsQrEnlargeButton,
                    onTapQrEnlarge: onTapQrEnlarge
                )
                .opacity(isFrontVisible ? 1 : 0)

                IDNectCardFaceView(face: .back, data: data, style: style)
                    .scaleEffect(x: -1, y: 1)
                    .opacity(isFrontVisible ? 0 : 1)
            }
            .frame(width: style.cardSize.width, height: style.cardSize.height)
            .clipped()
        }
        .frame(width: style.cardSize.width, height: style.cardSize.height)
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0), perspective: 0.3)
        .onTapGesture { handleFlipTap() }
        .onAppear { startShimmerAnimationIfNeeded() }
        .onChange(of: style.showsShimmer) { newValue in
            if newValue {
                startShimmerAnimationIfNeeded()
            } else {
                shimmerProgress = -1.5
            }
        }
        .onChange(of: isFlipped) { newValue in
            let targetRotation = newValue ? 180.0 : 0.0
            if rotation != targetRotation {
                withAnimation(.easeInOut(duration: 0.6)) {
                    rotation = targetRotation
                }
            }
        }
    }

    private var isFrontVisible: Bool {
        let normalized = abs(rotation.truncatingRemainder(dividingBy: 360))
        return normalized < 90 || normalized > 270
    }

    private func handleFlipTap() {
        let newValue = !isFlipped
        withAnimation(.easeInOut(duration: 0.6)) {
            rotation = newValue ? 180 : 0
            isFlipped = newValue
        }
        onFlip?(newValue)
    }

    private func startShimmerAnimationIfNeeded() {
        guard style.showsShimmer else { return }
        withAnimation(.linear(duration: style.shimmerDuration).repeatForever(autoreverses: false)) {
            shimmerProgress = 1.5
        }
    }
}

public struct IDNectCardSnapshotView: View {
    private let face: IDNectCardFace
    private let data: IDNectCardData
    private let style: IDNectCardStyle

    @State private var shimmerProgress: CGFloat = -1.5

    public init(face: IDNectCardFace, data: IDNectCardData, style: IDNectCardStyle = IDNectCardStyle()) {
        self.face = face
        self.data = data
        self.style = style
    }

    public var body: some View {
        ZStack {
            IDNectCardBackgroundView(style: style, shimmerProgress: $shimmerProgress)
            if face == .front && data.showsLogo {
                IDNectCardLogoView(logo: data.logo, size: style.logoSize)
            }
            IDNectCardFaceView(face: face, data: data, style: style)
        }
        .frame(width: style.cardSize.width, height: style.cardSize.height)
        .onAppear { startShimmerAnimationIfNeeded() }
    }

    private func startShimmerAnimationIfNeeded() {
        guard style.showsShimmer else { return }
        withAnimation(.linear(duration: style.shimmerDuration).repeatForever(autoreverses: false)) {
            shimmerProgress = 1.5
        }
    }
}

public struct IDNectQRCodeImage: View {
    private let code: String
    private let size: CGFloat
    private let cornerRadius: CGFloat
    private let backgroundColor: Color

    public init(
        code: String,
        size: CGFloat,
        cornerRadius: CGFloat = 8,
        backgroundColor: Color = .white
    ) {
        self.code = code
        self.size = size
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        Image(uiImage: IDNectQRCodeGenerator.generate(from: code))
            .resizable()
            .interpolation(.none)
            .aspectRatio(1, contentMode: .fit)
            .frame(width: size, height: size)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

private struct IDNectCardBackgroundView: View {
    let style: IDNectCardStyle
    @Binding var shimmerProgress: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: style.cornerRadius)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        style.cardColor.opacity(0.9),
                        style.cardColor.opacity(0.7),
                        style.cardColor.opacity(0.9)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.4),
                                .white.opacity(0.1),
                                .clear
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .blendMode(.overlay)
            )
            .overlay(shimmerOverlay)
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.6),
                                .white.opacity(0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }

    private var shimmerOverlay: some View {
        Group {
            if style.showsShimmer {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .clear,
                                Color.white.opacity(0.5),
                                .clear
                            ]),
                            startPoint: UnitPoint(x: shimmerProgress, y: 0),
                            endPoint: UnitPoint(x: shimmerProgress + 0.5, y: 1)
                        )
                    )
                    .mask(RoundedRectangle(cornerRadius: style.cornerRadius))
            }
        }
    }
}

private struct IDNectCardLogoView: View {
    let logo: Image?
    let size: CGFloat

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.9))
                        .frame(width: size, height: size)
                        .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                    if let logo = logo {
                        logo
                            .resizable()
                            .scaledToFit()
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                }
                .padding([.trailing, .bottom], 15)
            }
        }
    }
}

private struct IDNectCardFaceView: View {
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
            VStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                        .frame(width: style.qrSize + 20, height: style.qrSize + 20)
                    IDNectQRCodeImage(code: data.qrCodeString, size: style.qrSize, cornerRadius: 8)
                }
                .padding(.top, 15)

                Text(data.userHandle)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(style.textColor)
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
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
            HStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(data.userName)
                        .font(.system(size: 14, weight: .medium))
                    Text("@\(data.userId)")
                        .font(.system(size: 12, weight: .regular))
                    Spacer()
                }
                .foregroundColor(style.textColor)
                .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)

                Spacer()
                IDNectCardGameListView(games: data.games, isLoading: data.isLoading, textColor: style.textColor)
            }
            .padding(12)

            HStack {
                IDNectCardProfileLink(urlString: data.profileURL, textColor: style.textColor)
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)

            HStack {
                Spacer()
                VStack {
                    Spacer()
                    IDNectQRCodeImage(code: data.qrCodeString, size: style.qrSmallSize, cornerRadius: 5)
                        .padding(.trailing, 10)
                        .padding(.bottom, 10)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .frame(width: style.cardSize.width, height: style.cardSize.height)
    }
}

private struct IDNectCardGameListView: View {
    let games: [IDNectCardGame]
    let isLoading: Bool
    let textColor: Color

    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: textColor))
            } else {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(games) { game in
                        HStack(spacing: 10) {
                            Group {
                                if let image = game.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                } else {
                                    defaultGameIcon
                                }
                            }
                            .frame(width: 30, height: 30)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)

                            Text(game.name)
                                .font(.system(size: 12, weight: .medium))
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                }
            }
        }
        .foregroundColor(textColor)
        .frame(width: 200, height: 120)
    }

    private var defaultGameIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.white.opacity(0.2))
            Image(systemName: "gamecontroller.fill")
                .font(.system(size: 14))
        }
    }
}

private struct IDNectCardProfileLink: View {
    let urlString: String?
    let textColor: Color

    var body: some View {
        Group {
            if let urlString = urlString, let url = URL(string: urlString) {
                Link(urlString, destination: url)
            } else if let urlString = urlString {
                Text(urlString)
            } else {
                EmptyView()
            }
        }
        .font(.system(size: 10, weight: .regular))
        .foregroundColor(textColor)
        .underline()
        .lineLimit(1)
    }
}

private enum IDNectQRCodeGenerator {
    static func generate(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let scaledImage = outputImage.transformed(by: transform)
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
