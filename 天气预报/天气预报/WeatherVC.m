//
//  WeatherVC.m
//  天气预报
//
//  Created by 何华均 on 2018/10/14.
//  Copyright © 2018年 Mr_Guo. All rights reserved.
//

#import "WeatherVC.h"
#import <CoreLocation/CoreLocation.h>
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "WCell.h"
#import "ZCell.h"
#import "Waether.h"
#import "Weather.h"

static NSString *cellPlaceMarksID = @"cellPlaceMarksID";
static NSString *cellWeatherID = @"cellWeatherID";
static NSString *cellIndexID = @"cellIndexID";

@interface WeatherVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>{
    UIView *head;
}
@property(nonatomic,strong)UITableView *tbPlaceMarks;
//近三天，晚上则返回近四天
@property(nonatomic,strong)UITableView *tbWeather;
//天气指数：穿衣，洗车等
@property(nonatomic,strong)UITableView *tbIndex;
@property(nonatomic,strong)Weather *weatherModel;
@property(nullable,strong)CLLocationManager *mgr;
@property (nonatomic, strong) NSString *cityLoca;
@end

@implementation WeatherVC

#pragma mark- getter/setter
- (UITableView*)tbPlaceMarks{
    if (!_tbPlaceMarks) {
        _tbPlaceMarks = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbPlaceMarks.tag = 100;
        _tbPlaceMarks.dataSource = self;
        _tbPlaceMarks.delegate = self;
        [_tbPlaceMarks registerClass:[UITableViewCell class] forCellReuseIdentifier:cellPlaceMarksID];
    }
    return _tbPlaceMarks;
}
- (UITableView*)tbWeather{
    if (!_tbWeather) {
        _tbWeather = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbWeather.tag = 101;
        _tbWeather.backgroundColor = [UIColor greenColor];
        _tbWeather.dataSource = self;
        _tbWeather.delegate = self;
        [_tbWeather registerClass:[WCell class] forCellReuseIdentifier:cellWeatherID];
    }
    return _tbWeather;
}
- (UITableView*)tbIndex{
    if (!_tbIndex) {
        _tbIndex = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tbIndex.tag = 102;
        _tbIndex.dataSource = self;
        _tbIndex.delegate = self;
        _tbIndex.layer.cornerRadius = 5;
        _tbIndex.layer.masksToBounds = YES;
        _tbIndex.layer.borderWidth = 2.0f;
        _tbIndex.layer.borderColor = [UIColor blueColor].CGColor;
        _tbIndex.tableFooterView = [UIView new];//去掉tb尾部多去分割线
        [_tbIndex registerClass:[ZCell class] forCellReuseIdentifier:cellIndexID];
    }
    return _tbIndex;
}

- (void)setWeatherModel:(Weather *)weatherModel{
    _weatherModel = weatherModel;
    
    [self.tbIndex reloadData];
    [self.tbWeather reloadData];
    
    //更新head头部信息
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气预报";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //读取当前位置的经纬度和城市
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *la = [ud objectForKey:@"latitude"];
    NSString *lo = [ud objectForKey:@"longitude"];
    self.cityLoca = [ud objectForKey:@"city"];
    //如果读取到存储的经纬度，则用这个经纬度请求数据，否则自动定位
    if (la != 0 && lo != 0) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[la floatValue] longitude:[lo floatValue]];
        [self loadWeatherWith:location];
    } else {
        [self didClickLocation];
    }
    
    [self setupUI];
}

- (void)setupUI{
    //添加表
    [self.view addSubview:self.tbPlaceMarks];
    [self.view addSubview:self.tbIndex];
    [self.view addSubview:self.tbWeather];
    
    self.tbPlaceMarks.hidden = YES;
    
    //添加头部ui
    [self addHeadView];
    
    [self.tbWeather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(@100);
    }];
    [self.tbIndex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tbWeather);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.tbWeather.mas_left);
    }];
}

- (void)addHeadView{
    head = [UIView new];
    head.backgroundColor = [UIColor redColor];
    [self.view addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
}

#pragma mark- 请求天气数据
- (void) loadWeatherWith:(CLLocation *)loca {
    __weak typeof(self) weakself = self;
    [Weather loadWeatherWithCity:(CLLocation *)loca WithSuccessBlock:^(Weather *w) {
        weakself.weatherModel = w;
    } andErrorBlock:^(NSError *error){
        NSLog(@"天气加载出错!   %@", error);
    }];
    
}


#pragma mark- tableview datasource/delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        return 1;
    }
    if (tableView.tag == 101) { //天气
        return self.weatherModel.weather_data.count;
    }
    if (tableView.tag == 102) {//指数
        return self.weatherModel.index.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPlaceMarksID];
    cell.textLabel.text = @"cellPlaceMarksID";
    if (tableView.tag == 101) {
        WCell *cell = [tableView dequeueReusableCellWithIdentifier:cellWeatherID];
        cell.wd = self.weatherModel.weather_data[indexPath.row];
        return cell;
    }
    if (tableView.tag == 102) {
        ZCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndexID];
        cell.idx = self.weatherModel.index[indexPath.row];
        return cell;
    }
    
    return cell;
}

#pragma mark- 定位
//点击定位
- (void) didClickLocation {
    
    [SVProgressHUD showWithStatus:@"正在定位" maskType:SVProgressHUDMaskTypeBlack];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        
        self.mgr = [CLLocationManager new];
        
        if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.mgr requestWhenInUseAuthorization];
        }
        
        self.mgr.delegate = self;
        
        [self.mgr startUpdatingLocation];
        
    });
}

//定位代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = locations.lastObject;
    
    [self loadWeatherWith:location];
    
    //反地理编码
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //放错处理
        if (placemarks.count == 0 || error) {
            NSLog(@"定位出错");
            return;
        }
        
        for (CLPlacemark *placemark in placemarks) {
            
            //将当前位置赋给控制器属性
            self.cityLoca = [NSString stringWithFormat:@"%@%@", placemark.locality, placemark.subLocality];
            
            //根据当前位置请求天气数据
            [self loadWeatherWith:placemark.location];
            
            //将当前位置和城市存储到偏好设置中
            NSString *la = [NSString stringWithFormat:@"%lf", placemark.location.coordinate.latitude];
            NSString *lo = [NSString stringWithFormat:@"%lf", placemark.location.coordinate.longitude];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:la forKey:@"latitude"];
            [ud setObject:lo forKey:@"longitude"];
            NSString *ci = [NSString stringWithFormat:@"定位完成\n当前位置：%@", self.cityLoca];
            
            [SVProgressHUD showSuccessWithStatus:ci];
        }
        
    }];
    
    [self.mgr stopUpdatingLocation];
    
}

@end
