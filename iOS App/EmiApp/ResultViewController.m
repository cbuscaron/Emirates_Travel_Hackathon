//
//  ResultViewController.m
//  EmiApp
//
//  Created by Boris  on 11/8/15.
//  Copyright © 2015 LLT. All rights reserved.
//

#import "ResultViewController.h"
#import "ConfirmationViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize startFlightDepartureCity, startFlightDepartureTime, startFlightDuration, startFlightNumber, startFlightPrice;
@synthesize returnFlightDepartureCity, returnFlightDepartureTime, returnFlightDuration, returnFlightNumber, returnFlightPrice;
@synthesize altReturnFlightDepartureTime, altStartFlightDepartureTime, altReturnFlightNumber, altStartFlightNumber;

@synthesize startFlightInfo, returnFlightInfo;

- (IBAction)book:(id)sender {
    
    ConfirmationViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmation"];
    [self.navigationController pushViewController:cvc animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    startFlightDepartureCity.text     = [NSString stringWithFormat:@"%@ on 11/24/15",startFlightInfo[@"city"]];
    startFlightDepartureTime.text     = startFlightInfo[@"time"];
    startFlightDuration.text          = startFlightInfo[@"duration"];
    startFlightNumber.text            = [NSString stringWithFormat:@"Flight %@",startFlightInfo[@"number"]];
    startFlightPrice.text             = [NSString stringWithFormat:@"$%@",startFlightInfo[@"price"]];
    returnFlightDepartureCity.text    = [NSString stringWithFormat:@"%@ on 12/01/15",returnFlightInfo[@"city"]];
    returnFlightDepartureTime.text    = returnFlightInfo[@"time"];
    returnFlightDuration.text         = returnFlightInfo[@"duration"];
    returnFlightNumber.text           = [NSString stringWithFormat:@"Flight %@",returnFlightInfo[@"number"]];
    altStartFlightNumber.text         = [NSString stringWithFormat:@"Flight %@",startFlightInfo[@"number"]];
    altStartFlightDepartureTime.text  = [NSString stringWithFormat:@"Depart: 11/24/15 %@",startFlightInfo[@"time"]];
    altReturnFlightDepartureTime.text = [NSString stringWithFormat:@"Return: 12/02/15 %@",returnFlightInfo[@"time"]];
    
    TTSConfiguration *tts_conf = [[TTSConfiguration alloc] init];
    [tts_conf setBasicAuthUsername:@"e2cc79fc-ec26-4398-a8e5-8191ed5e88ae"];
    [tts_conf setBasicAuthPassword:@"LzbhcR1pRCeh"];
    [tts_conf setVoiceName:@"en-US_AllisonVoice"];
    
    TextToSpeech *tts = [TextToSpeech initWithConfig:tts_conf];
    
    [tts listVoices:^(NSDictionary* jsonDict, NSError* err){
        
        if(err == nil)
            NSLog(@"JSON Voices:%@",jsonDict);
        
    }];
    
    
    [tts synthesize:^(NSData *data, NSError *err) {
        
        // play audio and log when playing has finished
        [tts playAudio:^(NSError *err) {
            
            if(!err)
                NSLog(@"audio finished playing");
            else
                NSLog(@"error playing audio %@",err.localizedDescription);
            
        } withData:data];
        
    } theText:@"Okay, here are the best flights from DXB to MAA on those dates for 2 passengers. Please tap on the flight you would like to book"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
