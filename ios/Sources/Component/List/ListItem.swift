import Styleguide
import SwiftUI

public struct ListItem: View {
    private struct Const {
        static let maximumShowingUser = 7
    }

    private let title: String
    private let tag: TagType
    private let imageURL: URL?
    // TODO: Replace with real value
    private let users: [URL]
    private let date: Date
    private let isFavorited: Bool
    private let tapFavoriteAction: () -> Void
    private let tapAction: () -> Void

    public init(
        title: String,
        tag: TagType,
        imageURL: URL?,
        users: [URL],
        date: Date,
        isFavorited: Bool,
        tapFavoriteAction: @escaping () -> Void,
        tapAction: @escaping () -> Void
    ) {
        self.title = title
        self.tag = tag
        self.imageURL = imageURL
        self.users = users
        self.date = date
        self.isFavorited = isFavorited
        self.tapFavoriteAction = tapFavoriteAction
        self.tapAction = tapAction
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Tag(type: tag) {
                // Set action if needed.
            }
            HStack(alignment: .top) {
                VStack(spacing: 8) {
                    ImageView(
                        imageURL: imageURL,
                        placeholderSize: .small
                    )
                    .frame(width: 100, height: 100)
                }
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(AssetColor.Base.primary.color)
                        .lineLimit(users.isEmpty ? 3 : 2)
                    if !users.isEmpty {
                        HStack(spacing: -4) {
                            ForEach(users, id: \.self) { _ in
                                Rectangle()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                            }
                            if users.count > Const.maximumShowingUser {
                                Text("+\(users.count - Const.maximumShowingUser)")
                                    .font(.caption)
                                    .padding(4)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    HStack {
                        Text(date.formatted)
                            .font(.caption)
                            .foregroundColor(AssetColor.Base.tertiary.color)
                        Spacer()
                        Button(action: tapFavoriteAction, label: {
                            let image = isFavorited ? AssetImage.iconFavorite.image : AssetImage.iconFavoriteOff.image
                            image
                                .renderingMode(.template)
                                .foregroundColor(AssetColor.primary.color)
                        })
                    }
                }
            }
        }
        .onTapGesture(perform: tapAction)
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListItem(
                title: "タイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイ...",
                tag: .droidKaigiFm,
                imageURL: nil,
                users: [],
                date: Date(timeIntervalSince1970: 0),
                isFavorited: true,
                tapFavoriteAction: {},
                tapAction: {}
            )
            .background(AssetColor.Background.primary.color)
            .environment(\.colorScheme, .dark)
            ListItem(
                title: "タイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイ...",
                tag: .droidKaigiFm,
                imageURL: nil,
                users: [],
                date: Date(timeIntervalSince1970: 0),
                isFavorited: true,
                tapFavoriteAction: {},
                tapAction: {}
            )
            .environment(\.colorScheme, .light)
            ListItem(
                title: "タイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイ...",
                tag: .droidKaigiFm,
                imageURL: nil,
                users: Array(repeating: URL(string: "https://example.com")!, count: 8),
                date: Date(timeIntervalSince1970: 0),
                isFavorited: true,
                tapFavoriteAction: {},
                tapAction: {}
            )
            .background(AssetColor.Background.primary.color)
            .environment(\.colorScheme, .dark)
            ListItem(
                title: "タイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイトルタイ...",
                tag: .droidKaigiFm,
                imageURL: nil,
                users: Array(repeating: URL(string: "https://example.com")!, count: 8),
                date: Date(timeIntervalSince1970: 0),
                isFavorited: true,
                tapFavoriteAction: {},
                tapAction: {}
            )
            .environment(\.colorScheme, .light)
        }
        .previewLayout(.sizeThatFits)
    }
}
