# SwiftUI + UIKit

Use this repository, you can add some UIKit Elements to SwiftUI.



## Why I create this repository ?

Since swiftUI is still in its infancy, many uikit content is not included, so this repository was born.



## What components does it currently cover?

- [x] **NavigationView**

- [x] **Some View Modifiers**

- [ ] Scrollview

- [ ] UITextView

- [ ] UITextField

  

## Examples

### NavigationView with a searchBar

**Declare a variable to hold keywords**

```swift
@State var keywords = ""
```
**Create the NavigationView like this :**

```swift
navigationViewController {
  // The Content in NavigationView
}
.addSearchController(searchFor: $keywords, resultView: Anyview(ResultView))
.searchBarPlaceHolder("Search For Something")
```

**Notes:** 

- **ResultView is another View that will show the search result to Users.**
- **The “searchFor” parameter refers to the content of the keywords entered by the user**



## More

If you wants more components, you can [**Create an issure**](https://github.com/LiYanan2004/SwiftUIKit/issues/new).

If you have created some great components, you can [**Pull a Request to me**](https://github.com/LiYanan2004/SwiftUIKit/pulls).
