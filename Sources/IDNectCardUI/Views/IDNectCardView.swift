import SwiftUI

public enum IDNectCardFace {
    case front
    case back
}

public struct IDNectCardView: View {
    private let data: IDNectCardData
    private let style: IDNectCardStyle
    private let showsQrEnlargeButton: Bool
    private let onTapQrEnlarge: (() -> Void)?
    private let onFlip: ((Bool) -> Void)?
    private let externalFlipBinding: Binding<Bool>?
    private let backContent: (() -> AnyView)?

    @State private var internalFlipped: Bool
    @State private var rotation: Double
    @State private var shimmerProgress: CGFloat = -1.5

    public init(
        data: IDNectCardData,
        style: IDNectCardStyle = IDNectCardStyle(),
        isFlipped: Binding<Bool>? = nil,
        showsQrEnlargeButton: Bool = false,
        onTapQrEnlarge: (() -> Void)? = nil,
        onFlip: ((Bool) -> Void)? = nil,
        backContent: (() -> AnyView)? = nil
    ) {
        self.data = data
        self.style = style
        self.externalFlipBinding = isFlipped
        self.showsQrEnlargeButton = showsQrEnlargeButton
        self.onTapQrEnlarge = onTapQrEnlarge
        self.onFlip = onFlip
        self.backContent = backContent
        let initialFlipped = isFlipped?.wrappedValue ?? false
        self._internalFlipped = State(initialValue: initialFlipped)
        self._rotation = State(initialValue: initialFlipped ? 180 : 0)
    }

    public var body: some View {
        ZStack {
            IDNectCardBackgroundView(style: style, shimmerProgress: $shimmerProgress)
            if data.showsLogo && !isFlippedValue {
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

                IDNectCardFaceView(face: .back, data: data, style: style, backContent: backContent)
                    .scaleEffect(x: -1, y: 1)
                    .opacity(isFrontVisible ? 0 : 1)
            }
            .frame(width: style.cardSize.width, height: style.cardSize.height)
            .clipped()
        }
        .frame(width: style.cardSize.width, height: style.cardSize.height)
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0), perspective: 0.3)
        .contentShape(Rectangle())
        .onTapGesture { handleFlipTap() }
        .onAppear { startShimmerAnimationIfNeeded() }
        .onChange(of: style.showsShimmer) { newValue in
            if newValue {
                startShimmerAnimationIfNeeded()
            } else {
                shimmerProgress = -1.5
            }
        }
        .onChange(of: isFlippedValue) { newValue in
            let targetRotation = newValue ? 180.0 : 0.0
            if rotation != targetRotation {
                if style.allowsFlipAnimation {
                    withAnimation(.easeInOut(duration: style.flipAnimationDuration)) {
                        rotation = targetRotation
                    }
                } else {
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
        guard style.showsBackFace else { return }
        let newValue = !isFlippedValue
        if style.allowsFlipAnimation {
            withAnimation(.easeInOut(duration: style.flipAnimationDuration)) {
                rotation = newValue ? 180 : 0
                setIsFlipped(newValue)
            }
        } else {
            rotation = newValue ? 180 : 0
            setIsFlipped(newValue)
        }
        onFlip?(newValue)
    }

    private var isFlippedValue: Bool {
        guard style.showsBackFace else { return false }
        return externalFlipBinding?.wrappedValue ?? internalFlipped
    }

    private func setIsFlipped(_ newValue: Bool) {
        guard style.showsBackFace else {
            internalFlipped = false
            return
        }
        if let binding = externalFlipBinding {
            binding.wrappedValue = newValue
        } else {
            internalFlipped = newValue
        }
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
    private let backContent: (() -> AnyView)?

    @State private var shimmerProgress: CGFloat = -1.5

    public init(
        face: IDNectCardFace,
        data: IDNectCardData,
        style: IDNectCardStyle = IDNectCardStyle(),
        backContent: (() -> AnyView)? = nil
    ) {
        self.face = face
        self.data = data
        self.style = style
        self.backContent = backContent
    }

    public var body: some View {
        ZStack {
            IDNectCardBackgroundView(style: style, shimmerProgress: $shimmerProgress)
            if face == .front && data.showsLogo {
                IDNectCardLogoView(logo: data.logo, style: style)
            }
            IDNectCardFaceView(face: face, data: data, style: style, backContent: backContent)
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
