//
//  ViewController.h
//  LongRunningTaskLocationExample
//
//  Created by Bob Dugan on 11/5/15.
//  Copyright © 2015 Bob Dugan. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
#import "BackgroundTimeRemainingUtility.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, atomic) CLLocationManager* locationManager;

@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@property (weak, nonatomic) IBOutlet UILabel *speed;

@end

