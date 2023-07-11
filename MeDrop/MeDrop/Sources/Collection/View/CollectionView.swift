//
//  CollectionView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import Foundation
import SwiftUI

struct CollectionView: View {
    @StateObject var collectionViewModel = CollectionViewModel()
    
    @State var sortedBy = "가나다 순"
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Wallet")
                    .font(.black(34))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Menu {
                    Button {
                        self.sortedBy = "가나다 순"
                    } label: {
                        Text("가나다 순")
                        Spacer()
                        if sortedBy == "가나다 순" {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    Button {
                        self.sortedBy = "새로운 순"
                    } label: {
                        Text("새로운 순")
                        Spacer()
                        if sortedBy == "새로운 순" {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    Button {
                        self.sortedBy = "오래된 순"
                    } label: {
                        Text("오래된 순")
                        Spacer()
                        if sortedBy == "오래된 순" {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                } label: {
                    Text(sortedBy)
                    Image(systemName: "chevron.down")
                }
                .font(.regular(20))
                .frame(alignment: .trailing)
            }
            
            Spacer()
        }
        .padding(.top, .spacing40)
        .padding(.horizontal, .spacing20)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
