// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

/// `AnimatedLauncherUI` is a SwiftUI `Scene` for iOS apps that displays an animated launch screen overlay when your app starts.
///
/// The launcher displays a customizable logo, background, and animation, using information from your app’s configuration.
/// Once the animation completes, your main content appears.
///
/// ### Type Parameters
/// - `RootView`: The main content view of your app (displayed after the launcher animation).
/// - `Logo`: The logo or view shown in the center during the launcher animation.
///
/// ### Initializer Parameters
/// - `configLauncher`: An `AnimatedLauncherConfig` struct specifying the animation’s appearance and behavior (see below).
/// - `rootContent`: A closure returning the root view of your app.
/// - `logo`: A closure returning the logo view to display on the launcher.
///
/// ### Info.plist Configuration
/// You **must** add the following dictionary to your app’s `Info.plist`:
///
/// ```xml
/// <key>LauncherScreen</key>
/// <dict>
///     <key>ImageName</key>
///     <string>YourImageAssetName</string>
///     <key>Background Color</key>
///     <string>#RRGGBB or color name</string>
/// </dict>
/// ```
/// - `ImageName`: The name of the image asset for the logo.
/// - `Background Color`: The background color in hex or as a named color.
///
/// ### Usage Example
/// ```swift
/// import AnimatedLauncherUI
///
/// @main
/// struct MyApp: App {
///     var body: some Scene {
///         AnimatedLauncherUI(
///             configLauncher: AnimatedLauncherConfig(
///                 initialDelay: 0.4,
///                 backgroundColor: .black,
///                 logoBackground: .white,
///                 scaling: 3.0,
///                 forceHideLogo: false,
///                 animationDuration: 1.2
///             ),
///             rootContent: MyRootView(),
///             logo: { LogoView() }
///         )
///     }
/// }
/// ```
///
/// - Note: The launcher ignores safe areas to cover the entire device screen.
public struct AnimatedLauncherUI<RootView: View, Logo: View>: Scene {
    
    // MARK: - Properties
    
    public var configLauncher: AnimatedLauncherConfig
    @ViewBuilder private var rootContent: RootView
    @ViewBuilder private var logo: () -> Logo
    
    // MARK: - Initializer
    
    public init(configLauncher: AnimatedLauncherConfig,
                rootContent: RootView,
                logo: @escaping () -> Logo) {
        self.configLauncher = configLauncher
        self.rootContent = rootContent
        self.logo = logo
    }
    
    // MARK: - Body
    
    public var body: some Scene {
        WindowGroup {
            rootContent
                .modifier(AnimatedLauncherModifier(configLauncher: configLauncher, logo: logo))
                .ignoresSafeArea() // Ensures launcher covers the entire screen, ignoring safe areas
        }
    }
}
