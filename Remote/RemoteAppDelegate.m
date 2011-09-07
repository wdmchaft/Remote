//
//  RemoteAppDelegate.m
//  Remote
//
//  Created by Laurence Bortfeld on 07.09.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import "RemoteAppDelegate.h"
#import "RemoteControl.h"
#import "AppleRemote.h"
#import "MultiClickRemoteBehavior.h"

@implementation RemoteAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
   _remoteControll = [[AppleRemote alloc] initWithDelegate: self];
	[_remoteControll setDelegate: self];	
    
	// OPTIONAL CODE 
	// The MultiClickRemoteBehavior adds extra functionality.
	// It works like a middle man between the delegate and the remote control
	remoteBehavior = [MultiClickRemoteBehavior new];		
	[remoteBehavior setDelegate: self];
	[_remoteControll setDelegate: remoteBehavior];

    [_remoteControll startListening: self];
}


- (void) remoteButton: (RemoteControlEventIdentifier)buttonIdentifier pressedDown: (BOOL) pressedDown clickCount: (unsigned int)clickCount
{
    if (pressedDown == YES) return;
    NSLog(@"Click");
}

@end
