//
//  CalculatorViewController.m
//  Calculator
//
//  Created by iceAndFire on 15/9/1.
//  Copyright © 2015年 By.Li. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Calculator.h"
#import "ScreenView.h"
#import "AppDelegate.h"
#import "SubmitApproveViewController.h"
@interface CalculatorViewController () <UITextFieldDelegate>
@property (nonatomic, strong) Calculator *calculator;
@property (nonatomic) NSMutableString *tempString;
@property (nonatomic) NSMutableString *firstString;
@property (nonatomic) BOOL flag;
//@property (nonatomic) NSMutableString *lastString;
//用来保留当前运算符号
@property (nonatomic) NSMutableString *operator;
@end

@implementation CalculatorViewController
@synthesize delegate = _delegate;


- (void) loadView
{
    self.tempString = [NSMutableString string];
    self.firstString = [NSMutableString string];
//    用0来标识没有符号
    self.operator = [NSMutableString stringWithFormat:@"0"];
    self.calculator = [[Calculator alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.calculator;
    
    
    
}


//点击数字键 拼接于临时字符串并显示
- (void) tempString:(UIButton *)numButton
{
    self.calculator.add.layer.borderWidth = 0;
    self.calculator.subtraction.layer.borderWidth = 0;
    self.calculator.multiplication.layer.borderWidth = 0;
    self.calculator.devide.layer.borderWidth = 0;
    self.flag = YES;

    
    if(self.tempString.length > 7)
    {
        return;
    }
    
//    处理点击完等号 又点击数字的问题
    if([self.operator isEqualToString:@"＝"]||[self.operator isEqualToString:@"%"]||[self.operator isEqualToString:@"+/-"])
    {
//        NSLog(@"上次是等号");
        self.firstString = [NSMutableString stringWithFormat:@"0"];
        self.tempString = [NSMutableString string];
        self.operator = [NSMutableString stringWithFormat:@"0"];
    }
//    处理小数点
    if([self.tempString rangeOfString:@"."].location != NSNotFound && [numButton.titleLabel.text isEqualToString:@"."])
    {
        return;
    }
    [self.tempString appendString:numButton.titleLabel.text];
    
//    处理前缀0
    if([self.tempString hasPrefix:@"00"]||
       [self.tempString hasPrefix:@"01"]||
       [self.tempString hasPrefix:@"02"]||
       [self.tempString hasPrefix:@"03"]||
       [self.tempString hasPrefix:@"04"]||
       [self.tempString hasPrefix:@"05"]||
       [self.tempString hasPrefix:@"06"]||
       [self.tempString hasPrefix:@"07"]||
       [self.tempString hasPrefix:@"08"]||
       [self.tempString hasPrefix:@"09"]
       )
    {
        self.tempString = [NSMutableString stringWithFormat:@"%@",numButton.titleLabel.text];
    }
    
    self.calculator.screenText.text = self.tempString;
//    self.calculator.screenText.delegate = self;
     NSLog(@"=====%@",self.tempString);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"被点击");
    
    
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    结果不会退格
    NSLog(@"触摸结束");
    if(self.tempString.length > 1)
    {
        self.calculator.screenText.text = [self.calculator.screenText.text substringToIndex: self.calculator.screenText.text.length-1];
        self.tempString = [NSMutableString stringWithFormat:@"%@",self.calculator.screenText.text];
    }
    else if (self.tempString.length == 1)
    {
        self.calculator.screenText.text = @"0";
        self.tempString = [NSMutableString string];
    }
    
     NSLog(@"=====%@",self.tempString);
    
}

//加法与清零运算
- (void) operator:(UIButton *)operatorButton
{
    if([operatorButton.titleLabel.text isEqualToString:@"＋"])
    {
        self.calculator.add.layer.borderWidth = 3;
        self.calculator.subtraction.layer.borderWidth = 0;
        self.calculator.multiplication.layer.borderWidth = 0;
        self.calculator.devide.layer.borderWidth = 0;
        
        
        double a = [self.tempString doubleValue];
        double b = [self.firstString doubleValue];
        if (self.flag && ([self.operator isEqualToString:@"－"]||[self.operator isEqualToString:@"×"]||[self.operator isEqualToString:@"÷"]||[self.operator isEqualToString:@"+/-"]||[self.operator isEqualToString:@"%"]||[self.operator isEqualToString:@"＝"]))
        {
            if([self.operator isEqualToString:@"－"])
                self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b-a];
            else if([self.operator isEqualToString:@"×"])
                self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b*a];
            else if([self.operator isEqualToString:@"÷"])
                self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b/a];
            else if ([self.operator isEqualToString:@"+/-"])
                self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
            else if([self.operator isEqualToString:@"%"])
                self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
            
            self.calculator.screenText.text = [self subzero:self.firstString];
            self.tempString = [NSMutableString string];
        }
        else if([self.operator isEqualToString:@"0"])
        {
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a];
            self.calculator.screenText.text = [self subzero:self.firstString];
            self.tempString = [NSMutableString string];
        }
        else if(self.flag)
        {
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a+b];
            self.calculator.screenText.text = [self subzero:self.firstString];
            self.tempString = [NSMutableString string];
        }
        self.operator = [NSMutableString stringWithFormat:@"＋"];
        self.flag = NO;
    }
    else if([operatorButton.titleLabel.text isEqualToString:@"AC"])
    {
        self.calculator.add.layer.borderWidth = 0;
        self.calculator.subtraction.layer.borderWidth = 0;
        self.calculator.multiplication.layer.borderWidth = 0;
        self.calculator.devide.layer.borderWidth = 0;
        
        self.tempString = [NSMutableString string];
        self.firstString = [NSMutableString stringWithFormat:@"0"];
        self.operator = [NSMutableString stringWithFormat:@"0"];
        self.calculator.screenText.text = self.firstString;
    }
    
//    
    if (self.delegate) {
        [self.delegate deleteBtnClick];
        
    }
    
    
}
//减法运算
- (void) subOperator: (UIButton *) subOperator
{
    self.calculator.add.layer.borderWidth = 0;
    self.calculator.subtraction.layer.borderWidth = 3;
    self.calculator.multiplication.layer.borderWidth = 0;
    self.calculator.devide.layer.borderWidth = 0;
    
    double a = [self.tempString doubleValue];
    double b = [self.firstString doubleValue];
    if (self.flag && ([self.operator isEqualToString:@"＋"]||[self.operator isEqualToString:@"×"]||[self.operator isEqualToString:@"÷"]||[self.operator isEqualToString:@"+/-"]||[self.operator isEqualToString:@"%"]||[self.operator isEqualToString:@"＝"]))
    {
        if([self.operator isEqualToString:@"＋"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a+b];
        else if([self.operator isEqualToString:@"×"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b*a];
        else if([self.operator isEqualToString:@"÷"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b/a];
        else if ([self.operator isEqualToString:@"+/-"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        else if([self.operator isEqualToString:@"%"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"0"])
    {
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if(self.flag)
    {
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b-a];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    self.operator = [NSMutableString stringWithFormat:@"－"];
    self.flag = NO;
}
//乘法运算
- (void) multiplication: (UIButton *)multiplicationButton
{
    self.calculator.add.layer.borderWidth = 0;
    self.calculator.subtraction.layer.borderWidth = 0;
    self.calculator.multiplication.layer.borderWidth = 3;
    self.calculator.devide.layer.borderWidth = 0;
    
    double a = [self.tempString doubleValue];
    double b = [self.firstString doubleValue];
    if (self.flag && ([self.operator isEqualToString:@"＋"]||[self.operator isEqualToString:@"－"]||[self.operator isEqualToString:@"÷"]||[self.operator isEqualToString:@"+/-"]||[self.operator isEqualToString:@"%"]||[self.operator isEqualToString:@"＝"]))
    {
        if([self.operator isEqualToString:@"＋"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a+b];
        else if([self.operator isEqualToString:@"－"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b-a];
        else if([self.operator isEqualToString:@"÷"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b-a];
        else if ([self.operator isEqualToString:@"+/-"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        else if([self.operator isEqualToString:@"%"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"0"])
    {
        b=1;
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a*b];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if(self.flag)
    {
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a*b];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    self.operator = [NSMutableString stringWithFormat:@"×"];
    self.flag = NO;
}
//devide
//除法运算
- (void) devide: (UIButton *)multiplicationButton
{
    self.calculator.add.layer.borderWidth = 0;
    self.calculator.subtraction.layer.borderWidth = 0;
    self.calculator.multiplication.layer.borderWidth = 0;
    self.calculator.devide.layer.borderWidth = 3;
    
    double a = [self.tempString doubleValue];
    double b = [self.firstString doubleValue];
    
    if (self.flag && ([self.operator isEqualToString:@"＋"]||[self.operator isEqualToString:@"－"]||[self.operator isEqualToString:@"×"]||
        [self.operator isEqualToString:@"+/-"]||[self.operator isEqualToString:@"%"]||[self.operator isEqualToString:@"＝"]))
    {
        if([self.operator isEqualToString:@"＋"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b+a];
        else if([self.operator isEqualToString:@"－"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b-a];
        else if([self.operator isEqualToString:@"×"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b*a];
        else if ([self.operator isEqualToString:@"+/-"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        else if([self.operator isEqualToString:@"%"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"0"])
    {
        b=1;
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a/b];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if(self.flag)
    {
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b/a];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    self.operator = [NSMutableString stringWithFormat:@"÷"];
    self.flag = NO;
}

- (void) confirmMonitor: (UIButton *)sender{
    [self resultMonitor:self.calculator.results];
   
    NSLog(@"=====%@",self.calculator.screenText.text);
    
    [self.delegate sender:self.calculator.screenText.text];
   // [self.view removeFromSuperview];

}
//等号运算
- (void) resultMonitor: (UIButton *)sender
{
    self.calculator.add.layer.borderWidth = 0;
    self.calculator.subtraction.layer.borderWidth = 0;
    self.calculator.multiplication.layer.borderWidth = 0;
    self.calculator.devide.layer.borderWidth = 0;
    if(self.flag == NO)
        return;
    double a = [self.tempString doubleValue];
    double b = [self.firstString doubleValue];
//        等号走的方法需要上一次的运算符
    if ([self.operator isEqualToString:@"＋"])
    {
        self.operator = [NSMutableString stringWithFormat:@"＝"];
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a+b];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"－"])
    {
        self.operator = [NSMutableString stringWithFormat:@"＝"];
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b-a];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"×"])
    {
        self.operator = [NSMutableString stringWithFormat:@"＝"];
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",a*b];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"+/-"])
    {
        self.operator = [NSMutableString stringWithFormat:@"＝"];
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"%"])
    {
        self.operator = [NSMutableString stringWithFormat:@"＝"];
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"÷"])
    {
        if(a==0)
        {
            self.calculator.screenText.text = @"错误💀";
            self.tempString = [NSMutableString string];
            self.firstString = [NSMutableString stringWithFormat:@"0"];
            self.operator = [NSMutableString stringWithFormat:@"0"];
            self.operator = [NSMutableString stringWithFormat:@"＝"];
            return;
        }
        self.operator = [NSMutableString stringWithFormat:@"＝"];
        self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b/a];
        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    else if([self.operator isEqualToString:@"0"])
    {
//        NSLog(@"ok");
        self.operator = [NSMutableString stringWithFormat:@"＝"];
        self.firstString = [NSMutableString stringWithFormat:@"%@",self.tempString];
        self.calculator.screenText.text = [self subzero:self.tempString];
        self.tempString = [NSMutableString string];
    }
    self.flag = NO;
//    上一次是等号的话不做操作！！
    
    
     NSLog(@"-----=====%@",self.tempString);
}


//正负键
- (void) addSub: (UIButton *) sender
{
//    self.calculator.add.layer.borderWidth = 0;
//    self.calculator.subtraction.layer.borderWidth = 0;
//    self.calculator.multiplication.layer.borderWidth = 0;
//    self.calculator.devide.layer.borderWidth = 0;
//    double a = [self.tempString doubleValue];
//    double b = [self.firstString doubleValue];
//    if (self.flag && ([self.operator isEqualToString:@"＋"]||[self.operator isEqualToString:@"－"]||[self.operator isEqualToString:@"×"]||
//                      [self.operator isEqualToString:@"÷"]||[self.operator isEqualToString:@"%"]||[self.operator isEqualToString:@"＝"]))
//    {
////        NSLog(@"%s %int",__FUNCTION__,__LINE__);
////        NSLog(@"%lf %lf",a,b);
//        if([self.operator isEqualToString:@"＋"])
//            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b+a];
//        else if([self.operator isEqualToString:@"－"])
//            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b-a];
//        else if([self.operator isEqualToString:@"×"])
//            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b*a];
//        else if ([self.operator isEqualToString:@"÷"])
//            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b/a];
//        else if([self.operator isEqualToString:@"%"])
//            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
//        
//        self.calculator.screenText.text = [self subzero:self.firstString];
//        self.tempString = [NSMutableString string];
//    }
//    if([self.operator isEqualToString:@"0"])
//    {
//        b = a;
//        b = [self.firstString doubleValue] + a ;
//    }
//    else
//    {
//        b = [self.firstString doubleValue] ;
//    }
//    self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b * (-1)];
//    self.calculator.screenText.text = [self subzero:self.firstString];
//    self.tempString = [NSMutableString string];
//    self.flag = NO;
//    self.operator = [NSMutableString stringWithFormat:@"+/-"];
    
    
    
//    if (self.delegate) {
//        [self.delegate deleteBtnClick];
//        
//    }
//    
    
    
    if(self.tempString.length > 1)
    {
        self.calculator.screenText.text = [self.calculator.screenText.text substringToIndex: self.calculator.screenText.text.length-1];
        self.tempString = [NSMutableString stringWithFormat:@"%@",self.calculator.screenText.text];
    }
    else if (self.tempString.length == 1)
    {
        self.calculator.screenText.text = @"0";
        self.tempString = [NSMutableString string];
    }
    
    NSLog(@"=====%@",self.tempString);

    
}
//percent
- (void) percent: (UIButton *) sender
{
    self.calculator.add.layer.borderWidth = 0;
    self.calculator.subtraction.layer.borderWidth = 0;
    self.calculator.multiplication.layer.borderWidth = 0;
    self.calculator.devide.layer.borderWidth = 0;
    double a = [self.tempString doubleValue];
    double b = [self.firstString doubleValue];
    if (self.flag && ([self.operator isEqualToString:@"＋"]||[self.operator isEqualToString:@"－"]||[self.operator isEqualToString:@"×"]||
                      [self.operator isEqualToString:@"÷"]||[self.operator isEqualToString:@"+/-"]||[self.operator isEqualToString:@"＝"]))
    {
//        NSLog(@"%s %int",__FUNCTION__,__LINE__);
//        NSLog(@"%lf %lf",a,b);
        if([self.operator isEqualToString:@"＋"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b+a];
        else if([self.operator isEqualToString:@"－"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b-a];
        else if([self.operator isEqualToString:@"×"])
            self.firstString = [NSMutableString stringWithFormat:@"%.15lf",b*a];
        else if ([self.operator isEqualToString:@"÷"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b/a];
        else if([self.operator isEqualToString:@"+/-"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];
        else if([self.operator isEqualToString:@"＝"])
            self.firstString = [NSMutableString stringWithFormat:@"%.14lf",b];

        self.calculator.screenText.text = [self subzero:self.firstString];
        self.tempString = [NSMutableString string];
    }
    if([self.operator isEqualToString:@"0"])
    {
        b = a;
        b = [self.firstString doubleValue] + a ;
    }
    else
    {
        b = [self.firstString doubleValue];
    }
    b = b*0.01;
    self.firstString = [NSMutableString stringWithFormat:@"%.5lf",b];
    
    NSLog(@"%@",self.firstString);
    
    self.calculator.screenText.text = [self subzero:self.firstString];
    self.tempString = [NSMutableString string];
    self.flag = NO;
    self.operator = [NSMutableString stringWithFormat:@"%%"];
}


// 去除后缀0
- (NSMutableString *) subzero: (NSMutableString *)string
{
    char s[1000];
    strcpy(s, [string UTF8String]);
    unsigned long l = strlen(s)-1;
    if([string containsString:@"."]){
        while (s[l]=='0')
        {
            
            l--;
        }
        
    }
    
    
    if(s[l]=='.')
        l--;
    
    s[l+1]='\0';
    NSMutableString *str = [[NSMutableString alloc] initWithUTF8String:s];
    
    return str;
}

- (void)viewDidLoad
{
// 数字键
    [self.calculator.one addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.two addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.three addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.four addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.five addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.six addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.seven addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.eight addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.nine addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.zero addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.point addTarget:self action:@selector(tempString:) forControlEvents:UIControlEventTouchUpInside];
//  运算符键
    [self.calculator.add addTarget:self action:@selector(operator:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.subtraction addTarget:self action:@selector(subOperator:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.multiplication addTarget:self action:@selector(multiplication:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.devide addTarget:self action:@selector(devide:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculator.results addTarget:self action:@selector(resultMonitor:) forControlEvents:UIControlEventTouchUpInside];
     [self.calculator.confirm addTarget:self action:@selector(confirmMonitor:) forControlEvents:UIControlEventTouchUpInside];
//   清零键
    [self.calculator.allClean addTarget:self action:@selector(operator:) forControlEvents:UIControlEventTouchUpInside];
//   百分比键
//    percent
    [self.calculator.percent addTarget:self action:@selector(percent:) forControlEvents:UIControlEventTouchUpInside];
//   正负键
    [self.calculator.addSub addTarget:self action:@selector(addSub:) forControlEvents:UIControlEventTouchUpInside];
//    self.calculator.screenText.delegate = self;
    [super viewDidLoad];
    
}



#pragma mark -- ScreenView的代理方法

//- (void)deleteNum
//{
//    if(self.tempString.length > 1)
//    {
//        self.calculator.screenText.text = [self.calculator.screenText.text substringToIndex: self.calculator.screenText.text.length-1];
//        self.tempString = [NSMutableString stringWithFormat:@"%@",self.calculator.screenText.text];
//    }
//    else if (self.tempString.length == 1)
//    {
//        self.calculator.screenText.text = @"0";
//        self.tempString = [NSMutableString string];
//    }
//    
//    NSLog(@"=====%@",self.tempString);
//    
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
