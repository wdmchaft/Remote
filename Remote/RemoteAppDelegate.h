//
//  RemoteAppDelegate.h
//  Remote
//
//  Created by Laurence Bortfeld on 07.09.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RemoteControl;
@class MultiClickRemoteBehavior;


@interface RemoteAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    
    RemoteControl *_remoteControl;
    MultiClickRemoteBehavior *_remoteBehavior;
    NSLevelIndicator *_indicator;
}

@property(assign) IBOutlet NSWindow *window;
@property(nonatomic, retain) IBOutlet RemoteControl *remoteControll;
@property(nonatomic, retain) IBOutlet NSLevelIndicator *indicator;

- (IBAction)enableDisableRemoteControll:(id)sender;
- (void)disableInidcator;

@end
