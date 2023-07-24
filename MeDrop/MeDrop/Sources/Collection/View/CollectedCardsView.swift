//
//  CollectionView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import SwiftUI

struct CollectedCardsView: View {
    @State var sortedBy = "가나다 순"
    @State var profileLists: [ProfileCardModel] = ProfileCardModel.sampleData
    @State var selectedProfile: ProfileCardModel = ProfileCardModel.sampleData[0]
    @State var isDetail = false
    @State var isDelete = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading ) { HStack { Spacer()
                    Menu { sortingButton(order: "가나다 순")
                        sortingButton(order: "새로운 순")
                        sortingButton(order: "오래된 순")
                    } label: {
                        Text(sortedBy)
                        Image(systemName: "chevron.down")
                    }.padding(.trailing)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                    List { ForEach(profileLists) { profile in
                            Button(action: { isDetail.toggle()
                                selectedProfile = profile })
                            {
                                CollectedCardComponent(profileCard: profile) }
                        
//                        profileLists.removeAll { $0.id == profile.id
                            .swipeActions {
                                Button(action: {
                                    isDelete = true })
                                { Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                            .confirmationDialog(
                                Text("삭제 하시겠습니까?\n 이 행동은 돌이킬 수 없습니다."),
                                isPresented: $isDelete,
                                titleVisibility: .visible
                            ) {
                                Button("삭제", role: .destructive) {
                                    withAnimation {
                                        profileLists.removeAll { $0.id == profile.id }
                                    }
                                }
                            }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                }
            .navigationTitle("Collected Card")
            .navigationDestination(isPresented: $isDetail) {
                    ProfileDetailView(profileCard: $selectedProfile, isFromMy: false)
                }
            }
        }
}

struct CollectedCardComponent: View {
    var profileCard: ProfileCardModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
            HStack {
                VStack(alignment: .leading) {
                    Text("\(profileCard.name)")
                        .font(.title).bold().truncationMode(.tail)
                    Text("\(profileCard.company)")
                        .truncationMode(.tail)
                    Text("\(profileCard.job)")
                        .truncationMode(.tail)
                }.padding()
                Spacer()
            }.foregroundColor(.white)
        }
    }
}

struct CollectedCardsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectedCardsView()
    }
}
