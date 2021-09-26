//
//  ViewController.swift
//  FFmpegDemo
//
//  Created by myx on 2021/9/26.
//

import UIKit

class ViewController: UIViewController {

    private lazy var lib: URL = {
        return FileManager.default.urls(
            for: .libraryDirectory, in: .userDomainMask).last!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        // aac to wav
        let from = Bundle.main.url(forResource: "demo", withExtension: "aac")!.path
        let to: String = lib.appendingPathComponent("out.wav").path
        print("output: \(to)")
        
        FFformatConverter().convert(action: .aac_to_wav, from: from, to: to) {
            print("Command execution completed successfully.")
        } failure: { reson in
            print("失败了: \(reson)")
        }
        
        // wav to aac
//        let from = Bundle.main.url(forResource: "demo", withExtension: "wav")!.path
//        let to: String = lib.appendingPathComponent("out.aac").path
//        print("output: \(to)")
//
//        FFformatConverter().convert(action: .wav_to_aac, from: from, to: to) {
//            print("Command execution completed successfully.")
//        } failure: { reson in
//            print("失败了: \(reson)")
//        }
        
    }
        
//        foo(inPath: url!.path, outPath: outPath)
    
//    func foo(inPath: String, outPath: String) {
//        let command = "-i " + "\(inPath) " + outPath
//        let rc = MobileFFmpeg.execute(command)
//
//        if rc == RETURN_CODE_SUCCESS {
//            print("Command execution completed successfully.")
//        } else if rc == RETURN_CODE_CANCEL {
//            print("Command execution cancelled by user.")
//        } else {
//            print("Command execution failed with rc=\(rc) and output=\(String(MobileFFmpegConfig.getLastCommandOutput()))")
//        }
//    }

}

