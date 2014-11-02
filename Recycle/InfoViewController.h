//
//  InfoViewController.h
//  Recycle4
//
//  Created by Michael Stephenson on 12/8/13.
//  Copyright (c) 2013 Michael Stephenson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController {
    
    //..HTML File Name
    NSString *strHTML;

}


//..Web View
@property (strong, nonatomic) IBOutlet UIWebView *infoWebView;
@property (strong, nonatomic) IBOutlet UIImageView *infoBackgroundImage;

//.. Return Button
@property (strong, nonatomic) IBOutlet UIButton *returnButton;


@end
