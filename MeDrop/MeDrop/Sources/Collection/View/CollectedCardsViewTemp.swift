//
//  CollectionView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/07/10.
//

import SwiftUI

struct CollectedCardsViewTemp: View {
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
                
                    List {
                        ForEach(profileLists,id:\.self) { profile in
                            Button(action: { isDetail.toggle()
                                selectedProfile = profile
                            },
                               label: { CollectedCardComponent(profileCard: profile)})
                            .swipeActions {
                                Button(action: { selectedProfile = profile
                                    isDelete.toggle()
                                },
                            label: { Label("Delete", systemImage: "trash")})
                                .tint(.red) }
                           
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
        .confirmationDialog("\(selectedProfile.name) 님의 카드를 삭제 하시겠습니까?\n 이 행동은 돌이킬 수 없습니다.", isPresented: $isDelete, titleVisibility: .visible
        ) {
            Button("삭제", role: .destructive) {
                isDelete.toggle()
                profileLists.removeAll { $0.id == selectedProfile.id
            }
            }
        }
        .onChange(of: isDelete) { newValue in
            DEBUG_LOG(newValue)
        }
        }
}

struct CollectedCardComponent: View {
    var profileCard: ProfileCardModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(.black, lineWidth: 1)
            HStack {
                Image("\(profileCard.type)")
                    .renderingMode(.template)
                    .foregroundColor(Color(.sRGB, red: profileCard.color[0], green: profileCard.color[1], blue: profileCard.color[2]))
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("\(profileCard.name)")
                        .font(.title2).bold().truncationMode(.tail)
                    Text("\(profileCard.company)")
                        .truncationMode(.tail)
                    Text("\(profileCard.job)")
                        .truncationMode(.tail)
                }
                Spacer()
            }
        }
    }
}

struct CollectedCardsViewTemp_Previews: PreviewProvider {
    static var previews: some View {
        CollectedCardsViewTemp()
    }
}
