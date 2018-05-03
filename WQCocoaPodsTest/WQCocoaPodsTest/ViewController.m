//
//  ViewController.m
//  WQCocoaPodsTest
//
//  Created by 王强 on 2017/12/19.
//  Copyright © 2017年 XiYiChuanMei. All rights reserved.
//

#import "ViewController.h"
//#import <MJExtension/MJExtension.h>
//#import "MJExtension.h"
#import "XYRoundedCorner.h"
#import "TableViewCell.h"
#import "UIViewController+viewDidLoad.h"

typedef NS_ENUM(NSInteger,WQIndex) {
    WQIndex0,
    WQIndex1
};

@interface ViewController ()<UITableViewDataSource>
{
    NSString *_foo;
}
@property(nonatomic,assign) WQIndex index;
@property(nonatomic,strong) NSArray *arr0;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableArray *array1;
@end

@implementation ViewController

@synthesize array1 = array2;

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor greenColor];
//
//    self.arr0 = @[@"A",@"B",@"C",@"D"];
//    NSArray *arr1 = self.arr0.copy;
//    NSMutableArray *arr2 = self.arr0.mutableCopy;
//    [arr2 addObject:@"E"];
//    NSMutableArray *arr3 = arr2.mutableCopy;
//    [arr3 addObject:@"F"];
//    self.array = [NSMutableArray arrayWithArray:self.arr0];
//    [self.array addObject:@"K"];
//    array2 = [NSMutableArray arrayWithArray:self.arr0];
//    NSLog(@"self.arr0:%@\n arr1:%@\n arr2:%@\n narr3:%@    self.array:%@ \n _array2=%@",self.arr0,arr1,arr2,arr3,self.array,array2);

//    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
//    view.backgroundColor = [UIColor redColor];
//    view.contentSize = CGSizeMake(320, 1000);
//    [self.view addSubview:view];

//    if (@available(iOS 10.0, *)) {
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"王强好帅" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [v show];
//        }];
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    } else {
//        // Fallback on earlier versions
//    }

//    NSTimer *timer2 = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(acTion) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:NSRunLoopCommonModes];

////
//    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5"];
//    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIView *view = [UIView new];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//    }];

//    __block NSString *wangqiangStr = @"王强";
//    void(^foo)(void) = {
//        wangqiangStr = @"王强好帅";
//    };
//    NSLog(@"wangqiangStr_3:%p",&wangqiangStr);
//    NSMutableString *a = [NSMutableString stringWithString:@"Tom"];
//    NSLog(@"\n 定以前：------------------------------------\n\
//          a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);               //a在栈区
//    void (^foo)(void) = ^{
//        a.string = @"Jerry";
//        NSLog(@"\n block内部：------------------------------------\n\
//              a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);               //a在栈区
////        a = [NSMutableString stringWithString:@"William"];
//        self.array1 = [NSMutableArray new];
//    };
//    foo();
//    NSLog(@"\n 定以后：------------------------------------\n\
//          a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);               //a在栈区
//
//    NSLog(@"王强——1");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"王强——2");
//    });
//    NSLog(@"王强——3");
//
//    _foo = @"王强Key";
//    NSMutableDictionary *dict = [NSMutableDictionary new];
//    [dict setObject:@"王强" forKey:foo];
//    NSLog(@"王强——dict: %@",dict);

//    NSArray *self.arr00 = @[@"1",@"2",@"3",@"4",@"5"];
//    NSMutableArray *arr10 = self.arr00.mutableCopy;
//    NSMutableArray *arr12 = [NSMutableArray arrayWithArray:self.arr00];
//    NSMutableArray *arr13 = self.arr00.copy;
//    [arr10 addObject:@"6"];
//
////    [arr12 addObject:@"7"];
//    NSLog(@"self.arr00:%p    arr10:%p  arr12:%p   arr13:%p   arr10.class:%@  self.arr00.class:%@    arr13.class:%@   arr10:%@",self.arr00,arr10,arr12,arr13,[arr10 class],[self.arr00 class],[arr13 class],arr10);
//    arr12 = self.arr00;
//
//    self.arr00 = arr10;
//
//    NSLog(@"self.arr00:%p arr10:%p   arr10.clas:%@",self.arr00,arr10,[arr10 class]);
//
//    [arr10 addObject:@"7"];
//    NSLog(@"self.arr00:%p  arr10:%p self.arr00.clas:%@  self.arr00:%@",self.arr00,arr10,[self.arr00 class],self.arr00);
//
//
//    NSMutableArray *arr14 = self.arr00;
//    NSString *str14 = @"王强";
//    NSLog(@"arr14:%p  str14:%p arr14.clas:%@",arr14,str14,[arr14 class]);
//
//    [arr14 addObject:str14];
//
//    for (NSString *s in arr14) {
//        if ([s isEqualToString:@"王强"]) {
//            NSLog(@"arr14:%p   str14:%p   s:%p",arr14,str14,s);
//        }
//    }


//    UIView *la = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:la];
//    [la xySetCornerXYRadius:XYRadiusMake(50, 0, 50, 20) borderColor:nil borderWidth:0 backgroundColor:[UIColor yellowColor]];

//    [la xySetCornerRadius:50 backgroundColor:[UIColor yellowColor]];

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [tableView registerClass:[TableViewCell class] forCellReuseIdentifier:[TableViewCell cellReuseIdentifier]];
    tableView.rowHeight = 54;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (void)wqShuai {
    NSLog(@"王强最帅");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TableViewCell cellReuseIdentifier] forIndexPath:indexPath];
//    cell.avatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://oepjvpu5g.qnssl.com/avatar%li.jpg", indexPath.row % 20]];
    cell.avatarURL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521536493110&di=1de7d5cfc77b30aa80f5a1a6feaee6bf&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2015%2F203%2F32%2F85MX34D9VPR8_1000x500.jpg"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self acTion];
}

- (void)acTion {
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"王强好帅" message:@"王强好帅2018" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [v show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
