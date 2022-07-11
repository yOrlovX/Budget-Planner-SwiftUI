//
//  HiddenNavigationBar.swift
//  Budget-Planner-SwiftUI
//
//  Created by Yaroslav Orlov on 26.05.2022.
//

import SwiftUI

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}
