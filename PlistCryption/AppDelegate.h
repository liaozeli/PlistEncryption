//
//  AppDelegate.h
//  PlistCryption
//
//  Created by jimmy liao on 4/13/12.
//  Copyright (c) 2012 TwinFish Technology Co.Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSMutableArray *filePathArray;
    
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *textView;

- (IBAction)openPlist:(id)sender;
- (IBAction)savePlist:(id)sender;
- (IBAction)resetFiles:(id)sender;

@end
