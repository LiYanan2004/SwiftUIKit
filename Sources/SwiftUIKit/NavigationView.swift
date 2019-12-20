//
//  File.swift
//  
//
//  Created by LiYanan2004 on 2019/12/20.
//
import SwiftUI

@available(iOS 13.0, *)
struct navigationViewController<Content: View>: UIViewControllerRepresentable {

    @Binding var searchForText: String
    var navigationBarTitle: String? = nil
    var searchBarPlaceHolder: String? = nil
    var NavigationBarTitleDisplayMode = NavigationBarItem.TitleDisplayMode.large
    var searchResultView: AnyView? = nil
    var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        _searchForText = .constant("")
    }

    func makeCoordinator() -> navigationViewController.Coordinator {
        return Coordinator(searchForText: $searchForText)
    }

    class Coordinator: NSObject, UISearchResultsUpdating {
        @Binding var searchForText: String
        init(searchForText: Binding<String>) {
            _searchForText = searchForText
        }

        func updateSearchResults(for searchController: UISearchController) {
            self.searchForText = searchController.searchBar.text ?? ""
        }
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<navigationViewController>) -> UINavigationController {

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

    func updateUIViewController(_ vc: UINavigationController, context: UIViewControllerRepresentableContext<navigationViewController>) {
        // Update UIVIew Controller
    }

    func navigationContollerTitle(_ title: String, displayMode: NavigationBarItem.TitleDisplayMode = .large) -> navigationViewController {
        var modifier = self
        modifier.navigationBarTitle = title
        modifier.NavigationBarTitleDisplayMode = displayMode
        return modifier
    }

    func searchBarPlaceHolder(_ text: String) -> navigationViewController {
        var modifier = self
        modifier.searchBarPlaceHolder = text
        return modifier
    }

    func addSearchController(searchForText: Binding<String>, resultView: AnyView) -> navigationViewController {
        var modifier = self
        modifier.searchResultView = resultView
        modifier._searchForText = searchForText
        return modifier
    }
}
