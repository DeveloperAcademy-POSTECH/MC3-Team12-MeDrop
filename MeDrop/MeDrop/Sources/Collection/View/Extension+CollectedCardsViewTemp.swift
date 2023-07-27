//
//  Extension+CollectionView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/11.
//

import Foundation
import SwiftUI

extension CollectedCardsViewTemp {
    func sortingButton(order: String) -> some View {
        Button {
            self.sortedBy = order
        } label: {
            Text(order)
            Spacer()
            if sortedBy == order {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "checkmark.circle")
            }
        }
    }
}
