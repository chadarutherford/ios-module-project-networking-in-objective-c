//
//  CARWeatherFetcher.m
//  DailyWeather
//
//  Created by Chad Rutherford on 2/20/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARWeatherFetcher.h"
#import "LSIErrors.h"
#import "CARCurrentForecast.h"

@implementation CARWeatherFetcher

static NSString *const baseURLString = @"https://api.darksky.net/forecast";
static NSString *const apiKey = @"e09e8bef08758c26d56cacc49fda6973";

// https://api.darksky.net/forecast/API_KEY/lat,lon

- (void)fetchCurrentWeatherForLatitude:(double)latitude
                             longitude:(double)longitude
                            completion:(CARWeatherFetcherCompletion)completion {
    NSURL *url = [[[[NSURL alloc] initWithString:baseURLString] URLByAppendingPathComponent:apiKey] URLByAppendingPathComponent: [NSString stringWithFormat:@"%f,%f", latitude, longitude]];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSError *dataError = errorWithMessage(@"Data should not be nil from API request.", LSIDataNilError);
            completion(nil, dataError);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *weather = json[@"currently"];
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        CARCurrentForecast *forecast = [[CARCurrentForecast alloc] initWithDictionary:weather];
        if (!forecast) {
            NSString *errorMessage = [NSString stringWithFormat:@"Unable to parse JSON object %@", json];
            NSError *parsingError = errorWithMessage(errorMessage, LSIJSONDecodeError);
            completion(nil, parsingError);
            return;
        }
        
        completion(forecast, nil);
    }] resume];
}

@end
