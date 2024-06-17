//
//  AVPlayerControllerRepresented.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//

import AVKit
import Foundation
import SwiftUI

struct AVPlayerControllerRepresented: UIViewControllerRepresentable {
    @ObservedObject var viewModel: PlayerViewModel

    func makeUIViewController(context _: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = viewModel.player
        
        Task {
            do {
                guard let asset = controller.player?.currentItem?.asset else {
                    throw ContentViewError.failedToDownload
                }
                let (playable, protected) = try await asset.load(.isPlayable, .hasProtectedContent)
                
                if !playable || protected {
                    viewModel.contentViewError = .failedToPlay
                }
            } catch {
                viewModel.contentViewError = .failedToDownload
                debugPrint("Failed to load asset properties: \(error.localizedDescription)")
            }
        }

        return controller
    }

    func updateUIViewController(_: AVPlayerViewController, context _: Context) {}
}
