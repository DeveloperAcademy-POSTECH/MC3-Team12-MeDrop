//
//  MenuView.swift
//  MeDrop
//
//  Created by SY AN on 2023/07/23.
//

import SwiftUI

struct MenuView: View {
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: FAQView()) {
                        Text("자주 묻는 질문")
                            .bold()
                    }
                    NavigationLink(destination: PrivacyView()) {
                        Text("개인정보처리방침")
                            .bold()
                    }
                    NavigationLink(destination: TermsOfUseView()) {
                        Text("이용 약관")
                            .bold()
                    }
                }
                .listRowInsets(EdgeInsets())
                
                Section {
                    Button("로그아웃") {
                        showingAlert = true
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("로그아웃"),
                            message: Text("앱의 초기 화면으로 돌아갑니다.\n정말 로그아웃 하시겠어요?"),
                            primaryButton: .destructive(Text("로그아웃")) {
                            },
                            secondaryButton: .cancel(Text("취소"))
                        )
                    }
                    NavigationLink(destination: DeleteAccountView()) {
                        Text("회원 탈퇴")
                            .foregroundColor(DesignSystemAsset.gray1)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .scrollDisabled(true)
        }
        .background(DesignSystemAsset.white1)
        .scrollContentBackground(.hidden)
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.defaultMinListRowHeight, 60)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
