//
//  CostLayoutModel.h
//  Thinkape-iOS
//
//  Created by tixa on 15/5/27.
//  Copyright (c) 2015年 TIXA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CostLayoutModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *photopath;
@property (nonatomic,strong) NSString *TotalMoney;
@property (nonatomic,strong) NSMutableArray *fileds;
@property(nonatomic,strong) NSString *PrimaryKey;
@property(nonatomic,strong) NSString *RelationKey;
@property(nonatomic,strong) NSString *SqlTableName;
@property(nonatomic,strong)NSString *gridmainid;

@end
