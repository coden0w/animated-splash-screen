//
//  AnimatedLauncherModifier.swift
//  AnimatedLauncherUI
//
//  Created by alex on 17/11/25.
//

import Foundation
import SwiftUI

struct AnimatedLauncherModifier<Logo: View>: ViewModifier {
    
    // MARK: - Properties
    
    var configLauncher: AnimatedLauncherConfig
    @ViewBuilder var logo: Logo
    @Environment(\.scenePhase) private var scenePhase
    @State private var splashWindow: UIWindow?
    
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: onAppear)
    }
}

private extension AnimatedLauncherModifier {
    
    func onAppear() {
        let scenes = UIApplication.shared.connectedScenes
        for scene in scenes {
            guard let windowScene = scene as? UIWindowScene,
                  checkStates(windowScene.activationState),
                  windowScene.windows.contains(where: { $0.tag == 1337 }).not
            else {
                log("Already have a splash window for this scene.")
                continue
            }
            setSplashWindow(windowScene)
            log("Splash window added!")
        }
    }
    
    func checkStates(_ state: UIWindowScene.ActivationState) -> Bool {
        switch scenePhase {
        case .active: state == .foregroundActive
        case .inactive: state == .foregroundInactive
        case .background: state == .background
        default: state.hashValue == scenePhase.hashValue
        }
    }
    
    func setSplashWindow(_ windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = .clear
        window.isHidden = false
        window.isUserInteractionEnabled = true
        let rootViewController = UIHostingController(rootView: AnimatedLauncherView(configLauncher: configLauncher) {
            logo
        } isCompleted: {
            window.isHidden = true
            window.isUserInteractionEnabled = false
        })
        window.tag = 1337
        rootViewController.view.backgroundColor = .clear
        window.rootViewController = rootViewController
        splashWindow = window
    }
    
}

fileprivate extension ViewModifier {
    func log(_ message: String) {
        dump(String(format: "[AnimatedLauncherUI]: %@", message))
    }
}

fileprivate extension Bool {
    
    var not: Bool {
        !self
    }
}


