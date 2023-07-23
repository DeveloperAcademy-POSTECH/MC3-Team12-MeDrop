//
//  ColorSelectView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct ColorSelectView: View {
    @Binding var isFinish: Bool
    var body: some View {
        VStack{
            Text("ColorSelectView")
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("완료") {
                    isFinish.toggle()
                }
            }
        }
    }
}

struct ColorSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectView(isFinish: .constant(false))
    }
}
