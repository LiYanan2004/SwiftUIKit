import SwiftUI
import SwiftUIKit

/// Create a NavigationView that can support SearchBar and more.
/// use .addSearchController to add an searchBar.
@available(iOS 13.0, *)
public struct navigationViewController<Content: View>: UIViewControllerRepresentable {

    @Binding var searchForText: String
    var navigationBarTitle: String? = nil
    var searchBarPlaceHolder: String? = nil
    var NavigationBarTitleDisplayMode = NavigationBarItem.TitleDisplayMode.large
    var searchResultView: AnyView? = nil
    var content: Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        _searchForText = .constant("")
    }

    public func makeCoordinator() -> navigationViewController.Coordinator {
        return Coordinator(searchForText: $searchForText)
    }

    public class Coordinator: NSObject, UISearchResultsUpdating {
        @Binding var searchForText: String
        public init(searchForText: Binding<String>) {
            _searchForText = searchForText
        }

        public func updateSearchResults(for searchController: UISearchController) {
            self.searchForText = searchController.searchBar.text ?? ""
        }
    }

    public func makeUIViewController(context: Context) -> UINavigationController {

        let vc = UIHostingController(rootView: content)
        let navVC = UINavigationController(rootViewController: vc)
        let resultVC = UIHostingController(rootView: searchResultView)
        let searchController = self.searchResultView != nil ? UISearchController(searchResultsController: resultVC) : nil

        navVC.viewControllers = [vc]
        navVC.topViewController?.title = self.navigationBarTitle
        navVC.navigationBar.prefersLargeTitles = (NavigationBarTitleDisplayMode == .large)
        navVC.topViewController?.navigationItem.searchController = searchController

        searchController?.automaticallyShowsCancelButton = true
        searchController?.searchResultsUpdater = context.coordinator.self
        if searchBarPlaceHolder != nil {
            searchController?.searchBar.placeholder = searchBarPlaceHolder
        }

        return navVC
    }

    public func updateUIViewController(_ vc: UINavigationController, context: Context) { }

    public func navigationContollerTitle(_ title: String, displayMode: NavigationBarItem.TitleDisplayMode = .large) -> navigationViewController {
        var modifier = self
        modifier.navigationBarTitle = title
        modifier.NavigationBarTitleDisplayMode = displayMode
        return modifier
    }

    public func searchBarPlaceHolder(_ text: String) -> navigationViewController {
        var modifier = self
        modifier.searchBarPlaceHolder = text
        return modifier
    }

    /// **searchForText**: A Binding value that provides what the user typed.
    /// **resultView**: A View that shows the search result.
    /// Note: You can write it as ** AnyVIew(YourView) **
    public func addSearchController(searchForText: Binding<String>, resultView: AnyView) -> navigationViewController {
        var modifier = self
        modifier.searchResultView = resultView
        modifier._searchForText = searchForText
        return modifier
    }
}
