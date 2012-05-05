//
//  AppDelegate.m
//  PlistCryption
//
//  Created by jimmy liao on 4/13/12.
//  Copyright (c) 2012 TwinFish Technology Co.Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "NSDataAESCrypt.h"
#import "NSStringAdditions.h"

@implementation AppDelegate

#define kCryptionKey                @"Daifugo"

@synthesize window = _window;
@synthesize textView = _textView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

}

- (void)convertPlistCryption:(NSString *)fileName toPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // change file path with your own location
    NSData *fileData = [fileManager contentsAtPath:[NSString stringWithFormat:@"%@/%@.plist", filePath, fileName]];
    NSLog(@"%@", fileData);
    [fileManager createFileAtPath:[NSString stringWithFormat:@"%@/%@", filePath, [fileName MD5String]] 
                         contents:[fileData AES256EncryptWithKey:kCryptionKey] 
                       attributes:nil];
}

- (IBAction)openPlist:(id)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.allowsMultipleSelection = YES;
    openPanel.canCreateDirectories = NO;
    openPanel.allowedFileTypes = [NSArray arrayWithObjects:@"plist", nil];
    NSInteger eventInteger = [openPanel runModal];
    if (eventInteger == NSOKButton) {
        filePathArray = [NSMutableArray arrayWithArray:[openPanel URLs]];
        NSString *filePath = [NSString string];
        for (NSURL *url in filePathArray) {
            filePath = [filePath stringByAppendingFormat:@"%@\n", [url path]];
            NSLog(@"%@", [[[url path] lastPathComponent] stringByDeletingPathExtension]);
        }
        _textView.string = filePath;
    } 
}

- (IBAction)savePlist:(id)sender
{
    for (NSURL *url in filePathArray) {
        NSString *filePath = [[url path] stringByDeletingLastPathComponent];
        NSString *fileName = [[[url path] lastPathComponent] stringByDeletingPathExtension];
        [self convertPlistCryption:fileName toPath:filePath];
    }
}

- (IBAction)resetFiles:(id)sender
{
    _textView.string = @"";
    [filePathArray removeAllObjects];
}

@end
