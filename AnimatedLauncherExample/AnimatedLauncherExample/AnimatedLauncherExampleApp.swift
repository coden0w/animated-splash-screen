//
//  AnimatedLauncherExampleApp.swift
//  AnimatedLauncherExample
//
//  Created by alex on 17/11/25.
//

import SwiftUI
import AnimatedLauncherUI

@main
struct AnimatedLauncherExampleApp: App {
    var body: some Scene {
        AnimatedLauncherUI(configLauncher: .init(initialDelay: 0.5,
                                                 backgroundColor: .background),
                           rootContent: ContentView()) {
            Image(systemName: "apple.intelligence")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
        }
    }
}
