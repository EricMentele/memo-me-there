//
//  Queue.m
//  memo-me-there
//
//  Created by Eric Mentele on 2/3/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "Queue.h"

@implementation Queue

-(instancetype)init {
  
  self = [super init];
  if (self) {
    
    _items = [[NSMutableArray alloc] init];
  }
  return self;
}


-(void)enqueue:(id)item {
  
  [_items addObject:item];
}


-(id)dequeue{
  
  id item = _items.firstObject;
  [_items removeObjectAtIndex:0];
  return item;
}


-(id)peek{
  
  NSLog(@"%@",_items.firstObject);
  return _items.firstObject;
}
@end
