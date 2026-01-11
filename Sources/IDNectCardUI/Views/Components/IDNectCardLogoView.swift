import SwiftUI

struct IDNectCardLogoView: View {
    let logo: Image?
    let style: IDNectCardStyle

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: style.logoCornerRadius)
                        .fill(style.logoBackgroundColor)
                        .frame(width: style.logoSize, height: style.logoSize)
                        .shadow(color: style.shadowColor.opacity(0.6), radius: 3, x: 0, y: 2)
                    if let logo = logo {
                        logo
                            .resizable()
                            .scaledToFit()
                            .frame(width: style.logoSize, height: style.logoSize)
                            .clipShape(RoundedRectangle(cornerRadius: style.logoCornerRadius, style: .continuous))
                    }
                }
                .padding(style.logoPadding)
            }
        }
    }
}
