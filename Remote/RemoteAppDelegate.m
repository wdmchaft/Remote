/*****************************************************************************
 * RemoteAppDelegate.m
 * Remote
 *
 * Created by Laurence Bortfeld on 08.09.2011 under a MIT-style license. 
 * Copyright (c) 2011. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a 
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 *****************************************************************************/

#import "RemoteAppDelegate.h"
#import "AppleRemote.h"
#import "RemoteControl.h"
#import "MultiClickRemoteBehavior.h"

@implementation RemoteAppDelegate

@synthesize window;
@synthesize remoteControll = _remoteControl;
@synthesize indicator = _indicator;

static int ARROW_LEFT = 123;
static int ARROW_RIGHT = 124;
static int ARROW_UP = 126;
static int ARROW_DOWN = 125;

- (void)disableInidcator
{
    [_indicator setIntValue:0];
}


#pragma mark - NSApplication delegates

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
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
    
    int keyCode = 0;
    
    switch (buttonIdentifier) {
        case kRemoteButtonLeft:
            keyCode = ARROW_LEFT;
            break;
        case kRemoteButtonRight:
            keyCode = ARROW_RIGHT;
            break;
        case kRemoteButtonPlus:
            keyCode = ARROW_DOWN;
            break;
        case kRemoteButtonMinus:
            keyCode = ARROW_UP;
            break;
        case kRemoteButtonPlay:
            keyCode = ARROW_RIGHT;
            break;
        case kRemoteButtonMenu:
            keyCode = ARROW_RIGHT;
            break;
        default:
            keyCode = ARROW_RIGHT;
            break;
    }

    CGEventRef e1 = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)keyCode, true);
    CGEventPost(kCGSessionEventTap, e1);
    CFRelease(e1);
    
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
