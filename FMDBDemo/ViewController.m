//
//  ViewController.m
//  FMDBDemo
//
//  Created by WJ on 2017/8/21.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "ViewController.h"
#import "DBTool.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (nonatomic, strong)FMDatabase *db;
@property (nonatomic, strong)NSMutableArray *mArr;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)NSMutableDictionary *mdic;
@property (nonatomic, strong)DBTool *tool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    self.title = @"First";
    
    if (!self.tool) {
        self.tool = [DBTool shareDataBase];
    }
    
    // 往表中插入数据
//    [self.tool createDatas];
    
    [self.tool selectAllUserWithTable_name:@"person"];
    
    NSLog(@"%p",self.tool);
    
    
    
}


- (IBAction)clickButton:(id)sender {
    
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}




@end
