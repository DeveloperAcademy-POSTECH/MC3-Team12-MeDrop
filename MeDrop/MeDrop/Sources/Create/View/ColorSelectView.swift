//
//  ColorSelectView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct ColorSelectView: View {
    @Binding var isFinishied: Bool
    var body: some View {
        Text("ColorSelectView")
    }
}

struct ColorSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectView(isFinishied: .constant(false))
    }
}
