# Experiment of providing an environment object while using UINavigationController (iOS)

## SwiftUI situation

If the application uses `SwiftUI` navigation, 
then the EnvironmentObject needs to be provided for the navigation view, 
so that the EnvironmentObject would automatically be available to all pushed views in the navigation stack:

```swift
NavigationStack {
    ContentView()
}
.environmentObject(profile) // where Profile is an ObservableObject.
```

## UIKit situation

If the application uses `UIKit` navigation,
then the EnvironmentObject needs to be provided for the view,
because we can't provide it for the `UINavigationController`:

```swift
let view = ContentView()
    .environmentObject(profile) // where Profile is an ObservableObject.
    
let controller = UINavigationController(rootViewController: UIHostingController(rootView: view))
// show controller on the screen
```

This approach comes with a downside, that the EnvironmentObject will be available only in the `ContentView`,
but not in the other pushed views in the navigation stack.
You will need manually provide the EnvironmentObject to each of the pushed views in the navigation stack.

## UIKit solution

To solve this issue by wrapping the `UINavigationController` in a `UIViewControllerRepresentable` struct.
Provide an EnvironmentObject to this struct and place it into the `UIHostingController`.

```swift
struct CustomNavigationView<ViewController: UIViewController>: UIViewControllerRepresentable {
    var content: () -> ViewController
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: content())
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // modify navigation controller
    }
}

let view = CustomNavigationView { UIHostingController(rootView: ContentView()) }
    .environmentObject(profile) // where Profile is an ObservableObject.
    
let controller = UIHostingController(rootView: view)
// show controller on the screen
```

In the end we get a view hierarchy like this:

```swift
UIHostingController 
  > UINavigationController as UIViewRepresentable with environmentObject() 
    > UIHostingController 
      > some View
```

## Requirements

- Xcode 14.1.0
