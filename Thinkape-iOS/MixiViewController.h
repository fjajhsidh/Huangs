//
//  MixiViewController.h
//  Thinkape-iOS
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 TIXA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MixiViewController : UIViewController
@property(nonatomic,assign)long index;
@property(nonatomic,strong)NSMutableArray *costatrraylost;
@property(nonatomic,strong)NSMutableArray *costarrdate;
@property(nonatomic,strong)NSString *dexcel;

@property(nonatomic,strong)NSMutableDictionary *dict2;
//wo
@property(nonatomic,strong)NSString * selectAcceptType;
@property(nonatomic,assign)BOOL hudong;
@property(nonatomic,assign)int indexsele;
@property (nonatomic , strong) UIView * calculatorView;
@property(nonatomic) BOOL delaysContentTouches;
@end
