//
//  Publishers.swift
//  
//
//  Created by LiYanan2004 on 2020/1/19.
//

import SwiftUI
import Combine


/// Important: You also need to add `@Environment(\.colorScheme)` to receive the notifications
@available(iOS 13.0, *)
public var colorSchemeDidChange: AnyPublisher<UIUserInterfaceStyle, Never> {
    UITraitCollection.current.publisher(for: \.userInterfaceStyle)
        .map { $0 }
        .eraseToAnyPublisher()
}
