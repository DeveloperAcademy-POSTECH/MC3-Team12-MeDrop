//
//  DeleteView.swift
//  MeDrop
//
//  Created by SY AN on 2023/08/02.
//

import SwiftUI

struct DeleteView: View {
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: UIScreen.width * 0.5, height: 1)
            Text("삭제")
                .font(.title2)
                .fontWeight(.bold)
        }
    }
}

struct DeleteView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteView()
    }
}
