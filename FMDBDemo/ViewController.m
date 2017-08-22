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
    
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSString *path;
//    path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    
//    path = [path stringByAppendingString:@"/mysql.sqlite"];
//    
//    NSLog(@"path is : %@", path);
//    
//    self.db = [FMDatabase databaseWithPath:path];
//    [self.db open];
//    
//    // 建表之前一定要确保数据库为打开状态
//    BOOL success = [self.db executeUpdate:@"create table if not exists person (Id INTEGER PRIMARY KEY AUTOINCREMENT, name text, sex text)"];
//    
//    NSLog(@"success is %d", success);
//    
////    [self createDatas];
//    
//    [self selectAllUserWithTable_name:@"person" obj:3];
    
    if (!self.tool) {
        self.tool = [DBTool shareDataBase];
    }
    
//    [self.tool createDatas];
    
    NSLog(@"%p",self.tool);
    
    
    
}

- (void)updateUserWithTableName:(NSString *)table_name{
    
    
    
}

- (void)selectAllUserWithTable_name:(NSString *)tableName obj:(int)col{
    NSString *strSelect = [NSString stringWithFormat:@"select *from %@",tableName];
    
    NSMutableArray *arrObj = [NSMutableArray array];
    FMResultSet *set = [self.db executeQuery:strSelect];
//    NSLog(@" set is %@", set);
    while ([set next]) {
        
        int total = [set intForColumnIndex:0];
        NSLog(@"total is %d",total);
        
        
//        set 
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        // columnCount FMResultSet 的总列数
        for (int i = 0; i< set.columnCount; i++) {
            NSString *name = [set columnNameForIndex:i];
            NSString *value = [NSString stringWithFormat:@"%@",[set objectForColumn:name]];;
            [dic setObject:value forKey:name];
        }
        
        [arrObj addObject:dic];
    }
    
    NSLog(@"%ld", arrObj.count);
    
}

- (void)createDatas{
//    NSDictionary *dic = @{@"Id":@2, @"name":@"张三",  @"sex":@"true"};
//    [self.mArr addObject:dic];
//    
//    NSDictionary *dic1 = @{ @"name":@"李四", @"sex":@"false"};
//    [self.mArr addObject:dic1];
    
    NSDictionary *dic = @{@"Id":@2, @"name":@"王五"};
    [self.mArr addObject:dic];
    
    NSDictionary *dic1 = @{ @"name":@"老魏", @"sex":@"false"};
    [self.mArr addObject:dic1];

    
    for (NSDictionary *dicTemp in self.mArr) {
        [self insertIntoDatabaseInfo:dicTemp table_name:@"person"];
    }
}

- (void)insertIntoDatabaseInfo:(NSDictionary *)dic table_name:(NSString *)tableName{
    if (dic == nil) {
        return;
    }
    NSString *str;
    str = [NSString stringWithFormat:@"insert into %@ (",tableName];
    
    NSString *strKeys = @"";
    NSString *strValues = @"";
    NSEnumerator *enumerator = [dic keyEnumerator];
    for (NSString *key in enumerator) {
        NSString *sdic = [dic objectForKey:key];
        
        if ([sdic isKindOfClass:[NSNumber class]]) {
            sdic = [[dic objectForKey:key] stringValue];
        }
        
        strKeys = [strKeys stringByAppendingString:key];
        strKeys = [strKeys stringByAppendingString:@","];
        
        strValues = [strValues stringByAppendingString:[NSString stringWithFormat:@"\" %@ \",", (NSString *)sdic]];
    }
    
    strKeys = [strKeys substringToIndex:strKeys.length - 1];
    strValues = [strValues substringToIndex:strValues.length - 1];
    
    str = [str stringByAppendingString:[NSString stringWithFormat:@"%@) values(%@);",strKeys, strValues]];
    
    BOOL success = [self.db executeUpdate:str];
    
    NSLog(@"insert datas success is %d", success);
    
}

- (IBAction)clickButton:(id)sender {
    
    SecondViewController *vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (NSMutableArray *)mArr{
    if (!_mArr) {
        _mArr = [NSMutableArray array];
    }
    return _mArr;
}

- (NSMutableDictionary *)mdic{
    if (!_mdic) {
        _mdic = [NSMutableDictionary dictionary];
    }
    return _mdic;
}



@end
