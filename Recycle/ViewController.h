//
//  ViewController.h
//  Recycle
//
//  Created by Michael Stephenson on 10/13/13.
//  Copyright (c) 2013 Michael Stephenson. All rights reserved.
//

#import <UIKit/UIKit.h>

// 'UIGestureRecognizerDelegate' added for TAP in UIWebView
@interface ViewController :  UIViewController <UIPickerViewDataSource,UIPickerViewDelegate, UIGestureRecognizerDelegate> {
    
    //..iPhone 4 or 5 Background Images
    NSString *imgSymbols;
    NSString *imgLights;
    NSString *imgBatteries;
    NSString *imgPaints;
    NSString *imgHousehold;
    
    //..Picker
    NSArray *pickerCategoryArray;
	NSArray *pickerItemArray;
    NSArray *pickerItemImageArray; // Image
    // NSArray *pickerLifeCycleArray; // Unused 3rd column
    
    NSString *selectedCategory;	//Text of Selected Picker Item
    NSString *selectedItem;		//Text of Selected Picker Item
    NSString *selectedItemImage;  // Image
    NSString *itemArraySwitch;  // Switch for controlling Picker rows to be text or an image
    
    //..End Picker
    
    //..Motion Effects
    CGFloat horizontalMinimum;
    CGFloat horizontalMaximum;
    CGFloat verticalMinimum;
    CGFloat verticalMaximum;
    UIMotionEffectGroup *motionEffects;
    
    //..HTML File Name
    NSString *strHTML;
    
    //..Show/Hide Picker - Holds value for the visibility state (on / off)
    NSString *strPickerVisibility;
}

//..Picker
@property (strong, nonatomic) IBOutlet UIPickerView *pickerRecycle;

//..Image
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *labelBannerTransparent;

//..WebView
@property (strong, nonatomic) IBOutlet UIWebView *productWebView;
@property (strong, nonatomic) IBOutlet UIImageView *webImageView;  // Background behind web view

//..Show & Hide picker
// @property (strong, nonatomic) IBOutlet UIButton *hideButton;
@property (strong, nonatomic) IBOutlet UIButton *hideButton;
@property (strong, nonatomic) IBOutlet UIButton *showButton;
@property (strong, nonatomic) IBOutlet UILabel *pickerTransparancyLabel;
@property (strong, nonatomic) IBOutlet UILabel *buttonTransparencyLabel;
@property (strong, nonatomic) IBOutlet UIImageView *shadowBanner;
@property (strong, nonatomic) IBOutlet UIImageView *shadowPicker;
@property (strong, nonatomic) IBOutlet UILabel *labelGrayPicker;
@property (strong, nonatomic) IBOutlet UILabel *labelCategoryPicker;
@property (strong, nonatomic) IBOutlet UILabel *labelItemPicker;

//..TextField
@property (strong, nonatomic) IBOutlet UITextField *selectedTextField;

//
//declare a property to store your current responder
@property (nonatomic, assign) id currentResponder;

//..Show & Hide Picker
-(IBAction) btnPickerPressed:(id)sender;
-(IBAction) btnSelectionPressed:(id)sender;

-(void) MotionEffects:(UIView *)aView depth:(CGFloat)depth;  // Motion Effects
-(void) hidePicker;
-(void) showPicker;
-(void) reloadHTML;


//..Unwind View Controller
// -(IBAction)unwindToViewController;


@end
