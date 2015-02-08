//
//  Stack.m
//  memo-me-there
//
//  Created by Eric Mentele on 2/3/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "Stack.h"

@implementation Stack

-(instancetype)init {
  
  self = [super init];
  if (self) {
    
    _items = [[NSMutableArray alloc] init];
  }
  return self;
}


-(void)push:(id)item {
  
  [_items addObject:item];
}


-(id)peek{
  
  NSLog(@"%@",_items.lastObject);
  return _items.lastObject;
}


-(id)pop{
  
  id item = _items.lastObject;
  [_items removeLastObject];
  return item;
}

@end
