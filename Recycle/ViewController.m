//
//  ViewController.m
//  Recycle
//
//  Created by Michael Stephenson on 10/13/13.
//  Copyright (c) 2013 Michael Stephenson. All rights reserved.
//

#import "ViewController.h"


// Picker Definitions
#define componentCount 2		// Two columns for picker
#define categoryComponent 0		// Column 1
#define itemComponent 1		// Column 2



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //..Dermine iPhone type
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){CGSize result =[[UIScreen mainScreen] bounds].size;
        if(result.height <= 500){  // iPhone 4 (480) or lower
            imgSymbols = @"4symbolBackground.jpg";
            imgBatteries = @"4batteryBackground.jpg";
            imgLights = @"4lightsBackground.jpg";
            imgPaints = @"4paintBackground.jpg";
            imgHousehold = @"4householdBackground.jpg";
            
        }else { // iPhone 5 (568) or higher
            imgSymbols = @"5symbolBackground.jpg";
            imgBatteries = @"5batteryBackground.jpg";
            imgLights = @"5lightsBackground.jpg";
            imgPaints = @"5paintBackground.jpg";
            imgHousehold = @"5householdBackground.jpg";
            
        }}
    
    
    //..Image
    //Image
    // Loads image for top banner
    self.productImage.image = [UIImage imageNamed:@"symbolsBanner.jpg"];
    // Loads image background behind web view
    self.webImageView.image = [UIImage imageNamed:imgSymbols];
    

    // Tap to dismiss
    /*
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
     */
    
    //
    // //..Picker Populate
    //
    
    //      Load Inital values for picker for when program is first started
    pickerCategoryArray = [[NSArray alloc]initWithObjects:
                         @"Symbols",@"Batteries", @"Lights",
                         @"Paints",@"Household",
                         nil];
    // pickerItemArray used for inital value only - gets changed later
    //  Needs to correspond with first item on pickerCategoryArray list
    
    itemArraySwitch = @"image";
    
    pickerItemImageArray = [[NSArray alloc]initWithObjects:
                                                [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-1.gif"]],
                                                [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-2.gif"]],
                                                [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-3.gif"]],
                                                [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-4.gif"]],
                                                [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-5.gif"]],
                                                [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-6.gif"]],
                                                [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-7.gif"]],
                                                nil
                          ];
    
        pickerItemArray = [[NSArray alloc]initWithObjects:
                          @"1", @"2", @"3",@"4", @"5", @"6", @"7",nil];



    //
    // //..End Picker Populate
    //
    
    //
    //..Button
    //
    
    // inital value for show/hide picker
    strPickerVisibility = @"on";
    
    // inital value for buttons
    _hideButton.hidden = NO;
    _buttonTransparencyLabel.hidden = YES;
    _showButton.hidden = YES;
    _shadowPicker.hidden = NO;
    
    
    // Button Background Color & Text Color
	/*
     UIImage *normalImage = [[UIImage imageNamed:@"whiteButton.png"]
							stretchableImageWithLeftCapWidth:12.0
							topCapHeight:0.0];
	[_hideButton setBackgroundImage:normalImage forState:UIControlStateNormal];
	[_hideButton setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
     */
    //
    //..End Button
    //
    
    
    // ^|^|^
    // //..WebView Populate
    
    //..Loads a Local HTML File
    strHTML = @"Symbols-1";
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:strHTML ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [_productWebView loadHTMLString:htmlString baseURL:baseURL];

    //
    // //..End WebView Populate
    // ^|^|^
    
    // ~~~~~~ Set Motion Effects
    // ~~~~~~
    
    // Adjust motion value here:
    
    // Label Background Images
    [self MotionEffects:self.productImage depth:5.0];
    [self MotionEffects:self.labelBannerTransparent depth:5.0];
    [self MotionEffects:self.shadowBanner depth:5.0];
    
    // WebView Background Image
    [self MotionEffects:self.webImageView depth:30.0];
    
    // ~~~~~~
    // ~~~~~~ End Set Motion Effects

}  // - (void)viewDidLoad


// ~~~~~~
//  -  -    Motion Effects
//   --
// ~~~~~~

// NOTE: Change motion effect values in - (void)viewDidLoad

- (void)MotionEffects:(UIView *)aView depth:(CGFloat)depth;
{
    // Runs Motion only if iOS7
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {

        UIInterpolatingMotionEffect *horizontal;
        UIInterpolatingMotionEffect *vertical;
        
        horizontal = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        vertical = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                   type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        // positive/negative order changes tilt direction
        horizontal.maximumRelativeValue = @(-depth);
        horizontal.minimumRelativeValue = @(depth);
        vertical.maximumRelativeValue = @(-depth);
        vertical.minimumRelativeValue = @(depth);
        
        [aView addMotionEffect:horizontal];
        [aView addMotionEffect:vertical];
        
        // Create a motion effects group and add both of our motion effects to it.
        motionEffects = [[UIMotionEffectGroup alloc] init];
        motionEffects.motionEffects = @[horizontal, vertical];
    }
}

// ~~~~~~
//  -  -
//   --     End Motion Effects
// ~~~~~~



//  _____
// |     |
// | ^ ^ |	Tap to show / hide picker
// |  -  |
// |_____|
//

// Tap to Dismiss
//Implement resignOnTap:

- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
    // Calll to Hide Picker
    if([strPickerVisibility  isEqual: @"on"]) {
        [self hidePicker];
        strPickerVisibility = @"off";
    } else {
        [self showPicker];
        strPickerVisibility = @"on";
    }
}
//  _____
// |     |
// | ^ ^ |	End Tap to show / hide picker
// |  -  |
// |_____|
//


//  _____
// | _ _ |
// | ^|^ |	Segue to Info Page
// |  0  |
// |_____|
//

-(IBAction)unwindToViewController:(UIStoryboardSegue*)segue {
    
    //nothing goes here
}




//  _____
// | _ _ |
// | ^|^ |	End Segue to Info Page
// |  0  |
// |_____|
//


//  _____
// | _ _ |
// | ^|^ |	Show/Hide Picker
// | <-> |
// |_____|
//

#pragma mark Show & Hide Picker

// Decide if to be ON or OFF

-(IBAction) btnSelectionPressed:(id)sender {
		[self showPicker];
}

-(IBAction) btnPickerPressed:(id)sender {
		[self hidePicker];
}

// Gesture Recognition
/*
- (IBAction)tapDetected:(UIGestureRecognizer *)sender {
    [_hideButton.titleLabel  isEqual: @"Double Tap Hide Button"];
    [_showButton.titleLabel  isEqual: @"Double Tap Show Button"];
    //[self.productWebView addGestureRecognizer:];
}
*/

// Show Picker
-(void) showPicker {
    // Picker - Transition Effect
    [UIView transitionWithView:_pickerRecycle
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    [UIView transitionWithView:_shadowPicker
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _pickerRecycle.hidden = NO;
    _shadowPicker.hidden = NO;
    
    // Picker Transparancy Label - Transition Effect   pickerTransparancyLabel
    [UIView transitionWithView:_pickerTransparancyLabel
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _pickerTransparancyLabel.hidden = NO;
    
    // Button - Transition Effect
    [UIView transitionWithView:_hideButton
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_buttonTransparencyLabel
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_showButton
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _hideButton.hidden = NO;
    _buttonTransparencyLabel.hidden = YES;
    _showButton.hidden = YES;
    
    // _labelGrayPicker - Transition Effect
    [UIView transitionWithView:_labelGrayPicker
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    _labelGrayPicker.hidden = NO;
    
    // _labelCategoryPicker - Transition Effect
    [UIView transitionWithView:_labelCategoryPicker
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    _labelCategoryPicker.hidden = NO;
    
    // _labelItemPicker - Transition Effect
    [UIView transitionWithView:_labelItemPicker
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    _labelItemPicker.hidden = NO;
}

// Hide Picker
-(void) hidePicker {
    

    // Picker - Transition Effect
     [UIView transitionWithView:_pickerRecycle
                               duration:0.7
                                options:UIViewAnimationOptionTransitionCrossDissolve
                             animations:NULL
                             completion:NULL];
    
    [UIView transitionWithView:_shadowPicker
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
     
     _pickerRecycle.hidden = YES;
    _shadowPicker.hidden = YES;
    
    // Picker Transparancy Label - Transition Effect   pickerTransparancyLabel
    [UIView transitionWithView:_pickerTransparancyLabel
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    _pickerTransparancyLabel.hidden = YES;
    
        // Button - Transition Effect
        [UIView transitionWithView:_hideButton
                          duration:0.7
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
    [UIView transitionWithView:_buttonTransparencyLabel
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:_showButton
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
        _hideButton.hidden = YES;
        _buttonTransparencyLabel.hidden = NO;
        _showButton.hidden = NO;
    
    // _labelGrayPicker - Transition Effect
    [UIView transitionWithView:_labelGrayPicker
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    _labelGrayPicker.hidden = YES;
    
    // _labelCategoryPicker - Transition Effect
    [UIView transitionWithView:_labelCategoryPicker
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    _labelCategoryPicker.hidden = YES;
    
    // _labelItemPicker - Transition Effect
    [UIView transitionWithView:_labelItemPicker
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    _labelItemPicker.hidden = YES;

}

//  _____
// | _ _ |
// | ^|^ |	End Show/Hide Buttons
// | <-> |
// |_____|
//


//  _____
// | _ _ |
// | ^|^ |	Start Picker Setup
// | -~- |
// |_____|
//

// UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;{
    
    return componentCount;
    
}


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;{
    
    if (component==categoryComponent) {
		return [pickerCategoryArray count];
	} else {    // if (component==itemComponent) { // /*  Unused 3rd column
		return [pickerItemArray count];
    }
}

// Set height of Rows

 - (CGFloat)pickerView:(UIPickerView *)pickerView
 rowHeightForComponent: (NSInteger)component {
 return 50.0;
 }



// Set Picker Column Widths =
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	if (component==categoryComponent) {
		return 140.0; // the wide column
	} else {
		return 140.0; // the other column
	}
}

// UIPickerViewDelegate

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect

/*
//..TEXT ALIGNMENT IN THE PICKER
 
 NSTextAlignmentLeft      = 0,
 NSTextAlignmentCenter    = 1,
 NSTextAlignmentRight     = 2,
 NSTextAlignmentJustified = 3,
 NSTextAlignmentNatural   = 4,
 
 symbolLabel.textAlignment=2; // Aligns text to the Right
 
 */

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    if (component==categoryComponent) {
		UILabel *symbolLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,100,50)]; // productLabel.frame = CGRectMake(x,y,width,height);
		symbolLabel.backgroundColor=[UIColor clearColor];
		symbolLabel.text=[pickerCategoryArray objectAtIndex:row];
        symbolLabel.textAlignment=1;
		return symbolLabel;
    } else  { // (component==itemComponent)
        
        //
        // Display an IMAGE in the PICKER Row
        //
        
        if ([itemArraySwitch isEqual:@"image"]) {  // image
            
            // self.myImages is an array of UIImageView objects
            UIView * myView = [pickerItemImageArray objectAtIndex:row];
            
            // first convert to a UIImage
            UIGraphicsBeginImageContextWithOptions(myView.bounds.size, NO, 0);
            
            [myView.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            // then convert back to a UIImageView and return it
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            
            // Set image size
            [imageView setFrame:CGRectMake(0, 0, 45, 50)];
            
            return imageView;
        
        //
        // Display TEXT in the Picker Row
        //
        
        }else {  // text

            UILabel *productLabel;
            productLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,110,50)]; // productLabel.frame = CGRectMake(x,y,width,height);
            productLabel.backgroundColor=[UIColor clearColor];
            productLabel.text=[pickerItemArray objectAtIndex:row];
            productLabel.textAlignment=1;
            
            return productLabel;
        }
        
        /*
        if ([itemArraySwitch isEqual:@"text"]) {
            UILabel *productLabel;
            productLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,110,50)];
            productLabel.backgroundColor=[UIColor clearColor];
            productLabel.text=[pickerItemArray objectAtIndex:row];
            return productLabel;
        }else {
            return [pickerItemImageArray objectAtIndex:row];
        }
         */
        
    }
    
}

//  _____
// | _ _ |
// | ^|^ |	End Picker Setup
// | -~- |
// |_____|
//

#pragma mark - Picker Selected Item

//  _____
// | _ _ |
// | ^|^ |	Start Picker Selected Item
// | <-> |  Changes the 2nd column values based on 1st column selection
// |_____|
//

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
	if (component == categoryComponent) {
		NSString *selectSymbol = [self->pickerCategoryArray objectAtIndex:row];
        
        //
        // Set the Product column based on the Symbol column selection
        //
        
        if ([selectSymbol  isEqual: @"Symbols"]) {
            //..Array is an Image
            itemArraySwitch = @"image";
            
            if ((itemArraySwitch=@"image")) {
                pickerItemImageArray = [[NSArray alloc]initWithObjects:
                                      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-1.gif"]],
                                      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-2.gif"]],
                                      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-3.gif"]],
                                      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-4.gif"]],
                                      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-5.gif"]],
                                      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-6.gif"]],
                                      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Symbol-7.gif"]],
                                      nil];
                
                pickerItemArray = [[NSArray alloc]initWithObjects:
                                      @"1", @"2", @"3",@"4", @"5", @"6", @"7",nil];
            }
            
            
        } else if ([selectSymbol  isEqual: @"Batteries"]) {
            //..Array is Text
            itemArraySwitch = @"text";
            
            pickerItemArray = [[NSArray alloc]initWithObjects:
                                  @"Alkaline",@"Lithium", @"Lead Acid",
                                  nil];
            
        } else if ([selectSymbol  isEqual: @"Lights"]) {
            //..Array is Text
            itemArraySwitch = @"text";
            
            pickerItemArray = [[NSArray alloc]initWithObjects:
                                  @"Incandescent",@"Fluorescent",
                                  @"LED", @"Halogen",
                                  nil];
            
        } else if ([selectSymbol  isEqual: @"Paints"]) {
            //..Array is Text
            itemArraySwitch = @"text";
            
            pickerItemArray = [[NSArray alloc]initWithObjects:
                                  @"Spray Paint", @"Oil Based",
                                  @"Water Based", @"Stains",
                                  nil];
            
        } else if ([selectSymbol  isEqual: @"Household"]) {
            //..Array is Text
            itemArraySwitch = @"text";
            
            pickerItemArray = [[NSArray alloc]initWithObjects:
                                  @"Nail Polish", @"Motor Oil", @"Gasoline", @"Antifreeze",
                                  @"Brake Fluid", @"Pesticides",
                                  nil];
            
        }
		
        // Act on the data
        NSInteger intSymbol; //Location of Symbol (Image) Picker Item
        NSInteger intProduct = 0;	//Location of Product (Text) Picker Item
        
        // Location of Selected Symbol Picker Item
        intSymbol =[pickerView selectedRowInComponent:categoryComponent];
        // intLocation = [pickerView selectedRowInComponent:locationComponent];
        
        
        // Reload Picker location
        [pickerView reloadComponent:itemComponent];

        //..Set transition of 2nd Picker Column
        [UIView transitionWithView:_pickerRecycle
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        
		// These picker values are used to determine the Table View Contents
        // .....Note that "selectedItem" is set twice.
        // .....This is to allow the picker to compensate for different numbers of items without it crashing
        selectedCategory = [pickerCategoryArray objectAtIndex:intSymbol];
        selectedItem = [pickerItemArray objectAtIndex:intProduct]; // Somehow compensates for differing item length arrays

        intProduct = [pickerView selectedRowInComponent:itemComponent]; // Load the correct Tableview
        selectedItem = [pickerItemArray objectAtIndex:intProduct]; // Set the var to the correct array item
        
        
        /*      Unused in this program
        // Set the Location Column of the 2nd picker to top of column
		[pickerView selectRow:0 inComponent:itemComponent animated:YES]; // Set the Picker
         */
        
        
	} else { //(component == itemComponent)
		// Act on the data
        NSInteger intSymbol;
        NSInteger intProduct;
        
        //Location of Selected Picker Item
        intSymbol =[pickerView selectedRowInComponent:categoryComponent];
        intProduct =[pickerView selectedRowInComponent:itemComponent];
        
		// These values are used to determine Table View Contents
        selectedCategory  = [pickerCategoryArray objectAtIndex:intSymbol];
        selectedItem = [pickerItemArray objectAtIndex:intProduct];
	}
    
    //  _____
    // | _ _ |  'Picker Selected Item'
    // | O|O |      Continues below
    // | -:- |  'Populate the productText and productImage'
    // |_____|
    //

#pragma mark - Set Data & Banner Fade Times
    
    //..Banner
    // productImage
    [UIView transitionWithView:_productImage
                      duration:0.9
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    // labelBannerTransparent
    [UIView transitionWithView:_labelBannerTransparent
                      duration:0.9
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    // selectedTextField
    [UIView transitionWithView:_selectedTextField
                      duration:0.9
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    //..WebView
    // WebView
    [UIView transitionWithView:_productWebView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    // WebView Image
    [UIView transitionWithView:_webImageView
                      duration:0.9
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    
    
#pragma mark - Populate the productText and productImage
    
    //  _____
    // | ~ ~ |
    // | -|- |	Populate the productText and productImage
    // | -~- |  (located within 'Picker Selected Item')
    // |_____|
    //
    
    // This is where the the text information is created.
    // 1 - Calls methods below - see pragma marks
    // 2 - Reloads HTML file

#pragma mark - Symbols
    //..Symbols
    if ([selectedCategory  isEqual: @"Symbols"]) {
        
        //Image
        self.productImage.image = [UIImage imageNamed:@"symbolsBanner.jpg"];
        // Loads image background behing web view
        self.webImageView.image = [UIImage imageNamed: imgSymbols];
        
        //..1
        if ([selectedItem  isEqual: @"1"]) {
            // selected Text Field
            _selectedTextField.text = @"Recycling Symbol 1";
            // HTML File Name:
            strHTML = @"Symbols-1";
        //..2
        } else  if ([selectedItem  isEqual: @"2"])  {
            // selected Text Field
            _selectedTextField.text = @"Recycling Symbol 2";
            // HTML File Name:
            strHTML = @"Symbols-2";
        //..3
        } else  if ([selectedItem  isEqual: @"3"])  {
            // selected Text Field
            _selectedTextField.text = @"Recycling Symbol 3";
            // HTML File Name:
            strHTML = @"Symbols-3";
        //..4
        } else  if ([selectedItem  isEqual: @"4"])  {
            // selected Text Field
            _selectedTextField.text = @"Recycling Symbol 4";
            // HTML File Name:
            strHTML = @"Symbols-4";
        //..5
        } else  if ([selectedItem  isEqual: @"5"])  {
            // selected Text Field
            _selectedTextField.text = @"Recycling Symbol 5";
            // HTML File Name:
            strHTML = @"Symbols-5";
        //..6
        } else  if ([selectedItem  isEqual: @"6"])  {
            // selected Text Field
            _selectedTextField.text = @"Recycling Symbol 6";
            // HTML File Name:
            strHTML = @"Symbols-6";
        //..7
        } else  {
            // selected Text Field
            _selectedTextField.text = @"Recycling Symbol 7";
            // HTML File Name:
            strHTML = @"Symbols-7";
        } //..End If for Symbols

#pragma mark - Batteries
    //..Batteries   @"Alkaline",@"Lithium", @"Lead Acid",
    } else if ([selectedCategory  isEqual: @"Batteries"]) {
        // Set web image background color
        self.webImageView.backgroundColor = [UIColor blueColor];
        // Banner Image
        self.productImage.image = [UIImage imageNamed:@"batteryBanner.jpg"];
        // Loads image background behing web view
        self.webImageView.image = [UIImage imageNamed: imgBatteries];
        
        //..Alkaline
        if ([selectedItem  isEqual: @"Alkaline"]) {
            // selected Text Field
            _selectedTextField.text = @"Alkaline Batteries";
            // HTML File Name:
            strHTML = @"Batteries-Alkaline";
        //..Lithium
        } else  if ([selectedItem  isEqual: @"Lithium"])  {
            // selected Text Field
            _selectedTextField.text = @"Lithium Batteries";
            // HTML File Name:
            strHTML = @"Batteries-Lithium";
        //..Lead Acid
        } else  {
            // selected Text Field
            _selectedTextField.text = @"Lead-Acid Batteries";
            // HTML File Name:
            strHTML = @"Batteries-LeadAcid";
        } //..End If for Batteries
      
#pragma mark - Lights
    //..Lights      @"Incandescent",@"Fluorescent",@"LED", @"Halogen"
    } else if ([selectedCategory  isEqual: @"Lights"]) {
        //Image
        self.productImage.image = [UIImage imageNamed:@"lightsBanner.jpg"];
        // Loads image background behing web view
        self.webImageView.image = [UIImage imageNamed: imgLights];
        
        //..Incandescent
        if ([selectedItem  isEqual: @"Incandescent"]) {
            // selected Text Field
            _selectedTextField.text = @"Incandescent Lights";
            // HTML File Name:
            strHTML = @"Lights-Incandescent";
        //..Fluorescent
        } else  if ([selectedItem  isEqual: @"Fluorescent"])  {
            // selected Text Field
            _selectedTextField.text = @"Fluorescent Lights";
            // HTML File Name:
            strHTML = @"Lights-Fluorescent";
        //..LED
        } else  if ([selectedItem  isEqual: @"LED"])  {
            // selected Text Field
            _selectedTextField.text = @"LED Lights";
            // HTML File Name:
            strHTML = @"Lights-LED";
        //..Halogen
        } else  {
            // selected Text Field
            _selectedTextField.text = @"Halogen Lights";
            // HTML File Name:
            strHTML = @"Lights-Halogen";
        } //..End If for Lights

#pragma mark - Paints
    //..Paints  @"Spray Paint", @"Oil Based", @"Water Based", @"Stains"
    } else if ([selectedCategory  isEqual: @"Paints"]) {
        //Image
        self.productImage.image = [UIImage imageNamed:@"paintBanner.jpg"];
        // Loads image background behing web view
        self.webImageView.image = [UIImage imageNamed: imgPaints];
        
        //..Spray Paint
        if ([selectedItem  isEqual: @"Spray Paint"]) {
            // selected Text Field
            _selectedTextField.text = @"Spray Paint";
            // HTML File Name:
            strHTML = @"Paints-SprayPaint";
        //..Oil Based
        } else  if ([selectedItem  isEqual: @"Oil Based"])  {
            // selected Text Field
            _selectedTextField.text = @"Oil Based Paints";
            // HTML File Name:
            strHTML = @"Paints-OilBased";
        //..Water Based
        } else  if ([selectedItem  isEqual: @"Water Based"])  {
            // selected Text Field
            _selectedTextField.text = @"Water Based Paints";
            // HTML File Name:
            strHTML = @"Paints-WaterBased";
        //..Stains
        } else  {
            // selected Text Field
            _selectedTextField.text = @"Stains";
            // HTML File Name:
            strHTML = @"Paints-Stains";
        } //..End If for paints

#pragma mark - Household
    //..Household  @"Motor Oil", @"Gasoline", @"Antifreeze", @"Brake Fluid", @"Pesticides",
    } else { // ([selectedCategory  isEqual: @"House"]) {
        //Image
        self.productImage.image = [UIImage imageNamed:@"householdBanner.jpg"];
        // Loads image background behing web view
        self.webImageView.image = [UIImage imageNamed: imgHousehold];
        
        //..Nail Polish
        if ([selectedItem  isEqual: @"Nail Polish"]) {
            // selected Text Field
            _selectedTextField.text = @"Nail Polish";
            // HTML File Name:
            strHTML = @"Household-NailPolish";
        //..Motor Oil
        } else if ([selectedItem  isEqual: @"Motor Oil"]) {
            // selected Text Field
            _selectedTextField.text = @"Motor Oil";
            // HTML File Name:
            strHTML = @"Household-MotorOil";
        //..Gasoline
        } else  if ([selectedItem  isEqual: @"Gasoline"])  {
            // selected Text Field
            _selectedTextField.text = @"Gasoline";
            // HTML File Name:
            strHTML = @"Household-Gasoline";
        //..Antifreeze
        } else  if ([selectedItem  isEqual: @"Antifreeze"])  {
            // selected Text Field
            _selectedTextField.text = @"Antifreeze";
            // HTML File Name:
            strHTML = @"Household-Antifreeze";
        //..Brake Fluid
        } else  if ([selectedItem  isEqual: @"Brake Fluid"])  {
            // selected Text Field
            _selectedTextField.text = @"Brake Fluid";
            // HTML File Name:
            strHTML = @"Household-BrakeFluid";
        //..Pesticides
        } else  {
            // selected Text Field
            _selectedTextField.text = @"Pesticides";
            // HTML File Name:
            strHTML = @"Household-Pesticides";
        } //..End If forFuids
    
    } //.. End IF for Symbols

#pragma mark - Update HTML files
    // Reload .html data
    
    //..Loads a Local HTML File
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:strHTML ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [_productWebView loadHTMLString:htmlString baseURL:baseURL];
    
    //  _____
    // | ~ ~ |
    // | -|- |	End Populate the productText and productImage
    // | -~- |
    // |_____|
    //
    
} //..End IF for (component == categoryComponent) {

//  _____
// | _ _ |
// | ^|^ |	End Picker Selected Item
// | <-> |
// |_____|
//

// Reload the original yRecycle HTML file to return from visiting a website
-(void) reloadHTML
{
    //..Loads a Local HTML File
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:strHTML ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [_productWebView loadHTMLString:htmlString baseURL:baseURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
