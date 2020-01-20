import SwiftUI
//import Combine
//
///// Animate the View(s) with the Spring Animation when the keyboard `pops up` or `retracts`.
///// Tips: Only use this ViewModifier on `TextField`, or the final effect may not be as expected.
//@available(iOS 13.0, *)
//public struct KeyboardAnimated: ViewModifier {
//
//    public init() { }
//    
//    @State private var keyboardHeight = CGFloat()
//    public var keyBoardHeightPublisher: AnyPublisher<CGFloat, Never> {
//        Publishers.Merge(
//            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
//                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
//                .map { $0.height },
//
//            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
//                .map{ _ in CGFloat(0)}
//        ).eraseToAnyPublisher()
//    }
//
//    public func body(content: Content) -> some View {
//        content
//            .padding(.bottom, keyboardHeight)
//            .animation(Animation.spring(response: 0.4, dampingFraction: 0.9, blendDuration: 1.0))
//            .onReceive(keyBoardHeightPublisher) { self.keyboardHeight = $0 }
//    }
//}
