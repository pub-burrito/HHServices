//
//  ViewController.m
//  PublisherSample
//
//  Created by Tobias Löfstrand on 2013-09-21.
//  Copyright (c) 2013 Leafnode AB. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController {
    HHServicePublisher* publisherRAOP;
    HHServicePublisher* publisherAirPlay;
}


#pragma mark - Lifecycle

- (id) init {
    if( self = [super init] ) {
        // Setup the service publisher - remember to update the type parameter with your actual service type
        publisherRAOP = [[HHServicePublisher alloc] initWithName:@"5855CA1AE288@test"
                                                        type:@"_raop._tcp."
                                                      domain:@"local."
                                                        host:@"some-host.local."
                                                          ip:@"192.168.2.165"
                                                     txtData:[@{
                                                              @"txtvers": @"1",
                                                              @"ch": @"2",
                                                              @"cn": @"0,1,2,3",
                                                              @"da": @"true",
                                                              @"et": @"0,3,5",
                                                              @"md": @"0,1,2",
                                                              @"pw": @"false",
                                                              @"sv": @"false",
                                                              @"sr": @"44100",
                                                              @"ss": @"16",
                                                              @"tp": @"UDP",
                                                              @"vn": @"65537",
                                                              @"vs": @"150.33",
                                                              @"am": @"AppleTV3,1",
                                                              @"sf": @"0x4"
                                                              } dataFromTXTRecordDictionary]
                                                        port:47000];
        
        publisherAirPlay = [[HHServicePublisher alloc] initWithName:@"test"
                                                        type:@"_airplay._tcp."
                                                      domain:@"local."
                                                        host:@"some-host.local."
                                                          ip:@"192.168.2.165"
                                                     txtData:[@{
                                                             @"deviceid": @"58:55:CA:1A:E2:88",
                                                             @"features": @"0x100029ff",
                                                             @"model": @"AppleTV3,1",
                                                             @"srcvers": @"150.33"
                                                             } dataFromTXTRecordDictionary]
                                                        port:7000];
        publisherRAOP.delegate = self;
    }
    return self;
}

- (void) loadView {
    UIView* rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    rootView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(40, 50, 240, 44);
    [button setTitle:@"Publish" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(beginPublish) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(40, 100, 240, 44);
    [button setTitle:@"Unpublish" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(endPublish) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:button];
    
    self.view = rootView;
}


#pragma mark - Actions

- (void) beginPublish {
    [publisherRAOP beginPublish];
    [publisherAirPlay beginPublish];
}

- (void) endPublish {
    [publisherRAOP endPublish];
    [publisherAirPlay endPublish];
}


#pragma mark - HHServicePublisherDelegate
    
- (void) serviceDidPublish:(HHServicePublisher*)servicePublisher {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Publish result" message:@"Publish successful!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (void) serviceDidNotPublish:(HHServicePublisher*)servicePublisher {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Publish result" message:@"Publish failed!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

@end
