//
//  AnimatedLauncherConfig.swift
//  AnimatedLauncherUI
//
//  Created by alex on 17/11/25.
//

import Foundation
import SwiftUI

public struct AnimatedLauncherConfig {
    var initialDelay: Double = 0.35
    var backgroundColor: Color = .black
    var logoBackground: Color = .white
    var scaling: CGFloat = 4.0
    var forceHideLogo: Bool = false
    var animation: Animation = .smooth(duration: 1, extraBounce: .zero)
    
    public init(initialDelay: Double = 0.35,
                backgroundColor: Color = .black,
                logoBackground: Color = .white,
                scaling: CGFloat = 4.0,
                forceHideLogo: Bool = false,
                animation: Animation = .smooth(duration: 1, extraBounce: .zero)) {
        self.initialDelay = initialDelay
        self.backgroundColor = backgroundColor
        self.logoBackground = logoBackground
        self.scaling = scaling
        self.forceHideLogo = forceHideLogo
        self.animation = animation
    }
}
