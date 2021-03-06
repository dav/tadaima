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

@protocol GMBLCommunicationManagerDelegate;

/*!
 The GMBLCommunicationManager defines the interface for delivering communication events to your Gimbal enabled 
 application. 
 
 In order to receive communications associated to place entry and exit events, you must assign a class that conforms to
 the GMBLCommunicationManagerDelegate protocol to the delegate property of GMBLCommunicationManager.
 */
@interface GMBLCommunicationManager : NSObject

/// The delegate object to receive communication events.
@property (weak, nonatomic) id<GMBLCommunicationManagerDelegate> delegate;

@end

@class GMBLPlace;

/*!
 The GMBLCommunicationManagerDelegate protocol defines the methods used to receive events for the 
 GMBLCommunicationManager object.
 */
@protocol GMBLCommunicationManagerDelegate <NSObject>

@optional

/*!
 Tells the delegate that the user has a communication for the place that was entered.
 @param manager The communication manager object reporting the event.
 @param communications An array containing one or more GMBLCommunication associated to the place entered.
 @param place An object containing information about the place that was entered.
 @param date The date that the enter event occoured at.
 */
- (void)communicationManager:(GMBLCommunicationManager *)manager
    didReceiveCommunications:(NSArray *)communications
                    forPlace:(GMBLPlace *)place
                   enteredAt:(NSDate *)date;

/*!
 Tells the delegate that the user has a communication for the place that was exited.
 @param manager The communication manager object reporting the event.
 @param communications An array containing one or more GMBLCommunication associated to the place exited.
 @param place An object containing information about the place that was exited.
 @param date The date that the enter event occoured at.
 */
- (void)communicationManager:(GMBLCommunicationManager *)manager
    didReceiveCommunications:(NSArray *)communications
                    forPlace:(GMBLPlace *)place
                    exitedAt:(NSDate *)date;

@end