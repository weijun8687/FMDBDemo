//
//  SecondViewController.m
//  FMDBDemo
//
//  Created by WJ on 2017/8/22.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "SecondViewController.h"
#import "DBTool.h"

@interface SecondViewController ()

@property (nonatomic, strong) DBTool *tool;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Second";
    
    if (!self.tool) {
        self.tool = [DBTool shareDataBase];
    }
    
    NSLog(@"%p",self.tool);
    
}


@end
