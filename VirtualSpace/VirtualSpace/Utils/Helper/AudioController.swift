//
//  AudioController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import UIKit
import AVFoundation
import AVKit

class AudioController {

    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var player: AVPlayer?

    func fileURL(audioName: String = "recording.m4a") -> URL? {
        let folderName = "audioTemporary"
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let folderURL = documentsDirectory.appendingPathComponent(folderName, isDirectory: true)
        do {
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            return folderURL.appendingPathComponent(audioName)
        } catch {
            debugPrint("Error creating folder: \(error.localizedDescription)")
            return nil
        }
    }

    func isExistingFile(_ fileUrl: URL) -> Bool {
        if #available(iOS 16.0, *) {
            return FileManager.default.fileExists(atPath: fileUrl.path())
        } else {
            return FileManager.default.fileExists(atPath: fileUrl.relativePath)
        }
    }

    func getAudioDuration(url: URL) -> Double? {
        let asset = AVURLAsset(url: url)
        return asset.duration.seconds
    }

    func startPlaying(url: URL?, timeObserver: @escaping (_ seconds: Double) -> Void) {
        guard let url else { return }
        debugPrint("Url =>>> \(url)")
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
            try audioSession.setCategory(.playback, mode: .default, options: [])
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
            player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 10), queue: DispatchQueue.main, using: { [] time in
                    if self.player?.currentItem?.status == AVPlayerItem.Status.readyToPlay {
                        if (self.player?.currentItem?.isPlaybackLikelyToKeepUp) != nil {
                            timeObserver(time.seconds)
                        }
                    }
                })
        } catch {
            SceneDelegate.shared?._topVC?._showErrorAlertOK(message: error.localizedDescription)
        }
    }

    func stopPlaying() {
        player?.pause()
        player = nil
    }

}

extension AudioController {

    func downloadAudio(with urlStr: String?, completion: @escaping (_ url: URL?) -> Void) {
        guard let urlStr, let url = URL(string: urlStr) else { completion(nil); return }
        // If the file is in the cache
        if let fileURL = self.fileURL(audioName: url.lastPathComponent), self.isExistingFile(fileURL) {
            completion(fileURL)
            return
        }
        // If the file in the cache is not downloaded
        let task = URLSession.shared.downloadTask(with: url) { localURL, response, error in
            guard ResponseHandler.responseHandler(error: error) else { return }
            guard let localURL else { return }
            if let audioName = response?.suggestedFilename, let newLocalURL: URL = self.fileURL(audioName: audioName) {
                do {
                    try FileManager.default.moveItem(at: localURL, to: newLocalURL)
                    debugPrint("Audio is downloaded =>> \(newLocalURL)")
                    completion(newLocalURL)
                } catch {
                    SceneDelegate.shared?._topVC?._showErrorAlertOK(message: error.localizedFirebaseErrorMessage)
                    completion(nil)
                }
            }
        }
        task.resume()
    }

}
