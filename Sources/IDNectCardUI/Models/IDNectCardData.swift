import SwiftUI

public struct IDNectCardData {
    public var userName: String
    public var userHandle: String
    public var userId: String
    public var qrCodeString: String
    public var codeType: IDNectCodeType
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
        codeType: IDNectCodeType = .qr,
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
        self.codeType = codeType
        self.profileURL = profileURL
        self.games = games
        self.isLoading = isLoading
        self.logo = logo
        self.showsLogo = showsLogo
    }
}
