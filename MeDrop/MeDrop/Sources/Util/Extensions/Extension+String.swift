//
//  Extension+String.swift
//  MeDrop
//
//  Created by yongbeomkwak on 2023/07/11.
//

import Foundation

extension String {
    func convertMarkDown() -> AttributedString {
        do {
            let conv = try AttributedString(markdown: self, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)) // \n을 통한 줄바꿈을 위한
            return conv
        } catch {
            return ""
        }
    }
}
