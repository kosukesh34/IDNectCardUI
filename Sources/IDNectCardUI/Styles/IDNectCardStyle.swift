import SwiftUI

public struct IDNectCardStyle {
    public var cardColor: Color
    public var textColor: Color
    public var cornerRadius: CGFloat
    public var cardSize: CGSize
    public var qrSize: CGFloat
    public var qrSmallSize: CGFloat
    public var codeSize: CGSize
    public var codeSmallSize: CGSize
    public var codeCornerRadius: CGFloat
    public var codeBackgroundColor: Color
    public var codeForegroundColor: Color
    public var codeContainerSize: CGSize
    public var codeContainerCornerRadius: CGFloat
    public var codeContainerColor: Color
    public var codeContainerShadowColor: Color
    public var codeContainerShadowRadius: CGFloat
    public var codeContainerShadowOffset: CGSize
    public var logoSize: CGFloat
    public var logoCornerRadius: CGFloat
    public var logoBackgroundColor: Color
    public var logoPadding: EdgeInsets
    public var gameListSize: CGSize
    public var showProfileLink: Bool
    public var backgroundGradientColors: [Color]
    public var highlightGradientColors: [Color]
    public var borderGradientColors: [Color]
    public var borderWidth: CGFloat
    public var shadowColor: Color
    public var shadowRadius: CGFloat
    public var shadowOffset: CGSize
    public var secondaryShadowColor: Color
    public var secondaryShadowRadius: CGFloat
    public var secondaryShadowOffset: CGSize
    public var textShadowColor: Color
    public var textShadowRadius: CGFloat
    public var textShadowOffset: CGSize
    public var userHandleFont: Font
    public var userNameFont: Font
    public var userIdFont: Font
    public var gameNameFont: Font
    public var profileLinkFont: Font
    public var showsShimmer: Bool
    public var shimmerDuration: Double

    public init(
        cardColor: Color = Color(red: 0.792, green: 0.702, blue: 0.443),
        textColor: Color = .white,
        cornerRadius: CGFloat = 25,
        cardSize: CGSize = CGSize(width: 350, height: 220),
        qrSize: CGFloat = 120,
        qrSmallSize: CGFloat = 45,
        codeSize: CGSize? = nil,
        codeSmallSize: CGSize? = nil,
        codeCornerRadius: CGFloat = 8,
        codeBackgroundColor: Color = .white,
        codeForegroundColor: Color = .black,
        codeContainerSize: CGSize? = nil,
        codeContainerCornerRadius: CGFloat = 12,
        codeContainerColor: Color = .white,
        codeContainerShadowColor: Color = Color.black.opacity(0.1),
        codeContainerShadowRadius: CGFloat = 3,
        codeContainerShadowOffset: CGSize = CGSize(width: 0, height: 2),
        logoSize: CGFloat = 45,
        logoCornerRadius: CGFloat = 10,
        logoBackgroundColor: Color = Color.white.opacity(0.9),
        logoPadding: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 15),
        gameListSize: CGSize = CGSize(width: 200, height: 120),
        showProfileLink: Bool = true,
        backgroundGradientColors: [Color]? = nil,
        highlightGradientColors: [Color]? = nil,
        borderGradientColors: [Color]? = nil,
        borderWidth: CGFloat = 1,
        shadowColor: Color = Color.black.opacity(0.3),
        shadowRadius: CGFloat = 20,
        shadowOffset: CGSize = CGSize(width: 0, height: 10),
        secondaryShadowColor: Color = Color.black.opacity(0.1),
        secondaryShadowRadius: CGFloat = 5,
        secondaryShadowOffset: CGSize = CGSize(width: 0, height: 2),
        textShadowColor: Color = Color.black.opacity(0.3),
        textShadowRadius: CGFloat = 1,
        textShadowOffset: CGSize = CGSize(width: 0, height: 1),
        userHandleFont: Font = .system(size: 14, weight: .medium, design: .rounded),
        userNameFont: Font = .system(size: 14, weight: .medium),
        userIdFont: Font = .system(size: 12, weight: .regular),
        gameNameFont: Font = .system(size: 12, weight: .medium),
        profileLinkFont: Font = .system(size: 10, weight: .regular),
        showsShimmer: Bool = true,
        shimmerDuration: Double = 5.0
    ) {
        self.cardColor = cardColor
        self.textColor = textColor
        self.cornerRadius = cornerRadius
        self.cardSize = cardSize
        self.qrSize = qrSize
        self.qrSmallSize = qrSmallSize
        self.codeSize = codeSize ?? CGSize(width: qrSize, height: qrSize)
        self.codeSmallSize = codeSmallSize ?? CGSize(width: qrSmallSize, height: qrSmallSize)
        self.codeCornerRadius = codeCornerRadius
        self.codeBackgroundColor = codeBackgroundColor
        self.codeForegroundColor = codeForegroundColor
        self.codeContainerSize = codeContainerSize ?? CGSize(width: qrSize + 20, height: qrSize + 20)
        self.codeContainerCornerRadius = codeContainerCornerRadius
        self.codeContainerColor = codeContainerColor
        self.codeContainerShadowColor = codeContainerShadowColor
        self.codeContainerShadowRadius = codeContainerShadowRadius
        self.codeContainerShadowOffset = codeContainerShadowOffset
        self.logoSize = logoSize
        self.logoCornerRadius = logoCornerRadius
        self.logoBackgroundColor = logoBackgroundColor
        self.logoPadding = logoPadding
        self.gameListSize = gameListSize
        self.showProfileLink = showProfileLink
        self.backgroundGradientColors = backgroundGradientColors ?? [
            cardColor.opacity(0.9),
            cardColor.opacity(0.7),
            cardColor.opacity(0.9)
        ]
        self.highlightGradientColors = highlightGradientColors ?? [
            Color.white.opacity(0.4),
            Color.white.opacity(0.1),
            Color.clear
        ]
        self.borderGradientColors = borderGradientColors ?? [
            Color.white.opacity(0.6),
            Color.white.opacity(0.2)
        ]
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.secondaryShadowColor = secondaryShadowColor
        self.secondaryShadowRadius = secondaryShadowRadius
        self.secondaryShadowOffset = secondaryShadowOffset
        self.textShadowColor = textShadowColor
        self.textShadowRadius = textShadowRadius
        self.textShadowOffset = textShadowOffset
        self.userHandleFont = userHandleFont
        self.userNameFont = userNameFont
        self.userIdFont = userIdFont
        self.gameNameFont = gameNameFont
        self.profileLinkFont = profileLinkFont
        self.showsShimmer = showsShimmer
        self.shimmerDuration = shimmerDuration
    }
}
