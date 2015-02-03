//
//  Person.m
//  memo-me-there
//
//  Created by Eric Mentele on 2/2/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "Person.h"

@interface Person()

@property (strong,nonatomic) NSString *myName;

@end

@implementation Person

-(instancetype)initWithName:(NSString *)name {
  
  self = [super init];
  
  if (self) {
    
    self.myName = name;
  
  }
  return self;
}

@end
