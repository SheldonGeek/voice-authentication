#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>
#import "VoiceIt.h"

@interface VoiceItCordova : CDVPlugin {
  NSString *recorderFilePath;
  NSString *_callType;
  NSNumber *duration;
  AVAudioRecorder *recorder;
  AVAudioPlayer *player;
  CDVPluginResult *pluginResult;
  CDVInvokedUrlCommand *_command;
}

//USER API CALLS
- (void)createUser:(CDVInvokedUrlCommand*)command;
- (void)setUser:(CDVInvokedUrlCommand*)command;
- (void)getUser:(CDVInvokedUrlCommand*)command;
- (void)deleteUser:(CDVInvokedUrlCommand*)command;

//ENROLLMENT API CALLS
- (void)getEnrollments:(CDVInvokedUrlCommand*)command;
- (void)createEnrollment:(CDVInvokedUrlCommand*)command;
- (void)deleteEnrollment:(CDVInvokedUrlCommand*)command;

//AUTHENTICATION API CALLS
- (void)authentication:(CDVInvokedUrlCommand*)command;

//MISCELLANEOUS
- (void)playback:(CDVInvokedUrlCommand*)command;

@end
