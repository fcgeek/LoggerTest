//
//  ViewController.swift
//  LoggerTest
//
//  Created by liujianlin on 2016/11/30.
//  Copyright © 2016年 fcgeek. All rights reserved.
//

import UIKit
import CleanroomLogger
//import CocoaLumberjack

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // create 3 different types of formatters
//        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
//        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
//        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
//        DDLog.add(fileLogger)
//        
//        DDLogVerbose("Verbose");
//        DDLogDebug("Debug");
//        DDLogInfo("Info");
//        DDLogWarn("Warn");
//        DDLogError("Error");
        
        
//        Log.enable(debugMode: true, verboseDebugMode: true)
//        
//        Log.error?.message("Logging an error message")
        
        let xcodeFormat = XcodeLogFormatter()
        let aslFormat = ReadableLogFormatter()
        let fileFormat = ParsableLogFormatter()
        
        // create a configuration for logging to the Xcode console, but
        // disable ASL logging so we can use a different formatter for it
        let xcodeConfig = XcodeLogConfiguration(logToASL: false,
                                                formatter: xcodeFormat)

        // create a configuration containing an ASL log recorder
        // using the aslFormat formatter. turn off stderr echoing
        // so we don’t see duplicate messages in the Xcode  
        let aslRecorder = ASLLogRecorder(formatter: aslFormat,
                                         echoToStdErr: false)
        let aslConfig = BasicLogConfiguration(recorders: [aslRecorder])

        // create a configuration for a rotating log file directory
        // that uses the fileFormat formatter -- logDir is a String
        // holding the filesystem path to the log directory
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let path = paths.first else {
            return
        }
        let fileCfg = RotatingLogFileConfiguration(minimumSeverity: .info,
                                                   daysToKeep: 15,
                                                   directoryPath: "\(path)/CleanroomLogger",
                                                   formatters: [fileFormat])
        //FileManager.default.
        // crash if the log directory doesn’t exist yet & can’t be created
        try! fileCfg.createLogDirectory()
        
        // enable logging using the 3 different LogRecorders
        // that each use their own distinct LogFormatter
        Log.enable(configuration: [xcodeConfig, aslConfig, fileCfg])
        Log.info?.message("asdfasdfsafsd")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

