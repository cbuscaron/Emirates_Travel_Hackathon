//
//  ResultViewController.h
//  EmiApp
//
//  Created by Boris  on 11/8/15.
//  Copyright © 2015 LLT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <watsonsdk/TextToSpeech.h>

@interface ResultViewController : UIViewController 

@property (nonatomic,strong) NSDictionary *startFlightInfo;
@property (nonatomic,strong) NSDictionary *returnFlightInfo;

@property (nonatomic,strong) IBOutlet UILabel *startFlightNumber;
@property (nonatomic,strong) IBOutlet UILabel *startFlightDepartureCity;
@property (nonatomic,strong) IBOutlet UILabel *startFlightDepartureTime;
@property (nonatomic,strong) IBOutlet UILabel *startFlightDuration;
@property (nonatomic,strong) IBOutlet UILabel *startFlightPrice;
@property (nonatomic,strong) IBOutlet UILabel *returnFlightNumber;
@property (nonatomic,strong) IBOutlet UILabel *returnFlightDepartureCity;
@property (nonatomic,strong) IBOutlet UILabel *returnFlightDepartureTime;
@property (nonatomic,strong) IBOutlet UILabel *returnFlightDuration;
@property (nonatomic,strong) IBOutlet UILabel *returnFlightPrice;
@property (nonatomic,strong) IBOutlet UILabel *altStartFlightNumber;
@property (nonatomic,strong) IBOutlet UILabel *altStartFlightDepartureTime;
@property (nonatomic,strong) IBOutlet UILabel *altReturnFlightNumber;
@property (nonatomic,strong) IBOutlet UILabel *altReturnFlightDepartureTime;

@end
