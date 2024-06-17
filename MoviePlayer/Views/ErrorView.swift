//
//  ErrorView.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    let error: ContentViewError

    var body: some View {
        contentView
    }

    @ViewBuilder
    var contentView: some View {
        switch error {
        case .failedToDownload:
            Text("Unable to download file.")
                .foregroundColor(.red)
                .font(.title2)
        case .failedToPlay:
            Text("Failed to play the video")
                .foregroundColor(.red)
                .font(.title2)
        }
    }
}
