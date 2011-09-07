//
//  RemoteAppDelegate.h
//  Remote
//
//  Created by Laurence Bortfeld on 07.09.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RemoteControll;
@class MultiClickRemoteBehavior;


@interface RemoteAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    
    RemoteControll *_remoteControll;
    MultiClickRemoteBehavior* remoteBehavior;
}

@property (assign) IBOutlet NSWindow *window;

@end
