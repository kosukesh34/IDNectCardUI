import SwiftUI

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
                IDNectCardLogoView(logo: data.logo, style: style)
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
                IDNectCardLogoView(logo: data.logo, style: style)
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
