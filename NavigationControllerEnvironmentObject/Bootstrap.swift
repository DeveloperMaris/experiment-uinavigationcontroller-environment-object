//
//  Bootstrap.swift
//  NavigationControllerEnvironmentObject
//
//  Created by Maris Lagzdins on 05/01/2023.
//

import SwiftUI
import UIKit

@MainActor class Bootstrap {
    private let window: UIWindow
    private let profile: Profile

    init(window: UIWindow) {
        self.window = window
        self.profile = Profile()
    }

    func start() {
        window.rootViewController = UIHostingController(rootView: makeContentView())
        window.makeKeyAndVisible()
    }

    // MARK: - Menu

    /// A method which creates the SwiftUI view and wraps it inside the UINavigationController masked inside the UIViewControllerRepresentable struct.
    ///
    /// Masking UINavigationController in UIViewControllerRepresentable is necessary so that we would be able to inject the EnvironmentObject into it.
    /// - Returns: Navigation view as a swiftui view.
    private func makeContentView() -> some View {
        NavigationControllerView {
            UIHostingController(rootView: ContentView())
        } modifier: { controller in
            controller.navigationBar.prefersLargeTitles = true
        }
        .environmentObject(profile) // < Provide the environment object only once!!!
        .ignoresSafeArea()
    }
}

private struct NavigationControllerView<ViewController: UIViewController>: UIViewControllerRepresentable {
    /// A closure containing the instructions for SwiftUI view creation, which will be used as a root view for the navigation controller.
    var content: () -> ViewController

    /// An optional modifier closure for the navigation controller in which is possible to modify the UIKit's navigation controller properties.
    var modifier: ((UINavigationController) -> Void)?

    func makeUIViewController(context: Context) -> UINavigationController {
        let controller = UINavigationController(rootViewController: content())
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        modifier?(uiViewController)
    }

    @MainActor func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UINavigationControllerDelegate {
        func navigationController(
            _ navigationController: UINavigationController,
            didShow viewController: UIViewController,
            animated: Bool
        ) {
            viewController.navigationItem.backButtonDisplayMode = .generic
        }
    }
}
