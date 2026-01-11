import SwiftUI

struct IDNectCardBackgroundView: View {
    let style: IDNectCardStyle
    @Binding var shimmerProgress: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: style.cornerRadius)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: style.backgroundGradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: style.highlightGradientColors),
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
                            gradient: Gradient(colors: style.borderGradientColors),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: style.borderWidth
                    )
            )
            .shadow(color: style.shadowColor, radius: style.shadowRadius, x: style.shadowOffset.width, y: style.shadowOffset.height)
            .shadow(color: style.secondaryShadowColor, radius: style.secondaryShadowRadius, x: style.secondaryShadowOffset.width, y: style.secondaryShadowOffset.height)
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
