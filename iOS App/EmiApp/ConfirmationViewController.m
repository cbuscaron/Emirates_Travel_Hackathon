//
//  ConfirmationViewController.m
//  EmiApp
//
//  Created by Boris  on 11/8/15.
//  Copyright © 2015 LLT. All rights reserved.
//

#import "ConfirmationViewController.h"

@interface ConfirmationViewController ()

@end

@implementation ConfirmationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        
    } theText:@"Your flight from DXP to MAA on November 24th is booked! I am sending your confirmation to your email & calendar"];
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
