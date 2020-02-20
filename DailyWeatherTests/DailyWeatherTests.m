//
//  DailyWeatherTests.m
//  DailyWeatherTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../DailyWeather/Support/LambdaSDK/LSIFileHelper.h"
#import "../DailyWeather/Model/CARCurrentForecast.h"
#import "../DailyWeather/Model/CARDailyForecast.h"
#import "../DailyWeather/Model/CARHourlyForecast.h"

@interface DailyWeatherTests : XCTestCase

@end

@implementation DailyWeatherTests

- (void)testCurrentWeather {
    NSData *weatherData = loadFile(@"CurrentWeather.json", [DailyWeatherTests class]);
    NSError *jsonError = nil;
    NSDictionary *weatherDictionary = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing Error %@", jsonError);
    }
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581003354 / 1000.0];
    CARCurrentForecast *forecast = [[CARCurrentForecast alloc] initWithDictionary:weatherDictionary];
    XCTAssertEqualObjects(time, forecast.time);
    XCTAssertEqualObjects(@"Clear", forecast.summary);
    XCTAssertEqualObjects(@"clear-day", forecast.icon);
    XCTAssertEqualWithAccuracy(0, forecast.percipProbability, 0.001);
    XCTAssertEqualWithAccuracy(0, forecast.percipIntensity, 0.001);
    XCTAssertEqualWithAccuracy(48.35, forecast.temperature, 0.001);
    XCTAssertEqualWithAccuracy(47.4, forecast.apparentTemperature, 0.001);
    XCTAssertEqualWithAccuracy(0.77, forecast.humidity, 0.001);
    XCTAssertEqualWithAccuracy(1023.2, forecast.pressure, 0.001);
    XCTAssertEqualWithAccuracy(3.45, forecast.windSpeed, 0.001);
    XCTAssertEqual(24, forecast.windBearing);
    XCTAssertEqual(0, forecast.uvIndex);
}

- (void) testDailyWeather {
    NSData *weatherData = loadFile(@"DailyWeather.json", [DailyWeatherTests class]);
    NSError *jsonError = nil;
    NSArray *weatherArray = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing Error %@", jsonError);
    }
    
    NSMutableArray *weatherObjects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in weatherArray) {
        CARDailyForecast *forecast = [[CARDailyForecast alloc] initWithDictionary:dictionary];
        [weatherObjects addObject:forecast];
    }
    CARDailyForecast *forecast = [weatherObjects objectAtIndex:3];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581235200 / 1000.0];
    XCTAssertNotNil(weatherObjects);
    XCTAssertEqual(8, weatherObjects.count);
    XCTAssertEqualObjects(time, forecast.time);
    XCTAssertEqualObjects(@"Clear throughout the day.", forecast.summary);
    XCTAssertEqualObjects(@"clear-day", forecast.icon);
    XCTAssertEqualWithAccuracy(0, forecast.precipProbability, 0.001);
    XCTAssertEqualWithAccuracy(0, forecast.precipIntensity, 0.001);
    XCTAssertNil(forecast.precipType);
    XCTAssertEqualWithAccuracy(60.6, forecast.temperatureHigh, 0.001);
    XCTAssertEqualWithAccuracy(51.2, forecast.temperatureLow, 0.001);
    XCTAssertEqualWithAccuracy(60.1, forecast.apparentTemperature, 0.001);
    XCTAssertEqualWithAccuracy(0.42, forecast.humidity, 0.001);
    XCTAssertEqualWithAccuracy(1018.8, forecast.pressure, 0.001);
    XCTAssertEqualWithAccuracy(16.5, forecast.windSpeed, 0.001);
    XCTAssertEqual(15, forecast.windBearing);
    XCTAssertEqual(4, forecast.uvIndex);
}

- (void) testHourlyWeather {
    NSData *weatherData = loadFile(@"HourlyWeather.json", [DailyWeatherTests class]);
    NSError *jsonError = nil;
    NSArray *weatherArray = [NSJSONSerialization JSONObjectWithData:weatherData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing Error %@", jsonError);
    }
    
    NSMutableArray *weatherObjects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in weatherArray) {
        CARHourlyForecast *forecast = [[CARHourlyForecast alloc] initWithDictionary:dictionary];
        [weatherObjects addObject:forecast];
    }
    
    CARHourlyForecast *forecast = [weatherObjects objectAtIndex:0];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1581001200 / 1000.0];
    XCTAssertNotNil(weatherObjects);
    XCTAssertEqual(49, weatherObjects.count);
    XCTAssertEqualObjects(time, forecast.time);
    XCTAssertEqualObjects(@"Clear", forecast.summary);
    XCTAssertEqualObjects(@"clear-night", forecast.icon);
    XCTAssertEqualWithAccuracy(0.0, forecast.precipProbability, 0.001);
    XCTAssertEqualWithAccuracy(0, forecast.precipIntensity, 0.001);
    XCTAssertNil(forecast.precipType);
    XCTAssertEqualWithAccuracy(47.68, forecast.temperature, 0.001);
    XCTAssertEqualWithAccuracy(46.54, forecast.apparentTemperature, 0.001);
    XCTAssertEqualWithAccuracy(0.78, forecast.humidity, 0.001);
    XCTAssertEqualWithAccuracy(1022.8, forecast.pressure, 0.001);
    XCTAssertEqualWithAccuracy(3.57, forecast.windSpeed, 0.001);
    XCTAssertEqual(36, forecast.windBearing);
    XCTAssertEqual(0, forecast.uvIndex);
}

@end
