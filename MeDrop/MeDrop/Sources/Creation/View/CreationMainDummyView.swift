//
//  CreationMainDummyView.swift
//  MeDrop
//
//  Created by jose Yun on 2023/07/08.
//

import SwiftUI

struct CreationMainDummyView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("New Card", destination: CreateInfoView())
        }
    }
}

struct CreationMainDummyView_Previews: PreviewProvider {
    static var previews: some View {
        CreationMainDummyView()
    }
}
