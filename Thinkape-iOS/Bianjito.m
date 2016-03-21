//
//  Bianjito.m
//  Thinkape-iOS
//
//  Created by admin on 15/12/29.
//  Copyright © 2015年 TIXA. All rights reserved.
//

#import "Bianjito.h"
#import "CostLayoutModel.h"
#import "LayoutModel.h"
#import "Bianjiviewtableview.h"
#import "AppDelegate.h"
#import "MixiViewController.h"
#import "MiXimodel.h"
#import "BijicellTableViewCell.h"
#import "KindsItemsView.h"
#import "DatePickerView.h"
#import "KindsPickerView.h"
#import "KindsLayoutModel.h"
#import "DataManager.h"
#import "KindsItemModel.h"
@interface Bianjito ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,KindsItemsViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableview2;
@property(nonatomic,strong)UIAlertView *activer;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)NSInteger firstindex;
@property(nonatomic,assign)int IsPage;
@property(nonatomic,strong)UITableView *subTableview;
@property(nonatomic,strong)CostLayoutModel *coster;
@property(nonatomic,strong)NSMutableArray *Tositoma;
@property(nonatomic,strong)NSMutableArray *subArray;
@property(nonatomic,strong)NSMutableDictionary *subDict;
@property(nonatomic,strong)UIButton *imageview;
@property(nonatomic,strong)UITextField *textfield;
@property (strong, nonatomic) KindsModel *selectModel;
@property (strong, nonatomic) KindsPickerView *kindsPickerView;
@property(nonatomic,strong)DatePickerView *datePickerView;
@property(nonatomic,strong)NSMutableDictionary *Dictns;
@property(nonatomic,strong)UIBarButtonItem *item;
@property(nonatomic,strong)UIBarButtonItem *items;
@property(nonatomic,strong)NSString *stringall;
@property(nonatomic,strong)NSMutableArray *recolpend;
@end

@implementation Bianjito

{
    CGFloat width;
    CGFloat itemWidth;
    CGFloat speace;
    UILabel *label;
    UIView *ada;
    BOOL isSinglal;
    UIButton *addRightAdd;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self viewDidLoad];
    
    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"明 细";
    
    itemWidth = 80;
    speace = 20;
    
    self.imageview.selected=YES;
    self.isbool=NO;
    
    [self itemLength];
    [self layoutScroll];
    [self addRightNavgation];
    
    
    self.scrollview.bounces=NO;
    self.navigationController.navigationBarHidden=NO;
    //    if (self.editstart==YES||self.isstrart==YES||self.isbool) {
    //        [self.tableview reloadData];
    //    }
   
    _editnew =[NSMutableDictionary dictionary];
    _coster=[self.costLayoutArray safeObjectAtIndex:_index];
    self.Tositoma =_coster.fileds;
    self.textfield=[[UITextField alloc] initWithFrame:CGRectMake(140, 5, 170, 30)];
    self.textfield.textAlignment=NSTextAlignmentCenter;
    self.textfield.contentVerticalAlignment=UIControlContentHorizontalAlignmentCenter;
    
}



-(void)addRightNavgation{
    
    
    
    
    self.imageview= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    //    [self.imageview setBackgroundImage:[UIImage imageNamed:@"jiaban_white.png"] forState:UIControlStateNormal];
    [self.imageview setTitle:@"返回" forState:UIControlStateNormal];
    
    [self.imageview addTarget:self action:@selector(appcer) forControlEvents:UIControlEventTouchUpInside];
    
    _item=[[UIBarButtonItem alloc] initWithCustomView:self.imageview];
    
    self.navigationItem.rightBarButtonItem=_item;
    
    
    
    
    
    
    
}
-(void)addRight
{
    addRightAdd =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [addRightAdd setBackgroundImage:[UIImage imageNamed:@"jiaban_white.png"] forState:UIControlStateNormal];
    [addRightAdd addTarget:self action:@selector(addNEW) forControlEvents:UIControlEventTouchUpInside];
    _items =[[UIBarButtonItem alloc] initWithCustomView:addRightAdd];
    
    
    
}

-(void)appcer
{
    
    
    self.imageview.selected=!self.imageview.selected;
    
    if (self.imageview.selected==YES) {
        
        [self.tableview reloadData];
        NSLog(@"点的以二次");
        return;
        
    }
    if (self.imageview.selected==NO)
    {
        [ada removeFromSuperview];
        
        [self.tableview reloadData];
        
        NSLog(@"点的以一次");
        return;
    }
    
    
    
}
-(void)addNEW
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//wo左下角的按钮
- (void)layoutScroll{
    
    UIScrollView  *bottomScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 80, SCREEN_WIDTH, 80)];
    for (int i = 0; i < _costLayoutArray.count; i++) {
        CostLayoutModel *model = [_costLayoutArray safeObjectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*(60 + 35), 10, 57, 57)];
        [btn addTarget:self action:@selector(costDetail:) forControlEvents:UIControlEventTouchUpInside];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.photopath]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ab_nav_bg.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        btn.tag = i;
        [bottomScroll addSubview:btn];
        UILabel *totleMoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, 57, 15)];
        totleMoney.textColor = [UIColor whiteColor];
        totleMoney.font = [UIFont systemFontOfSize:15];
        totleMoney.text = model.TotalMoney;
        totleMoney.textAlignment = NSTextAlignmentCenter;
        [btn addSubview:totleMoney];
    }
    [bottomScroll setContentSize:CGSizeMake(95*_costLayoutArray.count, 80)];
    bottomScroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:bottomScroll];
}
- (void)costDetail:(UIButton *)btn{
    
    _index = btn.tag;
    
    [self itemLength];
    [self.tableview reloadData];
    
}
- (void)itemLength{
    CostLayoutModel *model = [self.costLayoutArray safeObjectAtIndex:_index];
    width = (itemWidth + speace) * model.fileds.count +100+ speace;
    self.tableview2.constant = width + 24;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int number=0;
    
    
    
    if (self.imageview.selected==YES) {
        CostLayoutModel *model = [self.costLayoutArray objectAtIndex:_index];
        if (model.fileds.count!=0) {
            number=model.fileds.count;
            
        }
        
        
    }
    if (self.imageview.selected==NO) {
        
        {
            NSArray *array = [_costDataArr safeObjectAtIndex:_index ];
            number = array.count + 2;
            
        }
    }
    
    return number;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    if (self.imageview.selected==YES) {
        
        
        
        CostLayoutModel *model = [self.costLayoutArray safeObjectAtIndex:_index];
        MiXimodel *layoutModel =[model.fileds
                                 safeObjectAtIndex:indexPath.row];
        
        _subArray =[_costDataArr safeObjectAtIndex:_index];
        _subDict= [_subArray safeObjectAtIndex:indexPath.row];
        
        
        self.tableview2.constant = SCREEN_WIDTH;
        
        BijicellTableViewCell *cell = (BijicellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
       // [self.scrollview addSubview:self.tableview];
        
        
        
        
        if (!cell) {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"BijicellTableViewCell" owner:self options:nil] lastObject];
            
            
            
        }
        
        cell.textlabel.text=[NSString stringWithFormat:@"%@",layoutModel.name];
      
        
        
       
        self.recolpend = [NSMutableArray arrayWithArray:_dataArr];
        
        _datar = [NSMutableDictionary dictionaryWithDictionary:self.Dictns];
        
         self.stringall = [_datar objectForKey:layoutModel.fieldname];
        
        cell.detailtext.text= self.stringall;
        cell.detailtext.tag=indexPath.row;
        cell.detailtext.delegate =self;
        
        cell.backgroundColor = [UIColor whiteColor];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageview.hidden=NO;
        
        
        return cell;
        
    }
    
    if (self.imageview.selected==NO)
        
    {
        CostLayoutModel *model = [self.costLayoutArray safeObjectAtIndex:_index];
        
        self.tableview2.constant = width+24;
        NSString *cellid = @"cell";
        UITableViewCell *cell = (UITableViewCell *)[tableView  dequeueReusableCellWithIdentifier:cellid];
        cell.tag=10;
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.backgroundColor = [UIColor clearColor];
        for (UIView *subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
        }
        if (indexPath.row == 0) {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(12, 17, width, 30)];
            bgView.backgroundColor = [UIColor colorWithRed:0.275 green:0.557 blue:0.914 alpha:1.000];
            [cell.contentView addSubview:bgView];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(13, 7.5, width, 15)];
            title.font = [UIFont systemFontOfSize:15];
            title.text = model.name;
            title.textColor = [UIColor whiteColor];
            
            
            [bgView addSubview:title];
            
        }
        
        else{
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, width, 50)];
            bgView.tag = 304;
            for (int i = 0; i < model.fileds.count + 1; i++) {
                //            UILabel *label;
                UIButton *button;
                if (i == 0 ) {
                    label = [[UILabel alloc] initWithFrame:CGRectMake(35, 8, 40, 15)];
                    button=[[UIButton alloc] initWithFrame:CGRectMake(10, 8, 40, 15)];
                }
                else
                    
                    label = [[UILabel alloc] initWithFrame:CGRectMake(40+speace + (itemWidth + speace) * (i-1), 8, itemWidth, 15)];
                label.textAlignment = NSTextAlignmentCenter;
                label.font = [UIFont systemFontOfSize:13];
                label.tag = i;
                label.textColor = [UIColor colorWithHexString:@"333333"];
                
                button=[[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.origin.x-speace+(itemWidth+speace)*(i-1)-10, 8, itemWidth, 15)];
                //            button.font=[UIFont systemFontOfSize:13];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                button.tag=i;
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [bgView addSubview:label];
                [bgView addSubview:button];
                
                if (indexPath.row == 1)
                {
                    if (label.tag == 0) {
                        label.text = @"序号";
                        
                    }
                    else
                    {
                        LayoutModel *layoutModel = [model.fileds safeObjectAtIndex:label.tag - 1];
                        
                        
                        label.text = layoutModel.name;
                        
                        
                        
                    }
                    
                    if (button.tag==1) {
                        
                        [button setTitle:@"操作" forState:UIControlStateNormal];
                    }
                    
                }
                else
                {
                    if (label.tag == 0) {
                        label.text = [NSString stringWithFormat:@"%ld",indexPath.row - 1];
                        
                    }
                    
                    else{
                        
//                        
                       LayoutModel *layoutModel = [model.fileds safeObjectAtIndex:label.tag -1];
////                        
                       _dataArr = [_costDataArr safeObjectAtIndex:_index];
                        
                        
                        //                        if (_dataArr.count!=0) {
                        //                            [self readtodate];
                        //
                        //                        }
                        
//                        self.Dictns = [NSMutableDictionary dictionaryWithDictionary:_datar];
//                        _datar = [_dataArr safeObjectAtIndex: indexPath.row-2];
//                        
                        
                        
                     
                        
               
                        
                        
                            _datar = [_dataArr safeObjectAtIndex:indexPath.row-2];
                            self.Dictns =[NSMutableDictionary dictionaryWithDictionary:_datar];
                        
                             label.text = [self.Dictns objectForKey:layoutModel.fieldname];
                        
                        
                        
                            
                       // [self.tableview reloadData];
            
                        
                        
                        
                        
                        
                        
                        
                        //                        if (self.isbool==YES) {
                        //
                        //                        }
                        //
                        //                    if (self.editstart==YES||self.isstrart==YES) {
                        //                        [self saveto:_dataArr];
                        //                    }
                        
                        NSLog(@"%@",label.text);
                        
                    }
                    if (button.tag==1) {
                        [button setTitle:@"删除" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(buttonaction) forControlEvents:UIControlEventTouchUpInside];
                        [bgView addSubview:button];
                        
                    }
                }
            }
            [cell.contentView addSubview:bgView];
            
            if ((indexPath.row - 2) % 2 == 0)
                bgView.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
            else
                //序号的背景
                bgView.backgroundColor = [UIColor whiteColor];
            
            
            
        }
        
        
        
        self.imageview.hidden=YES;
        
        return cell;
        
    }
    
    return nil;
}
-(void)saveto
{
    NSDictionary *dic =@{@"sda":self.stringall};
    [dic writeToFile:[self filePath] atomically:YES];
}
-(void)readtodate
{
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithContentsOfFile:[self filePath]];
   self.stringall= [dic objectForKey:@"sda"];
}
-(NSString *)filePath{
    NSString *documentsPath =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath =[documentsPath stringByAppendingPathComponent:@"Yaxh.txt"];
    NSLog(@"文件夹位置%@",filePath);
    return filePath;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//    if (indexPath.row==1||indexPath.row==0) {
//        return;
//    }
//
//
//
//
//    AppDelegate *app =[UIApplication sharedApplication].delegate;
//
//    //    _datar = [_dataArr safeObjectAtIndex:_indexRow];
//    //    if (self.editstart==YES) {
//    //    _datar=self.self.editnew;
//    //     app.dict = _datar;
//    //    }else
//    //    {
//    //     app.dict=_datar;
//    //    }
//
//
//    _indexRow = indexPath.row-2;
//
//
//    if (_IsPage==_index) {
//
//
//        if (indexPath.row==_indexRow+2) {
//
//            if (self.editstart==YES||self.isstrart==YES) {
//
//
//
//
//                //                NSMutableArray *dateAll = [NSMutableArray arrayWithArray:_dataArr];
//                //                NSMutableDictionary *aller =[NSMutableDictionary dictionaryWithDictionary:self.editnew];
//                //                [dateAll replaceObjectAtIndex:_indexRow withObject:aller];
//
//                //                _dataArr = dateAll;
//                //
//
//
//                _datar = [_dataArr safeObjectAtIndex:indexPath.row-2];
//
//
//
//
//
//
//                //            if (indexPath.row==_firstindex+2) {
//                //
//                //                app.dict = _datar;
//                //
//                //            }
//
//            }
//            else
//            {
//                _dataArr = [_costDataArr safeObjectAtIndex:_index];
//
//
//
//
//                _datar = [_dataArr safeObjectAtIndex:_indexRow];
//
//            }
//        }
//
//    }
//    //    if (_IsPage!=_index) {
//    //        if (self.isstrart==YES) {
//    //
//    //
//    //
//    //
//    //                NSMutableArray *dateAll = [NSMutableArray arrayWithArray:_dataArr];
//    //                NSMutableDictionary *aller =[NSMutableDictionary dictionaryWithDictionary:self.editxiao];
//    //                [dateAll replaceObjectAtIndex:_indexRow withObject:aller];
//    //                _dataArr = dateAll;
//    //                _datar = [_dataArr safeObjectAtIndex:_indexRow];
//    //                app.dict = _datar;
//    //
//    //
//    //
//    //
//    //
//    //        }
//    //
//    //
//    //    }
//    //    else
//    //    {
//    //
//    //        app.dict = _datar;
//    //    }
//    MixiViewController *vc =[[MixiViewController alloc] init];
//    vc.index = _index;
//
//    vc.costatrraylost=self.costLayoutArray;
//    vc.costarrdate=_costDataArr;
//
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    _indexRow = indexPath.row;
    if (self.imageview.selected==NO) {
        if (indexPath.row==0||indexPath.row==1) {
            return;
        }
    }
    if (self.imageview.selected==YES) {
        if (indexPath.row==_indexRow) {
            return;
        }
    }
    self.imageview.selected=!self.imageview.selected;
    if (self.imageview.selected==YES) {
        
        _indexRow = indexPath.row-2;
        
               
       
        
       
       
        [self.tableview reloadData];
        NSLog(@"点的以二次");
        return;
    }
    if (self.imageview.selected==NO)
    {
        [ada removeFromSuperview];
        
        self.isbool=NO;
        [self.tableview reloadData];
        
        NSLog(@"点的以一次");
        return;
    }
    
}
-(void)buttonaction
{
    
    [self.costDataArr removeAllObjects];
    [self.tableview reloadData];
    
}
- (CGFloat )fixStr:(NSString *)str{
    CGRect frame = [str boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame) - 115, 99999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    return  frame.size.height >=0 ? frame.size.height : 20;
}
- (void)selectItem:(NSString *)name ID:(NSString *)ID view:(KindsItemsView *)view{
    
    NSInteger tag = view.tag;
    NSLog(@"%@=%@=%lu",name,ID,tag);
    NSLog(@"tag值%lu",self.textfield.tag);
     CostLayoutModel *model =[self.costLayoutArray safeObjectAtIndex:_index];
    
    MiXimodel *layoutModel = [model.fileds safeObjectAtIndex:self.textfield.tag];
    NSLog(@"键值：%@=%@",layoutModel.fieldname,name);
    
    
    
    
//    _datar = [NSMutableDictionary dictionaryWithDictionary:self.Dictns];
    
    [self.Dictns setObject:name forKey:layoutModel.fieldname];
    NSLog(@"字典：%@",_datar);
    self.isbool=YES;
    
    
    [view closed];
    [self.tableview reloadData];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    self.tableview.bounces=NO;
    //   CostLayoutModel *model =[self.costatrraylost safeObjectAtIndex:_index];
    NSLog(@"tag值：%lu",textField.tag);
    
    self.textfield.tag=textField.tag;
    CostLayoutModel *model = [self.costLayoutArray safeObjectAtIndex:_index];
    MiXimodel *model2 =[model.fileds
                        safeObjectAtIndex:self.textfield.tag];
    
    
    
    if (![model2.datasource isEqualToString:@"0"]&&![model2.sqldatatype isEqualToString:@"date"]) {
        
        
        isSinglal =model2.issingle;
        
        [self kindsDataSource:model2];
       
        [self.Dictns setObject:self.textfield.text forKey:model2.fieldname];
        
          
        return NO;
    }else
        if ([model2.sqldatatype isEqualToString:@"date"]){
            
            [self addDatePickerView:self.textfield.tag date:textField.text];
            
            [self.Dictns setObject:self.textfield.text forKey:model2.fieldname];
            return NO;
        }
        else
            
            return YES;
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    CostLayoutModel *model = [self.costLayoutArray safeObjectAtIndex:_index];
    MiXimodel *layoutModel =[model.fileds
                             safeObjectAtIndex:self.textfield.tag];
    
    if (![self isPureInt:self.textfield.text] && [layoutModel.sqldatatype isEqualToString:@"number"] && textField.text.length != 0) {
        
        [SVProgressHUD showInfoWithStatus:@"请输入数字"];
        textField.text = @"";
    }
    
    if ([textField.text length]>0) {
        unichar single = [textField.text characterAtIndex:0];
        if ((single>='0'&&single<='9')||single=='.') {
            //            if ([textField.text length]==0) {
            if (single=='.') {
                [SVProgressHUD showInfoWithStatus:@"开头不能是小数点点"];
                textField.text=@"";
                return NO;
            }
        }
    }
    
    self.isbool=NO;
    [self.Dictns setObject:self.textfield.text forKey:layoutModel.fieldname];
    
    return YES;
}
- (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
- (void)addDatePickerView:(NSInteger)tag date:(NSString *)date{
    if (!self.datePickerView) {
        self.datePickerView = [[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil] lastObject];
        [self.datePickerView setFrame:CGRectMake(0, self.view.frame.size.height - 218, self.view.frame.size.width, 218)];
    }
    
    
    
    __block Bianjito *weaker=self;
    self.datePickerView.selectDateBack = ^(NSString *date){
        
        //    NSInteger tag = weaker.datePickerView.tag;
        //        LayoutModel *layout =[weaker.mainLayoutArray safeObjectAtIndex:tag];
        //
        //        [weaker.tableViewDic setObject:date forKey:layout.fieldname];
        //
        //        [weaker.datePickerView closeView:nil];
        //
        //        [weaker.tableview reloadData];
        
        
        MiXimodel *layout =[weaker.costLayoutArray safeObjectAtIndex:tag];
        
        [weaker.datar setObject:date forKey:layout.fieldname];
        
        
        [weaker.datePickerView closeView:nil];
        
    };
    [self.tableview reloadData];
    
    [self.view addSubview:self.datePickerView];
    
    //    [self savetoDb];
    NSLog(@"====================%@",self.textfield.text);
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 47.0f;
    }
    else
        return 50.0f;
}
- (void)kindsDataSource:(MiXimodel *)model{
    NSString *str1 = [NSString stringWithFormat:@"datasource like %@",[NSString stringWithFormat:@"\"%@\"",model.datasource]];
    NSInteger tag= [self.costLayoutArray indexOfObject:model];
    //包含9999，containsString
    if (model.datasource.length !=0) {
        NSString *oldDataVer = [[CoreDataManager shareManager] searchDataVer:str1];
        if ([oldDataVer isEqualToString:model.dataver>0 ?model.dataver:@"0.01"]&&oldDataVer.length>0) {
            NSString *str = [NSString stringWithFormat:@"datasource like %@ ",[NSString stringWithFormat:@"\"%@\"",model.datasource]];
            [SVProgressHUD showWithStatus:nil maskType:2];
            
            [self fetchItemsData:str callbakc:^(NSArray *arr) {
                if (arr.count ==0) {
                    [[CoreDataManager shareManager]updateModelForTable:@"KindsLayout" sql:str data:[NSDictionary dictionaryWithObjectsAndKeys:model.dataver.length >0 ? model.dataver:@"0.01",@"dataVer", nil]];
                    [self requestKindsDataSource:model dataVer:model.dataver];
                    
                }
                else
                {
                    [SVProgressHUD dismiss];
                    [self initItemView:arr tag:tag];
                    
                }
            }];
            
            
            
        }
        else
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:model.dataver.length > 0 ? model.dataver : @"0.01",@"dataVer", nil];
            [[CoreDataManager shareManager] updateModelForTable:@"KindsLayout" sql:str1 data:dic];
            [self requestKindsDataSource:model dataVer:model.dataver];
            
            
        }
        
    }
}
- (void)requestKindsDataSource:(MiXimodel *)model dataVer:(NSString *)Dataver{
    //model.dataver
    //[RequestCenter GetRequest:[NSString stringWithFormat:@"ac=GetDataSourceNew&u=%@&datasource=%@&dataver=0",self.uid,model.datasource]
    //http://localhost:53336/WebUi/ashx/mobilenew.ashx?ac=GetDataSource&u=9& datasource =400102&dataver=1.3
    NSInteger tag= [self.costLayoutArray indexOfObject:model];
    [RequestCenter GetRequest:[NSString stringWithFormat:@"ac=GetDataSourceNew&u=%@&datasource=%@&dataver=0",self.uid,model.datasource]
                   parameters:nil
                      success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                          id dataArr = [responseObject objectForKey:@"msg"];
                          if ([dataArr isKindOfClass:[NSArray class]]) {
                              [self saveItemsToDB:dataArr callbakc:^(NSArray *modelArr) {
                                  [self initItemView:modelArr tag:tag];
                                  [SVProgressHUD dismiss];
                              }];
                          }
                          else
                          {
                              [SVProgressHUD showInfoWithStatus:@"请求数据失败。"];
                              [SVProgressHUD dismiss];
                          }
                          
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          
                      }
            showLoadingStatus:YES];
}
- (void)fetchItemsData:(NSString *)sql callbakc:(void (^)(NSArray *arr))callBack{
    NSMutableArray *modelArr = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *arr =[NSArray arrayWithArray:[[CoreDataManager shareManager] fetchDataForTable:@"KindItem" sql:sql]];
        for (NSManagedObject *obj in arr) {
            KindsItemModel *model = [[KindsItemModel alloc] init];
            model.name = [obj valueForKey:@"name"];
            model.code = [obj valueForKey:@"code"];
            model.datasource = [obj valueForKey:@"datasource"];
            model.ID = [obj valueForKey:@"id"];
            [modelArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack(modelArr);
        });
    });
    
    
}
- (void)initItemView:(NSArray *)arr tag:(NSInteger)tag{
    KindsItemsView *itemView;
    itemView = [[[NSBundle mainBundle] loadNibNamed:@"KindsItems" owner:self options:nil] lastObject];
    itemView.frame = CGRectMake(50, 100, SCREEN_WIDTH - 20, SCREEN_WIDTH - 20);
    itemView.center = CGPointMake(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
    itemView.delegate = self;
    itemView.isSingl=isSinglal;
    
    itemView.transform =CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT / 2.0 - CGRectGetHeight(itemView.frame) / 2.0f);
    itemView.dataArray = arr;
    //    itemView.isSingl = isSinglal;
    itemView.tag = tag;
    [self.view addSubview:itemView];
    [UIView animateWithDuration:1.0
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.6
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         itemView.transform = CGAffineTransformMakeTranslation(0, 0);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
- (void)saveItemsToDB:(NSArray *)arr callbakc:(void (^)(NSArray *modelArr))callBack{
    NSMutableArray *modelArr = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSDictionary *dic in arr) {
            KindsItemModel *itemModel = [KindsItemModel objectWithKeyValues:dic];
            [modelArr addObject:itemModel];
            NSString *str = [NSString stringWithFormat:@"datasource like %@ and id like %@",[NSString stringWithFormat:@"\"%@\"",itemModel.datasource],[NSString stringWithFormat:@"\"%@\"",itemModel.ID]];
            [[CoreDataManager shareManager] updateModelForTable:@"KindItem"
                                                            sql:str
                                                           data:dic];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack(modelArr);
        });
    });
    
}
- (NSString *)uid{
    return [DataManager shareManager].uid;
}
- (void)selectItemArray:(NSArray *)arr view:(KindsItemsView *)view{
    NSString *idStr = @"";
    NSString *nameStr = @"";
    NSInteger tag = view.tag;
    MiXimodel *layoutModel = [self.costLayoutArray safeObjectAtIndex:tag];
    int i = 0;
    for (KindsItemModel *model in arr) {
        if (i == 0) {
            idStr = [NSString stringWithFormat:@"%@",model.ID];
            nameStr = [NSString stringWithFormat:@"%@",model.name];
        }
        else{
            idStr = [NSString stringWithFormat:@"%@,%@",idStr,model.ID];
            nameStr = [NSString stringWithFormat:@"%@,%@",nameStr,model.name];
        }
        i++;
    }
    
    [self.Dictns setObject:nameStr forKey:layoutModel.fieldname];
    [self.tableview reloadData];
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
