//
//  Encryption.h
//  voiceit out of the box
//
//  Created by Armaan Bindra on 4/20/15.
//  Copyright (c) 2015 VoiceIt Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject
+ (NSString *)sha256:(NSString *)input;
@end
