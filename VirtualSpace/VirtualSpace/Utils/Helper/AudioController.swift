//
//  AudioController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import AVFoundation
import Accelerate

class AudioController {
    var engine: AVAudioEngine?
    let player = AVAudioPlayerNode()
    let fftSetup = vDSP_DFT_zop_CreateSetup(nil, 1024, vDSP_DFT_Direction.FORWARD)
    var getAmplitudes: ((_ amplitudes: [Float]) -> Void)?

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

    func processAudioData(buffer: AVAudioPCMBuffer) -> [Float] {
        guard let fftSetup, let channelData = buffer.floatChannelData?[0] else { return [] }
        return self.fft(data: channelData, setup: fftSetup)
    }

    func startPlaying(_ url: URL?) {
        engine = AVAudioEngine()
        guard let engine, let url = url else { return }
        let mainMixerNode = engine.mainMixerNode
        engine.prepare()
        do {
            try engine.start()
            let audioFile = try AVAudioFile(forReading: url)
            let format = audioFile.processingFormat
            engine.attach(player)
            engine.connect(player, to: mainMixerNode, format: format)
            player.scheduleFile(audioFile, at: nil, completionHandler: { [weak self] in
                print("Audio playback finished.")
                self?.stopEngine()
            })
        } catch let error {
            print(error.localizedDescription)
        }
        mainMixerNode.installTap(onBus: 0, bufferSize: 1024, format: nil) { [weak self] (buffer, _) in
            self?.getAmplitudes?(self?.processAudioData(buffer: buffer) ?? [])
        }
        player.play()
    }

    func stopPlaying() {
        self.player.stop()
    }

    func stopEngine() {
        self.engine?.stop()
        self.engine?.reset()
        self.engine?.mainMixerNode.removeTap(onBus: 0)
        self.getAmplitudes?([])
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

extension AudioController {

    // MARK: - fft is equal => Fast Fourier transform
    func fft(data: UnsafeMutablePointer<Float>, setup: OpaquePointer) -> [Float] {
        // output setup
        var realIn = [Float](repeating: 0, count: 1024)
        var imagIn = [Float](repeating: 0, count: 1024)
        var realOut = [Float](repeating: 0, count: 1024)
        var imagOut = [Float](repeating: 0, count: 1024)

        // fill in real input part with audio samples
        for i in 0...1023 {
            realIn[i] = data[i]
        }

        vDSP_DFT_Execute(setup, &realIn, &imagIn, &realOut, &imagOut)

        // our results are now inside realOut and imagOut

        // package it inside a complex vector representation used in the vDSP framework
        var complex = DSPSplitComplex(realp: &realOut, imagp: &imagOut)

        // setup magnitude output
        var magnitudes = [Float](repeating: 0, count: 512)

        // calculate magnitude results
        vDSP_zvabs(&complex, 1, &magnitudes, 1, 512)

        // normalize
        var normalizedMagnitudes = [Float](repeating: 0.0, count: 512)
        var scalingFactor = Float(25.0 / 512)
        vDSP_vsmul(&magnitudes, 1, &scalingFactor, &normalizedMagnitudes, 1, 512)

        return normalizedMagnitudes
    }
}
