import SwiftUI

struct IDNectCardProfileLink: View {
    let urlString: String?
    let textColor: Color
    let font: Font

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
        .font(font)
        .foregroundColor(textColor)
        .underline()
        .lineLimit(1)
    }
}
