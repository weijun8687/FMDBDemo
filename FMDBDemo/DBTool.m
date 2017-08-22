//
//  DBTool.m
//  FMDBDemo
//
//  Created by WJ on 2017/8/22.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "DBTool.h"

@interface DBTool ()

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong)NSMutableArray *mArr;

@end

@implementation DBTool

+ (instancetype)shareDataBase{

    static DBTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[DBTool alloc] init];
        
    });
    return tool;
}

- (instancetype)init{
    if (self = [super init]) {
        if (!self.db) {
            
            NSString *path;
            path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            path = [path stringByAppendingString:@"/sql.sqlite"];
            self.db = [FMDatabase databaseWithPath:path];
            [self.db open];
            [self createtable];
        }
    }
    return self;
}

- (void)createtable{
    // 建表之前一定要确保数据库为打开状态
    BOOL success = [self.db executeUpdate:@"create table if not exists person (Id INTEGER PRIMARY KEY AUTOINCREMENT, name text, sex text)"];
    
    NSLog(@"success is %d", success);
    
//    [self createDatas];

}

- (void)selectAllUserWithTable_name:(NSString *)tableName{
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
            NSLog(@"%@: %@",name, value);
        }
        
        [arrObj addObject:dic];
    }
    
    NSLog(@"%ld", arrObj.count);
    
}

- (void)createDatas{
    NSDictionary *dic = @{ @"name":@"张三",  @"sex":@"true"};
    [self.mArr addObject:dic];

    NSDictionary *dic1 = @{ @"name":@"李四", @"sex":@"false"};
    [self.mArr addObject:dic1];
    
    NSDictionary *dic2 = @{ @"name":@"王五"};
    [self.mArr addObject:dic2];
    
    NSDictionary *dic3 = @{ @"name":@"老魏", @"sex":@"false"};
    [self.mArr addObject:dic3];
    
    
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

- (NSMutableArray *)mArr{
    if (!_mArr) {
        _mArr = [NSMutableArray array];
    }
    return _mArr;
}





@end
