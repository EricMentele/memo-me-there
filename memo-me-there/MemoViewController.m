//
//  MemoViewController.m
//  memo-me-there
//
//  Created by Eric Mentele on 2/4/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "MemoViewController.h"

@interface MemoViewController ()

@end

@implementation MemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  NSLog(@" long: %f lat: %f", self.annotation.coordinate.longitude, self.annotation.coordinate.latitude);
}


- (IBAction)memoButtonPressed:(id)sender {
  NSLog(@"MEMO ME");
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
