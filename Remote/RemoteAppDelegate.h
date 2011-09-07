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
    MultiClickRemoteBehavior* remoteBehavior;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) RemoteControl *remoteControll;

- (IBAction)enableDisableRemoteControll:(id)sender;

@end
