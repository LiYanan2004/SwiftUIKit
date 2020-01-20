//
//  Publishers.swift
//  
//
//  Created by LiYanan2004 on 2020/1/19.
//

/// Important: You also need to add `@Environment(\.colorScheme)` to receive the notifications

import SwiftUI
import Combine

@available(iOS 13.0, *)
public var colorSchemeDidChange: AnyPublisher<UIUserInterfaceStyle, Never> {
    UITraitCollection.current.publisher(for: \.userInterfaceStyle)
        .map { $0 }
        .eraseToAnyPublisher()
}
