//
//  PlayerViewModel.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//

import AVKit
import Combine
import Foundation
import SwiftUI

final class PlayerViewModel: ObservableObject {
    let contenPlayer: Player
    var player: AVPlayer { contenPlayer.player }
    private var cancellables = Set<AnyCancellable>()
    @Published var contentViewError: ContentViewError?
    @Published var isBuffering: Bool = true

    init(_ url: URL) {
        contenPlayer = ContenPlayer(url: url)
    }

    func stop() {
        contenPlayer.stop()
    }
}

extension PlayerViewModel {
    func onAppear() {
        setupBindings()
    }

    func setupBindings() {
        contenPlayer.player
            .publisher(for: \.timeControlStatus)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .waitingToPlayAtSpecifiedRate:
                    self?.isBuffering = self?.contentViewError == .failedToDownload ? false : true
                case .playing, .paused:
                    self?.isBuffering = false
                @unknown default:
                    self?.isBuffering = false
                }
            }
            .store(in: &cancellables)

        contenPlayer.player
            .publisher(for: \.status)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .readyToPlay:
                    self.contenPlayer.start()
                case .failed:
                    self.contentViewError = .failedToPlay
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
