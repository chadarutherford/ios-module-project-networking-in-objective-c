//
//  CARCurrentForecast.h
//  DailyWeather
//
//  Created by Chad Rutherford on 2/19/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARWeatherForecast.h"

NS_ASSUME_NONNULL_BEGIN

@interface CARCurrentForecast : CARWeatherForecast

@property (nonatomic, readonly) NSDate *time;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy) NSString *icon;
@property (nonatomic, readonly) double precipProbability;
@property (nonatomic, readonly) double precipIntensity;
@property (nonatomic, readonly) double temperature;
@property (nonatomic, readonly) double apparentTemperature;
@property (nonatomic, readonly) double humidity;
@property (nonatomic, readonly) double pressure;
@property (nonatomic, readonly) double windSpeed;
@property (nonatomic, readonly) int windBearing;
@property (nonatomic, readonly) int uvIndex;

- (instancetype) initWithTime:(NSDate *)time
                      summary:(NSString *)summary
                         icon:(NSString *)icon
            precipProbability:(double)precipProbability
              precipIntensity:(double)precipIntensity
                  temperature:(double)temperature
          apparentTemperature:(double)apparentTemperature
                     humidity:(double)humidity
                     pressure:(double)pressure
                    windSpeed:(double)windSpeed
                  windBearing:(int)windBearing
                      uvIndex:(int)uvIndex;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
