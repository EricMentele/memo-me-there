//
//  Queue.h
//  memo-me-there
//
//  Created by Eric Mentele on 2/3/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

@property (strong,nonatomic) NSMutableArray *items;

-(void)enqueue:(id)item;
-(id)dequeue;
-(id)peek;

@end
