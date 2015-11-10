//
//  MainViewController.m
//  EmiApp
//
//  Created by Boris  on 11/7/15.
//  Copyright © 2015 LLT. All rights reserved.
//

#import "MainViewController.h"
#import "ResultViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize result, titleLabel;

- (IBAction)start:(id)sender {
    
    result.text = @"";
    
    [self.stt recognize:^(NSDictionary* res, NSError* err){
        
        if(err == nil)
            result.text = [self.stt getTranscript:res];
    }];
    
}

- (IBAction)stop:(id)sender {
    
    
    [self.stt endRecognize];
    
    if (step == 0) {
        
        NSLog(@"STOPPED");
        
        if ([result.text containsString:@"hello"]) {
            
            TTSConfiguration *tts_conf = [[TTSConfiguration alloc] init];
            [tts_conf setBasicAuthUsername:@"e2cc79fc-ec26-4398-a8e5-8191ed5e88ae"];
            [tts_conf setBasicAuthPassword:@"LzbhcR1pRCeh"];
            [tts_conf setVoiceName:@"en-US_AllisonVoice"];
            
            TextToSpeech *tts = [TextToSpeech initWithConfig:tts_conf];
            
            [tts synthesize:^(NSData *data, NSError *err) {
                
                // play audio and log when playing has finished
                [tts playAudio:^(NSError *err) {
                    
                    if(!err)
                        NSLog(@"audio finished playing");
                    else
                        NSLog(@"error playing audio %@",err.localizedDescription);
                    
                } withData:data];
                
            } theText:@"Hello Boris"];
        }
        
        [self connectBlueMixAPI];
        
    }
    
    if (step == 1) {
        
        
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
                
                if(!err) {
                    NSLog(@"audio finished playing");
                    NSLog(@"audio finished playing");
                    NSDictionary *startFlightInfo = [[NSDictionary alloc] initWithObjects:@[@"EK542",@"DXB",@"23:12",@"12hrs",@"978.00"] forKeys:@[@"number",@"city",@"time",@"duration",@"price"]];
                    
                    NSDictionary *returnFlightInfo = [[NSDictionary alloc] initWithObjects:@[@"EK545",@"MAA",@"09:12",@"12hrs"] forKeys:@[@"number",@"city",@"time",@"duration"]];
                    
                    ResultViewController *rvc = [self.storyboard instantiateViewControllerWithIdentifier:@"result"];
                    rvc.startFlightInfo  = startFlightInfo;
                    rvc.returnFlightInfo = returnFlightInfo;
                    [self.navigationController pushViewController:rvc animated:YES];
                }
                else
                    NSLog(@"error playing audio %@",err.localizedDescription);
                
            } withData:data];
            
        } theText:@"Okay Austin, give me a second while I find you the best flight available"];
        
        
        //[NSThread sleepForTimeInterval:2.0f];
        
        
  
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    step = 0;
    
     STTConfiguration *stt_conf = [[STTConfiguration alloc] init];
    [stt_conf setBasicAuthUsername:@"14a6a511-5518-4b3f-9e57-89519020e2d7"];
    [stt_conf setBasicAuthPassword:@"NG27fn72xYDa"];
    [stt_conf setModelName:@"en-US_BroadbandModel"];
    [stt_conf setAudioCodec:WATSONSDK_AUDIO_CODEC_TYPE_OPUS];
    
    self.stt = [SpeechToText initWithConfig:stt_conf];

    
    [self.stt listModels:^(NSDictionary* jsonDict, NSError* err){
        
        if(err == nil)
            NSLog(@"JSON Models:%@",jsonDict);
        
            }];
    
    
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    step = 0;
    titleLabel.text = @"Good Morning Austin! Let me know where do you want to go?";
    
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

#pragma mark - NSURLConnection Methods

-(void)connectBlueMixAPI {

    NSString *placeString  = @"http://emix.mybluemix.net/text";
    [self URLConnect:placeString withMethod:@"POST"];
    
}



-(void)URLConnect:(NSString *)urlString withMethod:(NSString *)method {
    
    
    //NSString *str = @"{ \"text\" : \"find me a flight from SFO\"}";
    
    NSString *str = [NSString stringWithFormat:@"{ \"text\" : \"%@\"}",result.text.capitalizedString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *Connection =[[NSURLConnection alloc]
                                  initWithRequest:request
                                  delegate:self];
    
    if (Connection) {
        receivedData = [NSMutableData data];
    }
    
}

#pragma mark - NSURL Delegate Methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection success.");
    
    theResponse = [[NSString alloc] initWithBytes:[receivedData bytes] length:[receivedData length] encoding: NSUTF8StringEncoding];
    
    NSLog(@"theResponse:%@",theResponse);
    
    if (step == 0) {
        
        TTSConfiguration *tts_conf = [[TTSConfiguration alloc] init];
        [tts_conf setBasicAuthUsername:@"e2cc79fc-ec26-4398-a8e5-8191ed5e88ae"];
        [tts_conf setBasicAuthPassword:@"LzbhcR1pRCeh"];
        [tts_conf setVoiceName:@"en-US_AllisonVoice"];
        
        TextToSpeech *tts = [TextToSpeech initWithConfig:tts_conf];
        
        [tts listVoices:^(NSDictionary* jsonDict, NSError* err){
            
            if(err == nil)
                NSLog(@"JSON Voices:%@",jsonDict);
            
        }];
        
        step++;
        result.text = @"";
        titleLabel.text = @"When do you want to return Austin?";
        
        [tts synthesize:^(NSData *data, NSError *err) {
            
            // play audio and log when playing has finished
            [tts playAudio:^(NSError *err) {
                
                if(!err)
                    NSLog(@"audio finished playing");
                else
                    NSLog(@"error playing audio %@",err.localizedDescription);
                
            } withData:data];
            
        } theText:titleLabel.text];
        
    }
   
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failure.");
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
    
    theResponse = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
    
    /*
     If the request is being made from the requestRandomPassword method it will request a new random password
     and create a new PFObject with the password and singly user id then it will log the PFObject id in the
     users default with the singly user as a key, then it registers the user to ejabberd
     */

}


@end
