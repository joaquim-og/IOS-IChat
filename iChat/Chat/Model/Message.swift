//
//  Message.swift
//  iChat
//
//  Created by joaquim de oliveira gomes on 28/03/24.
//

import Foundation

struct Message: Hashable {
    let uuid: String
    let text: String
    let isMe: Bool
}
