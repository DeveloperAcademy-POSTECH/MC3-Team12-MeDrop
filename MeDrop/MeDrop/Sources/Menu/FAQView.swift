//
//  FAQView.swift
//  MeDrop
//
//  Created by JAESEOK LEE on 2023/08/01.
//

import SwiftUI

struct FAQ: Identifiable {
    var question: String
    var answer: String
    var id: String { question }
}

private let faqs: [FAQ] = [
    FAQ(question: "내 명함을 여러 사람에게 한 번에 공유하고 싶은데, 어떻게 해야 하나요?", answer: "현재 버전 (1.0.0)에서는 내 명함을 여러 사람에게 한 번에 공유하실 수 없습니다."),
    FAQ(question: "내 명함의 정보를 수정했는데, 상대방이 가진 내 명함에도 변경 사항이 반영되나요?", answer: "내 명함의 정보를 수정하시더라도 상대방에게 이미 공유된 내 명함에는 반영되지 않습니다."),
    FAQ(question: "내 명함을 삭제하면, 상대방이 가진 내 명함도 삭제가 되나요?", answer: "내 명함을 삭제하시더라도 상대방에게 이미 공유된 내 명함은 삭제되지 않습니다."),
    FAQ(question: "ME DROP을 탈퇴하면, 상대방이 가진 내 명함들은 삭제되나요?", answer: "탈퇴하더라도 이미 공유된 내 명함들은 삭제되지 않고 상대방의 명함 지갑에 남아있습니다.")
]

struct FAQView: View {
    var body: some View {
        List {
            ForEach(faqs) { faq in
                Section {
                    HStack(alignment: .top) {
                        Text("Q.")
                        Text(faq.question)
                    }
                    .bold()
                    
                    HStack(alignment: .top) {
                        Text("A.")
                        Text(faq.answer)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
        }
        .scrollDisabled(true)
        .background(DesignSystemAsset.white1)
        .scrollContentBackground(.hidden)
        .navigationTitle("자주 묻는 질문")
        .navigationBarTitleDisplayMode(.inline)
        .environment(\.defaultMinListRowHeight, 60)
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
