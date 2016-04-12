#import "VoiceItCordova.h"
#import <Cordova/CDV.h>

@implementation VoiceItCordova

//#define RECORDINGS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Library/NoCloud"]

- (void)createEnrollment:(CDVInvokedUrlCommand*)command {
   _command = command;
   duration = [NSNumber numberWithInt:5];
   _callType = @"Enrollment";

   [self.commandDelegate runInBackground:^{

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];

    NSError *err;
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&err];
    if (err)
    {
      NSLog(@"%@ %d %@", [err domain], [err code], [[err userInfo] description]);
    }
    err = nil;
    [audioSession setActive:YES error:&err];
    if (err)
    {
      NSLog(@"%@ %d %@", [err domain], [err code], [[err userInfo] description]);
    }

    NSDictionary *recordSettings = [[NSDictionary alloc]
    initWithObjectsAndKeys:
        [NSNumber numberWithFloat:11025.0], AVSampleRateKey,
        [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
        [NSNumber numberWithInt:8], AVLinearPCMBitDepthKey,
        [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
        [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
        [NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey, nil];
        // Unique recording URL
    NSString *fileName = @"RecordedFile"; // Changed it So It Keeps Replacing File
    recorderFilePath = [NSTemporaryDirectory()
        stringByAppendingPathComponent:[NSString
                                           stringWithFormat:@"%@.wav", fileName]];
    // // Create a new dated file
    // recorderFilePath = [NSString stringWithFormat:@"%@/%@.m4a", RECORDINGS_FOLDER, @"voiceitrecording"];
    // NSLog(@"recording file path: %@", recorderFilePath);

    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    err = nil;
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&err];
    if(!recorder){
      NSLog(@"recorder: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
      return;
    }

    [recorder setDelegate:self];

    if (![recorder prepareToRecord]) {
      NSLog(@"prepareToRecord failed");
      return;
    }

    if (![recorder recordForDuration:(NSTimeInterval)[duration intValue]]) {
      NSLog(@"recordForDuration failed");
      return;
    }

  }];
}

- (void)authentication:(CDVInvokedUrlCommand*)command {
   _command = command;
   duration = [NSNumber numberWithInt:5];
   _callType = @"Authentication";

   [self.commandDelegate runInBackground:^{

    AVAudioSession *audioSession = [AVAudioSession sharedInstance];

    NSError *err;
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&err];
    if (err)
    {
      NSLog(@"%@ %d %@", [err domain], [err code], [[err userInfo] description]);
    }
    err = nil;
    [audioSession setActive:YES error:&err];
    if (err)
    {
      NSLog(@"%@ %d %@", [err domain], [err code], [[err userInfo] description]);
    }

    NSDictionary *recordSettings = [[NSDictionary alloc]
    initWithObjectsAndKeys:
        [NSNumber numberWithFloat:11025.0], AVSampleRateKey,
        [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
        [NSNumber numberWithInt:8], AVLinearPCMBitDepthKey,
        [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
        [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
        [NSNumber numberWithBool:NO], AVLinearPCMIsFloatKey, nil];
        // Unique recording URL
    NSString *fileName = @"RecordedFile"; // Changed it So It Keeps Replacing File
    recorderFilePath = [NSTemporaryDirectory()
        stringByAppendingPathComponent:[NSString
                                           stringWithFormat:@"%@.wav", fileName]];
    // // Create a new dated file
    // recorderFilePath = [NSString stringWithFormat:@"%@/%@.m4a", RECORDINGS_FOLDER, @"voiceitrecording"];
    // NSLog(@"recording file path: %@", recorderFilePath);

    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    err = nil;
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&err];
    if(!recorder){
      NSLog(@"recorder: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
      return;
    }

    [recorder setDelegate:self];

    if (![recorder prepareToRecord]) {
      NSLog(@"prepareToRecord failed");
      return;
    }

    if (![recorder recordForDuration:(NSTimeInterval)[duration intValue]]) {
      NSLog(@"recordForDuration failed");
      return;
    }

  }];
}

- (void)stop:(CDVInvokedUrlCommand*)command {
  _command = command;
  NSLog(@"stopRecording");
  [recorder stop];
  NSLog(@"stopped");
}

- (void)getUser:(CDVInvokedUrlCommand*)command {
  _command = command;
  VoiceIt *myVoiceIt = [[VoiceIt alloc] init:[_command.arguments objectAtIndex:0]];
  [myVoiceIt
     getUser:[_command.arguments objectAtIndex:1]
      passwd:[_command.arguments objectAtIndex:2]
    callback:^(NSString *result) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }];
}

- (void)deleteUser:(CDVInvokedUrlCommand*)command {
  _command = command;
  VoiceIt *myVoiceIt = [[VoiceIt alloc] init:[_command.arguments objectAtIndex:0]];
  [myVoiceIt
     deleteUser:[_command.arguments objectAtIndex:1]
      passwd:[_command.arguments objectAtIndex:2]
    callback:^(NSString *result) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }];
}

- (void)createUser:(CDVInvokedUrlCommand*)command {
  _command = command;
  VoiceIt *myVoiceIt = [[VoiceIt alloc] init:[_command.arguments objectAtIndex:0]];
  [myVoiceIt
     createUser:[_command.arguments objectAtIndex:1]
      passwd:[_command.arguments objectAtIndex:2]
      firstName:[_command.arguments objectAtIndex:3]
       lastName:[_command.arguments objectAtIndex:4]
    callback:^(NSString *result) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }];
}

- (void)setUser:(CDVInvokedUrlCommand*)command {
  _command = command;
  VoiceIt *myVoiceIt = [[VoiceIt alloc] init:[_command.arguments objectAtIndex:0]];
  [myVoiceIt
     setUser:[_command.arguments objectAtIndex:1]
      passwd:[_command.arguments objectAtIndex:2]
      firstName:[_command.arguments objectAtIndex:3]
       lastName:[_command.arguments objectAtIndex:4]
    callback:^(NSString *result) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }];
}

- (void)getEnrollments:(CDVInvokedUrlCommand*)command {
  _command = command;
  VoiceIt *myVoiceIt = [[VoiceIt alloc] init:[_command.arguments objectAtIndex:0]];
  [myVoiceIt
     getEnrollments:[_command.arguments objectAtIndex:1]
      passwd:[_command.arguments objectAtIndex:2]
    callback:^(NSString *result) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }];
}

- (void)deleteEnrollment:(CDVInvokedUrlCommand*)command {
  _command = command;
  VoiceIt *myVoiceIt = [[VoiceIt alloc] init:[_command.arguments objectAtIndex:0]];
  [myVoiceIt
     deleteEnrollment:[_command.arguments objectAtIndex:1]
      passwd:[_command.arguments objectAtIndex:2]
      enrollmentId:[_command.arguments objectAtIndex:3]
    callback:^(NSString *result) {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    }];
}


- (void)playback:(CDVInvokedUrlCommand*)command {
  _command = command;
  if(recorderFilePath == nil || [recorderFilePath isEqualToString:@""]){
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Nothing to Play"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
    return;
  }

  [self.commandDelegate runInBackground:^{
    NSLog(@"recording playback");
    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    NSError *err;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    player.numberOfLoops = 0;
    player.delegate = self;
    [player prepareToPlay];
    [player play];
    if (err) {
      NSLog(@"%@ %d %@", [err domain], [err code], [[err userInfo] description]);
    }
    NSLog(@"playing");
  }];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
  NSLog(@"audioPlayerDidFinishPlaying");
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Completed Playing Recording"];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
  NSURL *url = [NSURL fileURLWithPath: recorderFilePath];
  NSError *err = nil;
  NSData *audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
  if(!audioData) {
    NSLog(@"audio data: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
  } else {
    NSLog(@"recording saved: %@", recorderFilePath);
    VoiceIt *myVoiceIt = [[VoiceIt alloc] init:[_command.arguments objectAtIndex:0]];
    if([_callType isEqualToString:@"Enrollment"]){
      [myVoiceIt
           createEnrollment:[_command.arguments objectAtIndex:1]
                     passwd:[_command.arguments objectAtIndex:2]
        pathToEnrollmentWav:recorderFilePath
        contentLanguage:[_command.arguments objectAtIndex:3]
                   callback:^(NSString *result) {
                     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                     [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
                   }];
    }
    else if([_callType isEqualToString:@"Authentication"]){
      [myVoiceIt
             authentication:[_command.arguments objectAtIndex:1]
                     passwd:[_command.arguments objectAtIndex:2]
    pathToAuthenticationWav:recorderFilePath
                   accuracy:[_command.arguments objectAtIndex:3]
             accuracyPasses:[_command.arguments objectAtIndex:4]
      accuracyPassIncrement:[_command.arguments objectAtIndex:5]
                 confidence:[_command.arguments objectAtIndex:6]
            contentLanguage:[_command.arguments objectAtIndex:7]


                   callback:^(NSString *result) {
                     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                     [self.commandDelegate sendPluginResult:pluginResult callbackId:_command.callbackId];
                   }];
    }
  }
}

@end
