//
//  AnimatedLauncherView.swift
//  AnimatedLauncherUI
//
//  Created by alex on 17/11/25.
//

import Foundation
import SwiftUI

struct AnimatedLauncherView<Logo: View>: View {
    
    // MARK: - Properties
    
    var configLauncher: AnimatedLauncherConfig
    @ViewBuilder var logo: Logo
    @State private var scaleDown: Bool = false
    @State private var scaleUp: Bool = false
    var isCompleted: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(configLauncher.backgroundColor)
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                let size = proxy.size.applying(.init(scaleX: configLauncher.scaling, y: configLauncher.scaling))
                
                logo
                    .blur(radius: configLauncher.forceHideLogo ? .zero : (scaleUp ? 15 : .zero))
                    .animation(.smooth(duration: 0.3, extraBounce: .zero)) { content in
                        content
                            .scaleEffect(scaleDown ? 0.8 : 1)
                    }
                    .visualEffect { [scaleUp] content, proxy in
                        let scaleX: CGFloat = size.width / proxy.size.width
                        let scaleY: CGFloat = size.height / proxy.size.height
                        let maxScale = Swift.max(scaleX, scaleY)
                        return content.scaleEffect(scaleUp ? maxScale : 1)
                    }
                    .opacity(configLauncher.forceHideLogo ? 0 : 1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .opacity(configLauncher.forceHideLogo ? 1 : (scaleUp ?  .zero : 1))
        .background {
            Rectangle()
                .fill(configLauncher.logoBackground)
                .opacity(scaleUp ? .zero : 1)
        }
        .ignoresSafeArea()
        .task {
            guard scaleDown.not else { return }
            try? await Task.sleep(for: .seconds(configLauncher.initialDelay))
            scaleDown = true
            try? await Task.sleep(for: .seconds(0.1))
            withAnimation(configLauncher.animation, completionCriteria: .logicallyComplete, {
                scaleUp = true
            }, completion: isCompleted)
        }
    }
}

fileprivate extension Bool {
    
    var not: Bool {
        !self
    }
}
