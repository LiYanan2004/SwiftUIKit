//
//  Popover.swift
//  
//
//  Created by LiYanan2004 on 2020/1/17.
//

import SwiftUI

@available(iOS 13.0, *)
public func showPopover(from rootView: UIViewController, to destination: AnyView, WindowSize: CGSize, rect: CGRect) {
    let destinationController = UIHostingController(rootView: destination)
    let delegate = PopoverConfiguration()
    let blankView = UIView(frame: rect.offsetBy(dx: 0, dy: (UIApplication.shared.windows.last?.safeAreaInsets.top)!))

    destinationController.preferredContentSize = WindowSize
    destinationController.modalPresentationStyle = .popover
    if let controller = destinationController.popoverPresentationController {

        // override the delegate to make sure it can show up as popover style on iPhone.
        controller.delegate = delegate

        // Create a blank view as the sourceView
        rootView.view.addSubview(blankView)
        controller.sourceView = blankView
    }

    rootView.present(destinationController, animated: true)
}

public class PopoverConfiguration: NSObject, UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

public struct ElementsRectPreferenceData: Equatable {
    public let rect: CGRect
}

public struct ElementsRectPreferenceKey: PreferenceKey {
    public typealias Value = [ElementsRectPreferenceData]

    public static var defaultValue: [ElementsRectPreferenceData] = []

    public static func reduce(value: inout [ElementsRectPreferenceData], nextValue: () -> [ElementsRectPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

@available(iOS 13.0, *)
public struct prefrenceSetter: View {
    public let coordinateSpaceName: String
    public var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: ElementsRectPreferenceKey.self,
                            value: [ElementsRectPreferenceData(rect: geometry.frame(in: .named(self.coordinateSpaceName)))])
        }
    }
}

@available(iOS 13.0, *)
public struct locationPrefrence: ViewModifier {
    @Binding var rect: CGRect
    let coordinateSpaceName: String

    public init(rect: Binding<CGRect>, coordinateSpaceName: String) {
        _rect = rect
        self.coordinateSpaceName = coordinateSpaceName
    }

    public func body(content: Content) -> some View {
        content
            .background(prefrenceSetter(coordinateSpaceName: self.coordinateSpaceName))
            .onPreferenceChange(ElementsRectPreferenceKey.self) { preference in
                self.rect = preference[0].rect
            }
    }
}
