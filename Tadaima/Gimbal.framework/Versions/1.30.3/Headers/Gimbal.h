/**
 * Copyright (C) 2014 Gimbal, Inc. All rights reserved.
 *
 * This software is the confidential and proprietary information of Gimbal, Inc.
 *
 * The following sample code illustrates various aspects of the Gimbal SDK.
 *
 * The sample code herein is provided for your convenience, and has not been
 * tested or designed to work on any particular system configuration. It is
 * provided AS IS and your use of this sample code, whether as provided or with
 * any modification, is at your own risk. Neither Gimbal, Inc. nor any
 * affiliate takes any liability nor responsibility with respect to the sample
 * code, and disclaims all warranties, express and implied, including without
 * limitation warranties on merchantability, fitness for a specified purpose,
 * and against infringement.
 */

#import <Foundation/Foundation.h>

#ifndef _GIMBAL_
#define _GIMBAL_

#import <Gimbal/GMBLPlaceManager.h>
#import <Gimbal/GMBLPlace.h>
#import <Gimbal/GMBLAttributes.h>

#import <Gimbal/GMBLCommunicationManager.h>
#import <Gimbal/GMBLCommunication.h>

#endif


/*!
 The Gimbal class contains functions that handle the global configuration of the Gimbal framework.
 */
@interface Gimbal : NSObject

/*!
 Sets the API for your Gimbal application.
 @param APIKey The client API key for your Gimbal application.
 @param options The options you'd like to start the Gimbal application with
 */
+ (void)setAPIKey:(NSString *)APIKey options:(NSDictionary *)options;

/*!
 Returns the application instance identifier that is unique across your users
 @result The string that identifies this application instance
 */
+ (NSString *)applicationInstanceIdentifier;

/*!
 Deletes all the user data associated to the user on the device.
 
 If deletion is successfull, all gimbal settings are reset to default state.
 @param The block to execute when the user data deletion has completed or when an error occours.
 */
+ (void)resetApplicationInstanceIdentifierWithCompletionHandler:(void (^)(BOOL success, NSError *error))completionHandler;

@end