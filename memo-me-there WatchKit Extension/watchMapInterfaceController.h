//
//  watchMapInterfaceController.h
//  memo-me-there
//
//  Created by Eric Mentele on 2/6/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface watchMapInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceMap *watchMap;
@property (strong,nonatomic) CLCircularRegion *region;


@end
