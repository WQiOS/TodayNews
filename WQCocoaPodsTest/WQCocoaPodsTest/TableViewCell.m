//
//  TableViewCell.m
//  JMRoundedCornerDemo
//
//  Created by 饶志臻 on 2016/10/7.
//  Copyright © 2016年 饶志臻. All rights reserved.
//

#import "TableViewCell.h"
#import "WQRoundedCorner.h"
#import "WQRoundedCorner.h"

@interface TableViewCell ()

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 40, 40)];
//    _avatarView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_avatarView];
    
    NSInteger viewWidth = ([UIScreen mainScreen].bounds.size.width - 78) / 2;
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(60 + 0.22, 7, viewWidth + 0.34, 40)];
    [_button setTitle:@"button" forState:UIControlStateNormal];
    [_button setCornerRadius:20 borderColor:[UIColor greenColor] borderWidth:3 backgroundColor:[UIColor redColor]];
    _button.titleLabel.font = [UIFont systemFontOfSize:12];
    [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_button];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(70 + viewWidth , 7, viewWidth, 40)];
    _label.text = @"label";
    [_label setCornerWQRadius:WQRadiusMake(4, 4, 4, 4) borderColor:[UIColor redColor] borderWidth:0.5 backgroundColor:[UIColor whiteColor]];
    [_label setShadowColor:[UIColor redColor] shadowOffset:CGSizeZero opacity:0.2 radius:2 shadowHeight:5];
    _label.font = [UIFont systemFontOfSize:12];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_label];
}

- (void)setAvatarURL:(NSURL *)avatarURL {
    [_avatarView setShadowColor:[UIColor redColor] shadowOffset:CGSizeZero opacity:0.2 radius:2 shadowHeight:5];
    [_avatarView setCornerWQRadius:WQRadiusMake(20, 20, 20, 20) imageURL:_avatarURL placeholder:[UIImage imageNamed:@"avatar"] size:CGSizeMake(40, 40)];
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass(self);
}

@end
