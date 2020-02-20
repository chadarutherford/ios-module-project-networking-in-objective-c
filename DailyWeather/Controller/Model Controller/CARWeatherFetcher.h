//
//  CARWeatherFetcher.h
//  DailyWeather
//
//  Created by Chad Rutherford on 2/20/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CARCurrentForecast.h"

typedef void(^CARWeatherFetcherArrayCompletion)(NSArray * _Nullable weatherArray, NSError * _Nullable error);

typedef void(^CARWeatherFetcherCompletion)(CARCurrentForecast * _Nullable weather, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface CARWeatherFetcher : NSObject

- (void)fetchCurrentWeatherForLatitude:(double)latitude
                             longitude:(double)longitude
                            completion:(CARWeatherFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
