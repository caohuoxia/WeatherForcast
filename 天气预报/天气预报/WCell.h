//
//  WCell.h
//  天气预报
//
//  Created by Mr_Guo on 16/6/23.
//  Copyright © 2016年 Mr_Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Weather_data.h"
#import "Weather.h"

@interface WCell : UITableViewCell

@property (nonatomic, strong) WeatherDataItem *wd;

@end
