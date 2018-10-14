//
//  Weather.h
//  天气预报
//
//  Created by 何华均 on 2018/10/14.
//  Copyright © 2018年 Mr_Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class IndexItem,WeatherDataItem;

@interface Weather : NSObject
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, copy) NSString *pm25;
@property (nonatomic, strong) NSArray<IndexItem*> *index;
@property (nonatomic, strong) NSArray<WeatherDataItem*> *weather_data;

+ (void) loadWeatherWithCity:(CLLocation *)loca WithSuccessBlock:(void(^)(Weather *))successBlock andErrorBlock:(void(^)(NSError *))errorBlock;
@end

@interface IndexItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *zs;
@property (nonatomic, copy) NSString *tipt;
@property (nonatomic, copy) NSString *des;
@end

@interface  WeatherDataItem: NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *dayPictureUrl;
@property (nonatomic, copy) NSString *nightPictureUrl;
@property (nonatomic, copy) NSString *weather;
@property (nonatomic, copy) NSString *wind;
@property (nonatomic, copy) NSString *temperature;
@end
NS_ASSUME_NONNULL_END
