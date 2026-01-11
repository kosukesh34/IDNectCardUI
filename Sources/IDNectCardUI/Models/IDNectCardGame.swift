import UIKit

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
