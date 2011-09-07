//
//  RemoteAppDelegate.m
//  Remote
//
//  Created by Laurence Bortfeld on 07.09.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import "RemoteAppDelegate.h"
#import "AppleRemote.h"
#import "RemoteControl.h"
#import "MultiClickRemoteBehavior.h"

@implementation RemoteAppDelegate

@synthesize window;
@synthesize remoteControll = _remoteControl;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
   _remoteControl = [[AppleRemote alloc] initWithDelegate: self];
	[_remoteControl setDelegate: self];	
    
	// OPTIONAL CODE 
	// The MultiClickRemoteBehavior adds extra functionality.
	// It works like a middle man between the delegate and the remote control
	remoteBehavior = [MultiClickRemoteBehavior new];		
	[remoteBehavior setDelegate: self];
	[_remoteControl setDelegate: remoteBehavior];

    [_remoteControl startListening: self];
    [_remoteControl setListeningToRemote:NO];
}

- (void) remoteButton: (RemoteControlEventIdentifier)buttonIdentifier pressedDown: (BOOL) pressedDown clickCount: (unsigned int)clickCount
{
    if (pressedDown == YES) return;

    NSLog(@"Click");
}

- (IBAction)enableDisableRemoteControll:(id)sender
{
    if (_remoteControl.isListeningToRemote == YES) {
        [_remoteControl setListeningToRemote:NO];
    } else {
        [_remoteControl setListeningToRemote:YES];
    }
}

@end
