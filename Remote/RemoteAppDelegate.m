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
@synthesize indicator = _indicator;



- (void)disableInidcator
{
    [_indicator setIntValue:0];
}


#pragma mark - NSApplication delegates

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    [NSApp delete:self];
    _remoteControl = [[AppleRemote alloc] initWithDelegate: self];
    [_remoteControl setDelegate: self];	
    
	_remoteBehavior = [[MultiClickRemoteBehavior alloc] init];		
	[_remoteBehavior setDelegate: self];
	[_remoteControl setDelegate: _remoteBehavior];

    [_remoteControl startListening: self];
    [_remoteControl setListeningToRemote:NO];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [_remoteControl stopListening:self];
    
    [_remoteControl release]; _remoteControl = nil;
    [_remoteBehavior release]; _remoteBehavior = nil;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}



#pragma mark - RemoteControl delegate
- (void) remoteButton:(RemoteControlEventIdentifier)buttonIdentifier pressedDown:(BOOL)pressedDown clickCount: 
  (unsigned int)clickCount
{
    if (pressedDown == YES) {
        [_indicator setIntValue:1];
        return;
    } else {
        [self disableInidcator];
    }

    [_indicator setIntValue:1];
    [self performSelector:@selector(disableInidcator) withObject:self afterDelay:0.1];
   
}



#pragma mark - IBActions

- (IBAction)enableDisableRemoteControll:(id)sender
{
    if (_remoteControl.isListeningToRemote == YES) {
        [_remoteControl setListeningToRemote:NO];
    } else {
        [_remoteControl setListeningToRemote:YES];
    }
}

@end
