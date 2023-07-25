//
//  ShareDataModel.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/25.
//

import Foundation

enum ConnectState: Codable { // 연결 상태
    case connected
    case notConnected
}

enum RequestType: Codable { // mpc 요청 타입
    case connect
    case confirm
    case denied
}

struct ShareData: Codable { // 보낼 데이터 모델
    
    let userName: String
    let team : String
    let cardInfo: String
}

struct MpcInfoDTO: Codable { // mpc에 실어 보낼 데이터 타입
    let type: RequestType
    let peerId: String
    let data: ShareData
}

