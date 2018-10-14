//
//  Weather.m
//  天气预报
//
//  Created by 何华均 on 2018/10/14.
//  Copyright © 2018年 Mr_Guo. All rights reserved.
//

#import "Weather.h"
#import <YYModel.h>

@implementation Weather
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"index" : [IndexItem class],
             @"weather_data" : [WeatherDataItem class] };
}

+ (void) loadWeatherWithCity:(CLLocation *)loca WithSuccessBlock:(void(^)(Weather *))successBlock andErrorBlock:(void(^)(NSError *))errorBlock {
    
    NSURL *url = [NSURL URLWithString:@"http://api.map.baidu.com/telematics/v3/weather?"];
    NSMutableURLRequest *requset = [NSMutableURLRequest requestWithURL:url];
    requset.HTTPMethod = @"post";
    NSString *body = [NSString stringWithFormat:@"location=%f,%f&output=%@&ak=%@&mcode=%@", loca.coordinate.longitude, loca.coordinate.latitude, @"json", @"tMh0AM0uDdjk9bgyocHBuOuE", @"cn.itgcq.weather"];
    requset.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", body);
    [NSURLConnection sendAsynchronousRequest:requset queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            NSLog(@"%@", connectionError);
            return;
        }
        
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary *dict = responseObject[@"results"][0];
        NSLog(@"%@", responseObject);
        Weather *w = [Weather yy_modelWithDictionary:dict];
        
        if (successBlock) {
            successBlock(w);
        }
        
    }];
    
}
@end

@implementation IndexItem
@end

@implementation WeatherDataItem
@end
