//
//  MainViewController.h
//  EmiApp
//
//  Created by Boris  on 11/7/15.
//  Copyright © 2015 LLT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <watsonsdk/SpeechToText.h>
#import <watsonsdk/STTConfiguration.h>
#import <watsonsdk/TextToSpeech.h>
#import <watsonsdk/TTSConfiguration.h>

@interface MainViewController : UIViewController <NSURLConnectionDelegate> {
    
    
    int step;
    
    // HTTP Request Related Local Variables
    NSMutableData *receivedData;
    NSURLConnection *urlConnection;
    NSString *theResponse;
    NSString *connectionType;
}

@property (nonatomic, strong) SpeechToText *stt;
@property (nonatomic, strong) IBOutlet UITextView *result;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;


@end
