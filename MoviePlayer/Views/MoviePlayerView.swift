//
//  MoviePlayerView.swift
//  MoviePlayer
//
//  Created by Oleksiy Chebotarov on 17/06/2024.
//

import AVKit
import SwiftUI

struct MoviePlayerView: View {
    private let url: URL
    @ObservedObject var viewModel: PlayerViewModel
    @Environment(\.dismiss) var dismiss

    init(url: URL) {
        self.url = url
        viewModel = PlayerViewModel(url)
    }

    var body: some View {
        ZStack {
            AVPlayerControllerRepresented(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: viewModel.onAppear)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.stop()
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                            .opacity(0.3)
                            .padding()
                    }
                }
            }
            if viewModel.isBuffering {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }

            VStack {
                Spacer()
                if let error = viewModel.contentViewError {
                    ErrorView(error: error)
                }
            }
        }
    }
}
