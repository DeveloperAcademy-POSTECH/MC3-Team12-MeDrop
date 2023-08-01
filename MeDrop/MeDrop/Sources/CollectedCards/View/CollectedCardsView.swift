//
//  CollectedCardsView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/24.
//

import SwiftUI

struct CollectedCardsView: View {
    
    @Binding var selectedTab: Tab
    
    @State var sortedBy = "가나다 순"
    @State var selectedProfile: ProfileCardModel = ProfileCardModel.sampleData[0]
    @Binding var yourCards: [ProfileCardModel]
    @State var isDetail: Bool = false
    @State var isDelete = false
    @Environment(\.scenePhase) private var scenePhase
    @State var sortYourCards: [ProfileCardModel] = []
    
    @State var showingAlert = false
    
    let saveAction: () -> Void
    
    func sortingButton(order: String) -> some View {
        Button {
            self.sortedBy = order
        } label: {
            Text(order).font(.caption2)
            Spacer()
            if sortedBy == order {
                Image(systemName: "checkmark.circle.fill")
            } else {
                Image(systemName: "checkmark.circle")
            }
        }
    }
    
    var bottomBar: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(tabItems) { tabItem in
                Button(action: {
                    if tabItem.type == .tabType {
                        withAnimation(.easeInOut) {
                            selectedTab = tabItem.tab!
                        }
                    }
                }) {
                    if tabItem.type == .tabType {
                        VStack(spacing: 0) {
                            Image(systemName: tabItem.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                            Text(tabItem.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                    } else {
                        Image(systemName: tabItem.icon).foregroundColor(selectedTab == .my ? .black : .gray).padding()
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .foregroundColor(Color.white)
                            .background(Circle().foregroundColor(.white))
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                            
                            .disabled(selectedTab == .your)
                    }
                }
                .offset(y: tabItem.type == .tabType ? 0 : -35)
                .foregroundColor(selectedTab == tabItem.tab ? .black : .secondary)
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .frame(height: 88, alignment: .top)
        .padding(.top, 14)
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                DesignSystemAsset.gray4
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(alignment: .leading ) {
                    HStack {
                    Spacer()
                    Menu { sortingButton(order: "가나다 순")
                        sortingButton(order: "새로운 순")
                        sortingButton(order: "오래된 순")
                    } label: {
                        HStack {
                            Text(sortedBy)
                            Image(systemName: "chevron.down").foregroundColor(.red)
                        }.onChange(of: sortedBy) { _ in
                            if sortedBy == "가나다 순" {
                                sortYourCards.sort {
                                    $0.name < $1.name
                                }
                            } else if sortedBy == "새로운 순" {
                                sortYourCards.sort {
                                    $0.date < $1.date
                                }
                            } else {
                                sortYourCards.sort {
                                    $0.date > $1.date
                                }
                            }
                        }
                    }.padding(.trailing)
                    .foregroundColor(.black)
                }
                    Spacer()
                    
                    if sortYourCards.isEmpty == false {
                        List {
                            ForEach(sortYourCards, id:\.self) { profile in
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
                            .listRowBackground(DesignSystemAsset.gray4)
                        }
                        .listStyle(.plain)
                    }
                    
                    
                    Spacer()
                    
                    TabClipperShape(radius: 38.0)
                        .fill(.white)
                        .frame(height: 88, alignment: .top)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -1)
                        .overlay(bottomBar)
    //                    .alert("교환 버튼 클릭", isPresented: $showingAlert) {
    //                        Button("확인", role: .cancel) { }
    //                    }
                    
                    
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Collected Cards")
                .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $isDetail) {
                CardDetailCollectedView(card: $selectedProfile)
            }
            
        }
        .onAppear{
            sortYourCards = yourCards
        }
        .confirmationDialog("\(selectedProfile.name) 님의 카드를 삭제 하시겠습니까?\n 이 행동은 돌이킬 수 없습니다.", isPresented: $isDelete, titleVisibility: .visible
        ) {
            Button("삭제", role: .destructive) {
                isDelete.toggle()
                yourCards.removeAll { $0.id == selectedProfile.id
            }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        
    }
}

struct CollectedCardComponent: View {
    var profileCard: ProfileCardModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0).foregroundColor(.white)
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

struct CollectedCardsView_Previews: PreviewProvider {
    static var previews: some View {
        CollectedCardsView(selectedTab: .constant(Tab.your), yourCards: .constant(ProfileCardModel.sampleData),saveAction: {})
    }
}
