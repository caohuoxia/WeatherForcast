//
//  WCell.m
//  天气预报
//
//  Created by Mr_Guo on 16/6/23.
//  Copyright © 2016年 Mr_Guo. All rights reserved.
//

#import "WCell.h"
#import "Masonry.h"
#import <UIImageView+AFNetworking.h>

@interface WCell(){
    UILabel *lbDate;
    UILabel *lbWeather;
    UILabel *lbWind;
    UILabel *lbTemp;
    UIImageView *ivIcon;
}
//@property (nonatomic, copy) NSString *date;
//@property (nonatomic, copy) NSString *dayPictureUrl;
//@property (nonatomic, copy) NSString *nightPictureUrl;
//@property (nonatomic, copy) NSString *weather;
//@property (nonatomic, copy) NSString *wind;
//@property (nonatomic, copy) NSString *temperature;

//@property (weak, nonatomic) IBOutlet UILabel *date;
//@property (weak, nonatomic) IBOutlet UIImageView *img;
//@property (weak, nonatomic) IBOutlet UILabel *weather;
//@property (weak, nonatomic) IBOutlet UILabel *wind;
//@property (weak, nonatomic) IBOutlet UILabel *temp;

@end

@implementation WCell

-(void)setWd:(WeatherDataItem *)wd {
    _wd = wd;
    lbDate.text = wd.date;
    [ivIcon setImageWithURL:[NSURL URLWithString:wd.dayPictureUrl]];
    lbWeather.text = wd.weather;
    lbWind.text = wd.wind;
    lbTemp.text = wd.temperature;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    UIView *superview = self.contentView;
    
    CGFloat fontSize = 12;
    CGFloat margin = 5.f;
    
    lbWeather = [UILabel new];
    lbWeather.font = [UIFont systemFontOfSize:fontSize];
    lbDate = [UILabel new];
    lbDate.font = [UIFont systemFontOfSize:fontSize];
    lbTemp = [UILabel new];
    lbTemp.font = [UIFont systemFontOfSize:fontSize];
    lbWind = [UILabel new];
    lbWind.font = [UIFont systemFontOfSize:fontSize];
    ivIcon = [UIImageView new];
    
    [superview addSubview:ivIcon];
    [superview addSubview:lbDate];
    [superview addSubview:lbWeather];
    [superview addSubview:lbTemp];
    [superview addSubview:lbWind];
    
    //有意思，xcode10里面 上下约束好后，tb行高自动布局；之前是要设置estimaterowheight等相关属性的
    [lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview).offset(margin);
        make.centerX.equalTo(superview);
//        make.height.equalTo(@22);
    }];
    [ivIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDate.mas_bottom).offset(margin);
        make.centerX.equalTo(lbDate);
        make.size.mas_equalTo(CGSizeMake(60, 45));
    }];
    [lbWeather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ivIcon.mas_bottom).offset(margin);
        make.centerX.equalTo(lbDate);
//        make.height.equalTo(lbDate);
    }];
    [lbWind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbWeather.mas_bottom).offset(margin);
        make.centerX.equalTo(lbDate);
//        make.height.equalTo(lbDate);
    }];
    [lbTemp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbWind.mas_bottom).offset(margin);
        make.centerX.equalTo(lbDate);
//        make.height.equalTo(lbDate);
        make.bottom.equalTo(superview.mas_bottom).offset(-margin);
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
