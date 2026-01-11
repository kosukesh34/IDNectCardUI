import SwiftUI

public struct IDNectCodeImage: View {
    private let code: String
    private let type: IDNectCodeType
    private let size: CGSize
    private let cornerRadius: CGFloat
    private let foregroundColor: Color
    private let backgroundColor: Color

    public init(
        code: String,
        type: IDNectCodeType = .qr,
        size: CGSize,
        cornerRadius: CGFloat = 8,
        foregroundColor: Color = .black,
        backgroundColor: Color = .white
    ) {
        self.code = code
        self.type = type
        self.size = size
        self.cornerRadius = cornerRadius
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        Image(uiImage: IDNectCodeGenerator.generate(from: code, type: type, size: size, foregroundColor: foregroundColor, backgroundColor: backgroundColor))
            .resizable()
            .interpolation(.none)
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

public struct IDNectQRCodeImage: View {
    private let code: String
    private let size: CGFloat
    private let cornerRadius: CGFloat
    private let backgroundColor: Color
    private let foregroundColor: Color

    public init(
        code: String,
        size: CGFloat,
        cornerRadius: CGFloat = 8,
        foregroundColor: Color = .black,
        backgroundColor: Color = .white
    ) {
        self.code = code
        self.size = size
        self.cornerRadius = cornerRadius
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        IDNectCodeImage(
            code: code,
            type: .qr,
            size: CGSize(width: size, height: size),
            cornerRadius: cornerRadius,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor
        )
    }
}
