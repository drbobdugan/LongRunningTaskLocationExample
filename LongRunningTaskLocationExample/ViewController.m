//
//  ViewController.m
//  LongRunningTaskLocationExample
//
//  Created by Bob Dugan on 11/5/15.
//  Copyright © 2015 Bob Dugan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    // Location manager initialization code
    //
    self.locationManager = [[CLLocationManager alloc] init];
    
    // Request authorization to get location information
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    // Fails in iOS7 and earlier
    else
    {
        NSLog(@"CLLocationManager: requestAlwaysAuthorization failed");
    }
    
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// Location Manager delegate method
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];

    // Send location info to console
    NSLog(@"%@", [locations lastObject]);
    
    // Send background info to console if in background
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        [BackgroundTimeRemainingUtility NSLog];
    }
    // Update UI if in foreground
    else
    {
        dispatch_block_t work_to_do = ^{
            _latitude.text = [[NSString alloc] initWithFormat:@"%.3f",location.coordinate.latitude];
            _longitude.text = [[NSString alloc] initWithFormat:@"%.3f",location.coordinate.longitude];
            _speed.text = [[NSString alloc] initWithFormat:@"%.3f",location.speed];
        };
        
        if ([NSThread mainThread]) work_to_do();
        else dispatch_sync(dispatch_get_main_queue(), work_to_do);
    }
}

@end
