//
//  FFformatConverter.swift
//  FFmpegDemo
//
//  Created by myx on 2021/9/26.
//

import Foundation

class FFformatConverter: NSObject, ExecuteDelegate {
    
    enum ConvertAction {
        case aac_to_wav
        case wav_to_aac
    }

    typealias ConvertFailureReason = String
    typealias ConvertedSuccessCompletion = () -> ()
    typealias ConvertedFailureCompletion = (ConvertFailureReason) -> ()
    
    private var successCallback: ConvertedSuccessCompletion!
    private var failureCallback: ConvertedFailureCompletion!

    func convert(action: ConvertAction,
                 from fromPath: String,
                 to toPath: String,
                 success: @escaping ConvertedSuccessCompletion,
                 failure: @escaping ConvertedFailureCompletion) {
        
        var cmd: String = ""
        
        switch action {
        case .aac_to_wav:
            cmd = "-i \(fromPath) \(toPath)"
        case .wav_to_aac:
            cmd = "-i \(fromPath) -c:a aac \(toPath)"
        }
        
        successCallback = success
        failureCallback = failure
        
        MobileFFmpeg.executeAsync(cmd, withCallback: self, andDispatchQueue: .queue)
    }

    func executeCallback(_ executionId: Int, _ returnCode: Int32) {
        switch returnCode {
        case RETURN_CODE_SUCCESS:
            //print("Command execution completed successfully.")
            successCallback()
        case RETURN_CODE_CANCEL:
            failureCallback("Command execution cancelled by user.")
        default:
            let reason: String = """
                Command execution failed with rc=\(returnCode) and
                output=\(String(MobileFFmpegConfig.getLastCommandOutput()))
            """
            failureCallback(reason)
        }
    }
    
    deinit {
        print("已经析构...")
    }
}

fileprivate extension DispatchQueue {
    static let queue = DispatchQueue(label: "com.zebra-c.ff.convert.format.queue")
}
