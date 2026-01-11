import SwiftUI

struct IDNectCardGameListView: View {
    let games: [IDNectCardGame]
    let isLoading: Bool
    let textColor: Color
    let font: Font
    let size: CGSize

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
                                .font(font)
                                .lineLimit(1)
                            Spacer()
                        }
                    }
                }
            }
        }
        .foregroundColor(textColor)
        .frame(width: size.width, height: size.height)
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
