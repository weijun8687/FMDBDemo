//
//  DBTool.h
//  FMDBDemo
//
//  Created by WJ on 2017/8/22.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBTool : NSObject

+(instancetype)shareDataBase;
// 创建数据
-(void) createDatas;
// 
//查询表中的所有数据
- (void)selectAllUserWithTable_name:(NSString *)tableName;

@end
