//
//  DeleteAccountView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/08/01.
//

import SwiftUI

struct DeleteAccountDescription: Identifiable {
    var title: String
    var content: String
    var id: String { title }
}

private let deleteAccountDescriptions: [DeleteAccountDescription] = [
    DeleteAccountDescription(title: "이미 공유된 명함들은 사라지지 않아요.", content: "ME DROP을 탈퇴하더라도 상대방에게 이미 공유된 내 카드들은 삭제되지 않고 그대로 상대방의 컬렉션에 남아있습니다."),
    DeleteAccountDescription(title: "명함을 처음부터 다시 모아야해요.", content: "ME DROP을 탈퇴하시면 지금까지 모아온 명함들은 완벽히 삭제되기 때문에 명함을 다시 모아야해요."),
    DeleteAccountDescription(title: "개인 정보는 완벽히 삭제돼요.", content: "ME DROP을 탈퇴하시면 고객님의 개인정보는 개인정보처리방침에 따라 완벽히 삭제되니 안심하세요.")
]

struct DeleteAccountView: View {
    @State private var showingAlert = false
    @State private var goBack: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("탈퇴 전, 반드시 확인해주세요.")
                    .bold()
                    .font(.title)
                    .padding(.bottom)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 5)
            
            ForEach(deleteAccountDescriptions) { description in
                VStack(alignment: .leading) {
                    Text(description.title)
                        .font(.title3)
                        .bold()
                        .padding(.bottom, 2)
                    Text(description.content)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(DesignSystemAsset.gray4)
                .cornerRadius(15)
                .padding(.vertical, 20)
            }
            
            Spacer()
            
            HStack {
//                NavigationLink(destination: MenuView(), isActive: $goBack) {
//                    Button(action: {
//                        goBack = true
//                    }) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10).foregroundColor(DesignSystemAsset.white2)
//                            Text("돌아가기")
//                                .font(Font.custom("SF Pro Text", size: 17))
//                                .foregroundColor(DesignSystemAsset.gray1)
//                        }
//                    }
//                }
                
                Button(action: {
                    showingAlert = true
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(DesignSystemAsset.mainRed)
                        Text("탈퇴하기")
                            .font(Font.custom("SF Pro Text", size: 17))
                            .foregroundColor(DesignSystemAsset.white1)
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("회원 탈퇴"),
                        message: Text("그동안 모은 명함들을 더 이상 볼 수 없어요.\n정말 탈퇴 하시겠어요?"),
                        primaryButton: .destructive(Text("탈퇴")) {
                        },
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
            }
            .frame(height: UIScreen.height * 0.07)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .navigationTitle("회원 탈퇴")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}
