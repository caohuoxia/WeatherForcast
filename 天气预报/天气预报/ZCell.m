//
//  ZCell.m
//  天气预报
//
//  Created by Mr_Guo on 16/6/23.
//  Copyright © 2016年 Mr_Guo. All rights reserved.
//

#import "ZCell.h"
#import "Masonry.h"

@interface ZCell (){
    UILabel *lbTipt;
    UILabel *lbZs;
    UILabel *lbDes;
}

//@property (weak, nonatomic) IBOutlet UILabel *tipt;
//@property (weak, nonatomic) IBOutlet UILabel *zs;
//@property (weak, nonatomic) IBOutlet UILabel *des;


@end

@implementation ZCell

-(void)setIdx:(IndexItem *)idx {

    _idx = idx;
//    self.tipt.text = idx.tipt;
//    self.zs.text = idx.zs;
//    self.des.text = idx.des;
    
    lbTipt.text = idx.tipt;
    lbZs.text = idx.zs;
    lbDes.text = idx.des;
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
    
    lbZs = [UILabel new];
    lbZs.font = [UIFont systemFontOfSize:15];
    lbTipt = [UILabel new];
    lbDes = [UILabel new];
    lbDes.numberOfLines = 0;
    lbDes.font = [UIFont systemFontOfSize:14];
    
    [superview addSubview:lbZs];
    [superview addSubview:lbDes];
    [superview addSubview:lbTipt];
    
    //有意思，xcode10里面 上下约束好后，tb行高自动布局；之前是要设置estimaterowheight等相关属性的
    [lbTipt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(superview).offset(5);
//        make.height.equalTo(@21);
    }];
    [lbZs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbTipt);
        make.right.equalTo(superview).offset(-5);
    }];
    [lbDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTipt.mas_bottom).offset(5);
        make.left.equalTo(superview).offset(5);
        make.right.bottom.equalTo(superview).offset(-5);
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
