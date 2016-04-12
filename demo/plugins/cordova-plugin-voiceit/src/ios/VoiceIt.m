//
//  VoiceIt.m
//  TestSDK
//
//  Created by Armaan Bindra on 6/29/15.
//  Copyright (c) 2015 Armaan Bindra. All rights reserved.
//

#import "VoiceIt.h"

@implementation VoiceIt

- (NSString *)sha256:(NSString *)input
{
    return [Encryption sha256:input];
}

- (id)init:(NSString *)developerId
{
    self.developerId = developerId;
    NSLog(@"Developer id is set to %@", developerId);
    return self;
}

-(NSString*)getHost
{
    return @"https://siv.voiceprintportal.com/sivservice/api/";
    //return @"http://10.0.0.12:8080/sivservice/api/";
}

-(NSString*)addString:(NSString*)firstString secondString:(NSString*)secondString
{
    return [[NSString alloc] initWithFormat:@"%@%@",firstString,secondString];
}

#pragma mark - User API Calls
- (void)getUser:(NSString *)email
         passwd:(NSString *)passwd
       callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc] initWithString:[self addString:[self getHost] secondString:@"users"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];

    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {

                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"getUser Called and Returned: %@", result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

- (void)createUser:(NSString *)email
            passwd:(NSString *)passwd
         firstName:(NSString *)firstName
          lastName:(NSString *)lastName
          callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc] initWithString:[self addString:[self getHost] secondString:@"users"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:firstName forHTTPHeaderField:@"VsitFirstName"];
    [request addValue:lastName forHTTPHeaderField:@"VsitLastName"];
    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {

                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"CreateUser Called and Returned: %@", result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

- (void)setUser:(NSString *)email
         passwd:(NSString *)passwd
      firstName:(NSString *)firstName
       lastName:(NSString *)lastName
       callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc] initWithString:[self addString:[self getHost] secondString:@"users"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"PUT"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:firstName forHTTPHeaderField:@"VsitFirstName"];
    [request addValue:lastName forHTTPHeaderField:@"VsitLastName"];
    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {

                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"setUser Called and Returned: %@", result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

- (void)deleteUser:(NSString *)email
            passwd:(NSString *)passwd
          callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc] initWithString:[self addString:[self getHost] secondString:@"users"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"DELETE"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];

    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {
                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"deleteUser Called and Returned: %@", result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

#pragma mark - Enrollment API Calls

- (void)getEnrollments:(NSString *)email
                passwd:(NSString *)passwd
              callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc]
                        initWithString:[self addString:[self getHost] secondString:@"enrollments"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];

    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {
                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"getEnrollments Called and Returned: %@", result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

- (void)getEnrollmentsCount:(NSString *)email
                     passwd:(NSString *)passwd
                    vppText:(NSString *)vppText
                   callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[[NSURL alloc]
                                                 initWithString:[self addString:[self getHost] secondString:@"enrollments/count"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"GET"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:vppText forHTTPHeaderField:@"VppText"];


    NSURLSessionDataTask *task =
    [session dataTaskWithRequest:request
               completionHandler:^(NSData *data, NSURLResponse *response,
                                   NSError *error) {
                   NSString *result =
                   [[NSString alloc] initWithData:data
                                         encoding:NSUTF8StringEncoding];
                   NSLog(@"getEnrollmentsCount Called and Returned: %@", result);
                   // Add Call to Callback function passing in result
                   callback(result);
               }];
    [task resume];
}

- (void)createEnrollment:(NSString *)email
                  passwd:(NSString *)passwd
     pathToEnrollmentWav:(NSString *)pathToEnrollmentWav
         contentLanguage:(NSString *)contentLanguage
                callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc]
                        initWithString:[self addString:[self getHost] secondString:@"enrollments"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"audio/wav" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:contentLanguage forHTTPHeaderField:@"ContentLanguage"];
    [request
        setHTTPBody:[[NSData alloc] initWithContentsOfFile:pathToEnrollmentWav]];

    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {
                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"createEnrollment Called and Returned: %@", result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

- (void)createEnrollmentByWavURL:(NSString *)email
                          passwd:(NSString *)passwd
              urlToEnrollmentWav:(NSString *)urlToEnrollmentWav
                 contentLanguage:(NSString *)contentLanguage
                        callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc]
                        initWithString:[self addString:[self getHost] secondString:@"enrollments/bywavurl"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"audio/wav" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:urlToEnrollmentWav forHTTPHeaderField:@"VsitwavURL"];
    [request addValue:contentLanguage forHTTPHeaderField:@"ContentLanguage"];


    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {
                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"createEnrollmentByWavURL Called and Returned: %@",
                           result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

- (void)deleteEnrollment:(NSString *)email
                  passwd:(NSString *)passwd
            enrollmentId:(NSString *)enrollmentId
                callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc]
                        initWithString:
                            [[NSString alloc]
                                initWithFormat:@"%@%@",[self addString:[self getHost] secondString:@"enrollments/"],
                                               enrollmentId]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"DELETE"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];

    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {
                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"deleteEnrollment Called and Returned: %@", result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

#pragma mark - Authentication API Calls

- (void)authentication:(NSString *)email
                     passwd:(NSString *)passwd
    pathToAuthenticationWav:(NSString *)pathToAuthenticationWav
                   accuracy:(NSString *)accuracy
             accuracyPasses:(NSString *)accuracyPasses
      accuracyPassIncrement:(NSString *)accuracyPassIncrement
                 confidence:(NSString *)confidence
            contentLanguage:(NSString *)contentLanguage
                   callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc]
                        initWithString:[self addString:[self getHost] secondString:@"authentications"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"audio/wav" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:accuracy forHTTPHeaderField:@"VsitAccuracy"];
    [request addValue:accuracyPasses forHTTPHeaderField:@"VsitAccuracyPasses"];
    [request addValue:accuracyPassIncrement
        forHTTPHeaderField:@"VsitAccuracyPassIncrement"];
    [request addValue:confidence forHTTPHeaderField:@"VsitConfidence"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:contentLanguage forHTTPHeaderField:@"ContentLanguage"];
    [request setHTTPBody:[[NSData alloc]
                             initWithContentsOfFile:pathToAuthenticationWav]];

    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {
                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"authentication Called and Returned: %@", result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

- (void)authenticationByWavURL:(NSString *)email
                        passwd:(NSString *)passwd
        urlToAuthenticationWav:(NSString *)urlToAuthenticationWav
                      accuracy:(NSString *)accuracy
                accuracyPasses:(NSString *)accuracyPasses
         accuracyPassIncrement:(NSString *)accuracyPassIncrement
                    confidence:(NSString *)confidence
               contentLanguage:(NSString *)contentLanguage
                      callback:(void (^)(NSString *))callback
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
        initWithURL:[[NSURL alloc] initWithString:[self addString:[self getHost] secondString:@"authentications/bywavurl"]]];
    NSURLSession *session = [NSURLSession sharedSession];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"14" forHTTPHeaderField:@"PlatformID"];
    [request addValue:@"audio/wav" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:self.developerId forHTTPHeaderField:@"VsitDeveloperId"];
    [request addValue:email forHTTPHeaderField:@"VsitEmail"];
    [request addValue:accuracy forHTTPHeaderField:@"VsitAccuracy"];
    [request addValue:accuracyPasses forHTTPHeaderField:@"VsitAccuracyPasses"];
    [request addValue:accuracyPassIncrement
        forHTTPHeaderField:@"VsitAccuracyPassIncrement"];
    [request addValue:confidence forHTTPHeaderField:@"VsitConfidence"];
    [request addValue:[self sha256:passwd] forHTTPHeaderField:@"VsitPassword"];
    [request addValue:urlToAuthenticationWav forHTTPHeaderField:@"VsitwavURL"];
    [request addValue:contentLanguage forHTTPHeaderField:@"ContentLanguage"];

    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:request
                   completionHandler:^(NSData *data, NSURLResponse *response,
                                       NSError *error) {
                     NSString *result =
                         [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
                     NSLog(@"authenticationByWavURL Called and Returned: %@",
                           result);
                     // Add Call to Callback function passing in result
                     callback(result);
                   }];
    [task resume];
}

@end
