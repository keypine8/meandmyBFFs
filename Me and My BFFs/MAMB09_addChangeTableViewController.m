//
//  MAMB09_addChangeTableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-06-29.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

//#include <CoreServices/CoreServices.h>   // these 4 are for  start = mach_absolute_time();
//#include <mach/mach.h>
//#include <mach/mach_time.h>
//#include <unistd.h>


#import "MAMB09_addChangeTableViewController.h"
//#import "MAMB09_selectReportsTableViewController.h"
#import "rkdebug_externs.h"
#import "MAMB09AppDelegate.h"   // to get globals
#import "mamblib.h"

//#import <AudioToolbox/AudioToolbox.h>
//AudioServicesPlaySystemSound(1103);  // C functions
//AudioServicesPlaySystemSound(1106);
//AudioServicesPlaySystemSound(1151);
//AudioServicesPlaySystemSound(1000);
//AudioServicesPlaySystemSound(1052);
//AudioServicesPlaySystemSound(1054);
//AudioServicesPlaySystemSound(1111);
//AudioServicesPlaySystemSound(1257);

//You can Change the Placeholder textcolor to any color which you want by using the below code.  like placeholder tintcolor
//    UIColor *color = [UIColor lightTextColor];
//    YOURTEXTFIELD.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"PlaceHolder Text"
//                                                                          attributes: @{NSForegroundColorAttributeName: color} ];
//

// Tells the receiver to suspend the handling of touch-related events.
//   You typically call this method before starting an animation or transitiion.
//   Calls are nested with the endIgnoringInteractionEvents method.
//
//        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//  if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) { [[UIApplication sharedApplication] endIgnoringInteractionEvents]; }
//
//  if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] == YES) 
//      [[UIApplication sharedApplication] endIgnoringInteractionEvents]; 
//  if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] ==  NO) 
//      [[UIApplication sharedApplication] beginIgnoringInteractionEvents];



//#import "QuartzCore"  
#import "QuartzCore/QuartzCore.h"  // for rounded corners uitextview
//#import <QuartzCore/QuartzCore.h>


@interface MAMB09_addChangeTableViewController ()


@end

    char city_prov_coun_PSVs[26 * 128];    // [max num 25 * fixed length of 128]  for search city using typed so far
    int  num_PSVs_found;                   // zero-based                          for search city using typed so far


@implementation MAMB09_addChangeTableViewController

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender { //  NOTE  still shows paste
//  NSLog(@"in canPerformAction  pppppppppppppppppppppppppppppppppppppppppppp pppppppp pppppppp ppppppppp");
////     return YES;
//    if (action == @selector(paste:)) return NO;
////    return [super canPerformAction:action withSender:sender];
//
//     return NO;
//}
//


-(void)myMenuWillBeShown  // NSNotification  for DISABLE showing of select/paste/cut etc (flashes a bit, but only the 1st time)
{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible: NO];
    [menu performSelector: @selector(setMenuVisible:)
               withObject: [NSNumber numberWithBool: NO]
//               afterDelay: 0.1
               afterDelay: 0.0
    ]; //also tried 0 as interval both look quite similar

}

//
//- (IBAction) handleTapFrom: (UIGestureRecognizer*) myRecognizer   // recognizer view is one of the 3 above
//{
//  NSLog(@"in handleTapFrom !");
//  NSLog(@"myRecognizer.view =%@",myRecognizer.view );
//  NSLog(@"myRecognizer.view.tag=%ld",myRecognizer.view.tag);
//  NSLog(@"myRecognizer.view.description=%@",myRecognizer.view.description);
//
//    CGPoint point        = [myRecognizer locationInView: myRecognizer.view];
//    CGPoint offset       = self.tableView.contentOffset;
//    CGPoint contentPoint = CGPointMake(point.x + offset.x, point.y + offset.y);
////  NSLog(@"contentPoint =%@",contentPoint );
////  NSLog(@"gbl_myname.frame             =%@",gbl_myname.frame);
////  NSLog(@"gbl_mycityprovcounLabel.frame=%@",gbl_mycityprovcounLabel.frame);
////  NSLog(@"gbl_mybirthinformation.frame =%@",gbl_mybirthinformation.frame);
//
//    //UITextField *gbl_myname;              for add new person or group
//    //UILabel     *gbl_mycityprovcounLabel; for display found city,prov,coun
//    //UITextField *gbl_mybirthinformation;  for add new person
//    //
//    if (CGRectContainsPoint(gbl_myname.frame,              contentPoint)) {
//  NSLog(@"    TAP  in  NAME     TAP  in  NAME     TAP  in  NAME ");
//    }
//    if (CGRectContainsPoint(gbl_mycityprovcounLabel.frame, contentPoint)) {
//  NSLog(@"    TAP  in  CITY     TAP  in  CITY     TAP  in  CITY ");
//    }
//    if (CGRectContainsPoint(gbl_mybirthinformation.frame,  contentPoint)) {
//  NSLog(@"    TAP  in  COUN     TAP  in  COUN     TAP  in  COUN ");
//    }
//
//}
//

//- (void)didRecognizeTapGesture:(UITapGestureRecognizer*)gesture
//{
//tn();  NSLog(@"in didRecognizeTapGesture");
//    CGPoint point = [gesture locationInView:gesture.view];
//
//    if (gesture.state == UIGestureRecognizerStateEnded)
//    {
//nbn(20);
////        if (CGRectContainsPoint(self.textField.frame, point))
//        if (CGRectContainsPoint(gbl_myname.frame, point))
//        {
//nbn(21);
////            [self doSomething];
//        }
//    }
//nbn(22);
//}
//


- (void)viewDidLoad {
    [super viewDidLoad];
//    
////  for test
//    uint64_t        mystart;
//    uint64_t        myend;
////    uint64_t        elapsed;
////    Nanoseconds     elapsedNano;
//    uint64_t     elapsedNano;
////    uint64_t     elapsedNano;
//    uint64_t        myInterval;
//    mystart = mach_absolute_time();
//  NSLog(@"mystart=%lld",mystart);
////    (void) getpid();
////    (void) getpid();
////    (void) getpid();
////    (void) getpid();
////    (void) getpid();
//sleep(1);
//    myend = mach_absolute_time();
//  NSLog(@"myend=%lld",myend);
////    elapsedNano = AbsoluteToNanoseconds( *(AbsoluteTime *) &elapsed );
//
////    myInterval =  * (uint64_t *) &elapsedNano;
//    myInterval =  myend - mystart;
//  NSLog(@"myInterval=%lld",myInterval);
//
////
//  NSDate *mytoday = [NSDate date];
//	NSTimeInterval oldTime = [mytoday timeIntervalSince1970] * 1000;
//	NSString *timeStamp = [[NSString alloc] initWithFormat:@"%0.0f", oldTime];
//	NSLog(@"%@", timeStamp);
//
//  sleep(2);
////    (void) getpid();
////    (void) getpid();
////    (void) getpid();
////    (void) getpid();
////    (void) getpid();
////
//
//  mytoday = [NSDate date];
//	NSTimeInterval oldTime2 = [mytoday timeIntervalSince1970] * 1000;
//	NSString *timeStamp2 = [[NSString alloc] initWithFormat:@"%0.0f", oldTime2];
//	NSLog(@"%@", timeStamp);
//	NSLog(@"%f", oldTime2 - oldTime);
//
////
////
//CFTimeInterval startTime = CACurrentMediaTime();  // returns double CFTimeInterval
//sleep(2);
//CFTimeInterval endTime = CACurrentMediaTime();
//NSLog(@"Total Runtime: %g s", endTime - startTime);
//
////
//
//

  NSLog(@"in ADD CHANGE  viewDidLoad!");
  NSLog(@"gbl_lastSelectedPerson=[%@]",gbl_lastSelectedPerson);

//
////UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesture:)];
//UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:gbl_myname action:@selector(didRecognizeTapGesture:)];
////[self.textField.superview addGestureRecognizer:tapGesture];
////[gbl_myname.superview addGestureRecognizer:tapGesture];
////[gbl_myname addGestureRecognizer:tapGesture];
//[self.tableView addGestureRecognizer:tapGesture];
//tapGesture.delegate = self;
//
//


    gbl_editingChangeNAMEHasOccurred = 0;  // default 0 at startup (after hitting "Edit" button on home page)
    gbl_editingChangeCITYHasOccurred = 0;  // default 0 at startup (after hitting "Edit" button on home page)
    gbl_editingChangeDATEHasOccurred = 0;  // default 0 at startup (after hitting "Edit" button on home page)

    gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"

    gbl_rollerBirthInfo   = @"" ;      // init // only shows stuff actually selected on the rollers


     // Disable the swipe to make sure you get your chance to save  
     // self.navigationController?.interactivePopGestureRecognizer.enabled = false
     self.navigationController.interactivePopGestureRecognizer.enabled = false ;




    [[NSNotificationCenter defaultCenter] addObserver: self  // DISABLE showing of select/paste/cut etc (flashes a bit)
                                             selector: @selector(myMenuWillBeShown)
                                                 name: UIMenuControllerWillShowMenuNotification   // <<<====----
                                               object: nil
    ];

//    [[NSNotificationCenter defaultCenter] addObserver: self  // run method doStuff_2_OnEnteringForeground()  when entering Foreground
//                                             selector: @selector(doStuff_2_OnEnteringForeground)
//                                                 name: UIApplicationWillEnterForegroundNotification
//                                               object: nil  ];



    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;




//
//    UITapGestureRecognizer *gotTAPin_tableview =    
////         [[UITapGestureRecognizer alloc] initWithTarget: self
////         [[UITapGestureRecognizer alloc] initWithTarget: self.tableView 
//         [[UITapGestureRecognizer alloc] initWithTarget: self.view
//                                                 action: @selector( handleTapFrom: )];
//    gotTAPin_tableview.delegate                             = self;
//    gotTAPin_tableview.cancelsTouchesInView                 = NO;
//    gotTAPin_tableview.numberOfTapsRequired                 = 1;
//
//    [ gbl_myname              addGestureRecognizer: gotTAPin_tableview ];     
//




  // try to stop landscape for this view   did not work
  //[super [super supportedInterfaceOrientations] ];
  [super supportedInterfaceOrientations] ;





  [self shouldAutorotate];
  [self supportedInterfaceOrientations];



    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone]; // remove separator lines between cells


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];

NSLog(@"currentScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
NSLog(@"currentScreenWidthHeight.height =%f",currentScreenWidthHeight.height );

//    self.outletFor_YMDHMA_picker.delegate   = self;  // like sel date screen
//    self.outletFor_YMDHMA_picker.dataSource = self;
    


//    gbl_myname.inputAccessoryView =gbl_ToolbarForPersonName ; // for person name input field
//    gbl_mybirthinformation.inputAccessoryView =  gbl_ToolbarForBirthDate;




    // set up PICKER VIEWs  ( http://stackoverflow.com/questions/19646822/uipickerview-in-uitableview )
    //
    // @property  (strong, nonatomic)          UIPickerView *pickerView;
    //
//    self.pickerViewDateTime            = [[UIPickerView alloc] initWithFrame:(CGRect){{0, 0}, 320, 480}];


//        gbl_ToolbarForPersonName    = [[UIToolbar alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];

   float heightPickerView;  // There are only three valid heights for UIPickerView (162.0, 180.0 and 216.0).
//   heightPickerView = 216.0;
    if (currentScreenWidthHeight.height  >= 480.0) heightPickerView = 162.0;   // 4s
//    else                                           heightPickerView = 180.0;
    else                                           heightPickerView = 216.0;

    self.pickerViewDateTime            = [[UIPickerView alloc] initWithFrame:
        CGRectMake (
            0.0,                                                  // x  from top left
            currentScreenWidthHeight.height - heightPickerView,   // y
            currentScreenWidthHeight.width,                       // width
            heightPickerView                                      // height
        )
    ];



    self.pickerViewDateTime.delegate   = self;
    self.pickerViewDateTime.dataSource = self;
    self.pickerViewDateTime.hidden     =  NO;


//    self.pickerViewDateTime.inputAccessoryView =  gbl_ToolbarForBirthDate;
//    [self.pickerViewDateTime setInputAccessoryView:  gbl_ToolbarForBirthDate ];

//    self.pickerViewDateTime.hidden     = YES;
//    self.pickerViewDateTime.showsSelectionIndicator = YES;   // ?
//    self.pickerViewDateTime.center     = (CGPoint){160, 640};
//    categoryTypePicker.tag = kCATEGORYTYPEPICKERTAG;
//    countryTypePicker.backgroundColor = [UIColor blueColor];

//    self.pickerViewCity            = [[UIPickerView alloc] initWithFrame:(CGRect){{0, 0}, 320, 480}];

    self.pickerViewCity            = [[UIPickerView alloc] initWithFrame:
        CGRectMake (
            0.0,                                                  // x  from top left
            currentScreenWidthHeight.height - heightPickerView,   // y
            currentScreenWidthHeight.width,                       // width
            heightPickerView                                      // height
        )
    ];

    self.pickerViewCity.delegate   = self;
    self.pickerViewCity.dataSource = self;
    self.pickerViewCity.hidden     =  NO;
nbn(881);

    // set up default picker to use
    // this changes to "city picker"         in city    tag=2, textFieldDidBeginEditing
    // this changes to @"date/time picker";  in city    tag=2, textFieldDidEndEditing 
    //
    gbl_pickerToUse          = @"date/time picker";  // "city picker" or "date/time picker"
  NSLog(@"gbl_pickerToUse  11      =[%@]",gbl_pickerToUse          );

//    gbl_lastInputFieldTapped = @"date";   NOTE: setting this causes date picklist to comeup automatically

  NSLog(@"        init                        gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"        init                        gbl_pickerToUse7=%@",gbl_pickerToUse );


    gbl_mycitySearchString.hidden = YES;


    // set up default input view for city 
    //
//  gbltmpstr = gbl_mycityInputView;
    gbl_mycityInputView = @"keyboard";     // = "keyboard" or "picker", default is KB
//  NSLog(@"--lod ----- VASSIGN gbl_mycityInputView ---------------- old=[%@]  new=[%@] ---", gbltmpstr, gbl_mycityInputView );

    // initialize the  1  toolbar  For City inputView  accessory



    // initialize the  3  toolbars  For City inputView  accessory
    //
    //  1. gbl_ToolbarForCityPicklist                "< Keyboard"   tor             
    //  2.  gbl_ToolbarForCityKeyboardWithPicklist    "Clear"        tor     "Picklist >" 
    //  3.  gbl_ToolbarForCityKeyboardNoPicklist      "Clear"        tor     
    // 
        // create buttons for toolbars 
        // @property (strong, nonatomic) IBOutlet UIBarButtonItem *outletToButtonToGetPicklist;
        // 
        gbl_nameButtonToClearKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"Clear"  
                                                                        style: UIBarButtonItemStylePlain
                                                                       target: self
                                                                       action: @selector( onNameInputViewClearButton: )
        ];

        gbl_cityButtonToClearKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"Clear City"  
                                                                        style: UIBarButtonItemStylePlain
                                                                       target: self
                                                                       action: @selector( oncityInputViewClearButton1: )
        ];
        self.outletToButtonToGetPicklist = [[UIBarButtonItem alloc]initWithTitle: @"Picklist >"  
                                                                      style: UIBarButtonItemStylePlain
                                                                     target: self
                                                                     action: @selector( oncityInputViewPicklistButton: )
        ];

//        gbl_dateButtonToClearKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"Clear Birth Date"  
        gbl_dateButtonToClearKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"Clear"  
                                                                        style: UIBarButtonItemStylePlain
                                                                       target: self
                                                                       action: @selector( onDateInputViewClearButton: )
        ];

        //        self.outletToButtonToGetPicklist.tintColor = [UIColor yellowColor];
        //        self.outletToButtonToGetPicklist.tintColor = [UIColor redColor];
                self.outletToButtonToGetPicklist.tintColor = [UIColor blackColor];
        //  decided to leave regular blue color

        // Create a 1x1 pixel image with the color you prefer.
        // In this case this image's name is "icons_gb.png".
        // Then add following code to your AppDelegate.m .
        // Image color will be repeated in the button's background.
        //
        // UIImage *btnBg = [[UIImage imageNamed:@"icons_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        // 
        // [[UIBarButtonItem appearance] setBackgroundImage:btnBg 
        //                                         forState:UIControlStateNormal
        //                                       barMetrics:UIBarMetricsDefault];
        //

        //                // you can make the background a solid color by
        //                // 1. setting backgroundImage to [UIImage new]
        //                // 2. assigning navigationBar.backgroundColor to the color you like.
        //                // (when you  do this,  translucent becomes = NO)  that's OK
        //                //  http://stackoverflow.com/questions/19226965/how-to-hide-ios7-uinavigationbar-1px-bottom-line/
        //                //
        //                [self.navigationController.navigationBar setBackgroundImage: [UIImage new]       // 1. of 2
        //                                                             forBarPosition: UIBarPositionAny
        //                                                                 barMetrics: UIBarMetricsDefault];
        //                //
        //                [self.navigationController.navigationBar setShadowImage: [UIImage new]];   
        //                //
        //                self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];  // 2. of 2
        //

//        UIImage *myYellowBG = [UIImage  imageNamed: @"bg_yellow_1x1c.png" 
//        UIImage *gbl_YellowBG = [UIImage  imageNamed: @"bg_yellow_1x1b.png"
//                                          inBundle: nil
//                     compatibleWithTraitCollection: nil
//        ];
        [self.outletToButtonToGetPicklist setBackgroundImage: gbl_YellowBG
                                                    forState: normal
                                                  barMetrics: UIBarMetricsDefault 
        ];
//
//        [self.outletToButtonToGetPicklist.backgroundColor = [UIColor yellowColor];

//        [UIColor yellowColor]





        gbl_cityButtonToGetKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"< Keyboard"  
                                                                      style: UIBarButtonItemStylePlain
                                                                     target: self
                                                                     action: @selector( oncityInputViewKeyboardButton: )
        ];


//        gbl_cityInputPicklistLeftButton  = [[UIBarButtonItem alloc]initWithTitle: @"< Keyboard "  
//                                                                           style: UIBarButtonItemStylePlain
//                                                                          target: self
//                                                                          action: @selector( oncityInputViewKeyboardButton: )
//        ];
//        gbl_cityInputKeyboardLeftButton2 = [[UIBarButtonItem alloc]initWithTitle: @"Clear"  
//                                                                           style: UIBarButtonItemStylePlain
//                                                                          target: self
//                                                                          action: @selector( oncityInputViewClearButton1: )
//        ];
//        gbl_cityInputKeyboardLeftButton2 = [[UIBarButtonItem alloc]initWithTitle: @"Clear"  
//                                                                           style: UIBarButtonItemStylePlain
//                                                                          target: self
//                                                                          action: @selector( oncityInputViewClearButton2: )
//        ];

        // TOOLBARs for City inputView 
//        gbl_ToolbarForCityPicklist               = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
//        gbl_ToolbarForCityKeyboardHavingPicklist = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
//        gbl_ToolbarForCityKeyboardWithNoPicklist = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];

//        gbl_ToolbarForCityPicklist               = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
//        gbl_ToolbarForCityKeyboardHavingPicklist = [[UIToolbar alloc] initWithFrame:CGRectMake(160, 260 - 44, 320, 44)];
//        gbl_ToolbarForCityKeyboardWithNoPicklist = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];


        gbl_ToolbarForPersonName    = [[UIToolbar alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
        gbl_ToolbarForBirthDate     = [[UIToolbar alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
        gbl_ToolbarForCityPicklist  = [[UIToolbar alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
        gbl_ToolbarForCityKeyboard  = [[UIToolbar alloc] initWithFrame: gbl_ToolbarForCityPicklist.bounds ];

        float heightKeyboard; 
        heightKeyboard = 216.0; 
        float heightKeyboardToolbar;  
        heightKeyboardToolbar = 44.0;

  NSLog(@"currentScreenWidthHeight.height=[%f]",currentScreenWidthHeight.height);
  NSLog(@"currentScreenWidthHeight.width =[%f]",currentScreenWidthHeight.width);
  NSLog(@"heightKeyboard                 =[%f]",heightKeyboard);
  NSLog(@"heightKeyboardToolbar          =[%f]",heightKeyboardToolbar);

//        gbl_ToolbarForPersonName    = [[UIToolbar alloc] initWithFrame:
//            CGRectMake (
//                0.0,                                                  // x  from top left
//                currentScreenWidthHeight.height - heightKeyboard - heightKeyboardToolbar,   // y
//                currentScreenWidthHeight.width,                       // width
//                heightKeyboardToolbar                                 // height
//            )
//        ];
//


        float heightPickerToolbar;  // There are only three valid heights for UIPickerView (162.0, 180.0 and 216.0).
        heightPickerToolbar = 44.0;
        gbl_ToolbarForBirthDate     = [[UIToolbar alloc] initWithFrame:
            CGRectMake (
                0.0,                                                  // x  from top left
                currentScreenWidthHeight.height - heightPickerView - heightPickerToolbar,   // y
                currentScreenWidthHeight.width,                       // width
                heightPickerToolbar                                   // height
            )
        ];


//        gbl_ToolbarForCityKeyboardHavingPicklist = [[UIToolbar alloc] initWithFrame: gbl_ToolbarForCityPicklist.bounds ];
//        gbl_ToolbarForCityKeyboardWithNoPicklist = [[UIToolbar alloc] initWithFrame: gbl_ToolbarForCityPicklist.bounds ];

//        gbl_ToolbarForCityPicklist               = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//        gbl_ToolbarForCityKeyboardHavingPicklist = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//        gbl_ToolbarForCityKeyboardWithNoPicklist = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0 320, 44)];


        // make arrays of buttons for the Toolbars
        //
        gbl_buttonArrayForPersonName    =  [NSArray arrayWithObjects:  // like  " Clear Person Name  ___      "
            gbl_nameButtonToClearKeyboard, gbl_flexibleSpace,
            gbl_title_personName         , gbl_flexibleSpace,
            gbl_flexibleSpace            , nil ]; 


        gbl_buttonArrayForPicklist    =  [NSArray arrayWithObjects:  // like  " < KeyBoard    toron     _____      "
            gbl_cityButtonToGetKeyboard, gbl_flexibleSpace,
            gbl_title_cityPicklist     , gbl_flexibleSpace,
            gbl_flexibleSpace            , nil ]; 

        gbl_buttonArrayForKeyboard    =  [NSMutableArray arrayWithObjects:  // like  " Clear         toron     Picklist > "
            gbl_cityButtonToClearKeyboard, gbl_flexibleSpace,
            gbl_title_cityKeyboard       , gbl_flexibleSpace,
            self.outletToButtonToGetPicklist              , nil ]; 

        gbl_buttonArrayForBirthDate    =  [NSArray arrayWithObjects:  // like  " Clear Person Name  ___      "
            gbl_dateButtonToClearKeyboard, gbl_flexibleSpace,
            gbl_title_birthDate         , gbl_flexibleSpace,
            gbl_flexibleSpace            , nil ]; 

        // put the array of buttons in the Toolbar
        [gbl_ToolbarForPersonName    setItems: gbl_buttonArrayForPersonName  animated: YES];
        [gbl_ToolbarForCityPicklist  setItems: gbl_buttonArrayForPicklist    animated: YES];
        [gbl_ToolbarForCityKeyboard  setItems: gbl_buttonArrayForKeyboard    animated: YES];
        [gbl_ToolbarForBirthDate     setItems: gbl_buttonArrayForBirthDate   animated: YES];



//  gbltmpstr = [gbl_ToolbarForCityPicklist.description substringToIndex: 15];
//  NSLog(@"-v did ld -- VASSIGN gbl_ToolbarForCityPicklist.description --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_ToolbarForCityPicklist.description substringToIndex: 15]);


//        [[self.view viewWithTag: gbl_tag_cityInputPicklistButton ] setHidden: YES ];
//  NSLog(@"-v did ld -- VASSIGN gbl_ToolbarForCityKeyboard.description --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_ToolbarForCityKeyboard.description substringToIndex: 15]);


//

    //
    // All UIResponder objects have an inputView property.
    // The inputView of a UIResponder is the view that will be shown in place of the keyboard
    // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
    //



    // get SCREEN WIDTH for sizing
    // for the width of Labels for city/prov/coun we want the smaller of width or height
    //
    CGFloat currScrWidth;
    CGFloat currScrHeight;
    currScrWidth  = currentScreenWidthHeight.width;
    currScrHeight = currentScreenWidthHeight.height;
    if (currScrWidth  <=  currScrHeight) gbl_widthForLabelsForCityProvCoun = currScrWidth;
    else                                 gbl_widthForLabelsForCityProvCoun = currScrHeight;
  NSLog(@"gbl_widthForLabelsForCityProvCoun =%f",gbl_widthForLabelsForCityProvCoun );


    // set up  DATA
    //
    self.array_BirthYearsToPick = [[NSMutableArray alloc]init];
    self.array_Months      = [[NSArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    self.array_DaysOfMonth = [[NSMutableArray alloc]init];
    self.array_Hours_1_12  = [[NSMutableArray alloc]init];
    self.array_Min_0_59    = [[NSMutableArray alloc]init];
    self.array_AM_PM       = [[NSMutableArray alloc]init];
 
    for (int i = 1; i <= 31; i++) {
        [self.array_DaysOfMonth addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    //NSLog(@"self.arrayMonths=%@",self.arrayMonths);
    for (int i = 1; i <= 12; i++) {
        [self.array_Hours_1_12 addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    for (int i = 0; i <= 59; i++) {
        [self.array_Min_0_59 addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    [self.array_AM_PM addObject: @"am" ];
    [self.array_AM_PM addObject: @"pm" ];

//  NSLog(@" self.array_BirthYearsToPick.count !!!   =%ld",     self.array_BirthYearsToPick.count);
  NSLog(@" self.array_Months.count      =%ld", (unsigned long)self.array_Months.count);
  NSLog(@" self.array_DaysOfMonth.count;=%ld", (unsigned long)self.array_DaysOfMonth.count);
  NSLog(@" self.array_Hours_1_12.count  =%ld", (unsigned long)self.array_Hours_1_12.count);
  NSLog(@" self.array_Min_0_59.count    =%ld", (unsigned long)self.array_Min_0_59.count);
  NSLog(@" self.array_AM_PM.count       =%ld", (unsigned long)self.array_AM_PM.count);

    do {    // populate array array_BirthYearsToPick for uiPickerView and init picker and init birth info label field  (130 lines)
 
        // get the current year
        //
        NSCalendar *gregorian = [NSCalendar currentCalendar];          // Get the Current Date and Time

//        NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit)
//                                                        fromDate:[NSDate date]];
        NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear)
                                                        fromDate:[NSDate date]];

        gbl_currentYearInt  = [dateComponents year];
        gbl_currentMonthInt = [dateComponents month];
        gbl_currentDayInt   = [dateComponents day];
        //NSLog(@"gbl_currentYearInt  =%ld",(long)gbl_currentYearInt  );
        //NSLog(@"gbl_currentMonthInt =%ld",(long)gbl_currentMonthInt );
        //NSLog(@"gbl_currentDayInt   =%ld",(long)gbl_currentDayInt   );
        
        
        gbl_currentDay_yyyymmdd = [NSString stringWithFormat:@"%04ld%02ld%02ld",
                                       (long)gbl_currentYearInt,
                                       (long)gbl_currentMonthInt,
                                       (long)gbl_currentDayInt     ];

        NSArray *psvArray;
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]  ) {
            psvArray =
              [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        }
        if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]  ) {
            psvArray =
              [gbl_TBLRPTS1_PSV_personJust1 componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        }

        NSString *psvMonthOfBirth = psvArray[1];
        NSString *psvDayOfBirth   = psvArray[2];
        NSString *psvYearOfBirth  = psvArray[3];

        gbl_intBirthYear       = [psvYearOfBirth intValue];  // convert NSString to integer
        gbl_intBirthMonth      = [psvMonthOfBirth intValue];
        gbl_intBirthDayOfMonth = [psvDayOfBirth intValue]; 
        //NSLog(@"gbl_intBirthYear       =%ld",(long)gbl_intBirthYear       );
        //NSLog(@"gbl_intBirthMonth      =%ld",(long)gbl_intBirthMonth      );
        //NSLog(@"gbl_intBirthDayOfMonth =%ld",(long)gbl_intBirthDayOfMonth );
        

        // for the picker, set array_BirthYearsToPick str array
        //
        [self.array_BirthYearsToPick removeAllObjects];
        self.array_BirthYearsToPick   = [[NSMutableArray alloc] init];
        
        // not birthday (privacy)
        //for (NSInteger pickyr = gbl_intBirthYear; pickyr <=  gbl_currentYearInt + 1; pickyr++)   // only allow to go to next calendar year
        for (NSInteger pickyr = gbl_earliestYear; pickyr <=  gbl_currentYearInt + 1; pickyr++) {  // only allow to go to next calendar year
            [self.array_BirthYearsToPick addObject: [@(pickyr) stringValue] ];
        }
  NSLog(@"self.array_BirthYearsToPick.count=%lu",(unsigned long)self.array_BirthYearsToPick.count);
        
//        NSString *myInitDateFormatted = @"Birth Date and Time";  // use yr= 2000
        NSString *myInitDateFormatted = gbl_initPromptDate ; // is @"Birth Date and Time" // use yr= 2000
  NSLog(@"myInitDateFormatted =%@",myInitDateFormatted );

//        gbl_rollerBirth_yyyy  = @"initYYYY";  // birth date of 30-year-old
        gbl_rollerBirth_yyyy  = @"2000";  // birth date of 30-year-old
        gbl_rollerBirth_mth   = @"Jan";
        gbl_rollerBirth_dd    = @"01";
        gbl_rollerBirth_hour  = @"12";
        gbl_rollerBirth_min   = @"01";
        gbl_rollerBirth_amPm  = @"PM";

        gbl_selectedBirthInfo = myInitDateFormatted;  // initial display of birth time info

        //        // Here is a short list of sample formats using ICU:
        //        // -------------------------------------------------------------------------
        //        // Pattern                           Result (in a particular locale)
        //        // -------------------------------------------------------------------------
        //        // yyyy.MM.dd G 'at' HH:mm:ss zzz    1996.07.10 AD at 15:08:56 PDT
        //        // EEE, MMM d, ''yy                  Wed, July 10, '96
        //        // h:mm a                            12:08 PM
        //        // hh 'o''clock' a, zzzz             12 o'clock PM, Pacific Daylight Time
        //        // K:mm a, z                         0:00 PM, PST
        //        // yyyyy.MMMM.dd GGG hh:mm aaa       01996.July.10 AD 12:08 PM
        //        // -------------------------------------------------------------------------
        //        // The format specifiers are quite straightforward, Y = year, M = month, etc.
        //        // Changing the number of specifiers for a field, changes the output.
        //        // For example, MMMM generates the full month name “November”,
        //        // MMM results in “Nov” and MM outputs “11”.
        //        // 
        //        NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
        //        [myFormatter setDateFormat:@"MMM dd, yyyy"];
        //        NSString *yearString = [myFormatter stringFromDate:[NSDate date]];
        //

        // display YMDHMA  initial value
        //

        //  INIT  PICKER roller values
        //
//        NSString* myInitYear = [NSString stringWithFormat:@"%i", initYYYY];  // convert c int to NSString
        NSInteger myIndex;
        myIndex = [self.array_BirthYearsToPick  indexOfObject: @"2000"];  // start roller on year 2000

        // for (id member in self.array_BirthYearsToPick)    // loop thru year array

        if (myIndex == NSNotFound) {
            myIndex = yearsToPickFrom3.count - 1;
        }

        dispatch_async(dispatch_get_main_queue(), ^{    //  INIT  PICKER roller values

            [self.pickerViewDateTime selectRow: myIndex inComponent: 0 animated: YES]; // This is how you manually SET(!!) a selection!
            [self.pickerViewDateTime selectRow:       0 inComponent: 1 animated: YES]; // mth  = jan
            [self.pickerViewDateTime selectRow:       0 inComponent: 2 animated: YES]; // day  = 01
            // 3 = spacer
            [self.pickerViewDateTime selectRow:      11 inComponent: 4 animated: YES]; // hr   = 12
            // 5 = colon
            [self.pickerViewDateTime selectRow:       1 inComponent: 6 animated: YES]; // min  = 01   2nd one
            [self.pickerViewDateTime selectRow:       1 inComponent: 7 animated: YES]; // ampm = 12   2nd one
        });

    } while( false);  // populate array array_BirthYearsToPick for uiPickerView

//nbn(357);
//    [self doStuff_2_OnEnteringForeground];  // position highlight

//nbn(358);
//    [gbl_myname becomeFirstResponder];

} // viewDidLoad



//- (void) doStuff_2_OnEnteringForeground 
//{
//tn();trn("in doStuff_2_OnEnteringForeground()   NOTIFICATION method    position highlight ");
//
//    NSString  *nameOfGrpOrPer;
//    NSInteger idxGrpOrPer;
//    NSArray *arrayGrpOrper;
//    idxGrpOrPer = -1;   // zero-based idx
//
//    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
//
//        for (id eltGrp in gbl_arrayGrp) { // find index of _mambCurrentSelection (like "~Family") in gbl_arrayGrp
//          idxGrpOrPer = idxGrpOrPer + 1;
////NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
////NSLog(@"eltGrp=%@", eltGrp);
//          NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
//          arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet: mySeparators];
//          nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld
//
//          if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedGroup]) {
//            break;
//          }
//        } // search thru gbl_arrayGrp
////NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);
//
//// get the indexpath of row num idxGrpOrPer in tableview
//        NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
////tn();trn("SCROLL 111111111111111111111111111111111111111111111111111111111");
//
//        // select the row in UITableView
//        // This puts in the light grey "highlight" indicating selection
//        [self.tableView selectRowAtIndexPath: foundIndexPath 
//                                    animated: YES
//                              scrollPosition: UITableViewScrollPositionNone];
//        //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
//        [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//                                                  animated: YES];
//    }
//
//    if ([gbl_lastSelectionType isEqualToString:@"person"]) {
//
//        NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//        
//        do { // highlight gbl_lastSelectedPerson row in tableview
//
//            for (id eltPer in gbl_arrayPer) {  // find index of gbl_lastSelectedPerson (like "~Dave") in gbl_arrayPer
//                idxGrpOrPer = idxGrpOrPer + 1; 
////              NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
////              NSLog(@"eltPer=%@", eltPer);
//
//              NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
//              arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
//              nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld
//
//              if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedPerson]) {
//                break;
//              }
//            } // search thru gbl_arrayPer
////        NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);
//
//            // get the indexpath of row num idxGrpOrPer in tableview
//            NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
////        NSLog(@"foundIndexPath=%@",foundIndexPath);
////        NSLog(@"foundIndexPath.row=%ld",(long)foundIndexPath.row);
//
//
//            // select the row in UITableView
//            // This puts in the light grey "highlight" indicating selection
//            [self.tableView selectRowAtIndexPath: foundIndexPath 
//                                        animated: YES
//                                  scrollPosition: UITableViewScrollPositionMiddle];
////                                  scrollPosition: UITableViewScrollPositionNone];
//            //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
//            [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//                                                              animated: YES];
//
//        } while (FALSE); // END highlight lastEntity row in tableview
//
//    }
//    // end of   highlight correct entity in seg control at top
//    
//} // end of  doStuff_2_OnEnteringForeground()
//



//
//
////-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
////  NSLog(@"in shouldAutorotateToInterfaceOrientation !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
////    return (interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
////}
//
- (BOOL)shouldAutorotate {
  NSLog(@"in ADD   shouldAutorotate !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return YES;
}

// - (NSUInteger)supportedInterfaceOrientations
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  NSLog(@"in ADD   supportedInterfaceOrientations !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return UIInterfaceOrientationMaskPortrait;
}


//    The viewController life cycle are 
//
//    loadView
//    viewDidLoad
//    viewWillAppear
//    viewWillLayoutSubviews
//    viewDidLayoutSubviews
//    viewDidAppear
//    .................
//    viewWillDisappear
//    viewDidDisappear
//    viewWillAppear
//    viewWillLayoutSubviews
//    viewDidLayoutSubviews
//    viewDidAppear
//
//

//-(void)viewWillLayoutSubviews{
//
//  NSLog(@"in viewWillLayoutSubviews !!!");
////    UINavigationController.navigationBar.backItem.backBarButtonItem = [[UIBarButtonItem alloc]
////    navigationController.navigationBar.backItem.backBarButtonItem = [[UIBarButtonItem alloc]
////     initWithTitle: @"Cancel"
////             style:UIBarButtonItemStylePlain
////            target:self
////            action:nil];
//
////    [UIBarButtonItem.appearance setTitle: @"Cancel" ];     // 
//
////    navigationController.navigationBar.backItem.backBarButtonItem = [[UIBarButtonItem alloc]
////     UINavigationBar.backBarButton = [[UIBarButtonItem alloc]
////     initWithTitle: @"Cancel"
////             style:UIBarButtonItemStylePlain
////            target:self
////            action:nil];
//
////[[self navigationItem] setBackBarButtonItem:];
////        UIBarButtonItem *navCancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
////                                                                                         target: self
////                                                                                         action: @selector(pressedCancel:)];
////        navCancelButton.title = @"Cancel";
////[[self navigationItem] setBackBarButtonItem:navCancelButton];
//
//}
//



- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
  NSLog(@"in viewWillAppear! in ADD CHANGE");

  NSLog(@"gbl_homeUseMODE     =[%@]",gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
  NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);


    addChangeViewJustEntered = 1;  // 1=y,0=n

// do now when current field changes to "city"
//    [ [NSRunLoop mainRunLoop] addTimer: self.timerToCheckCityPicklistTrigger  // init
//                               forMode: NSRunLoopCommonModes
//    ];  // init



//   gbl_cityPlaceHolderStr = @"Search For City of Birth 123456";
//   gbl_cityPlaceHolderStr = @"City of Birth 56789 1234567 90";
//   gbl_cityPlaceHolderStr = @"City of Birth Search";
//   gbl_cityPlaceHolderStr = @"Type Birth City Name";  not used

//   gbl_enteredCity        = @"City or Town 456789 1234 6 8 0";

    gbl_myname.text = gbl_initPromptName;

    gbl_enteredCity        = gbl_initPromptCity;  // @"City or Town";  for display in gbl_mycityprovcounLabel= found city,prov,counl
    gbl_enteredProv        = gbl_initPromptProv;  // @"State or Province";
    gbl_enteredCoun        = gbl_initPromptCoun;  // @"Country";


    gbl_previousCharTypedWasSpace = 0;                 // for no multiple consecutive spaces




        if (   [gbl_homeUseMODE      isEqualToString: @"regular mode" ]
            && [gbl_homeEditingState isEqualToString: @"add" ]
        ) {
            self.view.backgroundColor     = gbl_colorHomeBG;     // blue
            gbl_colorEditingBG_current    = gbl_colorHomeBG;     // is now yellow or blue for add a record screen  (addChange view)
        } else {
            self.view.backgroundColor     = gbl_colorEditingBG;  // set yellow bg for editing screens
            gbl_colorEditingBG_current    = gbl_colorEditingBG;   // is now yellow or blue for add a record screen  (addChange view)
        }


    do {  // set up NAV BAR


        // When someone is creating a new entry, you need a way for them to abandon that entry and not create anything.
        // In iOS apps, there are two ways of doing this:
        // Use the 'back' button position for the 'cancel' button, and have a single 'done' button.
        // This is functionally how many iOS apps handle things, and the method that I would recommend.
        // Here you don't have to decide how your back button will behave, and the options are clear to your users.
        //
        //  navbar=   Cancel   New Contact   Done
        //
        // http://ux.stackexchange.com/questions/38157/is-there-a-need-for-save-cancel-buttons-in-ios-app

//        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave
        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                                         target: self
                                                                                         action: @selector(pressedSaveDone:)];
//        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        UIBarButtonItem *navCancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                                                         target: self
                                                                                         action: @selector(pressedCancel:)];

//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
//        spaceView.backgroundColor = [UIColor redColor];
//        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView: spaceView];
//

//<.>
//    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
//    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
//
//
//    // TWO-LINE NAV BAR TITLE
//    //
//    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//        self.navigationItem.rightBarButtonItem = _goToReportButton;
//        self.navigationItem.titleView           = mySelDate_Label; // mySelDate_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
//        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//    });
//
//
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
//
//
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
//                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//                [self.navigationController.navigationBar setTranslucent:NO];
//
//<.>
//



//        navCancelButton.title = @"Cancel";
//        //        navAddButton.tintColor = [UIColor blackColor];   // colors text

//    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 60) forBarMetrics: UIBarMetricsDefault];     // make all "Back" buttons have just the arrow
//    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 60) forBarMetrics: UIBarMetricsLandscapePhone];     // make all "Back" buttons have just the arrow
////        navCancelButton.title = @"Cancel";
////    [UIBarButtonItem.appearance setTitle: @"Cancel" ];     // 
//



        dispatch_async(dispatch_get_main_queue(), ^{  

//            self.navigationItem.leftBarButtonItems   =
//                [self.navigationItem.leftBarButtonItems   arrayByAddingObject: navCancelButton]; // add CANCEL BUTTON


            self.navigationItem.leftBarButtonItem    = navCancelButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item
//            self.navigationItem.backBarButtonItem    = navCancelButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item


//self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
//self.navigationController.navigationBar.topItem.backBarButtonItem = navCancelButton;


// gold
            self.navigationItem.rightBarButtonItems  =
                [self.navigationItem.rightBarButtonItems  arrayByAddingObject: navSaveButton  ]; // add SAVE   BUTTON

//            self.navigationItem.rightBarButtonItems =
//                [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];

//            self.navigationItem.rightBarButtonItems  =
//                [self.navigationItem.rightBarButtonItems  arrayByAddingObject: navSaveButton  ]; // add SAVE   BUTTON

        });


        if ( [gbl_homeEditingState isEqualToString: @"add" ]) {  // "add" for add a new person or group, "view or change" for tapped person or group

            gbl_helpScreenDescription = @"add";

            if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"] ) {
                dispatch_async(dispatch_get_main_queue(), ^{  
//                    [[self navigationItem] setTitle: @"Add Person"];
                    [[self navigationItem] setTitle: @"New Person"];
                });
            }
            if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"group"] ) {
                dispatch_async(dispatch_get_main_queue(), ^{   
//                    [[self navigationItem] setTitle: @"Add Group"];
                    [[self navigationItem] setTitle: @"New Group"];
                });
            }
        }

        if ( [gbl_homeEditingState isEqualToString: @"view or change" ]) {  

            gbl_helpScreenDescription = @"view or change";

            if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"] ) {
                dispatch_async(dispatch_get_main_queue(), ^{  
                    [[self navigationItem] setTitle: [NSString stringWithFormat:@"%@ Details", gbl_lastSelectedPerson ] ];

                });
            }
            if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"group"] ) {
                dispatch_async(dispatch_get_main_queue(), ^{   
//                [[self navigationItem] setTitle: gbl_lastSelectedGroup ];
                    [[self navigationItem] setTitle: [NSString stringWithFormat:@"%@ Details", gbl_lastSelectedGroup  ] ];
                });
            }
        }


//
//    // You can use
//    // [self.navigationController.navigationBar setTitleTextAttributes:]
//    // to set someone navigationController's appearence, while
//    // [UINavigationBar appearance] setTitleTextAttributes:]
//    // works for your whole App directly.(Of course you need to put it in a property position.)
//    //
////    [ [UINavigationBar appearance] setTitleTextAttributes:
//    [self.navigationController.navigationBar setTitleTextAttributes:
//        [ NSDictionary dictionaryWithObjectsAndKeys:
////            [UIFont fontWithName:@"Helvetica-Bold" size:18.0],
//            [UIFont fontWithName:@"systemFont" size: 24.0],
//            NSFontAttributeName,
//            nil
//        ]
//    ];
//
//

    } while (false);   // set up NAV BAR



} // end of   viewWillAppear


//action: @selector( onNameInputViewClearButton: )
- (IBAction) onNameInputViewClearButton: (id)sender {
  NSLog(@"in onNameInputViewClearButton!");

    gbl_userSpecifiedPersonName = @"";  // final value in "new person" screen

    // in didEnd
    //    if (textField.tag == 1) { // name
    //        gbl_userSpecifiedPersonName = textField.text; // final value in "new person" screen
    //  NSLog(@"FINAL  gbl_userSpecifiedPersonName =[%@]",gbl_userSpecifiedPersonName );
    //    }

//    if (textField.tag == 1) { // name
//        textField.text = @""; 
//    NSLog(@"SET    name textfield.text = zilch");
//    }
//


    dispatch_async(dispatch_get_main_queue(), ^{     
//        gbl_myname.text          = gbl_initPromptName;
//        gbl_myname.textColor    = [UIColor grayColor];


        gbl_myname.text          = @"";
        gbl_myname.placeholder   = @"Name";
//        gbl_myname.placeholder   = gbl_initPromptName;
//        gbl_myname.placeholder   = @"";

//        [gbl_myname setValue: [UIColor colorWithRed: 128.0/255.0    // use KVC
//                                              green: 128.0/255.0
//                                               blue: 128.0/255.0
//                                              alpha: 1.0         ]
//                  forKeyPath: @"_placeholderLabel.textColor"];

//                gbl_myname.textColor                = [UIColor colorWithRed: 128.0/255.0    // use KVC
//                                                                      green: 128.0/255.0
//                                                                       blue: 128.0/255.0
//                                                                      alpha: 1.0         ] ;

    });


} // end of onNameInputViewClearButton


//action: @selector( onDateInputViewClearButton: )
- (IBAction) onDateInputViewClearButton: (id)sender {
  NSLog(@"in onDateInputViewClearButton!");

    gbl_rollerBirth_yyyy  = @"2000"; 
    gbl_rollerBirth_mth   = @"Jan";
    gbl_rollerBirth_dd    = @"01";
    gbl_rollerBirth_hour  = @"12";
    gbl_rollerBirth_min   = @"01";
    gbl_rollerBirth_amPm  = @"PM";

//    NSString *myInitDateFormatted = @"Birth Date and Time";  // use yr= 2000
    NSString *myInitDateFormatted = gbl_initPromptDate ;  // is @"Birth Date and Time" // use yr= 2000

    gbl_selectedBirthInfo = myInitDateFormatted;  // initial display of birth time info


    //  INIT  PICKER roller values
    //
//        NSString* myInitYear = [NSString stringWithFormat:@"%i", initYYYY];  // convert c int to NSString
    NSInteger myIndex;
    myIndex = [self.array_BirthYearsToPick  indexOfObject: @"2000"];  // start roller on year 2000

    // for (id member in self.array_BirthYearsToPick)    // loop thru year array

    if (myIndex == NSNotFound) {
        myIndex = yearsToPickFrom3.count - 1;
    }

    dispatch_async(dispatch_get_main_queue(), ^{    //  INIT  PICKER roller values

        [self.pickerViewDateTime selectRow: myIndex inComponent: 0 animated: YES]; // This is how you manually SET(!!) a selection!
        [self.pickerViewDateTime selectRow:       0 inComponent: 1 animated: YES]; // mth  = jan
        [self.pickerViewDateTime selectRow:       0 inComponent: 2 animated: YES]; // day  = 01
        // 3 = spacer
        [self.pickerViewDateTime selectRow:      11 inComponent: 4 animated: YES]; // hr   = 12
        // 5 = colon
        [self.pickerViewDateTime selectRow:       1 inComponent: 6 animated: YES]; // min  = 01   2nd one
        [self.pickerViewDateTime selectRow:       1 inComponent: 7 animated: YES]; // ampm = 12   2nd one
    });

        // show  selected day field on screen
        //
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            self.outletToSelectedBirthInfo.text = myFormattedStr;

            NSIndexPath *indexPathBirthInfoLabel = [NSIndexPath indexPathForRow: 5 inSection: 0];

//                [self.tableView beginUpdates];
    //        [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
            [self.tableView reloadRowsAtIndexPaths:  @[ indexPathBirthInfoLabel ]
                                  withRowAnimation: UITableViewRowAnimationFade ];
//                                  withRowAnimation: UITableViewRowAnimationNone ];
//                                  withRowAnimation: UITableViewRowAnimationRight ];
//                                  withRowAnimation: UITableViewRowAnimationMiddle ];

//                [self.tableView endUpdates];

//            [gbl_myname             resignFirstResponder];
//            [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//            [gbl_mybirthinformation resignFirstResponder]; 

            //
            // All UIResponder objects have an inputView property.
            // The inputView of a UIResponder is the view that will be shown in place of the keyboard
            // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
            //
             [gbl_mybirthinformation becomeFirstResponder];
    });



} // end of onDateInputViewClearButton


- (IBAction) oncityInputViewClearButton1: (id)sender {
  NSLog(@"in oncityInputViewClearButton1!");
    gbl_myCitySoFar                   = @"";
    gbl_fewEnoughCitiesToMakePicklist = 0;

//    gbl_searchStringTitle.title = @"Type City Name";
//    [self setCitySearchStringTitleTo: @"Type City Name x" ];
//        [passwordTextField becomeFirstResponder];

//    UITextField *ptrToCityField = (UITextField *)[self.view viewWithTag: 2 ];
//  NSLog(@"1   ptrToCityField.text=[%@]",ptrToCityField.text);
//  NSLog(@"=[%@]",);
//  NSLog(@"SET    city textfield.text = zilch");
//    ptrToCityField.text = @"";
//  NSLog(@"2   ptrToCityField.text=[%@]",ptrToCityField.text);


    [self setCitySearchStringTitleTo: @"Type City Name" ];

    gbl_enteredCity        = gbl_initPromptCity;  // @"City or Town";  for display in gbl_mycityprovcounLabel= found city,prov,counl
    gbl_enteredProv        = gbl_initPromptProv;  // @"State or Province";
    gbl_enteredCoun        = gbl_initPromptCoun;  // @"Country";


    // update city label field  update field in cellForRowAtIndexpath
    //
    [ self updateCityProvCoun ]; // update city/prov/couon field  in cellForRowAtIndexpath

    [self showHide_ButtonToSeePicklist ];

//<.> TODO
//    [[self.view viewWithTag: gbl_tag_cityInputPicklistButton ] setHidden: YES ];

} // end of oncityInputViewClearButton1



//- (IBAction) oncityInputViewClearButton2: (id)sender {
//  NSLog(@"in oncityInputViewClearButton2!");
//    gbl_myCitySoFar             = @"";
////    gbl_searchStringTitle.title = @"Type City Name";
//    [self setCitySearchStringTitleTo: @"Type City Name 2" ];
//
//    gbl_enteredCity        = gbl_initPromptCity;  // @"City or Town";  for display in gbl_mycityprovcounLabel= found city,prov,counl
//    gbl_enteredProv        = gbl_initPromptProv;  // @"State or Province";
//    gbl_enteredCoun        = gbl_initPromptCoun;  // @"Country";
//
//
//    // update city label field  update field in cellForRowAtIndexpath
//    //
//    [ self updateCityProvCoun ]; // update city/prov/couon field  in cellForRowAtIndexpath
//
////<.> TODO
////    [[self.view viewWithTag: gbl_tag_cityInputPicklistButton ] setHidden: YES ];
//} // end of oncityInputViewClearButton2



// add the button "Picklist >"  to  the inputViewAccessory toolbar
// but only if gbl_fewEnoughCitiesToMakePicklist == 1  yes
//
- (void) showHide_ButtonToSeePicklist
{
tn();  NSLog(@"in showHide_ButtonToSeePicklist!");

    // here picklist button is not there

    //
    //// This is how you remove the button from the toolbar and animate it
    //[toolbarButtons removeObject:self.myButton];
    //[self setToolbarItems:toolbarButtons animated:YES];
    //
    //// This is how you add the button to the toolbar and animate it
    //if (![toolbarButtons containsObject:self.myButton]) {
    //    // The following line adds the object to the end of the array.  
    //    // If you want to add the button somewhere else, use the `insertObject:atIndex:` 
    //    // method instead of the `addObject` method.
    //    [toolbarButtons addObject:self.myButton];
    //    [self setToolbarItems:toolbarButtons animated:YES];
    //}
    //
    NSInteger picklistButtonIsNowOnToolbar;
    picklistButtonIsNowOnToolbar = -1;
  NSLog(@"gbl_buttonArrayForKeyboard       =[%@]",gbl_buttonArrayForKeyboard );

  NSLog(@"self.outletToButtonToGetPicklist =[%@]", self.outletToButtonToGetPicklist.description );

//    for (id mybarbutton in gbl_buttonArrayForKeyboard ) 
    for ( UIBarButtonItem *mybarbutton in gbl_buttonArrayForKeyboard ) {
  NSLog(@"mybarbutton.description =[%@]", mybarbutton.description );
        if ( [ mybarbutton.description  isEqualToString: self.outletToButtonToGetPicklist.description ] ) picklistButtonIsNowOnToolbar = 1;
        else                                                                                              picklistButtonIsNowOnToolbar = 0;
    }

//    if ( ! [ gbl_buttonArrayForKeyboard containsObject: self.outletToButtonToGetPicklist ] ) picklistButtonIsNowOnToolbar = 1;
//    else                                                                                     picklistButtonIsNowOnToolbar = 0;

  NSLog(@"picklistButtonIsNowOnToolbar      =[%ld]",(long)picklistButtonIsNowOnToolbar      );
  NSLog(@"gbl_fewEnoughCitiesToMakePicklist =[%ld]",(long)gbl_fewEnoughCitiesToMakePicklist );

    if (   picklistButtonIsNowOnToolbar      == 1
        && gbl_fewEnoughCitiesToMakePicklist == 0 ) {
  NSLog(@" Hide ButtonToSeePicklist!");
        // remove picklist button
        [gbl_buttonArrayForKeyboard removeObject: self.outletToButtonToGetPicklist ];
        // add flexible space
        [gbl_buttonArrayForKeyboard    addObject: gbl_flexibleSpace];

        [gbl_ToolbarForCityKeyboard setItems: gbl_buttonArrayForKeyboard animated:YES];         // <<==---  works
    }

    if (   picklistButtonIsNowOnToolbar      == 0
        && gbl_fewEnoughCitiesToMakePicklist == 1 ) {
  NSLog(@" Show ButtonToSeePicklist!");
        // remove flexible space (is at end)
        [gbl_buttonArrayForKeyboard removeLastObject ];
        // put up picklist button
        [gbl_buttonArrayForKeyboard addObject: self.outletToButtonToGetPicklist ];

        [gbl_ToolbarForCityKeyboard setItems: gbl_buttonArrayForKeyboard animated:YES];         // <<==---  works
    }
}  // showHide_ButtonToSeePicklist


// show the city picklist
- (IBAction) oncityInputViewPicklistButton: (id)sender {
  NSLog(@"in oncityInputViewPicklistButton!");

    gbl_mycityInputView = @"picker";  // is "keyboard" or "picker"

    [self putUpCityPicklist ];

    [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"

    //
    // All UIResponder objects have an inputView property.
    // The inputView of a UIResponder is the view that will be shown in place of the keyboard
    // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
    //
//  ?? switch  becomefirst  and inputview=  ???
//    [gbl_mycitySearchString becomeFirstResponder];
//nbn(60);
//   [self reloadInputViews ];
//
//  NSLog(@"-didsel3b-- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );
//  NSLog(@"end of  oncityInputViewPicklistButton!");

} // end of oncityInputViewPicklistButton


// show the city keyboard
- (IBAction) oncityInputViewKeyboardButton: (id)sender {
tn();  NSLog(@"in oncityInputViewKeyboardButton!");


    self.pickerViewCity.hidden       = YES;
    gbl_mycityInputView              = @"keyboard";  
    gbl_mycitySearchString.inputView = nil ;          // this has to be here to put up keyboard



tn();trn("gbl_mycitySearchString resignFirstResponder        get rid of picker  1");

            [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here

  NSLog(@"--onc ----- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER ---------------- " );

  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];

            gbl_mycitySearchString.inputView = nil ;  // get rid of picker input view   // necessary ?  works?=yes

  NSLog(@"--onc ----- VASSIGN gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);


nbn(2332);
tn();trn("gbl_mycitySearchString becomeFirstResponder        put up keyboard 1  KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
            // put up keyboard   works?=
            //
            // All UIResponder objects have an inputView property.
            // The inputView of a UIResponder is the view that will be shown in place of the keyboard
            // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
            //

    [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"

            [gbl_mycitySearchString becomeFirstResponder];  // control textFieldShouldBeginEditing > textFieldDidBeginEditing > back here
  NSLog(@"--onc ----- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );



    [self showHide_ButtonToSeePicklist ];


NSLog(@"end of  oncityInputViewKeyboardButton!"); tn();
} // end of oncityInputViewKeyboardButton



// qOLD
//
//- (IBAction)onCancelCityPicker:(id)sender
//{
//  NSLog(@"onCancelCityPicker");
//
//} // onCancelCityPicker
//
//- (IBAction)onCancelInputCity:(id)sender
//{
//tn();  NSLog(@"onCancelInputCity  CANCEL  CANCEL  CANCEL  CCANCEL  ANCEL  ");
//  NSLog(@"gbl_searchStringTitle.title=%@",gbl_searchStringTitle.title);
//  NSLog(@"gbl_mycitySearchString.inputView=%@",gbl_mycitySearchString.inputView);
//  NSLog(@"gbl_mycityInputView             =%@",gbl_mycityInputView);
//
//
////    if ([ gbl_searchStringTitle.title isEqualToString: @"Pick City" ] ) { // are in uiPICKERview input
//    if ([ gbl_mycityInputView isEqualToString: @"picker" ] ) { // (not "keyboard")
//
//nbn(233);
////        gbl_mycityInputView = @"picker";     // = "keyboard" or "picker", default is KB
//
//  gbltmpstr = gbl_mycityInputView;
//        gbl_mycityInputView = @"keyboard";     // = "keyboard" or "picker", default is KB
//  NSLog(@"--onc ----- VASSIGN gbl_mycityInputView ---------------- old=[%@]  new=[%@] ---", gbltmpstr, gbl_mycityInputView );
//
//  gbltmpint = gbl_justCancelledOutOfCityPicker ;
//        gbl_justCancelledOutOfCityPicker = 1;   // used in should/did  begin/end  editing  to alter city inputview  kb/picker
//  NSLog(@"--onc ----- USAGE gbl_justCancelledOutOfCityPicker ---------------- old=[%ld]  new=[%ld] ---", gbltmpint, gbl_justCancelledOutOfCityPicker );
//
////            self.pickerViewCity.hidden       = YES;
////            gbl_mycitySearchString.inputView = nil ;  // get rid of picker input view   // necessary ?  works?=yes
//
//nbn(2331);
//tn();trn("gbl_mycitySearchString resignFirstResponder        get rid of picker  1");
//            [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//  NSLog(@"--onc ----- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER ---------------- " );
//
//nbn(23311);
//tn();trn("gbl_mycitySearchString.inputView = nil             gbl_mycitySearchString resignFirstResponder ??? ");
//
//
//  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];
//            gbl_mycitySearchString.inputView = nil ;  // get rid of picker input view   // necessary ?  works?=yes
//  NSLog(@"--onc ----- VASSIGN gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);
//
//
//nbn(2332);
//tn();trn("gbl_mycitySearchString becomeFirstResponder        put up keyboard 1  KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
//            // put up keyboard   works?=
//            //
//            // All UIResponder objects have an inputView property.
//            // The inputView of a UIResponder is the view that will be shown in place of the keyboard
//            // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
//            //
//            [gbl_mycitySearchString becomeFirstResponder];  // control textFieldShouldBeginEditing > textFieldDidBeginEditing > back here
//  NSLog(@"--onc ----- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );
//
//  gbltmpstr = gbl_searchStringTitle.title;
//            gbl_searchStringTitle.title =  @"Type Birth City Name";  //  update title of keyboard "toolbar"
//  NSLog(@"--in pkr--- VASSIGN gbl_searchStringTitle.title  --- old=[%@]  new=[%@] ---", gbltmpstr, gbl_searchStringTitle.title );
//
//
//
//nbn(2333);
//        NSInteger tmpIndex = [gbl_myCitySoFar length];                                         // end char out of  gbl_myCitySoFar 
//        if (tmpIndex > 0) gbl_myCitySoFar = [gbl_myCitySoFar substringToIndex: tmpIndex - 1];  // end char out of  gbl_myCitySoFar
//
//nbn(901); NSLog(@"=gbl_myCitySoFar %@",gbl_myCitySoFar );
//        
//  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
//  NSLog(@"gbl_enteredCity =%@",gbl_enteredCity );
//  NSLog(@"gbl_enteredProv =%@",gbl_enteredProv );
//  NSLog(@"gbl_enteredCoun =%@",gbl_enteredCoun );
//
//  gbltmpstr = gbl_searchStringTitle.title;
//        gbl_searchStringTitle.title = gbl_myCitySoFar;
//  NSLog(@"-901 in pkr VASSIGN gbl_searchStringTitle.title  --- old=[%@]  new=[%@] ---", gbltmpstr, gbl_searchStringTitle.title );
//
//
//        const char *sofarC_CONST;                                                    // convert NSString to c string 
//        sofarC_CONST = [gbl_myCitySoFar cStringUsingEncoding:NSUTF8StringEncoding];  // convert NSString to c string
//        char   sofarCstring[64];                                                     // convert NSString to c string 
//        strcpy(sofarCstring, sofarC_CONST);                                          // convert NSString to c string 
//
//        int idx_into_placetab;
//tn();trn("bin_find_first_city  IN ONCANCEL");
//        idx_into_placetab = bin_find_first_city(  // **********  ==========   GET CITY,prov,coun
////            arg_cityBeginsWith,
//            sofarCstring,
//            gbl_numCitiesToTriggerPicklist,  // is type  int
//            &num_PSVs_found,                 // is type  int  (0-based index to last string)
//            city_prov_coun_PSVs              // array of chars holding fixed length "strings"
//        );
//tn();tr("bin_find_first_city  IN ONCANCEL >>>");kin(idx_into_placetab );
//        if (idx_into_placetab == -2) gbl_fewEnoughCitiesToMakePicklist = 1;
//        else                         gbl_fewEnoughCitiesToMakePicklist = 0;
//  NSLog(@"gbl_fewEnoughCitiesToMakePicklist =%ld",gbl_fewEnoughCitiesToMakePicklist );
//        gbl_pickerToUse  = @"city picker"; // regardless
//
//        //    if (       idx_into_placetab == -1) {  // city not found beginning with string  arg_citySoFar  
//        //    } else if (idx_into_placetab == -2) {  // -2  IF there are few enough cities to make a picklist
//        if (idx_into_placetab > 0) {
//
//  NSLog(@" show latest city,prov,coun  beginning with city chars typed so far");
//            // show latest city,prov,coun  beginning with city chars typed so far
//            char myCityName [64];
//            strcpy(myCityName, gbl_placetab[idx_into_placetab].my_city); 
//            NSString *myLatestCity =  [NSString stringWithUTF8String: myCityName ];  // convert c string to NSString
//            gbl_enteredCity = myLatestCity ;
//
//            char myProvName [64];
//            strcpy(myProvName, array_prov[gbl_placetab[idx_into_placetab].idx_prov]); 
//            NSString *myLatestProv =  [NSString stringWithUTF8String: myProvName];  // convert c string to NSString
//            gbl_enteredProv = myLatestProv ;
//
//            char myCounName [64];
//            strcpy(myCounName, array_coun[gbl_placetab[idx_into_placetab].idx_coun]); 
//            NSString *myLatestCoun =  [NSString stringWithUTF8String: myCounName];  // convert c string to NSString
//            gbl_enteredCoun = myLatestCoun ;
//
//            [ self updateCityProvCoun ]; // update city/prov/couon field  in cellForRowAtIndexpath
//        }
// 
//        gbl_currentCityPicklistIsForTypedSoFar = @"";  // like "toron"  or "toro"   BECAUSE CANCELLED OUT OF CITY PICKLIST
//nbn(2339);
//
//    } else {   // are in KEYBOARD input
//nbn(234);
//  gbltmpstr = gbl_mycityInputView;
//        gbl_mycityInputView = @"keyboard";     // = "keyboard" or "picker", default is KB
//  NSLog(@"--onc1----- VASSIGN gbl_mycityInputView ---------------- old=[%@]  new=[%@] ---", gbltmpstr, gbl_mycityInputView );
//
//        // erase typing done so far for city name search
//        //
//        gbl_myCitySoFar = @"";
//nbn(902); NSLog(@"=gbl_myCitySoFar %@",gbl_myCitySoFar );
//
//        //  update title of keyboard "toolbar"
//        //
//  gbltmpstr = gbl_searchStringTitle.title;
//        gbl_searchStringTitle.title = @"Type City Name";
//  NSLog(@"--in kb---- VASSIGN gbl_searchStringTitle.title  --- old=[%@]  new=[%@] ---", gbltmpstr, gbl_searchStringTitle.title );
//
//
//        // update city label field  update field in cellForRowAtIndexpath
//        //
//            //  myTextCity = [NSString stringWithFormat:@" %@\n %@\n %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
//            gbl_enteredCity = gbl_initPromptCity;
//            gbl_enteredProv = gbl_initPromptProv;
//            gbl_enteredCoun = gbl_initPromptCoun;
//
//        // clear internal typed in buffer for city search string
//        //
//        gbl_mycitySearchString.text = @"";
//
//        NSIndexPath *indexPathSearchCityString = [NSIndexPath indexPathForRow: 2 inSection: 0];
//
//        NSArray *indexPathsToUpdate = [NSArray arrayWithObjects: indexPathSearchCityString, nil];
//        [self.tableView beginUpdates];
//        [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
//                              withRowAnimation: UITableViewRowAnimationNone ];
//        [self.tableView endUpdates];
//
//nbn(235);
////
//////        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//////        [gbl_mycitySearchString becomeFirstResponder]; 
////
//////        [self.view endEditing:YES];
////        [gbl_mycitySearchString  endEditing:YES];        //  hides the keyboard
//
//        //
//        // All UIResponder objects have an inputView property.
//        // The inputView of a UIResponder is the view that will be shown in place of the keyboard
//        // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
//        //
//        [gbl_mycitySearchString becomeFirstResponder];   // brings keyboard back
//  NSLog(@"--onc2----- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );
//nbn(236);
////
////        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//// 
////        gbl_mycitySearchString.inputView = nil ;   // necessary ?
////
////        [gbl_mycitySearchString becomeFirstResponder]; 
////
//    }
//
//    // show values in gbl_enteredCity  Prov  Coun
//    [ self updateCityProvCoun ]; // update city/prov/couon field  in cellForRowAtIndexpath
//
////    NSIndexPath *indexPathLabelCityProvCoun = [NSIndexPath indexPathForRow: 3 inSection: 0];
////
////    NSArray *indexPathsToUpdate = [NSArray arrayWithObjects: indexPathLabelCityProvCoun, nil];
////    [self.tableView beginUpdates];
////    [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
////                          withRowAnimation: UITableViewRowAnimationNone ];
////    [self.tableView endUpdates];
////
//
//
//
////  gbltmpint = gbl_justCancelledOutOfCityPicker ;
////        gbl_justCancelledOutOfCityPicker = 0;   // used in should/did  begin/end  editing  to alter city inputview  kb/picker
////  NSLog(@"--onc (end)- USAGE gbl_justCancelledOutOfCityPicker ---------------- old=[%ld]  new=[%ld] ---", gbltmpint, gbl_justCancelledOutOfCityPicker );
////<.>
//
//    [self putUpCancelButtonOrNot  ];
//
//NSLog(@"END OF  onCancelInputCity  CANCEL  CANCEL  CANCEL  CCANCEL  ANCEL  ");
//tn();
//
//} // onCancelInputCity
//
//


- (IBAction)pressedCancel:(id)sender     // this is the Cancel on left of Nav Bar
{
  NSLog(@"pressedCancel");
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
  NSLog(@"gbl_myname.text       =[%@]",gbl_myname.text       );
  NSLog(@"gbl_enteredCity       =[%@]",gbl_enteredCity       );
  NSLog(@"gbl_enteredProv       =[%@]",gbl_enteredProv);
  NSLog(@"gbl_enteredCoun       =[%@]",gbl_enteredCoun);
  NSLog(@"gbl_selectedBirthInfo =[%@]",gbl_selectedBirthInfo );

    //        - (void) viewDidLoad
    //        {
    //        // change the back button to cancel and add an event handler
    //        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@”back”
    //        style:UIBarButtonItemStyleBordered
    //        target:self
    //        action:@selector(handleBack:)];
    //
    //        self.navigationItem.leftBarButtonItem = backButton;
    //        [backButton release];
    //
    //        }
    //        - (void) handleBack:(id)sender
    //        {
    //        // pop to root view controller
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //
    //        }
    //
//    gbl_myname.text              = gbl_initPromptName;
//    gbl_myCitySoFar              = @"";
//    gbl_editingChangeNAMEHasOccurred = 0;
//    gbl_editingChangeCITYHasOccurred = 0;
//    gbl_editingChangeDATEHasOccurred = 0;
//
//    gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"
//
//

//            [self.view endEditing: YES];
    [gbl_myname             resignFirstResponder];
  NSLog(@"-didsel3a-- VASSIGN gbl_myname             RESIGN!FIRST_RESPONDER ---------------- " );
    [gbl_mybirthinformation resignFirstResponder]; 
  NSLog(@"-didsel3a-- VASSIGN gbl_mybirthinformation RESIGN!FIRST_RESPONDER ---------------- " );
    [gbl_mycitySearchString resignFirstResponder]; // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
  NSLog(@"-didsel3a-- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER ---------------- " );


    
    if (   gbl_editingChangeNAMEHasOccurred == 1
        || gbl_editingChangeCITYHasOccurred == 1
        || gbl_editingChangeDATEHasOccurred == 1
    ) {

        // here editing changes have happened

        NSString *msg;            // set msg
        if ([gbl_homeEditingState isEqualToString:  @"add" ] ) {

            if ([gbl_myname.text       isEqualToString: gbl_initPromptName ] ) gbl_DisplayName = @"";
            else                                                               gbl_DisplayName = gbl_myname.text;

            if ([gbl_enteredCity       isEqualToString: gbl_initPromptCity ] ) gbl_DisplayCity = @"";
            else                                                               gbl_DisplayCity = gbl_enteredCity;
            if ([gbl_enteredProv       isEqualToString: gbl_initPromptProv ] ) gbl_DisplayProv = @"";
            else                                                               gbl_DisplayProv = gbl_enteredProv;
            if ([gbl_enteredCoun       isEqualToString: gbl_initPromptCoun ] ) gbl_DisplayCoun = @"";
            else                                                               gbl_DisplayCoun = gbl_enteredCoun;

            if ([gbl_selectedBirthInfo isEqualToString: gbl_initPromptDate ] ) gbl_DisplayDate = @"";
            else                                                               gbl_DisplayDate = gbl_selectedBirthInfo;

            msg = [NSString stringWithFormat:
//                @"\nyou want to throw away what you entered for this new %@?\n\nName:  \"%@\"\nCity:  \"%@\"\nDate:  \"%@\"",
                @"\nyou want to throw away what you entered for this new %@?\n\n\"%@\"\n\"%@\"\n\"%@\"",
                gbl_fromHomeCurrentEntity,
                gbl_DisplayName,
                gbl_DisplayCity,
                gbl_DisplayDate
            ]; // "person" or "group"

            if (   [gbl_DisplayName   isEqualToString: @"" ]
                && [gbl_DisplayCity   isEqualToString: @"" ]
                && [gbl_DisplayProv   isEqualToString: @"" ]
                && [gbl_DisplayCoun   isEqualToString: @"" ]
                && [gbl_DisplayDate   isEqualToString: @"" ]
            ) {
  NSLog(@" // 111a actually do the BACK action on when changes net out to nothing");
                [self.navigationController popToRootViewControllerAnimated: YES]; // actually do the "Back" action
            }

        }
        if ([gbl_homeEditingState isEqualToString:  @"view or change" ] ) {  
            msg = @"\nthrow away your changes?";
        }

        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Are you Sure"
                                                                       message: msg
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle: @"Yes"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {   // handler

  NSLog(@"Yes button pressed xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

            gbl_myname.text              = gbl_initPromptName;
            gbl_myCitySoFar              = @"";
            gbl_editingChangeNAMEHasOccurred = 0;
            gbl_editingChangeCITYHasOccurred = 0;
            gbl_editingChangeDATEHasOccurred = 0;

            gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"


  NSLog(@" // 111 actually do the BACK action on Pressing YES to throw away");
            [self.navigationController popToRootViewControllerAnimated: YES]; // actually do the "Back" action

        } ];   // handler

        UIAlertAction* noButton = [UIAlertAction actionWithTitle: @"No"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {   // handler

  NSLog(@" no button pressed"); // if "no" answer to throwing away changes, do nothing, just return
            ;                   // if "no" answer to throwing away changes, do nothing, just return

        } ];   // handler
         
        [alert addAction: yesButton];
        [alert addAction:  noButton];

        [self presentViewController: alert  animated: YES  completion: nil   ];


    } else {  // here no editing changes have happened
        // actually do the "Back" action
        //
  NSLog(@" // 222 actually do the BACK action ");
        [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller
    }

} // pressedCancel



- (IBAction)pressedSaveDone:(id)sender
{
  NSLog(@"in pressedSAVEDONE!!");

  NSLog(@"gbl_myname.text       =[%@]",gbl_myname.text       );
  NSLog(@"gbl_enteredCity       =[%@]",gbl_enteredCity);
  NSLog(@"gbl_enteredProv       =[%@]",gbl_enteredProv);
  NSLog(@"gbl_enteredCoun       =[%@]",gbl_enteredCoun);
  NSLog(@"gbl_selectedBirthInfo =[%@]",gbl_selectedBirthInfo );


    
    if ([gbl_homeEditingState isEqualToString:  @"add" ] ) {

        if (   gbl_editingChangeNAMEHasOccurred == 1
            || gbl_editingChangeCITYHasOccurred == 1
            || gbl_editingChangeDATEHasOccurred == 1
        ) {
            // here editing changes have happened

            if ([gbl_myname.text       isEqualToString: gbl_initPromptName ] ) gbl_DisplayName = @"";
            else                                                               gbl_DisplayName = gbl_myname.text;

            if ([gbl_enteredCity       isEqualToString: gbl_initPromptCity ] ) gbl_DisplayCity = @"";
            else                                                               gbl_DisplayCity = gbl_enteredCity;
            if ([gbl_enteredProv       isEqualToString: gbl_initPromptProv ] ) gbl_DisplayProv = @"";
            else                                                               gbl_DisplayProv = gbl_enteredProv;
            if ([gbl_enteredCoun       isEqualToString: gbl_initPromptCoun ] ) gbl_DisplayCoun = @"";
            else                                                               gbl_DisplayCoun = gbl_enteredCoun;

            if ([gbl_selectedBirthInfo isEqualToString: gbl_initPromptDate ] ) gbl_DisplayDate = @"";
            else                                                               gbl_DisplayDate = gbl_selectedBirthInfo;


            if (   [gbl_DisplayName   isEqualToString: @"" ]
                && [gbl_DisplayCity   isEqualToString: @"" ]
                && [gbl_DisplayProv   isEqualToString: @"" ]
                && [gbl_DisplayCoun   isEqualToString: @"" ]
                && [gbl_DisplayDate   isEqualToString: @"" ]
            ) {
  NSLog(@" // 111b actually do the BACK action on when changes net out to nothing");
                [self.navigationController popToRootViewControllerAnimated: YES]; // actually do the "Back" action
            }
// TODO
            // before save of New Person,  check for missing information  name,city,date  same as prompt
            if (   [gbl_DisplayName isEqualToString: @"" ]
                || [gbl_DisplayCity isEqualToString: @"" ]
                || [gbl_DisplayCoun isEqualToString: @"" ]
            ) {
                // here info is missing
                NSString *namePrompt; NSString *cityPrompt; NSString *datePrompt;
                namePrompt = @"";     cityPrompt = @"";     datePrompt = @"";
                if (  [gbl_DisplayName isEqualToString: @"" ]) namePrompt = @" Name ";
                if (  [gbl_DisplayCity isEqualToString: @"" ]) cityPrompt = @" Birth City or Town ";
                if (  [gbl_DisplayCoun isEqualToString: @"" ]) datePrompt = @" Birth Date and Time ";
                NSString *missingMsg =  [NSString stringWithFormat:@"Missing Information:\n%@\n%@\n%@",
                    namePrompt, cityPrompt, datePrompt
                ];
                UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Can Not Save"
                                                                                 message: missingMsg
                                                                          preferredStyle: UIAlertControllerStyleAlert  ];
                 
                UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                    style: UIAlertActionStyleDefault
                                                                  handler: ^(UIAlertAction * action) {
                        NSLog(@"Ok button pressed");
                    }
                ];
                 
                [myAlert addAction:  okButton];

                [self presentViewController: myAlert  animated: YES  completion: nil   ];
            }

            // before save of New Person,  check if entered name already exists in database
            //
            NSString *nameOfGrpOrPer;
            NSArray  *arrayGrpOrper;
//            NSInteger idxGrpOrPer;
//            idxGrpOrPer = -1;
            NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];

            for (id eltPer in gbl_arrayPer) {
//                idxGrpOrPer = idxGrpOrPer + 1;
//  NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
//  NSLog(@"eltPer=%@", eltPer);
//
//  NSLog(@"nameOfGrpOrPer =[%@]",nameOfGrpOrPer );
//  NSLog(@"gbl_DisplayName=[%@]",gbl_DisplayName);
                arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
                nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

//                if ([nameOfGrpOrPer isEqualToString: gbl_DisplayName]) {
                if( [nameOfGrpOrPer caseInsensitiveCompare: gbl_DisplayName] == NSOrderedSame ) // strings are equal except for possibly case
                {
                    // here the name of New Person is in database

                    NSString *msg_alreadyThere = [
                        NSString stringWithFormat: @"You already have a Person with the name \"%@\".\n\nPlease make this new name different.",
                        nameOfGrpOrPer  // gbl_DisplayName
                    ];
                    UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Person Already There"
                                                                                     message: msg_alreadyThere 
                                                                              preferredStyle: UIAlertControllerStyleAlert  ];
                     
                    UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                        style: UIAlertActionStyleDefault
                                                                      handler: ^(UIAlertAction * action) {
                            NSLog(@"Ok button pressed");
                        }
                    ];
                     
                    [myAlert addAction:  okButton];

                    [self presentViewController: myAlert  animated: YES  completion: nil   ];

                    return;  // pressed "Done" > cannot save > stay in this screen

                }
            } // search thru gbl_arrayPer


  NSLog(@" // Actually do save of New Person   here");
            // Actually do save of New Person   here
            //

<.>
            // first build a Person database record in a string
            NSString *myNewPersonRecord;
            myNewPersonRecord = [self buildPersonRecord ];
<.>
// // FINAL  values for saving
// //
// NSString *gbl_userSpecifiedPersonName;  // final value in "add person" screen
// 
// NSString *gbl_rollerBirth_mth;  // like "Jan"
// NSString *gbl_rollerBirth_dd;
// NSString *gbl_rollerBirth_yyyy; // for saving picker roller current values
// NSString *gbl_rollerBirth_hour;
// NSString *gbl_rollerBirth_min;
// NSString *gbl_rollerBirth_amPm;
// 
// NSString *gbl_userSpecifiedCity;  // final value in "add person" screen  use for calc  latitude, hours diff from greenwich
// NSString *gbl_userSpecifiedProv;  // final value in "add person" screen
// NSString *gbl_userSpecifiedCoun;  // final value in "add person" screen
// //
// // FINAL  values for saving
//
- (NSString) buildPersonRecord  // from globals
{
} // end of getPersonRecord  
<.>

<.>  the 10 fields are:
            strcpy(psvName, csv_get_field(my_psv, "|", 1));
            strcpy(psvMth,  csv_get_field(my_psv, "|", 2));
            strcpy(psvDay,  csv_get_field(my_psv, "|", 3));
            strcpy(psvYear, csv_get_field(my_psv, "|", 4));
            strcpy(psvHour, csv_get_field(my_psv, "|", 5));
            strcpy(psvMin,  csv_get_field(my_psv, "|", 6));
            strcpy(psvAmPm, csv_get_field(my_psv, "|", 7));
            strcpy(psvCity, csv_get_field(my_psv, "|", 8));
            strcpy(psvProv, csv_get_field(my_psv, "|", 9));
            strcpy(psvCountry, csv_get_field(my_psv, "|", 10));
            ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
            ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
            
            // get longitude and timezone hoursDiff from Greenwich
            // by looking up psvCity, psvProv, psvCountry
            //
            seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
            
            strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
            strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
<.>
<.>

NSString *gbl_DisplayName;

      NSLog(@"gbl_rollerBirth_mth  =%@",gbl_rollerBirth_mth  );
      NSLog(@"gbl_rollerBirth_dd   =%@",gbl_rollerBirth_dd   );
      NSLog(@"gbl_rollerBirth_yyyy =%@",gbl_rollerBirth_yyyy );
      NSLog(@"gbl_rollerBirth_hour =%@",gbl_rollerBirth_hour );
      NSLog(@"gbl_rollerBirth_min  =%@",gbl_rollerBirth_min  );
      NSLog(@"gbl_rollerBirth_amPm =%@",gbl_rollerBirth_amPm );

NSString *gbl_enteredCity; // to update 3 place labels
NSString *gbl_enteredProv; // to update 3 place label
NSString *gbl_enteredCoun; // to update 3 place labels
            
<.>

            //  test = [[NSMutableArray alloc]init];
nbn(14);
            [gbl_arrayPer addObject: myNewPersonRecord]; // add the new Person database record in a string to the person array


            MAMB09AppDelegate *myappDelegate =
                (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m

            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"person"];  // write new data to file
nbn(15);
            [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"person"]; // read new data from file to array
nbn(152);
            [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"person"]; } // sort by name
nbn(153);

            gbl_justAddedRecord  = 1;  // cause reload of home data

nbn(16);
            // after saving new person, go back to home view
            [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller (actually do the "Back" action)

nbn(17);

        } else {
            // here editing changes have NOT happened
  NSLog(@" // 222b actually do the BACK action  when Done hit and there are no editing changes");
            [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller (actually do the "Back" action)
        }
    } // if gbl_homeEditingState = "add"




} // pressedSaveDone



- (IBAction)pressedPrivacy:(id)sender
{
  NSLog(@"pressedPrivacy");
} // pressedPrivacy




- (void)didReceiveMemoryWarning {
    //    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"The App received a Memory Warning"
                                                                   message: @"The system has determined that the \namount of available memory is very low."
                                                            preferredStyle: UIAlertControllerStyleAlert  ];
     
    UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                        style: UIAlertActionStyleDefault
                                                      handler: ^(UIAlertAction * action) {
        NSLog(@"Ok button pressed");
    } ];
    [alert addAction:  okButton];
    [self presentViewController: alert  animated: YES  completion: nil   ];
    [super didReceiveMemoryWarning];
} // didReceiveMemoryWarning 


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    return 7;
    return 6;  // hidden gbl_mycitySearchString   moved to rownum=2 from rownum=6 (for scrollRectToVisible)
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    BOOL touchedViewIsTextfield = NO;
// 
//    // first check we have a cell
//    NSIndexPath *indexPathAtHitPoint = [self indexPathForRowAtPoint:point];
//    id cell = [tableview.cell cellForRowAtIndexPath:indexPathAtHitPoint];
//    if (cell) {
//        NSArray *subViews = [[cell contentView] subviews];
//        // Cycle through subviews of the contentView
//        for (UIView *view in subViews) {
//            // Test if the subView is a UITextField
//            if ([view isKindOfClass :[UITextField class]]) {
//                // And here is the bit that aint working... where did I go wrong?
//                touchedViewIsTextfield = [view pointInside:point withEvent:event];
//                if (touchedViewIsTextfield) { NSLog(@";yes"); }
//            }
//        }
//    }
//    return [super hitTest:point withEvent:event];
//}   
//


// textFieldShouldBeginEditing: is called just before the text field becomes active.
// This is a good place to customize the behavior of your application.
// In this instance, the background color of the text field changes when this method is called to indicate the text field is active.
//
- (BOOL)textFieldShouldBeginEditing: (UITextField *)textField {
tn();   NSLog(@"in textFieldShouldBeginEditing ################################################## ");
  NSLog(@"textField.tag=[%ld]",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
  NSLog(@"gbl_myname.text=[%@]",gbl_myname.text);
//  NSLog(@"gbl_justCancelledOutOfCityPicker =%ld",gbl_justCancelledOutOfCityPicker );
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);

    [ self checkResponderStuff ];
    if ( [gbl_firstResponder_current isEqualToString:  @"date" ] ) {
        gbl_fieldTap_leaving = @"date";  // picker has no should/did end to set this with
    }

//    textField.backgroundColor = [UIColor colorWithRed: 220.0f/255.0f green: 020.0f/255.0f blue: 220.0f/255.0f alpha: 1.0f];

    if (textField.tag == 1) {
        gbl_lastInputFieldTapped = @"name";
  NSLog(@"                                    GOT A TAP  in   textField  NAME");
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse1        =%@",gbl_pickerToUse );
//        return YES;  // name entry
    }
    if (textField.tag == 2) {                 // city,prov,coun  LABEL
        gbl_lastInputFieldTapped = @"city";
  NSLog(@"                                    GOT A TAP  in   textField  CITY");
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse1        =%@",gbl_pickerToUse );
//        return YES;  // name entry
    }
    if (textField.tag == 3) {                 // date/time entry
        // this never gets called because of uipickerview is inputview for date
        gbl_lastInputFieldTapped = @"date";
  NSLog(@"                                    GOT A TAP  in   textField  DATE");
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse1        =%@",gbl_pickerToUse );
//        return YES;  // name entry
    }

  NSLog(@"gbl_mycityInputView =%@",gbl_mycityInputView );
//  NSLog(@"gbl_justCancelledOutOfCityPicker =%ld",gbl_justCancelledOutOfCityPicker );
//
//  NSLog(@"-- USAGE  gbl_justCancelledOutOfCityPicker --  in  textFieldShouldBeginEditing --  hide picker ?");
//    if (   [gbl_mycityInputView isEqualToString: @"picker" ]  
//        && gbl_justCancelledOutOfCityPicker == 1 )
//    {
//tn();trn("hide picker hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//        self.pickerViewCity.hidden       = YES;
//        gbl_mycityInputView              = @"keyboard";  
//        gbl_mycitySearchString.inputView = nil ;          // this has to be here to put up keyboard
//    }


//    return  NO;  // default
trn("END OF textFieldShouldBeginEditing (yes) ########################################################################################## ");tn();
    return  YES;  

} // textFieldShouldBeginEditing


// textFieldDidBeginEditing: is called when the text field becomes active.
//
- (void)textFieldDidBeginEditing: (UITextField *)textField
{           
tn();   NSLog(@"in textFieldDidBeginEditing ################################################## ");
  NSLog(@"textField.tag=[%ld]",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);
  NSLog(@"gbl_myname.text=[%@]",gbl_myname.text);
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"gbl_mycityInputView=%@",gbl_mycityInputView);
//  NSLog(@"gbl_justCancelledOutOfCityPicker =%ld",gbl_justCancelledOutOfCityPicker );
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);

//  NSLog(@"-- USAGE  gbl_justCancelledOutOfCityPicker --  in  textFieldDidBeginEditing --  rm last char from textField.text ?");
//
//    if (gbl_justCancelledOutOfCityPicker == 1) {   // NO  = 0 here
//  NSLog(@"remove last char from  textField.text");
//        NSString *tmpNSString = textField.text;
//        NSInteger tmpIndex    = [tmpNSString length];                                      // end char out of textField.text
//        if (tmpIndex > 0) textField.text = [tmpNSString substringToIndex: tmpIndex - 1];  // end char out
//  NSLog(@"textField.text=[%@]",textField.text);
//    }


    if ([textField.text isEqualToString: gbl_initPromptName ]  ) {
        textField.text = @"";
    }


    gbl_previousCharTypedWasSpace = 0;                 // for no multiple consecutive spaces
//  NSLog(@"gbl_previousCharTypedWasSpace =%ld",gbl_previousCharTypedWasSpace );


    // textField.tag is always 2  somehow  but sometimes date picker is up

  NSLog(@"gbl_fieldTap_leaving=[%@]",gbl_fieldTap_leaving);
  NSLog(@"gbl_fieldTap_goingto=[%@]",gbl_fieldTap_goingto);
  // which  toolbar is up
  // which  picker is up
  NSLog(@"gbl_firstResponder_previous=[%@]",gbl_firstResponder_previous);
  NSLog(@"gbl_firstResponder_current =[%@]",gbl_firstResponder_current);


    if (textField.tag == 2) {              // city


// try without
        gbl_pickerToUse = @"city picker";  // "city picker" or "date/time picker"
  NSLog(@"gbl_pickerToUse  22      =[%@]",gbl_pickerToUse          );




// qOLD
//  NSLog(@"-- USAGE  gbl_justCancelledOutOfCityPicker --  in  textFieldDidBeginEditing --  put up picker  ?");
//
//
//        // line 1616  see also
//        if (   [gbl_mycityInputView isEqualToString: @"picker" ]  
//            && gbl_justCancelledOutOfCityPicker != 1 
//        ) {
//
//  tn();trn(" putting up  picker because gbl_mycityInputView isEqualToString: picker");
//  //<.>
//  //          [gbl_mycitySearchString resignFirstResponder]; // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//  //          [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//    //
//    // All UIResponder objects have an inputView property.
//    // The inputView of a UIResponder is the view that will be shown in place of the keyboard
//    // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
//    //
//            self.pickerViewCity.hidden       =  NO;
//
//              CFTimeInterval timeRightNow       = CACurrentMediaTime();  // returns double CFTimeInterval
//              gbl_secondsSinceCurrCityKeyStroke = timeRightNow - gbl_timeOfCurrCityKeystroke;  // CALC
//      NSLog(@"=====  SET INTERVAL1 ================== gbl_secondsSinceCurrCityKeyStroke =%g",gbl_secondsSinceCurrCityKeyStroke );
//      NSLog(@"gbl_typedCharPrev=[%@]  gbl_typedCharCurr=[%@]",gbl_typedCharPrev, gbl_typedCharCurr);
//      NSLog(@"============================================================");
//    tn();trn("CHECKDIFF CHECKDIFF CHECKDIFF CHECKDIFF CHECKDIFF   gbl_secondsSinceCurrCityKeyStroke ");
//      NSLog(@"check  check      gbl_secondsSinceCurrCityKeyStroke =%g",gbl_secondsSinceCurrCityKeyStroke );
//      NSLog(@"gbl_typedCharPrev=[%@]  gbl_typedCharCurr=[%@]",gbl_typedCharPrev, gbl_typedCharCurr);
//
//            if (gbl_secondsSinceCurrCityKeyStroke > gbl_secondsPauseInCityKeyStrokesToTriggerPicklist) { // checkdiff - put up city picklist
//
//      NSLog(@"UP  11   UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP   ");
//
//  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];
//                gbl_mycitySearchString.inputView = [self pickerViewCity] ; 
//  NSLog(@"--up 11 --- VASSIGN gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);
//
//
//                [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do no show old data
//
////                gbl_pickerToUse = @"city picker";  // "city picker" or "date/time picker"
//      NSLog(@"   SET                              gbl_pickerToUse2=%@",gbl_pickerToUse );
//
//                [self putUpCancelButtonOrNot  ];
//
//            } else {
//
//  tn();trn("   NOT NOT    putting up  picker because gbl_mycityInputView isEqualToString: picker");
//            }
//        }
//

    } // city

    // NSString *gbl_fieldTap_leaving; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
    // NSString *gbl_fieldTap_goingto; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
    //
    if (            gbl_myname.isFirstResponder == 1)  gbl_fieldTap_goingto = @"name";
    if (gbl_mycitySearchString.isFirstResponder == 1)  gbl_fieldTap_goingto = @"city"; 
    if (gbl_mybirthinformation.isFirstResponder == 1)  gbl_fieldTap_goingto = @"date";  // never
  NSLog(@"gbl_fieldTap_goingto =%@  tap tap tap ",gbl_fieldTap_goingto );

    [ self checkResponderStuff ];


trn("END OF  textFieldDidBeginEditing ########################################################################################## ");tn();

} // textFieldDidBeginEditing



// textFieldShouldEndEditing:  is called just before the text field becomes inactive.
//
- (BOOL)textFieldShouldEndEditing: (UITextField *)textField
{
tn();   NSLog(@"in textFieldShouldEndEditing ################################################## ");
  NSLog(@"textField.tag=[%ld]",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);
  NSLog(@"gbl_myname.text=[%@]",gbl_myname.text);
//    textField.backgroundColor = [UIColor cyanColor];
  NSLog(@"gbl_mycityInputView =%@",gbl_mycityInputView );
//  NSLog(@"gbl_justCancelledOutOfCityPicker =%ld",gbl_justCancelledOutOfCityPicker );
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);


    // trim spaces off end
    //
    NSString *myTmpStr2;
    NSString *myTmpStr3;
    myTmpStr2 = textField.text;
    myTmpStr3 = [myTmpStr2 stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
  NSLog(@"myTmpStr3 =[%@]",myTmpStr3 );
  NSLog(@"set textField.txt = myTmpStr3 xxxxxxxxx 557  xxxxxxxxxxxx");
        textField.text = myTmpStr3;
  NSLog(@"textField.text=[%@]",textField.text);


//
//    // get rid of picker as inputview
//    // if the city field is switching from picker to kb  (due to hit cancel button)
//    if (   gbl_justCancelledOutOfCityPicker == 1 )
////        && [ gbl_mycityInputView isEqualToString: @"picker" ] 
//    {
//tn();trn("get rid of picker  2");
//
//     // NOTE:   BEWARE!   dispatch does not do it
////        dispatch_async(dispatch_get_main_queue(), ^{    //  INIT  PICKER roller values
////        });
//            gbl_mycitySearchString.inputView = nil ;  // get rid of picker input view   // necessary ?  works?=yes
//        
//        gbl_mycityInputView = @"keyboard";
//
//tn();trn("put up keyboard 2  KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
//
//        // put up keyboard
//        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//        // put up keyboard   works?=
//        [gbl_mycitySearchString becomeFirstResponder];  // control textFieldShouldBeginEditing > textFieldDidBeginEditing > back here
//
//    }
//


    // NSString *gbl_fieldTap_leaving; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
    // NSString *gbl_fieldTap_goingto; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
    //
    if (            gbl_myname.isFirstResponder == 1)  gbl_fieldTap_leaving = @"name";
    if (gbl_mycitySearchString.isFirstResponder == 1)  gbl_fieldTap_leaving = @"city"; 
    if (gbl_mybirthinformation.isFirstResponder == 1)  gbl_fieldTap_leaving = @"date";
  NSLog(@"gbl_fieldTap_leaving =%@  tap tap tap ",gbl_fieldTap_leaving );
    [ self checkResponderStuff ];



trn("END OF  textFieldShouldEndEditing (yes) ########################################################################################## ");tn();
    return YES;

} // textFieldShouldEndEditing


// textFieldDidEndEditing:     is called when the text field becomes inactive.
//
- (void)textFieldDidEndEditing: (UITextField *)textField
{
tn();   NSLog(@"in textFieldDidEndEditing ################################################## ");
  NSLog(@"textField.tag=[%ld]",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
  NSLog(@"gbl_myname.text1=[%@]",gbl_myname.text);

    [ self checkResponderStuff ];


//   [self.view endEditing:YES];
    gbl_previousCharTypedWasSpace = 0;                 // for no multiple consecutive spaces

  NSLog(@"gbl_myname.text2=[%@]",gbl_myname.text);
    if (textField.tag == 1) { // name
        gbl_userSpecifiedPersonName = textField.text; // final value in "new person" screen
  NSLog(@"FINAL  gbl_userSpecifiedPersonName =[%@]",gbl_userSpecifiedPersonName );
    }

  NSLog(@"gbl_myname.text3=[%@]",gbl_myname.text);
    if (textField.tag == 2) { // city
        gbl_userSpecifiedCity = gbl_enteredCity; // final value in "new person" screen
        gbl_userSpecifiedProv = gbl_enteredProv; // final value in "new person" screen
        gbl_userSpecifiedCoun = gbl_enteredCoun; // final value in "new person" screen


        if (textField.tag == 2) {                   // see textFieldDidBeginEditing
            gbl_pickerToUse = @"date/time picker";  // "city picker" or "date/time picker"
  NSLog(@"gbl_pickerToUse  33      =[%@]",gbl_pickerToUse          );
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse6=%@",gbl_pickerToUse );
        }
  NSLog(@"gbl_myname.text4=[%@]",gbl_myname.text);

    }
  NSLog(@"gbl_myname.text5=[%@]",gbl_myname.text);

//        gbl_cityPlaceHolderStr = gbl_enteredCity;   // replace gbl_myCitySoFar with full name when finished

  NSLog(@"FINAL  gbl_userSpecifiedCity =[%@]",gbl_userSpecifiedCity );
  NSLog(@"FINAL  gbl_userSpecifiedProv =[%@]",gbl_userSpecifiedProv );
  NSLog(@"FINAL  gbl_userSpecifiedCoun =[%@]",gbl_userSpecifiedCoun );
  NSLog(@"gbl_myname.text5=[%@]",gbl_myname.text);
//  NSLog(@"FINAL  gbl_cityPlaceHolderStr=[%@]",gbl_cityPlaceHolderStr );
    
    // KLUDGE:
    // catch the case where re-entry into date field, where these are all zero
    //
    //    NOTE: this sometimes unnecessarily sets   gbl_fieldTap_goingto = @"date"
    //          when it is not appropriate, but other logic sets it back to the correct field (name or city)
    //    HOWEVER:  when going to the date field, this setting to of gbl_fieldTap_goingto = @"date"
    //              is the only way to get it set correctly (do not see another way)
    //
    if (               gbl_myname.isFirstResponder == 0
        && gbl_mycitySearchString.isFirstResponder == 0
        && gbl_mybirthinformation.isFirstResponder == 0 )
    {

tn();trn("CATCH  CATCH  CATCH  CATCH  CATCH  CATCH  CATCH  CATCH  ");
            gbl_fieldTap_goingto = @"date";
    }

bn(7);    [ self checkResponderStuff ];
trn("END OF  textFieldDidEndEditing ########################################################################################## ");tn();

} // textFieldDidEndEditing


// determine   gbl_firstResponder_previous 
//             gbl_firstResponder_current
// using       gbl_fieldTap_leaving 
//             gbl_fieldTap_goingto
//
- (void) checkResponderStuff 
{
    if ([ gbl_fieldTap_leaving isEqualToString: gbl_fieldTap_goingto ]) {
  NSLog(@"--- 111 -------------------------------------------------------");
  NSLog(@"            gbl_myname.isFirstResponder=%d",gbl_myname.isFirstResponder);
  NSLog(@"gbl_mycitySearchString.isFirstResponder=%d",gbl_mycitySearchString.isFirstResponder);
  NSLog(@"gbl_mybirthinformation.isFirstResponder=%d",gbl_mybirthinformation.isFirstResponder);
  NSLog(@"gbl_fieldTap_leaving  =%@",gbl_fieldTap_leaving );
  NSLog(@"gbl_fieldTap_goingto  =%@",gbl_fieldTap_goingto );
  NSLog(@"gbl_firstResponder_previous  =%@",gbl_firstResponder_previous );
  NSLog(@"gbl_firstResponder_current   =%@",gbl_firstResponder_current  );
  NSLog(@"---------------------------------------------------------------");
        return;
    } else {
          
nb(3);
        // here a user tap causes the current field to change  (leaving and goingto fields are different)
        //
        gbl_firstResponder_previous = gbl_fieldTap_leaving;
        gbl_firstResponder_current  = gbl_fieldTap_goingto;

// qOLD
//        // turn gbl_timerToCheckCityPicklistTrigger  ON and OFF when appropriate
//        //
//        if ([ gbl_firstResponder_current isEqualToString: @"city"]) {  // when entering field "city"
//
//            // turn ON  (self.timerToCheckCityPicklistTrigger is a method to set gbl_timerToCheckCityPicklistTrigger )
//            [ [NSRunLoop mainRunLoop] addTimer: self.timerToCheckCityPicklistTrigger 
//                                       forMode: NSRunLoopCommonModes
//            ];  
//  NSLog(@"TURN ON    timerToCheckCityPicklistTrigger");
//        } else {
//
//            [ gbl_timerToCheckCityPicklistTrigger invalidate ];                       // turn OFF
//             gbl_timerToCheckCityPicklistTrigger = nil;                             // turn OFF
//  NSLog(@"TURN OFF   timerToCheckCityPicklistTrigger  + make nil");
//        }
//


//        } else {
//nb(4);
//            gbl_firstResponder_previous = gbl_firstResponder_current;
//            gbl_firstResponder_current  = gbl_fieldTap_goingto;
//        }


  NSLog(@"--- 222 -- firstResponder Change!!  ---------------------------");
  NSLog(@"            gbl_myname.isFirstResponder=%d",gbl_myname.isFirstResponder);
  NSLog(@"gbl_mycitySearchString.isFirstResponder=%d",gbl_mycitySearchString.isFirstResponder);
  NSLog(@"gbl_mybirthinformation.isFirstResponder=%d",gbl_mybirthinformation.isFirstResponder);
  NSLog(@"gbl_fieldTap_leaving  =%@",gbl_fieldTap_leaving );
  NSLog(@"gbl_fieldTap_goingto  =%@",gbl_fieldTap_goingto );
  NSLog(@"gbl_firstResponder_previous  =%@",gbl_firstResponder_previous );
  NSLog(@"gbl_firstResponder_current   =%@",gbl_firstResponder_current  );
  NSLog(@"---------------------------------------------------------------");

    }

//
//    // make BG color of old     input field = white
//    // make BG color of current input field = highlighted
//    //
//    NSArray *indexPathsToUpdate;
//    NSIndexPath *indexPath_leaving;
//    NSIndexPath *indexPath_goingto;
//
//    indexPath_leaving  = nil;
//    indexPath_goingto  = nil;
//    indexPathsToUpdate = nil;
//
//  NSLog(@"gbl_fieldTap_leaving =[%@]",gbl_fieldTap_leaving );
// 
//    if      (gbl_fieldTap_leaving == nil) {
//nbn(360);
//        ;  // do nothing
//    } else {
//nbn(361);
//        if      ([gbl_fieldTap_leaving isEqualToString: @"name"]) indexPath_leaving = [NSIndexPath indexPathForRow: 1 inSection: 0];
//        else if ([gbl_fieldTap_leaving isEqualToString: @"city"]) indexPath_leaving = [NSIndexPath indexPathForRow: 3 inSection: 0];
//        else if ([gbl_fieldTap_leaving isEqualToString: @"date"]) indexPath_leaving = [NSIndexPath indexPathForRow: 5 inSection: 0];
//  NSLog(@"indexPath_leaving =[%@]",indexPath_leaving );
//
//        if (indexPath_leaving != nil) {
//nbn(362);
//            indexPathsToUpdate = [NSArray arrayWithObjects: indexPath_leaving, nil];
//            [self.tableView beginUpdates];
//            [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
//                                  withRowAnimation: UITableViewRowAnimationNone ];
//            [self.tableView endUpdates];
//        }
//    }
//
//    if      (gbl_fieldTap_goingto == nil) {
//nbn(363);
//        ;  // do nothing
//    } else {
//
//nbn(364);
//        if      ([gbl_fieldTap_goingto isEqualToString: @"name"]) indexPath_goingto = [NSIndexPath indexPathForRow: 1 inSection: 0];
//        else if ([gbl_fieldTap_goingto isEqualToString: @"city"]) indexPath_goingto = [NSIndexPath indexPathForRow: 3 inSection: 0];
//        else if ([gbl_fieldTap_goingto isEqualToString: @"date"]) indexPath_goingto = [NSIndexPath indexPathForRow: 5 inSection: 0];
//  NSLog(@"gbl_fieldTap_goingto =[%@]",gbl_fieldTap_goingto );
//  NSLog(@"indexPath_goingto =[%@]",indexPath_goingto );
//
//        if (indexPath_goingto != nil) {
//nbn(365);
//            indexPathsToUpdate = [NSArray arrayWithObjects: indexPath_goingto, nil];
//            [self.tableView beginUpdates];
//            [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
//                                  withRowAnimation: UITableViewRowAnimationNone ];
//            [self.tableView endUpdates];
//        }
//nbn(366);
//    }
//nbn(367);
//




//    NSArray *indexPathsToUpdate = [NSArray arrayWithObjects: indexPath_leaving, indexPath_goingto, nil];

} //  checkResponderStuff 



// ===============================================================================================================================
// ===============================================================================================================================


// textFieldShouldChangeCharactersInRange: replacementString: is called each time the user types a character on the keyboard.
// In fact, this method is called just before a character is displayed.
// If you are looking to restrict certain characters from a text field, this is the method for you.
// As you can see in our example, we added some logic to disallow the "#" symbol.
//
//    if ([ kbString isEqualToString: @"#"])  return NO;
//    else                                    return YES;
//
- (BOOL)textField: (UITextField *)textField shouldChangeCharactersInRange: (NSRange)    range
                                                        replacementString: (NSString *) arg_typedCharAsNSString
{

    NSLog(@"in textField: shouldChangeCharactersInRange: replacementString: rrrrrrrrr rrrrrrrr rrrrrrrr rrrrrrrr rrrrrrrr rrrrrrrr rrrrrrrr");
//  NSLog(@"=%@", [@"" stringByPaddingToLength:100 withString: @"abc" startingAtIndex:0]);
  NSLog(@"arg_typedCharAsNSString=[%@]",arg_typedCharAsNSString);

  if (arg_typedCharAsNSString.length != 0  && arg_typedCharAsNSString != nil) {
  NSLog(@"in textField: shouldChangeCharactersInRange: replacementString: =%@",
       [@"" stringByPaddingToLength: 20 withString: arg_typedCharAsNSString  startingAtIndex: 0] );
  }

  //  NSLog(@"textField.description=%@",textField.description);
  NSLog(@"textField.tag=%ld",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
  NSLog(@"gbl_myname.text=[%@]",gbl_myname.text);
  NSLog(@"gbl_previousCharTypedWasSpace =%ld",(long)gbl_previousCharTypedWasSpace );


        // this WORKS  for detecting when backspace was pressed:
        // const char *mychar = [arg_typedCharAsNSString cStringUsingEncoding: NSUTF8StringEncoding];
        // int isBackSpace = strcmp(mychar, "\b");
        // if (isBackSpace == -8) {
        //   NSLog(@"HEY!  BACKSPACE  was pressed");
        // }

    
    // set keystrokes and times
    //
//    gbl_typedCharPrev                  = gbl_typedCharCurr;           // for test
//    gbl_typedCharCurr                  = arg_typedCharAsNSString;     // for test

// qOLD
//    gbl_timeOfPrevCityKeystroke        = gbl_timeOfCurrCityKeystroke; // set city keystroke interval times
//    CFTimeInterval myTimeNow           = CACurrentMediaTime();        // returns double CFTimeInterval
//    myTimeNow           = CACurrentMediaTime();        // returns double CFTimeInterval
////    double myTimeNow             = CACurrentMediaTime();        // returns double CFTimeInterval
//    gbl_timeOfCurrCityKeystroke        = myTimeNow;                     // set city keystroke interval times
////        dispatch_async(dispatch_get_main_queue(), ^{        
////        });
//
//


    if (   [arg_typedCharAsNSString isEqualToString: @" " ]
        && (
               [gbl_myname.text isEqualToString: @""  ]     // here first character typed for city is SPACE
            ||  gbl_myname.text == nil                      // here first character typed for city is SPACE
           )
    )
    {
        return NO;
    }


    if (textField.tag == 2 ) {   // CITY 
//          gbl_myCitySoFar =  [NSString stringWithFormat:@"%@%@", textField.text,  arg_typedCharAsNSString ];

        if (gbl_myCitySoFar == nil) {
            gbl_myCitySoFar =  arg_typedCharAsNSString;
        } else {
            gbl_myCitySoFar =  [NSString stringWithFormat:@"%@%@", gbl_myCitySoFar, arg_typedCharAsNSString ]; // APPEND typed char
        }
  NSLog(@"after APPEND typed char, gbl_myCitySoFar=[%@]",gbl_myCitySoFar ); tn();
    }


    NSString *myNotFoundMsg;

    if ( [arg_typedCharAsNSString isEqualToString: @""] )    // backspace
    {
tn(); NSLog(@"HEY!    BACKSPACE     was pressed");
  NSLog(@"gbl_myCitySoFar1=%@",gbl_myCitySoFar);



        // because this is BACKSPACE KEY,  remove final char of arg gbl_myCitySoFar 
        //
        if ( textField.text != nil  &&  textField.text.length != 0 ) {

            if (textField.tag == 2) { // city
//                gbl_myCitySoFar =  textField.text ;
//  NSLog(@"gbl_myCitySoFar2=%@",gbl_myCitySoFar);

                NSInteger tmpIndex = [gbl_myCitySoFar length];                                         // end char out of  gbl_myCitySoFar 
                if (tmpIndex > 0) gbl_myCitySoFar = [gbl_myCitySoFar substringToIndex: tmpIndex - 1];  // end char out of  gbl_myCitySoFar
NSLog(@"=gbl_myCitySoFar %@",gbl_myCitySoFar );

                [self showCityProvCountryForTypedInCity:  gbl_myCitySoFar ];   // and possibly shown button  "Picklist >"

                if (gbl_CITY_NOT_FOUND == YES) {

                    myNotFoundMsg = [NSString stringWithFormat:@"starting with \"%@\"", gbl_myCitySoFar ];

//                    UIAlertView *alert = [[UIAlertView alloc]
//                            initWithTitle: @"No City Found"
//                                  message: myNotFoundMsg 
//                                 delegate: nil
//                        cancelButtonTitle: @"OK"
//                        otherButtonTitles: nil ];
//                    [alert show];
//

                    UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"No City Found"
                                                                                   message: myNotFoundMsg
                                                                            preferredStyle: UIAlertControllerStyleAlert  ];
                     
                    UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                        style: UIAlertActionStyleDefault
                                                                      handler: ^(UIAlertAction * action) {
                            NSLog(@"Ok button pressed");
                        }
                    ];
                     
                    [alert addAction:  okButton];

                    [self presentViewController: alert  animated: YES  completion: nil   ];


                    gbl_CITY_NOT_FOUND = NO;

                    return NO;
                }
            } // city
        }


        if (gbl_myCitySoFar.length == 0) {
            [self setCitySearchStringTitleTo: @"Type City Name" ]; //  update title of keyboard "toolbar"
        } else {
            [self setCitySearchStringTitleTo: gbl_myCitySoFar   ]; //  update title of keyboard "toolbar"
        }

  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
        // update place labels  (has one less char in gbl_myCitySoFar)
        // field updates in cellForRowAtIndexpath
        //
        [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath

//        gbl_timeOfPrevCityKeystroke = gbl_timeOfCurrCityKeystroke; // set city keystroke interval times
//        CFTimeInterval timeNow      = CACurrentMediaTime();  // returns double CFTimeInterval
//        gbl_timeOfCurrCityKeystroke = timeNow;               // set city keystroke interval times

//<.>
//    [self showHide_ButtonToSeePicklist ];
//<.>

        if (textField.tag == 1) { // name
            gbl_editingChangeNAMEHasOccurred = 1;   // default 0 at startup (after hitting "Edit" button on home page)
        }
        if (textField.tag == 2) { // city
            gbl_editingChangeCITYHasOccurred = 1;   // default 0 at startup (after hitting "Edit" button on home page)
        }
        return YES;  // backspace 
    }  // backspace 


    if (textField.tag == 1  &&  gbl_myname.text.length >= gbl_MAX_lengthOfName )     // 15 (applies to Person and Group both)
    {
  NSLog(@"in KB in NAME field");

        NSString *myAlertTitle;
        NSString *myMaxMsg;

        myAlertTitle = [NSString stringWithFormat:@"Maximum %ld Characters", (long)gbl_MAX_lengthOfName ];

//        if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"] ) myMaxMsg =  @"Maximum 15 Characters\nfor Person Name";
        if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"] ) myMaxMsg =  @"for Person Name";
        if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"group"] )  myMaxMsg =  @"for Group Name";

//        UIAlertView *alert = [[UIAlertView alloc]
//                initWithTitle: @"Maximum 15 Characters"
//                      message: myMaxMsg
//                     delegate: nil
//            cancelButtonTitle: @"OK"
//            otherButtonTitles: nil ];
//        [alert show];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Maximum 15 Characters"
                                                                       message: myMaxMsg
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [alert addAction:  okButton];

        [self presentViewController: alert  animated: YES  completion: nil   ];

        
        return NO;
    }

    if (textField.tag == 2  &&  gbl_mycitySearchString.text.length >= gbl_MAX_lengthOfCity ) {   // CITY max 30 char
  NSLog(@"in KB in CITY field");

        NSString *myAlertTitle;
        NSString *myMaxMsg;

        myAlertTitle = [NSString stringWithFormat:@"Maximum %ld Characters", (long)gbl_MAX_lengthOfCity ];
        myMaxMsg     =  @"for Place of Birth";

//        UIAlertView *alert = [[UIAlertView alloc]
//                initWithTitle: myAlertTitle
//                      message: myMaxMsg
//                     delegate: nil
//            cancelButtonTitle: @"OK"
//            otherButtonTitles: nil ];
//        [alert show];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: myAlertTitle
                                                                       message: myMaxMsg
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [alert addAction:  okButton];

        [self presentViewController: alert  animated: YES  completion: nil   ];

        
        return NO;
    }

    if (   [textField.text          isEqualToString: @"" ]
        && [arg_typedCharAsNSString isEqualToString: @" "] )   return NO;   // NO LEADING SPACES


    NSString *allowedCharactersInName = @"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
//    NSString *allowedCharactersInCity = @"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-./()";
    NSString *allowedCharactersInCity = @"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-";


    if (textField.tag == 1 && [allowedCharactersInName rangeOfString: arg_typedCharAsNSString].location == NSNotFound)
    {

        NSLog(@"allowedCharacters does not contain typed char");
        NSString *myMsg5;
        if ( [arg_typedCharAsNSString isEqualToString: @"~"] )  {
            myMsg5 = @"\nABCDEFGHIJKLMNOPQRSTUVWXYZ\nabcdefghijklmnopqrstuvwxyz\n1234567890\n\n( \"~\" is only used for example data )";
        } else {
            myMsg5 =
           [NSString stringWithFormat: @"\nABCDEFGHIJKLMNOPQRSTUVWXYZ\nabcdefghijklmnopqrstuvwxyz\n1234567890\n\nYou typed \"%@\"", 
               arg_typedCharAsNSString ]; 
        }

//        UIAlertView *alert = [[UIAlertView alloc]
//                initWithTitle: @"Characters that can be used\nin Person Name "
//                      message: myMsg5
//                     delegate: nil
//            cancelButtonTitle: @"OK"
//            otherButtonTitles: nil ];
//        [alert show];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Characters that can be used\nin Person Name "
                                                                       message: myMsg5
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [alert addAction:  okButton];

        [self presentViewController: alert  animated: YES  completion: nil   ];
        

        return NO;
    }

    if (textField.tag == 2 && [allowedCharactersInCity rangeOfString: arg_typedCharAsNSString].location == NSNotFound)
    {

        NSLog(@"allowedCharacters does not contain typed char");
        NSString *charNotAllowedMSG = 
           [NSString stringWithFormat: @"\n-abcdefghijklmnopqrstuvwxyz\nABCDEFGHIJKLMNOPQRSTUVWXYZ\n\nYou typed \"%@\"", 
               arg_typedCharAsNSString ]; 

//        UIAlertView *alert = [[UIAlertView alloc]
//                initWithTitle: @"Characters that can be used\nin City Name "
//                      message: charNotAllowedMSG
//                     delegate: nil
//            cancelButtonTitle: @"OK"
//            otherButtonTitles: nil ];
//        [alert show];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Characters that can be used\nin City Name "
                                                                       message: charNotAllowedMSG
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [alert addAction:  okButton];

        [self presentViewController: alert  animated: YES  completion: nil   ];
        
        
        NSInteger tmpIndex = [gbl_myCitySoFar length];                                         // end char out of  gbl_myCitySoFar 
        if (tmpIndex > 0) gbl_myCitySoFar = [gbl_myCitySoFar substringToIndex: tmpIndex - 1];  // end char out of  gbl_myCitySoFar
NSLog(@"after remove last char (bad char) gbl_myCitySoFar=[%@]",gbl_myCitySoFar );
        return NO;
    }

    NSLog(@"GOOD  GOOD   allowedCharacters contains typed char!");

    if (   gbl_previousCharTypedWasSpace == 1   
        && [arg_typedCharAsNSString isEqualToString: @" "] )   return NO;   // NO MULTIPLE CONSECUTIVE SPACES

    if ( ! [arg_typedCharAsNSString isEqualToString: @" "] )  {
        gbl_previousCharTypedWasSpace = 0;
    } else {
        gbl_previousCharTypedWasSpace = 1;
    }
//  NSLog(@"  #3 gbl_previousCharTypedWasSpace =%ld",gbl_previousCharTypedWasSpace );



    if (textField.tag == 2)  // city
    {

//
////      gbl_myCitySoFar =  [NSString stringWithFormat:@"%@%@", textField.text, arg_typedCharAsNSString ];  // add typed char to gbl_myCitySoFar
////        gbl_myCitySoFar =  [NSString stringWithFormat:@"%@%@", gbl_myCitySoFar, arg_typedCharAsNSString ];
//            if (gbl_myCitySoFar == nil) {
//                gbl_myCitySoFar =  arg_typedCharAsNSString;
//            } else {
//                gbl_myCitySoFar =  [NSString stringWithFormat:@"%@%@", gbl_myCitySoFar, arg_typedCharAsNSString ];
//            }
//nbn(702); NSLog(@"=gbl_myCitySoFar %@",gbl_myCitySoFar );
//


  NSLog(@"in CITY field, so show latest city/prov/coun  ");
        [self showCityProvCountryForTypedInCity:  gbl_myCitySoFar ];   // and possibly shown button  "Picklist >"

        if (gbl_CITY_NOT_FOUND == YES) {



            myNotFoundMsg = [NSString stringWithFormat:@"starting with \"%@\"", gbl_myCitySoFar ];
//            UIAlertView *alert = [[UIAlertView alloc]
//                    initWithTitle: @"No City Found"
//                          message: myNotFoundMsg 
//                         delegate: nil
//                cancelButtonTitle: @"OK"
//                otherButtonTitles: nil ];
//            [alert show];
//
            UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"No City Found"
                                                                           message: myNotFoundMsg
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
             
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
                NSLog(@"Ok button pressed");
            } ];
             
            [alert addAction:  okButton];

            [self presentViewController: alert  animated: YES  completion: nil   ];
        

            gbl_CITY_NOT_FOUND = NO;


  NSLog(@"textField.text =%@",textField.text );
  NSLog(@"gbl_myCitySoFar =%@",gbl_myCitySoFar );
//        gbl_myCitySoFar =  textField.text ;

        NSInteger tmpIndex = [gbl_myCitySoFar length];                                         // end char out of  gbl_myCitySoFar 
        if (tmpIndex > 0) gbl_myCitySoFar = [gbl_myCitySoFar substringToIndex: tmpIndex - 1];  // end char out of  gbl_myCitySoFar
NSLog(@"after remove last char (not found) gbl_myCitySoFar=[%@]",gbl_myCitySoFar );

            return NO;
        }



        //  update title of keyboard "toolbar"
        //

//        gbl_searchStringTitle.title = gbl_myCitySoFar; 
    [self setCitySearchStringTitleTo: gbl_myCitySoFar ];

        // update city label field  update field in cellForRowAtIndexpath
        //
        [ self updateCityProvCoun ]; // update city/prov/couon field  in cellForRowAtIndexpath

    }  // is city field

  NSLog(@"----- END OF  shouldChangeCharactersInRange  -----"); tn();


    if (textField.tag == 1) { // name
        gbl_editingChangeNAMEHasOccurred = 1;   // default 0 at startup (after hitting "Edit" button on home page)
    }
    if (textField.tag == 2) { // city
        gbl_editingChangeCITYHasOccurred = 1;   // default 0 at startup (after hitting "Edit" button on home page)
    }
    if (gbl_editingChangeNAMEHasOccurred  == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{        
            gbl_myname.textColor                = [UIColor blackColor];
        });
    }



    return YES; // default accept typed char

} // shouldChangeCharactersInRange


// ===============================================================================================================================


// textFieldShouldClear: is called when the user presses the clear button, the gray "x," inside the text field.
// Before the active text field is cleared, this method gives you an opportunity to make any needed customizations.
//

- (BOOL)textFieldShouldClear: (UITextField *)textField{
  NSLog(@"in textFieldShouldClear:");
  NSLog(@"textField.tag=[%ld]",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);

    return YES;
}
- (BOOL)textFieldDidClear: (UITextField *)textField{
  NSLog(@"in textFieldDIDClear:");
  NSLog(@"textField.tag=[%ld]",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);

    return YES;
}

//- (void)clearSearchTextField
//{
//  NSLog(@"in clearSearchTextField   !!!!!!!!!!");
//}


// textFieldShouldReturn: is called when the user presses the return key on the keyboard.
// In the example, we find out which text field is active by looking at the tag property.
// If the "Username" text field is active, the next text field, "Password," should become active instead.
// If the "Password" text field is active, "Password" should resign, resigning the keyboard with it.
//
//    NSLog(@"textFieldShouldReturn:");
//    if (textField.tag == 1) {
//        UITextField *passwordTextField = (UITextField *)[self.view viewWithTag: 2];
//        [passwordTextField becomeFirstResponder];
//    }
//    else {
//        [textField resignFirstResponder];
//    }
//    return YES;
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;   // called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;  // called when 'return' key pressed. return NO to ignore.
//
- (BOOL)textFieldShouldReturn: (UITextField *)textField
{

NSLog(@"in textFieldShouldReturn:");
  NSLog(@"textField.tag=[%ld]",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);

//    if (textField.tag == 1) {  // tag = 1 = Name
//
//        [gbl_myname resignFirstResponder];  // control goes to textFieldShouldEndEditing then textFieldDidEndEditing then comes back here
//  NSLog(@"--tfsr----- VASSIGN gbl_myname             RESIGN!FIRST_RESPONDER ---------------- " );
//
////        UITextField *myCityOfBirthInputField = (UITextField *)[self.view viewWithTag: 2];
////        [myCityOfBirthInputField becomeFirstResponder];
//    }
//    if (textField.tag == 2) {  // tag = 1 = city of birth
//
//    }
//
//    return YES;
//

//    return  NO;

    [textField resignFirstResponder];
    return  YES;

} //  textFieldShouldReturn



//- (BOOL)textFieldShouldReturn:(UITextField *)textField {    
//    NSLog(@"in textFieldShouldReturn");
//
//
//return YES;
//}
//



//
////  dismiss the keyboard simply by tapping on the screen.
////
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesBegan:withEvent:");
//    [self.view endEditing:YES];
//    [super touchesBegan:touches withEvent:event];
//}
//
//

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  NSLog(@"cellForRowAtIndexPath !");
  NSLog(@"in cellForRowAtIndexPath!!!    indexPath.row =%ld",(long)indexPath.row );

    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];

    // Configure the cell...

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"AddChangeCellIDentifier";
    


    // check to see if we can reuse a cell from a row that has just rolled off the screen
    // if there are no cells to be reused, create a new cell
    // 
    // ADDITION:  create subviews only once
    // 
    // 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


//    UIColor *currentBGfieldColor;

//    UIFont *myFont = [UIFont fontWithName: @"Menlo" size: 12.0];
//    UIFont *myFont         = [UIFont fontWithName: @"Menlo" size: 16.0];
//    UIFont *myFontMiddle   = [UIFont fontWithName: @"Menlo" size: 14.0];

    UIFont *myFontMiddle   = [UIFont fontWithName: @"Menlo" size: 18.0];

//    UIFont *myFontSmaller1 = [UIFont fontWithName: @"Menlo" size: 13.0];
//    UIFont *myFontSmaller2 = [UIFont fontWithName: @"Menlo" size: 12.5];

//    UIFont *myFontSmaller2 = [UIFont fontWithName: @"Menlo" size: 16.0];
//    UIFont *myFontSmaller2 = [UIFont fontWithName: @"Menlo" size: 15.0];
//    UIFont *myFontSmaller2 = [UIFont fontWithName: @"Menlo" size: 14.0];
    UIFont *myFontSmaller2 = [UIFont fontWithName: @"Menlo" size: 16.0];

    // invisible button for taking away the disclosure indicator
    //
    UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [UIButton buttonWithType: UIButtonTypeCustom];
    myInvisibleButton.backgroundColor = gbl_colorEditingBG_current;  //   [UIColor clearColor];

   
     if (indexPath.row == 0) {   //  filler row 0
nbn(200);
        dispatch_async(dispatch_get_main_queue(), ^{        
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
        });
     }

     if (indexPath.row == 1) {   //  NAME of Person or Group
//nbn(2011);
//  NSLog(@"gbl_fieldTap_goingto =[%@]",gbl_fieldTap_goingto );
  NSLog(@"name row    gbl_myname.text =[%@]",gbl_myname.text );

        gbl_myname.delegate = self;

// arcane
//        // set current BG editing color  depending on what field has focus
//        //
//        if      ([gbl_fieldTap_goingto isEqualToString: @"name"]) { currentBGfieldColor = gbl_bgColor_editFocus_YES; }
//        else                                                      { currentBGfieldColor = gbl_bgColor_editFocus_NO ; }


        dispatch_async(dispatch_get_main_queue(), ^{        

//            cell.textLabel.backgroundColor           = gbl_colorEditing;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;

//            gbl_myname.placeholder              = @"Name";
//            [gbl_myname setValue: [UIColor colorWithRed: 064.0/255.0    // use KVC
//                                                  green: 064.0/255.0
//                                                   blue: 064.0/255.0
//                                                  alpha: 1.0         ]
//                      forKeyPath: @"_placeholderLabel.textColor"];



            gbl_myname.autocorrectionType       = UITextAutocorrectionTypeNo;
//            gbl_myname.clearButtonMode          = UITextFieldViewModeWhileEditing ;
//            gbl_myname.keyboardType             = UIKeyboardTypeNamePhonePad; // optimized for entering a person's name or phone number
// UIKeyboardTypeASCIICapable   disables emoji keyboard
            gbl_myname.keyboardType             = UIKeyboardTypeASCIICapable; // disables emoji keyboard


//            gbl_myname.backgroundColor          = gbl_colorEditing;
//            gbl_myname.backgroundColor          = [UIColor yellowColor];
            gbl_myname.backgroundColor          = gbl_colorEditingBGforInputField;
//            gbl_myname.backgroundColor          = currentBGfieldColor;

//            if (   [gbl_myname.text isEqualToString: @"" ] 
//                ||  gbl_myname.text == nil 
//                || [gbl_myname.text isEqualToString: gbl_myname.text ]   xx wrong xxx

            if (   [gbl_myname.text isEqualToString: gbl_initPromptName ] 
                &&  gbl_editingChangeNAMEHasOccurred == 0                  // default 0 at startup (after hitting "Edit" button on home page)
            ) {
                gbl_myname.text                     = gbl_initPromptName ; // is  @"Name"

//            gbl_myname.placeholder              = @"Name";
//            gbl_myname.placeholder              = gbl_initPromptName ;  // is  @"Name"
nbn(700);

//            [gbl_myname setValue: [UIColor colorWithRed: 128.0/255.0    // use KVC
//                                                  green: 128.0/255.0
//                                                   blue: 128.0/255.0
//                                                  alpha: 1.0         ]
//                      forKeyPath: @"_placeholderLabel.textColor"];

//                gbl_myname.textColor                = [UIColor grayColor];

                gbl_myname.textColor                = [UIColor colorWithRed: 128.0/255.0    // use KVC
                                                                      green: 128.0/255.0
                                                                       blue: 128.0/255.0
                                                                      alpha: 1.0         ] ;
            } else {
                gbl_myname.textColor                = [UIColor blackColor];
            }


//            gbl_myname.font                     = myFont;
            gbl_myname.font                     = myFontMiddle;
            gbl_myname.borderStyle              = UITextBorderStyleRoundedRect;
            gbl_myname.textAlignment            = NSTextAlignmentLeft;
            gbl_myname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            gbl_myname.tag                      = 1;
            gbl_myname.autocapitalizationType   = UITextAutocapitalizationTypeNone;

    gbl_myname.inputAccessoryView = gbl_ToolbarForPersonName ; // for person name input field
  NSLog(@"gbl_myname.inputAccessoryView 01 SET SET SET SET SET SET SET SET SET  SET ");


            [cell addSubview: gbl_myname ];
        });
     } //  NAME





//     if (indexPath.row == 2) {   //  filler 
//nbn(202);
//        dispatch_async(dispatch_get_main_queue(), ^{        
//            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
//            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
//            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
//        });
//     }
//





     if (indexPath.row == 3) {   // "LABEL" for  city,proc,coun  of Birth of Person
nb(203);
  NSLog(@"city row   gbl_fieldTap_goingto =[%@]",gbl_fieldTap_goingto );


//        myTextCity = [NSString stringWithFormat:@"%@\n%@\n%@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
//        myTextCity = [NSString stringWithFormat:@" %@\025|%@\025 %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
//        myTextCity = [NSString stringWithFormat:@" %@\n                        z%@            \n %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
        NSString *myTextCity;
        myTextCity = [NSString stringWithFormat:@" %@\n %@\n %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];


//        myTextCity = [NSString stringWithFormat:@" %@qqqy%@qqq %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
//        NSMutableString *myMutCity = [myTextCity mutableCopy];
//    //                // replace '_' from pair names with ' '    (underscore only in cell in tableview)
//    //                [curr_cellPersonAname replaceOccurrencesOfString: @"_"
//    //                                                      withString: @" "
//    //                                                         options: 0
//    //                                                           range: NSMakeRange(0, curr_cellPersonAname.length)
//    //                ];
//    [myMutCity replaceOccurrencesOfString: @"qqq"
//    withString: @"\n"
//    options: 0
//    range: NSMakeRange(0, myMutCity.length)
//    ];
//    myTextCity = myMutCity;
//

//        // set current BG editing color  depending on what field has focus
//        //
//        if      ([gbl_fieldTap_goingto isEqualToString: @"city"]) { currentBGfieldColor = gbl_bgColor_editFocus_YES; }
//        else                                                      { currentBGfieldColor = gbl_bgColor_editFocus_NO ; }



//        UIColor *borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
//        UIColor *borderColor =  [UIColor lightGrayColor];  // too dark
        UIColor *borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];

        gbl_mycityprovcounLabel.layer.borderColor  = borderColor.CGColor;
        gbl_mycityprovcounLabel.layer.borderWidth  = 1.0;
        gbl_mycityprovcounLabel.layer.cornerRadius = 5.0;
//        gbl_mycityprovcounLabel .clipsToBounds = YES;

        // If you want the clear button to be always visible,
        // then you need to set the text field's clearButtonMode property to UITextFieldViewModeAlways. 

        NSString *exceptionalSearchStr = [NSString stringWithFormat:@" %@",
            gbl_initPromptCity  // is  gbl_initPromptCity  (@"Birth City or Town")  with LEADING SPACE  with LEADING SPACE
        ];


        dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line

            cell.userInteractionEnabled         = YES;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
//            cell.contentView.backgroundColor    = currentBGfieldColor;

            gbl_mycityprovcounLabel.text             = myTextCity;

  NSLog(@"[gbl_mycityprovcounLabel.text =[%@]",gbl_mycityprovcounLabel.text );
  NSLog(@"gbl_initPromptCity =[%@]",gbl_initPromptCity );
//            if ([gbl_mycityprovcounLabel.text hasPrefix: gbl_initPromptCity ] )  // is  @"Birth City or Town"
            if ([gbl_mycityprovcounLabel.text hasPrefix: exceptionalSearchStr ] )
            {
nbn(23);
                gbl_mycityprovcounLabel.textColor    = [UIColor grayColor];
//                gbl_mycityprovcounLabel.textColor    = gbl_colorPlaceHolderPrompt; // gray   too dark
            } else {
nbn(24);
                gbl_mycityprovcounLabel.textColor    = [UIColor blackColor];
            }


            gbl_mycityprovcounLabel.numberOfLines    = 0;

            gbl_mycityprovcounLabel.tag              = 2;
//            gbl_mycityprovcounLabel.font             = myFontSmaller1;
            gbl_mycityprovcounLabel.font             = myFontSmaller2;
            gbl_mycityprovcounLabel.textAlignment    = NSTextAlignmentLeft;
//            gbl_mycityprovcounLabel.backgroundColor  = gbl_colorEditingBG;
//            gbl_mycityprovcounLabel.backgroundColor  = [UIColor whiteColor];
            gbl_mycityprovcounLabel.backgroundColor  =  gbl_colorEditingBGforInputField;
//            gbl_mybirthinformation.backgroundColor          = currentBGfieldColor;

            // If you want the clear button to be always visible,
            // then you need to set the text field's clearButtonMode property to UITextFieldViewModeAlways. 
//            gbl_mycityprovcounLabel.clearButtonMode  = UITextFieldViewModeAlways;
//           gbl_mycitySearchString.clearButtonMode  = UITextFieldViewModeAlways;

            [cell addSubview: gbl_mycityprovcounLabel ];

        });
     } // row = 2   "LABEL" for  city,proc,coun  of Birth of Person


     if (indexPath.row == 4) {   //  filler 
nb(204);
        dispatch_async(dispatch_get_main_queue(), ^{        
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
        });
     }





     if (indexPath.row == 5) {   // "LABEl" for  time of birth information
nb(205);
  NSLog(@"date row                            DRAWING        CELL  having LABEl for  DATE/time of birth ");
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse9        =%@",gbl_pickerToUse );


    // right here,  determine if last field tapped is gbl_mybirthinformation field, if so become firstResponder to putup date picker
    // 
    if ([gbl_lastInputFieldTapped isEqualToString: @"date"]) {

tn();trn("DATE field was drawn  hey   hey   hey   hey   hey   hey   hey   ");
        //
        // All UIResponder objects have an inputView property.
        // The inputView of a UIResponder is the view that will be shown in place of the keyboard
        // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
        //


        [gbl_mybirthinformation becomeFirstResponder]; 
  NSLog(@"-didsel5--- VASSIGN gbl_mybirthinformation BECOME_FIRST_RESPONDER ---------------- " );

//    self.pickerViewDateTime.hidden     =  NO; 
//    gbl_mybirthinformation.hidden = NO;
    }



//        // set current BG editing color  depending on what field has focus
//        //
//        if      ([gbl_fieldTap_goingto isEqualToString: @"date"]) { currentBGfieldColor = gbl_bgColor_editFocus_YES; }
//        else                                                      { currentBGfieldColor = gbl_bgColor_editFocus_NO ; }



        NSString *myBirthTimeInformation;
//        myBirthTimeInformation = @"Date of Birth" ;
//        myBirthTimeInformation = @"Birth Date and Time" ;
        myBirthTimeInformation = gbl_initPromptDate ;  // is @"Birth Date and Time" 


//        gbl_mybirthinformation.inputView = [self pickerView] ;
        gbl_mybirthinformation.inputView = [self pickerViewDateTime] ;

        gbl_mybirthinformation.inputAccessoryView =  gbl_ToolbarForBirthDate;
  NSLog(@"gbl_mybirthinformation.inputAccessoryView 02 SET SET SET SET SET SET SET SET SET  SET ");

        // err was: ios child view controller:   should have parent view controller:  but requested parent is:
        // e.g.
        //mTextField.inputView = mInputVeiw;
        //[mInputVeiw removeFromSuperview];
        //[mTextField becomeFirstResponder];
//        [ [self pickerViewDateTime] removeFromSuperview];
//        [gbl_mybirthinformation becomeFirstResponder];


  NSLog(@"gbl_selectedBirthInfo=%@",gbl_selectedBirthInfo);

        dispatch_async(dispatch_get_main_queue(), ^{        

//            cell.textLabel.backgroundColor           = gbl_colorEditing;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
            
            cell.userInteractionEnabled         = YES;
//            cell.userInteractionEnabled         = NO;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;

//            gbl_mybirthinformation.placeholder              = myBirthTimeInformation;
//            [gbl_mybirthinformation setValue: [UIColor colorWithRed: 064.0/255.0    // use KVC
//                                                  green: 064.0/255.0
//                                                   blue: 064.0/255.0
//                                                  alpha: 1.0         ]
//                      forKeyPath: @"_placeholderLabel.textColor"];

//            [gbl_mybirthinformation setValue: [UIColor colorWithRed: 128.0/255.0    // use KVC
//                                                  green: 128.0/255.0
//                                                   blue: 128.0/255.0
//                                                  alpha: 1.0         ]
//                      forKeyPath: @"_placeholderLabel.textColor"];

            gbl_mybirthinformation.autocorrectionType       = UITextAutocorrectionTypeNo;
//            gbl_mybirthinformation.clearButtonMode          = UITextFieldViewModeWhileEditing ;
//            gbl_mybirthinformation.clearButtonMode          = UITextFieldViewModeAlways ;
//            gbl_mybirthinformation.keyboardType             = UIKeyboardTypeNamePhonePad; // optimized for entering a person's name or phone number

//            gbl_mybirthinformation.backgroundColor          = gbl_colorEditing;
//            gbl_mybirthinformation.backgroundColor          = [UIColor yellowColor];
              gbl_mybirthinformation.backgroundColor = gbl_colorEditingBGforInputField;


//  NSLog(@"addChangeViewJustEntered =[%ld]",(long)addChangeViewJustEntered );
//            if ( addChangeViewJustEntered == 1) {
//                addChangeViewJustEntered               = 0;
//                gbl_mybirthinformation.backgroundColor = gbl_colorEditingBGforInputField;
//            } else {
//                gbl_mybirthinformation.backgroundColor = [UIColor yellowColor];
//            }
//

//            gbl_mybirthinformation.backgroundColor          = [UIColor yellowColor];

//            gbl_mybirthinformation.backgroundColor          = currentBGfieldColor;
//            gbl_mybirthinformation.textColor                = [UIColor blackColor];
//            gbl_mybirthinformation.textColor                = [UIColor grayColor];
//            gbl_mybirthinformation.font                     = myFont;
            gbl_mybirthinformation.font                     = myFontMiddle;
            gbl_mybirthinformation.borderStyle              = UITextBorderStyleRoundedRect;
            gbl_mybirthinformation.textAlignment            = NSTextAlignmentLeft;

            gbl_mybirthinformation.text                     = gbl_selectedBirthInfo;

            if ([gbl_mybirthinformation.text isEqualToString: gbl_initPromptDate ] )  // is @"Birth Date and Time" 
            {
                gbl_mybirthinformation.textColor                = [UIColor grayColor];
            } else {
                gbl_mybirthinformation.textColor                = [UIColor blackColor];
            }
            gbl_mybirthinformation.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//            gbl_mybirthinformation.tag                      = 6;
            gbl_mybirthinformation.tag                      = 3;
            gbl_mybirthinformation.autocapitalizationType   = UITextAutocapitalizationTypeNone;


            [cell addSubview: gbl_mybirthinformation ];
        });

        // reload  cell having display of birth info selected so far 
        //
//        NSIndexPath *indexPathBirthInfoLabel = [NSIndexPath indexPathForRow: 5 inSection: 0];
//        NSIndexPath *indexPathBirthInfoLabel = [NSIndexPath indexPathForRow: 9 inSection: 0];
        NSIndexPath *indexPathBirthInfoLabel = [NSIndexPath indexPathForRow: 5 inSection: 0];

            // update display of selected date
            //

            [self.tableView beginUpdates];
    //        [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
            [self.tableView reloadRowsAtIndexPaths:  @[ indexPathBirthInfoLabel ]
                                  withRowAnimation: UITableViewRowAnimationFade ];
//                                  withRowAnimation: UITableViewRowAnimationNone ];
//                                  withRowAnimation: UITableViewRowAnimationRight ];
            [self.tableView endUpdates];



     } // BIRTH INFORMATION


     if (indexPath.row == 2) {   // data entry for  City of Birth of Person  THIS is HIDDEN and stuck in rownum=2 for scrollRectToVisible use
nbn(206);
  NSLog(@"data entry for  City of Birth of Person!");

        gbl_mycitySearchString.delegate = self;

        dispatch_async(dispatch_get_main_queue(), ^{            // <===  short line and long line

//            cell.textLabel.backgroundColor           = gbl_colorEditing;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;


//            gbl_mycitySearchString.placeholder              = @"City of Birth";
//
//  NSLog(@"gbl_cityPlaceHolderStr=%@",gbl_cityPlaceHolderStr);
//            gbl_mycitySearchString.placeholder              = gbl_cityPlaceHolderStr;

//            gbl_mycitySearchString.text              = gbl_cityPlaceHolderStr;



//            [gbl_mycitySearchString setValue: [UIColor colorWithRed: 064.0/255.0    // use KVC
//                                                  green: 064.0/255.0
//                                                   blue: 064.0/255.0
//                                                  alpha: 1.0         ]
//                      forKeyPath: @"_placeholderLabel.textColor"];

            gbl_mycitySearchString.autocorrectionType       = UITextAutocorrectionTypeNo;

//            gbl_mycitySearchString.clearButtonMode          = UITextFieldViewModeWhileEditing ;
//            gbl_mycitySearchString.clearButtonMode          = UITextFieldViewModeAlways;

//            [self.view addSubview:rightField];
//            [gbl_mycitySearchString addSubview: rightView];

//            gbl_mycitySearchString.keyboardType    = UIKeyboardTypeNamePhonePad; // optimized for entering a person's name or phone number
//            gbl_mycitySearchString.keyboardType    = UIKeyboardTypeNumbersAndPunctuation; // NO
//            gbl_mycitySearchString.keyboardType    = UIKeyboardTypeTwitter; 
//            gbl_mycitySearchString.keyboardType    = UIKeyboardTypeAlphabet
//            gbl_mycitySearchString.keyboardType      = UIKeyboardTypeDefault;
            gbl_mycitySearchString.keyboardType      = UIKeyboardTypeASCIICapable; // disables emoji keyboard

//            gbl_mycitySearchString.backgroundColor          = gbl_colorEditing;
//            gbl_mycitySearchString.backgroundColor          = [UIColor yellowColor];
            gbl_mycitySearchString.backgroundColor          = gbl_colorEditingBGforInputField;
            gbl_mycitySearchString.textColor                = [UIColor blackColor];

//            gbl_mycitySearchString.font                     = myFont;
//            gbl_mycitySearchString.font                     = myFontSmaller;
            gbl_mycitySearchString.font                     = myFontMiddle;

            gbl_mycitySearchString.borderStyle              = UITextBorderStyleRoundedRect;
            gbl_mycitySearchString.textAlignment            = NSTextAlignmentLeft;
            gbl_mycitySearchString.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            gbl_mycitySearchString.tag                    = 2;  // no   USE TAG for gbl_mycityprovcounLabel because that's where people tap
            gbl_mycitySearchString.autocapitalizationType   = UITextAutocapitalizationTypeNone;

            [cell addSubview: gbl_mycitySearchString ];

// out        gbl_mycitySearchLabel.text = @"Search";
//            gbl_mycitySearchLabel.font = myFontSmaller2;
//            [cell addSubview: gbl_mycitySearchLabel ];
//

        });

//  NSLog(@"cell.textLabel.text =%@",cell.textLabel.text );
//  NSLog(@"cell.textLabel.attributedText =%@",cell.textLabel.attributedText );

     } //  CITY SEARCH string



//   textfield fields
//UITextField *passwordTextField = [[UITextField alloc] initWithFrame:passwordTextFieldFrame];
//passwordTextField.placeholder = @"Password";
//passwordTextField.backgroundColor = [UIColor whiteColor];
//passwordTextField.textColor = [UIColor blackColor];
//passwordTextField.font = [UIFont systemFontOfSize:14.0f];
//passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
//passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//passwordTextField.returnKeyType = UIReturnKeyDone;
//passwordTextField.textAlignment = UITextAlignmentLeft;
//passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//passwordTextField.tag = 2;
//passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//[self.view addSubview:passwordTextField];
//
//

nbn(299);
    return cell;

} // cellForRowAtIndexPath



// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // -------------------------
{
//  NSLog(@"in heightForRowAtIndexPath 1");
//     if (indexPath.row == 0)     //  filler row 0
//     if (indexPath.row == 1)     //  NAME of Person or Group
//     if (indexPath.row == 2)     //  filler 
//     if (indexPath.row == 3)     // "LABEL" for  city,proc,coun  of Birth of Person
//     if (indexPath.row == 4)     //  filler 
//     if (indexPath.row == 5)     // "LABEl" for  time of birth information
//     if (indexPath.row == 6)     // data entry for  City of Birth of Person
//
   
   if (indexPath.row == 0) return  8;  // fill

//   if (indexPath.row == 1) return 40;  // name 
   if (indexPath.row == 1) return 50;  // name 

   if (indexPath.row == 2) return 16;  // fill

//   if (indexPath.row == 3) return 60;  // "LABEL" for  city,proc,coun  of Birth of Person
   if (indexPath.row == 3) return 80;  // "LABEL" for  city,proc,coun  of Birth of Person
   if (indexPath.row == 4) return  8;  // fill

//   if (indexPath.row == 5) return 40;  // "LABEl" for  time of birth information
   if (indexPath.row == 5) return 50;  // "LABEl" for  time of birth information

   if (indexPath.row == 6) return 40;  // city seach field   ?

    return 32.0;

}  // ---------------------------------------------------------------------------------------------------------------------



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
tn();    NSLog(@"in didSelectRowAtIndexPath!  in AddChange !!");
NSLog(@"indexPath.row =%ld",(long)indexPath.row );
    
  NSLog(@"gbl_currentMenuPlusReportCode=%@", gbl_currentMenuPlusReportCode);

    // this is the "currently" selected row now
//    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];   was unused
    

    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
//tn();trn("hightlight ON");
//    [self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
//                                animated:NO
//                          scrollPosition:UITableViewScrollPositionNone];
//    [self.tableView scrollToNearestSelectedRowAtScrollPosition: currentlyselectedIndexPath.row
//                                                      animated: NO];
    
    // now you can use cell.textLabel.text



    if (indexPath.row == 3 ) {  // LABEL for city,coun,prov    CITY  CITY  CITY  CITY  CITY  CITY  CITY  CITY CITY  CITY


//        [myCityOfBirthInputField becomeFirstResponder];


//UIToolbar * keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//keyboardToolBar.barStyle = UIBarStyleBlackTranslucent;

//        UIBarButtonItem *gbl_searchStringTitle = [[UIBarButtonItem alloc]initWithTitle: @"Type City Name"
//                                                                  // style: UIBarButtonItemStylePlain
//                                                                   style: UIBarButtonItemStyleBordered
//                                                                  target: self
//                                                                  action: nil ];
//
//
// qOLD
//
////        UIBarButtonItem *myButtonCancelTypeCity = [[UIBarButtonItem alloc]initWithTitle: @"Cancel"
//          gbl_cityPickerCancelButton = [[UIBarButtonItem alloc]initWithTitle: @"Cancel"
//                                                                       style: UIBarButtonItemStyleBordered
//                                                                      target: self
//                                                                      action: @selector( onCancelInputCity: )
//        ];
//


       // try multiple inputView toolbars
       // 
       //  For Keyboard inputView  "Clear"        tor     "Picklist >"  (hidden or not hidden depends on num cities <= 25)
       //  For Picklist inputView  "< Keyboard"   tor   
       // 
       // 
//nbn(120);
//  NSLog(@"gbl_mycityInputView =[%@]",gbl_mycityInputView );
//       [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"



//    if ( [ arg_toolbarToUse isEqualToString: @"keyboard" ] ) {
//        gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityKeyboard;
//        
//        if ( [ arg_showPicklistButton == YES ] ) {
//            [[self.view viewWithTag: gbl_tag_cityInputKeyboardRightButton ] setHidden:  YES ];
//        } else {
//            [[self.view viewWithTag: gbl_tag_cityInputKeyboardRightButton ] setHidden:  NO ];
//        }
//
//        gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityKeyboard;
//    }  // put up keyboard city inputView toolbar
//





        // put APPROPRIATE  inputview   KEYBOARD   or   CITY PICKER
        //
nbn(121); trn("kdkdkdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");



//nbn(122); trn("kdkdkdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//        if ([gbl_mycityInputView isEqualToString: @"picker"])   {     // = "keyboard" or "picker", default is KB
//            gbl_mycitySearchString.inputView = [self pickerViewCity] ; 
//nbn(123); trn("kdkdkdkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//        }
//        if ([gbl_mycityInputView isEqualToString: @"keyboard"]) {     // = "keyboard" or "picker", default is KB
//            if (gbl_myCitySoFar != nil  &&  gbl_myCitySoFar.length > 0 ) {
//                gbl_searchStringTitle.title = gbl_myCitySoFar;
//            }
//        }
//

// qOLD
        // when entering city fld (didSelect row= 3), check title, set inputview accordingly
        //
//  NSLog(@"DANGER checking searchStringTitle !!");   // use  gbl_mycityInputView = "picker" instead ??
//        if (   [gbl_searchStringTitle.title isEqualToString: @"Pick City" ] )  // DANGER this never is true 20150828
        if ( [ gbl_mycityInputView  isEqualToString: @"picker" ] )
        {   // show city picker
nbn(123);
            dispatch_async(dispatch_get_main_queue(), ^{        

                [gbl_myname             resignFirstResponder];
  NSLog(@"-didsel3a-- VASSIGN gbl_myname             RESIGN!FIRST_RESPONDER ---------------- " );
                [gbl_mybirthinformation resignFirstResponder]; 
  NSLog(@"-didsel3a-- VASSIGN gbl_mybirthinformation RESIGN!FIRST_RESPONDER ---------------- " );
                [gbl_mycitySearchString resignFirstResponder]; // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
  NSLog(@"-didsel3a-- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER ---------------- " );

//                gbl_mycitySearchString.inputView = nil ;   // necessary ?

                self.pickerViewCity.hidden       =  NO;

                //
                // All UIResponder objects have an inputView property.
                // The inputView of a UIResponder is the view that will be shown in place of the keyboard
                // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
                //
     //  ?? switch  becomefirst  and inputview=  ???
                [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
  NSLog(@"-didsel3a-- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );

  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];

                gbl_mycitySearchString.inputView = [self pickerViewCity] ; 

  NSLog(@"-didsel 1-- VASSIGN gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);

                [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do no show old data
                [self.pickerViewCity selectRow: 0   inComponent: 0 animated: YES];
            });

//            [self putUpCancelButtonOrNot  ];

  NSLog(@"UP  22   UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP   ");

        } else { // show city KB


nbn(124);
  NSLog(@"=SHOW Keyboard in did sel row  3");
  NSLog(@"gbl_myCitySoFar =%@",gbl_myCitySoFar );

            dispatch_async(dispatch_get_main_queue(), ^{        
                [gbl_myname             resignFirstResponder];
  NSLog(@"-didsel3b-- VASSIGN gbl_myname             RESIGN!FIRST_RESPONDER ---------------- " );
                [gbl_mybirthinformation resignFirstResponder]; 
  NSLog(@"-didsel3b-- VASSIGN gbl_mybirthinformation RESIGN!FIRST_RESPONDER ---------------- " );
                [gbl_mycitySearchString resignFirstResponder]; // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
  NSLog(@"-didsel3b-- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER ---------------- " );


                // gbl_mycitySearchString.inputView = nil ;   // necessary ?   note: with this in, no keyboard appears

//  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];
//  NSLog(@"-didsel 2-- VASSIGN gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);
                self.pickerViewCity.hidden       =  NO;


  NSLog(@"gbl_mycityInputView =[%@]",gbl_mycityInputView );

  gbltmpstr = [gbl_mycitySearchString.inputAccessoryView.description substringToIndex: 15];
                [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"
  NSLog(@"-didsel 2b-- VASSIGN gbl_mycitySearchString.inputAccessoryView.description --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputAccessoryView.description substringToIndex: 15]);

                //
                // All UIResponder objects have an inputView property.
                // The inputView of a UIResponder is the view that will be shown in place of the keyboard
                // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
                //
     //  ?? switch  becomefirst  and inputview=  ???
                [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
  NSLog(@"-didsel3b-- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );
//                gbl_mycitySearchString.inputView = [self pickerViewCity] ; 



                // if city name char-typing is ongoing set title to  gbl_myCitySoFar
                //
//                if (gbl_myCitySoFar != nil  &&  gbl_myCitySoFar.length > 0) gbl_searchStringTitle.title = gbl_myCitySoFar;
//                else                                                        gbl_searchStringTitle.title = @"Type City Name";

                if (gbl_myCitySoFar != nil  &&  gbl_myCitySoFar.length > 0) {
                    [self setCitySearchStringTitleTo: gbl_myCitySoFar ];
                } else {
                    [self setCitySearchStringTitleTo: @"Type City Name" ];
                }

            });
        } // show kb


        // if current orientation is landscape, shift field into view
        //
        //  typedef enum : NSInteger {
        //     UIInterfaceOrientationUnknown            = UIDeviceOrientationUnknown,
        //     UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait,
        //     UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
        //     UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight,
        //     UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft 
        //  } UIInterfaceOrientation;
        //
        NSInteger myOrientation = [UIApplication sharedApplication].statusBarOrientation;
  NSLog(@"myOrientation =%ld", (long)myOrientation );
        if (   myOrientation == UIInterfaceOrientationLandscapeLeft      
            || myOrientation == UIInterfaceOrientationLandscapeRight  
        ) {
            dispatch_async(dispatch_get_main_queue(), ^{        
                [self.tableView setContentOffset: CGPointMake(-44,0) animated:YES];
            });
        }
    
    } // row == 3

} // didSelectRowAtIndexPath


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSLog(@"in canEditRowAtIndexPath!");
//  NSLog(@"indexPath.row =%ld",indexPath.row );

//
//    // Return NO if you do not want the specified item to be editable.
//    if (indexPath.row == 5 ) return  NO;
//    else                     return YES;
//

    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


//
////- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
////    if ([segue.identifier isEqualToString:@"alarmSegue"]) {
////
////
////        CATransition transition = [CATransition animation];
////        transition.duration = 0.5;
////        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
////        transition.type = kCATransitionPush;
////        transition.subtype = direction;
////        [self.view.layer addAnimation:transition forKey:kCATransition];
////
////        tab2ViewController *destViewController = segue.destinationViewController;
////        UIView *destView = destViewController.view;
////        destViewController.selectionName = @"alarms";
////
////        [sender setEnabled:NO];
////
////         }
////     }
////}
////
//
//
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
////
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//
//    if ([segue.identifier isEqualToString:@"seguehomeToAddChange"]) {
//
//        CATransition *myTransition = [CATransition animation];
//        myTransition.duration = 0.5;
//        myTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        myTransition.type = kCATransitionPush;
////        myTransition.subtype = direction;
//        myTransition.subtype = kCATransitionFromBottom;
//  NSLog(@"myTransition=%@",myTransition);
//
////        [self.view.layer addAnimation:myTransition forKey: kCATransition];
////        [self.view.layer addAnimation:myTransition forKey: @"myTransition"];
////        [self.view.layer addAnimation:myTransition forKey: kCATransitionFromBottom];
////        [self.view.layer addAnimation:myTransition forKey: kCATransitionPush];
//
////        tab2ViewController *destViewController = segue.destinationViewController;
////        UIView *destView = destViewController.view;
////        destViewController.selectionName = @"alarms";
//
//
//
////   UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
////   UIViewController *destinationController = (UIViewController*)[self destinationViewController];                    
//
//    // Get the new view controller using [segue destinationViewController]
//
//   UIViewController *sourceViewController  =  [segue sourceViewController];
//   UIViewController *destinationController =  [segue destinationViewController];
//  NSLog(@"sourceViewController  =%@",sourceViewController  );
//  NSLog(@"destinationController =%@",destinationController );
//    [sourceViewController.navigationController.view.layer addAnimation: myTransition
//                                                                forKey: kCATransition];
////    [sourceViewController.navigationController pushViewController: destinationController animated: NO];    
//     
//
//        [sender setEnabled:NO];
//
//    }
//
//} // end of prepareForSegue
//
//


// this is called for every valid keyboard keystroke in city field
//
//    ALWAYS     shows first city starting with typed sofar (in 3 city fields)
//    SOMETIMES  unhides inputview toolbar  right button "Picklist >"
//
- (void) showCityProvCountryForTypedInCity: (NSString *) arg_citySoFar  {  // either first one in 3 labels or picklist uitable
   
  NSLog(@"in showCityProvCountryForTypedInCity !!");
  NSLog(@"arg_citySoFar  =[%@]",arg_citySoFar  );


    const char *arg_cityBeginsWith_CONST;                                                  // NSString object arg_citySoFar  to C str
    char        arg_cityBeginsWith[128];                                                   // NSString object to C str
    arg_cityBeginsWith_CONST = [arg_citySoFar  cStringUsingEncoding:NSUTF8StringEncoding]; // NSString object to C str
    strcpy(arg_cityBeginsWith, arg_cityBeginsWith_CONST);                                  // NSString object to C str  // because of const
ksn(arg_cityBeginsWith);

    int idx_into_placetab;


    // search cities for typed in so far
    //
    gbl_fewEnoughCitiesToMakePicklist = 0;  

//    idx_into_placetab = bin_find_first_city( arg_cityBeginsWith);  // **********  ==========   GET CITY,prov,coun
//kin(idx_into_placetab);


    //  RETURN VALUE is
    //     1. index that is lowest_hit_so_far IF there are too many cities for picklist (numCitiesToGetPicklist)
    //     2. -1  IF no city  starts with arg "city_begins_with"
    //     3. -2  IF there are few enough cities to make a picklist
    //  also returns num cities found
    //  also returns array of chars holding city,prov,coun PSVs
    //
tn();
trn("bin_find_first_city  IN showCityProvCountryForTypedInCity ");
  NSLog(@"    ( determine whether or  not to show   Right Button  \"Picklist >\"  )");
    idx_into_placetab = bin_find_first_city(  // **********  ==========   GET CITY,prov,coun
        arg_cityBeginsWith,
        gbl_numCitiesToTriggerPicklist,  // is type  int
        &num_PSVs_found,                 // is type  int  (0-based index to last string)
        city_prov_coun_PSVs              // array of chars holding fixed length "strings"
    );
kin(idx_into_placetab);
kin(num_PSVs_found);

    if (       idx_into_placetab == -1) {  // city not found beginning with string  arg_citySoFar  

        gbl_CITY_NOT_FOUND = 1;
        return;

    } else if (idx_into_placetab == -2) {  // -2  IF there are few enough cities to make a picklist

        gbl_fewEnoughCitiesToMakePicklist = 1;
        gbl_pickerToUse                   = @"city picker";
  NSLog(@"gbl_pickerToUse  44      =[%@]",gbl_pickerToUse          );

  NSLog(@"  5  SHOW   Right Button  \"Picklist >\"  )");

//        gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityKeyboardHavingPicklist;
//        [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"

        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here

//    gbl_mycitySearchString.inputAccessoryView = nil;  // necessary  ?
//    gbl_mycitySearchString.inputView          = nil ; // necessary  ?
//    gbl_mycitySearchString.inputAccessoryView = nil;  // necessary  ?

        [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"


        [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here


//        gbl_searchStringTitle.title = gbl_myCitySoFar;           //  update title of keyboard "toolbar"
          [self setCitySearchStringTitleTo: gbl_myCitySoFar ];

//        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//        [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here

        // update city label field  update field in cellForRowAtIndexpath
        //
        [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath

// ?      gbl_searchStringTitle.title = gbl_myCitySoFar;           //  update title of keyboard "toolbar"
        [self setCitySearchStringTitleTo: gbl_myCitySoFar ];


//<.>

//  NSLog(@"CALL  putUpCityPicklist    in showCityProvCountryForTypedInCity  !!");
//        [ self putUpCityPicklist ];


        // -2  means this keystroke satisfies criterion to put up a city picklist
        //     (the number of cities found is <= gbl_numCitiesToTriggerPicklist)
        //  
        //    DO NOT suddenly put up city picklist right after keystroke  (too jarring).
        //    We want to put up a picklist here BUT not to interrupt user typing valid city characters 
        //  
        //    Therefore enforce a waiting period of gbl_secondsPauseInCityKeyStrokesToTriggerPicklist 
        //    between now and the last keystroke


        // BUT  only if the user pauses typing for  gbl_secondsPauseInCityKeyStrokesToTriggerPicklist seconds 
        // while user is typing search string for City
        //
        //
        // BUT do NOT put up picklist here if the last 2 keystrokes were like this:
        //     prev  keystroke was not eligible to put up picklist
        //     curr  keystroke  IS     eligible to put up picklist
        //     The idea is to allow user to continue typing valid keystrokes without
        //     being interrupted by picklist suddenly without pause.


// qOLD
//
////    gbl_secondsSinceLastCityKeyStroke = [timeRightNow  timeIntervalSinceDate: gbl_timeOfCurrCityKeystroke ];
//tn();trn("CHECKDIFF CHECKDIFF CHECKDIFF CHECKDIFF CHECKDIFF   gbl_intervalBetweenLast2Keystrokes ");
//  NSLog(@"check check    gbl_intervalBetweenLast2Keystrokes=%g",gbl_intervalBetweenLast2Keystrokes);
//  NSLog(@"gbl_typedCharPrev=[%@]  gbl_typedCharCurr=[%@]",gbl_typedCharPrev, gbl_typedCharCurr);
//
//
//        if ( gbl_intervalBetweenLast2Keystrokes > gbl_secondsPauseInCityKeyStrokesToTriggerPicklist )   // checkdiff - put up city picklist
//        {
//            [ self putUpCityPicklist ];
//        }
//


//Since 1 second = 1000ms, [NSDate timeIntervalSinceDate:foo] * 1000 should be milliseconds. –  esqew Jul 22 '11 at 22:58


// e.g.
// #import "MyViewController.h"
// 
// @interface MyViewController ()
// 
// @property (strong, nonatomic) NSTimer *timer;
// 
// @end
// 
// @implementation MyViewController
// 
// double timerInterval = 1.0f;
// 
// - (NSTimer *) timer {
//     if (!_timer) {
//         _timer = [NSTimer timerWithTimeInterval:timerInterval target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
//     }
//     return _timer;
// }
// 
// - (void)viewDidLoad
// {
//     [super viewDidLoad];
// 
//     [[NSRunLoop mainRunLoop] addTimer: self.timer forMode: NSRunLoopCommonModes];
// }
// 
// -(void)onTick:(NSTimer*)timer
// {
//     NSLog(@"Tick...");
// }
// 
// @end
//


nbn(555);

        

    } // else { // show latest city,prov,coun  beginning with city chars typed so far
//    }


    int idx_of_first_city_found;
    if (idx_into_placetab == -2 ) {
  NSLog(@"  when idx_into_placetab = -2, get idx of 1st city found  )");
        // **********  ==========   GET CITY,prov,coun
        idx_of_first_city_found = bin_find_first_city1 ( arg_cityBeginsWith );  // note "1" at end
    } else {
        idx_of_first_city_found = idx_into_placetab;
    }

  NSLog(@" show latest city,prov,coun  beginning with city chars typed so far");
    char myCityName [64];
    strcpy(myCityName, gbl_placetab[idx_of_first_city_found].my_city); 
    NSString *myLatestCity =  [NSString stringWithUTF8String: myCityName ];  // convert c string to NSString
    gbl_enteredCity = myLatestCity ;

    char myProvName [64];
    strcpy(myProvName, array_prov[gbl_placetab[idx_of_first_city_found].idx_prov]); 
    NSString *myLatestProv =  [NSString stringWithUTF8String: myProvName];  // convert c string to NSString
    gbl_enteredProv = myLatestProv ;

    char myCounName [64];
    strcpy(myCounName, array_coun[gbl_placetab[idx_of_first_city_found].idx_coun]); 
    NSString *myLatestCoun =  [NSString stringWithUTF8String: myCounName];  // convert c string to NSString
    gbl_enteredCoun = myLatestCoun ;


    [self showHide_ButtonToSeePicklist ];


// NSString *myLatestCity =  [NSString stringWithUTF8String: gbl_placetab[idx_of_first_city_found]->my_city ];  // convert c string to NSString
  NSLog(@"gbl_enteredCity =%@",gbl_enteredCity );
  NSLog(@"gbl_enteredProv =%@",gbl_enteredProv );
  NSLog(@"gbl_enteredCoun =%@",gbl_enteredCoun );

} // showCityProvCountryForTypedInCity

//
//// ?? when to invalidate ?? 
//// ?? when to add ??   viewWillAppear ?
//- (NSTimer *) timerToCheckCityPicklistTrigger {   // ? set in viewWillAppear
//  NSLog(@"CREATING   timerToCheckCityPicklistTrigger");
//
//    if (! gbl_timerToCheckCityPicklistTrigger) {
//  NSLog(@"CREATING2  timerToCheckCityPicklistTrigger");
//
//        // gbl_frequencyOfCheckingCityPicklistTrigger = 0.5; // 0.5  max wait = 2.5 when stop typing and picklist OK
//
////        dispatch_async(dispatch_get_main_queue(), ^{        // invalidate on same Q
//            gbl_timerToCheckCityPicklistTrigger = [
//               NSTimer timerWithTimeInterval: gbl_frequencyOfCheckingCityPicklistTrigger 
////               NSTimer scheduledTimerWithTimeInterval: gbl_frequencyOfCheckingCityPicklistTrigger 
//                                      target: self
//                                    selector: @selector(checkCityPicklistTriggerEvery: )
//                                    userInfo: nil
//                                     repeats: YES
//            ];
////        });
//    }
//    return gbl_timerToCheckCityPicklistTrigger;
//}
//
//

- (void)viewWillDisappear:(BOOL)animated {
     NSLog(@"in viewWillDisappear in  addChange   ! !");

    [super viewWillDisappear:animated];

//    segEntityOutlet.backgroundColor = [UIColor whiteColor];

// now doing this when field changes
//  NSLog(@"INVALIDATING  timerToCheckCityPicklistTrigger");
//    [ gbl_timerToCheckCityPicklistTrigger invalidate ];


} // viewWillDisappear


// qOLD
//
//// this checker is called 
////     after every gbl_checkCityPicklistTriggerEvery  seconds (from timer gbl_timerToCheckCityPicklistTrigger)
////            use         current time                - gbl_timeOfCurrCityKeystroke to get interval since last keystroke
////            instead of  gbl_timeOfCurrCityKeystroke - gbl_timeOfPrevCityKeystroke 
////
//-(void)checkCityPicklistTriggerEvery: (NSTimer*)argTimer
//{
//    NSLog(@"   in checkCityPicklistTriggerEvery    0.5 seconds are up now  ... ");
////  NSLog(@"gbl_firstResponder_current =%@",gbl_firstResponder_current );
////  NSLog(@"gbl_mycityInputView =%@",gbl_mycityInputView );
////  NSLog(@"gbl_fewEnoughCitiesToMakePicklist =%ld",gbl_fewEnoughCitiesToMakePicklist );
////  NSLog(@"gbl_justCancelledOutOfCityPicker =%ld",gbl_justCancelledOutOfCityPicker );
////  NSLog(@"gbl_mycityInputView=%@",gbl_mycityInputView);
////  NSLog(@"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
////
//
//    if (  gbl_firstResponder_current == nil )                      {
//trn(" NO PICKLIST PUT UP   NO NO NO   (gbl_firstResponder_current  = nil)");
//        return;
//    }
//    if ([ gbl_firstResponder_current isEqualToString: @"name"] )   {
//trn(" NO PICKLIST PUT UP   NO NO NO   (are in name field)");
//        return;
//    }
//    if ([ gbl_firstResponder_current isEqualToString: @"date"] )   {
//trn(" NO PICKLIST PUT UP   NO NO NO   (are in date field)");
//        return;
//    }
//    if (  gbl_fewEnoughCitiesToMakePicklist == 0)                  {
//trn(" NO PICKLIST PUT UP   NO NO NO   (too many cities)");
//        return;
//    }
////    if ([ gbl_mycityInputView isEqualToString: @"keyboard"] )      return;
////    if (  gbl_justCancelledOutOfCityPicker == 1)                   {
////nbn(85);trn(" NO PICKLIST PUT UP   NO NO NO");
////        return;
////    }
//    if (  gbl_mycityInputView == nil)                              {
//trn(" NO PICKLIST PUT UP   NO NO NO   (gbl_mycityInputView  = nil)");
//        return;
//    }
//
//
//
//    CFTimeInterval timeRightNow       = CACurrentMediaTime();  // returns double CFTimeInterval
//    gbl_secondsSinceCurrCityKeyStroke = timeRightNow - gbl_timeOfCurrCityKeystroke;  // CALC
//
////  NSLog(@"=====  SET INTERVAL2 ================== gbl_secondsSinceCurrCityKeyStroke =%g",gbl_secondsSinceCurrCityKeyStroke );
////  NSLog(@"gbl_typedCharPrev=[%@]  gbl_typedCharCurr=[%@]",gbl_typedCharPrev, gbl_typedCharCurr);
////  NSLog(@"============================================================");
////tn();trn("CHECKDIFF CHECKDIFF CHECKDIFF CHECKDIFF CHECKDIFF   gbl_secondsSinceCurrCityKeyStroke ");
////  NSLog(@"check  check      gbl_secondsSinceCurrCityKeyStroke =%g",gbl_secondsSinceCurrCityKeyStroke );
////  NSLog(@"gbl_typedCharPrev=[%@]  gbl_typedCharCurr=[%@]",gbl_typedCharPrev, gbl_typedCharCurr);
//
//    if (gbl_secondsSinceCurrCityKeyStroke > gbl_secondsPauseInCityKeyStrokesToTriggerPicklist) { // checkdiff - put up city picklist
//
//        // if city picker is not up now, then put it up
//        //
//        if (! [ gbl_mycityInputView isEqualToString: @"picker" ] ) {
//;     // = "keyboard" or "picker" (purpose is to reflect which one it is- not assigned)
//trn("    PICKLIST PUT UP   YES YES YES");
//            [ self putUpCityPicklist ];
//        } else {
//trn(" NO PICKLIST PUT UP   NO NO NO   (city picklist is up already)");
//        }
//    }
//
//
//} // checkCityPicklistTriggerEvery
//



- (void) setCitySearchStringTitleTo: (NSString *) arg_toolbar_title 
{
tn(); NSLog(@"=in setCitySearchStringTitleTo");
  NSLog(@"arg_toolbar_title VNEW CitySearchStringTitleTo =[%@]",arg_toolbar_title  );

    if ( [ gbl_mycityInputView isEqualToString: @"picker" ] ) {  // (gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityPicklist;)

        gbl_title_cityPicklist.title = arg_toolbar_title;

    }

    if ( [ gbl_mycityInputView isEqualToString: @"keyboard" ] ) {
        
//        if ( gbl_fewEnoughCitiesToMakePicklist == 1 ) {
//            gbl_title_cityKeyboardHavingPicklist.title = arg_toolbar_title;  // (gbl_ToolbarForCityKeyboardHavingPicklist)
//        } else {
//            gbl_title_cityKeyboardWithNoPicklist.title = arg_toolbar_title;  // (gbl_ToolbarForCityKeyboardWithNoPicklist)
//        }
        gbl_title_cityKeyboard.title = arg_toolbar_title;  // (gbl_ToolbarForCityKeyboardHavingPicklist)
    }

} // setCitySearchStringTitleTo



// SET inputAccessoryView for CITY:     gbl_mycitySearchString.inputAccessoryView
//
////  For Keyboard inputView  "Clear"        tor     "Picklist >"  (hidden or not hidden depends on num cities <= 25)
////  For Picklist inputView  "< Keyboard"   tor   
//// 
- (void)setCityInputAccessoryViewFor : (NSString *) arg_toolbarToUse   // arg is "keyboard" or "picker" (gbl_mycityInputView)
{
tn(); NSLog(@"=in setCityInputAccessoryViewFor ");
  NSLog(@"arg_toolbarToUse  =[%@]",arg_toolbarToUse  );
  NSLog(@"gbl_fewEnoughCitiesToMakePicklist =[%ld]",(long)gbl_fewEnoughCitiesToMakePicklist );

//inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//nbn(38);
//    gbl_mycitySearchString.inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
 

// A  gbl_mycitySearchString.inputAccessoryView = nil;  // necessary  ?
// A  [gbl_mycitySearchString reloadInputViews];

//   [ gbl_mycitySearchString.inputAccessoryView removeConstraints: [gbl_mycitySearchString.inputAccessoryView constraints]];
//[textView reloadInputViews];
//[gbl_mycitySearchString reloadInputViews];



//  gbltmpstr = [gbl_mycitySearchString.inputAccessoryView.description substringToIndex: 15];
  gbltmpstr = gbl_mycitySearchString.inputAccessoryView.description;

//    gbl_mycitySearchString.inputAccessoryView = nil;  // necessary  ?
//    gbl_mycitySearchString.inputView          = nil ; // necessary  ?

    if ( [ arg_toolbarToUse isEqualToString: @"picker" ] ) {
nbn(39);
        gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityPicklist;
  NSLog(@"gbl_mycitySearchString.inputAccessoryView 03 SET  picker  SET SET SET SET SET SET SET SET  SET ");

    }  // put up picker city inputView toolbar


    if ( [ arg_toolbarToUse isEqualToString: @"keyboard" ] ) {
nbn(40);
        
//        if ( gbl_fewEnoughCitiesToMakePicklist == 1 ) {
//nbn(41);
//            gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityKeyboardHavingPicklist;
////        gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityPicklist;
//        } else {
//            gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityKeyboardWithNoPicklist;
//nbn(42);
//        }
//nbn(43);

        gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityKeyboard;
  NSLog(@"gbl_mycitySearchString.inputAccessoryView 04 SET  keyboard  SET SET SET SET SET SET SET SET  SET ");

  NSLog(@"-setCityInputAccessoryViewFor -- VASSIGN gbl_mycitySearchString.inputAccessoryView.description --- old=[%@]  new=[%@] ---", gbltmpstr,
   gbl_mycitySearchString.inputAccessoryView.description  );
//  [ gbl_mycitySearchString.inputAccessoryView.description substringToIndex: 15]

    [self showHide_ButtonToSeePicklist ];


    }  // put up keyboard city inputView toolbar


//    [gbl_mycitySearchString.inputAccessoryView removeConstraints: [gbl_mycitySearchString.inputAccessoryView constraints]];
// B  [gbl_mycitySearchString reloadInputViews];

//    [gbl_mycitySearchString reloadInputViews];

} // setCityInputAccessoryViewFor 



- (void)putUpCityPicklist   
{
tn();  NSLog(@"in putUpCityPicklist !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

  gbltmpstr = gbl_mycityInputView;
    gbl_mycityInputView = @"picker";     // = "keyboard" or "picker"

  if (! [ gbl_mycityInputView isEqualToString: gbltmpstr ] ) {
    NSLog(@"-putup fn-- VASSIGN gbl_mycityInputView ---------------- old=[%@]  new=[%@] ---", gbltmpstr, gbl_mycityInputView );
  }

//  NSLog(@"gbl_currentCityPicklistIsForTypedSoFar =%@",gbl_currentCityPicklistIsForTypedSoFar );
//  NSLog(@"gbl_myCitySoFar                        =%@",gbl_myCitySoFar );
//    if ([ gbl_currentCityPicklistIsForTypedSoFar isEqualToString: gbl_myCitySoFar ] )   return;   // picker up already for this typed so far
//                                                                                                  // like "toron"  or "toro"

    gbl_currentCityPicklistIsForTypedSoFar = gbl_myCitySoFar;   // picker up already for this typed so far

    gbl_mycitySearchString.text = gbl_myCitySoFar;

//NSLog(@"gbl_mycitySearchString.text=%@",gbl_mycitySearchString.text );


    // gbl_mybirthinformation.inputView = [self pickerViewDateTime] ;  picker for date/time

  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];
    dispatch_async(dispatch_get_main_queue(), ^{        

        // order matters   resign/become

        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here

        self.pickerViewCity.hidden           =  NO;
//        gbl_mycitySearchString.inputView = nil;  // ?? needed ??


        gbl_mycitySearchString.inputView = [self pickerViewCity] ; 


// assume title was set elsewhere  ?  ok?
//  gbltmpstr = gbl_searchStringTitle.title;
//        gbl_searchStringTitle.title = @"Pick City"; // are in uipickerview input
//  NSLog(@"--in up pkr VASSIGN gbl_searchStringTitle.title  --- old=[%@]  new=[%@] ---", gbltmpstr, gbl_searchStringTitle.title );


        //
        // All UIResponder objects have an inputView property.
        // The inputView of a UIResponder is the view that will be shown in place of the keyboard
        // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
        //
        [gbl_mycitySearchString becomeFirstResponder];  
//        gbl_mycitySearchString.inputView = [self pickerViewCity] ; 

    });  // dispatch_async

    // show FIRST city,prov,coun  in picklist in the label for city/prov/coun
    //
    [ self getCurrentCityProvCounForRownum: 0 ]; // populates gbl_enteredCity, Prov, Coun
    [ self updateCityProvCoun ];                 // update city/prov/couon field  in cellForRowAtIndexpath

    
    [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do no show old data
    [self.pickerViewCity selectRow: 0   inComponent: 0 animated: YES];
    
  NSLog(@"--putup fn- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER ---------------- " );
  NSLog(@"--putup fn- VASSIGN6gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);
  NSLog(@"--putup fn- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );

  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];
   gbl_mycitySearchString.inputView = [self pickerViewCity] ; 
  NSLog(@"--putup fn- VASSIGN21gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);


        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
  NSLog(@"--putup fn- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER #2 ! ----------- " );
        [gbl_mycitySearchString becomeFirstResponder];  
  NSLog(@"--putup fn- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER #2 ! ----------- " );


  NSLog(@"UP  33   UP6 UP7 UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP   ");

//    [self putUpCancelButtonOrNot  ];

  NSLog(@"end of  putUpCityPicklist !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");tn();

} // putUpCityPicklist    


// uses these
//            gbl_enteredCity 
//            gbl_enteredProv
//            gbl_enteredCoun
// to do update in cell rownum = 2
//
    //typedef enum {
    //   UITableViewRowAnimationFade,
    //   UITableViewRowAnimationRight,
    //   UITableViewRowAnimationLeft,
    //   UITableViewRowAnimationTop,
    //   UITableViewRowAnimationBottom,
    //   UITableViewRowAnimationNone,
    //   UITableViewRowAnimationMiddle,
    //   UITableViewRowAnimationAutomatic = 100
    //} UITableViewRowAnimation;
    //
- (void)updateCityProvCoun
{
  NSLog(@"in updateCityProvCoun");
    // update city,prov,coun label fields

    // update city label field  update field in cellForRowAtIndexpath
    //
            //  myTextCity = [NSString stringWithFormat:@" %@\n %@\n %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
//            gbl_enteredCity = gbl_initPromptCity;
//            gbl_enteredProv = gbl_initPromptProv;
//            gbl_enteredCoun = gbl_initPromptCoun;

    NSIndexPath *indexPathLabelCityProvCoun = [NSIndexPath indexPathForRow: 3 inSection: 0];

    NSArray *indexPathsToUpdate = [NSArray arrayWithObjects: indexPathLabelCityProvCoun, nil];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
                          withRowAnimation: UITableViewRowAnimationNone ];
    [self.tableView endUpdates];

} // end of updateCityProvCoun


//
//- (void) putUpCancelButtonOrNot  // put up if gbl_firstResponder_current = "city" and gbl_mycityInputView = "keyboard"
//{
//  NSLog(@"in putUpCancelButtonOrNot !");
//  NSLog(@"gbl_firstResponder_current =[%@]",gbl_firstResponder_current );
//  NSLog(@"gbl_mycityInputView        =[%@]",gbl_mycityInputView        );
//
//// qOLD
//////    NSArray *items = [myToolbar items];
////    NSArray *items = [gbl_ToolbarForCityInputView items];
////    NSInteger doneAlready = 0;   // MAGIC - want to affect 1st item (Cancel button - show or hide)
////
////    if (   [ gbl_firstResponder_current isEqualToString: @"city"] 
////        && [ gbl_mycityInputView        isEqualToString: @"keyboard"] 
////    ) { 
////  NSLog(@"HIDE   Cancel Button");
////        for (UIBarButtonItem *myBarButton in items) {
////           //do something with button
////            if (doneAlready == 0) {
////                doneAlready = 1;
////                myBarButton.enabled   = NO;
////                myBarButton.tintColor = [UIColor clearColor];
////            }
////        }
////    } else {
////  NSLog(@"PUT UP Cancel Button");
////        for (UIBarButtonItem *myBarButton in items) {
////            if (doneAlready == 0) {
////                doneAlready = 1;
////                myBarButton.enabled   = YES;
////                myBarButton.tintColor = nil;
////            }
////        }
////    }
////
//}   // end of putUpCancelButtonOrNot
//




// --------------------------------------------------------------------------------------------------------------
// ----------------------------------   UIPickerView stuff ------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------
#pragma mark -  @protocol UIPickerViewDataSource   @required

// returns the number of 'columns' to display
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([ gbl_pickerToUse isEqualToString: @"date/time picker"] ) {  // "city picker" or "date/time picker"
        return 8;  // 0 yyyy  1-mth  2-dd  3-spacer  4-hr  5-colon  6-min  7-am/pm
    }


    if ([ gbl_pickerToUse isEqualToString: @"city picker"     ] ) {  // "city picker" or "date/time picker"
        return 1;
    }

    return 1;  // should not happen

} // numberOfComponentsInPickerView


// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{

    if ([ gbl_pickerToUse isEqualToString: @"date/time picker"] ) {  // "city picker" or "date/time picker"

    //  NSLog(@"in PICKER  numberOfRowsInComponent !!");
    //  NSLog(@"component=%ld",component);
    //  NSLog(@" array_BirthYearsToPick.count =%ld@",self.array_BirthYearsToPick.count);
    //  NSLog(@" self.array_Months.count      =%ld", self.array_Months.count);
    //  NSLog(@" self.array_DaysOfMonth.count;=%ld", self.array_DaysOfMonth.count);
    //  NSLog(@" self.array_Hours_1_12.count  =%ld", self.array_Hours_1_12.count);
    //  NSLog(@" self.array_Min_0_59.count    =%ld", self.array_Min_0_59.count);
    //  NSLog(@" self.array_AM_PM.count       =%ld", self.array_AM_PM.count);
    //



        if (component == 0) return self.array_BirthYearsToPick.count;
        if (component == 1) return self.array_Months.count;
        if (component == 2) return self.array_DaysOfMonth.count;
        if (component == 3) return 1; // spacer
        if (component == 4) return self.array_Hours_1_12.count;
        if (component == 5) return 1; // colon
        if (component == 6) return self.array_Min_0_59.count;
        if (component == 7) return self.array_AM_PM.count;
    //    if (component == 3) return self.array_Hours_1_12.count;
    //    if (component == 4) return self.array_Min_0_59.count;
    //    if (component == 5) return self.array_AM_PM.count;
        
        return 0;
  NSLog(@"self.array_BirthYearsToPick.count;=%lu",(unsigned long)self.array_BirthYearsToPick.count);
    }


    if ([ gbl_pickerToUse isEqualToString: @"city picker"     ] ) {  // "city picker" or "date/time picker"
//        &num_PSVs_found,                 // is type  int  (0-based index to last string)
//        city_prov_coun_PSVs              // array of chars holding fixed length "strings"
//        if (component == 0) return num_PSVs_found + 1;
        if (component == 0) return num_PSVs_found;
    }

    return 1;  // should not happen

} // numberOfRowsInComponent    picker


#pragma mark -   @end of  @protocol UIPickerViewDataSource   @required




#pragma mark -  @protocol UIPickerViewDelegate   @optional

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
// forComponent:(NSInteger)component reusingView:(UIView *)view {
//
//        UILabel *retval = (UILabel*)view;
//        if (!retval) {
//            retval = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
//        }
//
//        retval.font = [UIFont systemFontOfSize:22];
//
//        if (component==kNumComponent)
//            retval.text = Number[row];
//        else if(component==kSeaComponent)
//            retval.text = Season[row];
//        else
//            retval.text = Course[row];
//
//        return retval;
//}
//

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row
                                                   forComponent: (NSInteger)component
{
    NSString *titleForRowRetval;
    titleForRowRetval =  @"component not 0,1,2,4,6 or 7";

trn("in titleForRow in pickerview BIRTH !");
NSLog(@"      row=%ld",(long)row);
NSLog(@"component=%ld",(long)component);

//            [self.pickerViewDateTime selectRow: myIndex inComponent: 0 animated: YES]; // This is how you manually SET(!!) a selection!
//            [self.pickerViewDateTime selectRow:       0 inComponent: 1 animated: YES]; // mth  = jan
//            [self.pickerViewDateTime selectRow:       0 inComponent: 2 animated: YES]; // day  = 01
//            // 3 = spacer
//            [self.pickerViewDateTime selectRow:      11 inComponent: 4 animated: YES]; // hr   = 12
//            // 5 = colon
//            [self.pickerViewDateTime selectRow:       1 inComponent: 6 animated: YES]; // min  = 01   2nd one
//            [self.pickerViewDateTime selectRow:       1 inComponent: 7 animated: YES]; // ampm = 12   2nd one
    // return 6;  // 0 yyyy  1 mth  2 dd  3 hr  4 min  5 am/pm
    if (component == 0)  titleForRowRetval = [self.array_BirthYearsToPick objectAtIndex: row];
    if (component == 1)  titleForRowRetval = [self.array_Months      objectAtIndex: row];
    if (component == 2)  titleForRowRetval = [self.array_DaysOfMonth objectAtIndex: row];

    if (component == 4)  titleForRowRetval = [self.array_Hours_1_12  objectAtIndex: row];

    if (component == 6)  titleForRowRetval = [self.array_Min_0_59    objectAtIndex: row];
    if (component == 7)  titleForRowRetval = [self.array_AM_PM       objectAtIndex: row];

NSLog(@"RETURN titleForRowRetval=%@",titleForRowRetval);
    return titleForRowRetval;

} // titleForRow



//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *titleForRowRetval;
//    titleForRowRetval =  @"component not 0,1,2,3,4 or 5";
//
//trn("in attributedTitleForRow in pickerview BIRTH !");
//NSLog(@"      row=%ld",(long)row);
//NSLog(@"component=%ld",(long)component);
//
//    // return 6;  // 0 yyyy  1 mth  2 dd  3 hr  4 min  5 am/pm
//    if (component == 0)  titleForRowRetval = [self.array_BirthYearsToPick objectAtIndex: row];
//    if (component == 1)  titleForRowRetval = [self.array_Months      objectAtIndex: row];
//    if (component == 2)  titleForRowRetval = [self.array_DaysOfMonth objectAtIndex: row];
//    if (component == 3)  titleForRowRetval = [self.array_Hours_1_12  objectAtIndex: row];
//    if (component == 4)  titleForRowRetval = [self.array_Min_0_59    objectAtIndex: row];
//    if (component == 5)  titleForRowRetval = [self.array_AM_PM       objectAtIndex: row];
//
////    UIFont *font = [UIFont systemFontOfSize: 22];
//    UIFont *font1 = [UIFont systemFontOfSize: 10];
//    NSDictionary *myAttributes = @{NSFontAttributeName:font1 };
//
//    return [[NSAttributedString alloc] initWithString: titleForRowRetval attributes: myAttributes];
//}
//


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow: (NSInteger)row
                                                forComponent: (NSInteger)component
                                                 reusingView: (UIView *) arg_view
{
//  NSLog(@"in viewForRow !!  in PICKER ");
  NSLog(@"in viewForRow !!  in PICKER    row=%ld",(long)row);
  NSLog(@"gbl_pickerToUse=[%@]",gbl_pickerToUse);

    // NSString *gbl_fieldTap_leaving; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
    // NSString *gbl_fieldTap_goingto; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
    //
    if (            gbl_myname.isFirstResponder == 1)  gbl_fieldTap_goingto = @"name";
    if (gbl_mycitySearchString.isFirstResponder == 1)  gbl_fieldTap_goingto = @"city"; 
    if (gbl_mybirthinformation.isFirstResponder == 1)  gbl_fieldTap_goingto = @"date";


//    [ self checkResponderStuff ];

    //  here all 3 isFirstResponders are 0

//  NSLog(@"                                    gbl_pickerToUse=%@",gbl_pickerToUse);

    UILabel *retvalUILabel = (id) arg_view;

    if (!retvalUILabel) {
        retvalUILabel= [[UILabel alloc] initWithFrame: CGRectMake(
            0.0f,
            0.0f,
            [pickerView rowSizeForComponent: component].width,
            [pickerView rowSizeForComponent: component].height
            )
        ];
    }

    if ([ gbl_pickerToUse isEqualToString: @"date/time picker"] ) {  // "city picker" or "date/time picker"
        //    retvalUILabel.font = [UIFont systemFontOfSize:22];
        //    retvalUILabel.font = [UIFont systemFontOfSize: 10];
        //    retvalUILabel.font = [UIFont systemFontOfSize: 14];
        //    retvalUILabel.font = [UIFont systemFontOfSize: 16];

//        retvalUILabel.font = [UIFont systemFontOfSize: 23];
//        retvalUILabel.font = [UIFont systemFontOfSize: 22];
//        retvalUILabel.font = [UIFont systemFontOfSize: 21];
        retvalUILabel.font = [UIFont systemFontOfSize: 20];

//        retvalUILabel.font  = [UIFont fontWithName: @"Menlo" size: 14.0];
//        retvalUILabel.font  = [UIFont fontWithName: @"Menlo" size: 24.0];
//        retvalUILabel.font  = [UIFont fontWithName: @"Menlo" size: 20.0];
//        retvalUILabel.font  = [UIFont fontWithName: @"Menlo" size: 16.0];

        if (component == 0)  retvalUILabel.text = [self.array_BirthYearsToPick objectAtIndex: row];
        if (component == 1)  retvalUILabel.text = [self.array_Months      objectAtIndex: row];
        if (component == 2)  retvalUILabel.text = [self.array_DaysOfMonth objectAtIndex: row];
        if (component == 3)  retvalUILabel.text = @"";
        if (component == 4)  retvalUILabel.text = [self.array_Hours_1_12  objectAtIndex: row];
        if (component == 5) {
            retvalUILabel.textAlignment = NSTextAlignmentCenter;
            retvalUILabel.text = @":";
        }
        if (component == 6)  retvalUILabel.text = [self.array_Min_0_59    objectAtIndex: row];
        if (component == 7)  retvalUILabel.text = [self.array_AM_PM       objectAtIndex: row];
        //    if (component == 3)  retvalUILabel.text = [self.array_Hours_1_12  objectAtIndex: row];
        //    if (component == 4)  retvalUILabel.text = [self.array_Min_0_59    objectAtIndex: row];
        //    if (component == 5)  retvalUILabel.text = [self.array_AM_PM       objectAtIndex: row];

        //    retvalUILabel.text = [pickerViewArray objectAtIndex:row];
//  NSLog(@"DATE text=%@", retvalUILabel.text);
    }

    if ([ gbl_pickerToUse isEqualToString: @"city picker"] ) {  // "city picker" or "date/time picker"
        
        if (component == 0) {

                //        &num_PSVs_found,                 // is type  int  (0-based index to last string)
                //        city_prov_coun_PSVs              // array of chars holding fixed length "strings"

            [ self getCurrentCityProvCounForRownum: row ]; // populates gbl_enteredCity, Prov, Coun

            UIFont *myCityFont = [UIFont fontWithName: @"Menlo" size: 14.0]; // line has 35 chars

            retvalUILabel.adjustsFontSizeToFitWidth = NO;
            retvalUILabel.numberOfLines             =  2;          // always use 2 lines
            retvalUILabel.font                      = myCityFont;

//if (row == 2) {  // get max chars in line
//  //retvalUILabel.text = [NSString stringWithFormat:@" 2345678 1 2345678 2 23456789 3 2 4 6 8 5 2 4 6 8  6\n %@\n %@",  gbl_enteredProv, gbl_enteredCoun ];
////myStringForView = [NSString stringWithFormat:@" 2345678 1 2345678 2 23456789 3 2 4 6 8 5 2 4 6 8  6\n %@\n %@",  gbl_enteredProv, gbl_enteredCoun ];
//gbl_enteredCity = [NSString stringWithFormat:@" 2345678 1 2345678 2 23456789 3" ];
//}

             // for picker row:  attributed text in view (uilabel)
             //

             // define string for view
             //
             NSString *myStringForView;
             if (   gbl_enteredCity.length + gbl_enteredProv.length  +  @", ".length <= 35) {  // city + prov fit on one line
                myStringForView = [NSString stringWithFormat:@" %@, %@\n %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ]; 
             } else {                        
                myStringForView = [NSString stringWithFormat:@" %@\n %@, %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ]; 
             }


            // Define needed attributes for the entire allLabelExplaintext 
            NSDictionary *myNeededAttribs = @{
                //   e.g.
                ////                                      NSForegroundColorAttributeName: self.label.textColor,
                ////                                      NSBackgroundColorAttributeName: cell.textLabel.attributedText
                ////                                      NSBackgroundColorAttributeName: cell.textLabel.textColor
                //                                      NSFontAttributeName: cell.textLabel.font,
                //                                      NSBackgroundColorAttributeName: cell.textLabel.backgroundColor
                //                                      };
                //
                //            NSMutableAttributedString *myAttributedTextLabelExplain = 
                //                [[NSMutableAttributedString alloc] initWithString: allLabelExplaintext
                //                                                       attributes: myNeededAttribs     ];
                //
//                NSBackgroundColorAttributeName: retvalUILabel.attributedText.backgroundColor
                NSBackgroundColorAttributeName: retvalUILabel.backgroundColor
            };
            // define attributed string
            NSMutableAttributedString *myAttributedTextLabel = [
                [ NSMutableAttributedString alloc ] initWithString: myStringForView
                                                        attributes: myNeededAttribs   
            ];
  
            // set value of  attributed string
            [ myAttributedTextLabel addAttribute: NSBackgroundColorAttributeName 
//                                           value: [UIColor yellowColor]
                                           value: gbl_colorEditingBG_current
                                           range: NSMakeRange(1, gbl_myCitySoFar.length)  // offset, length
            ];

            // set value of attributedText property of retvalUILabel
            retvalUILabel.attributedText = myAttributedTextLabel;


        }  // city,prov \n coun

    }

    return retvalUILabel;

} // viewForRow



- (void) getCurrentCityProvCounForRownum: (NSInteger) arg_rownum   // populates gbl_enteredCity, Prov, Coun
{
    char my_buff[256];
    NSMutableString *myContentsPSV;
    NSArray  *tmpArray3;

    strcpy(my_buff, city_prov_coun_PSVs + arg_rownum * 128);  // fixed len rec = 128   get ROW   get ROW   get ROW  get ROW

    myContentsPSV = [NSMutableString stringWithUTF8String: my_buff];  // convert c string to NSString

    NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
    tmpArray3     = [myContentsPSV componentsSeparatedByCharactersInSet: mySeparators ];

    gbl_enteredCity = tmpArray3[0];
    gbl_enteredProv = tmpArray3[1];
    gbl_enteredCoun = tmpArray3[2];
}



//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *titleForRowRetval;
//    titleForRowRetval =  @"component not 0,1,2,3,4 or 5";
//
//trn("in attributedTitleForRow in pickerview BIRTH !");
//NSLog(@"      row=%ld",(long)row);
//NSLog(@"component=%ld",(long)component);
//
//    // return 6;  // 0 yyyy  1 mth  2 dd  3 hr  4 min  5 am/pm
//    if (component == 0)  titleForRowRetval = [self.array_BirthYearsToPick objectAtIndex: row];
//    if (component == 1)  titleForRowRetval = [self.array_Months      objectAtIndex: row];
//    if (component == 2)  titleForRowRetval = [self.array_DaysOfMonth objectAtIndex: row];
//    if (component == 3)  titleForRowRetval = [self.array_Hours_1_12  objectAtIndex: row];
//    if (component == 4)  titleForRowRetval = [self.array_Min_0_59    objectAtIndex: row];
//    if (component == 5)  titleForRowRetval = [self.array_AM_PM       objectAtIndex: row];
//
////    UIFont *font = [UIFont systemFontOfSize: 22];
//    UIFont *font1 = [UIFont systemFontOfSize: 10];
//    NSDictionary *myAttributes = @{NSFontAttributeName:font1 };
//
//    return [[NSAttributedString alloc] initWithString: titleForRowRetval attributes: myAttributes];
//}
//



- (CGFloat)pickerView:(UIPickerView *)pickerView  rowHeightForComponent: (NSInteger)component
{
    int sectionHeight;
    sectionHeight = 40;

    if ([ gbl_pickerToUse isEqualToString: @"date/time picker"] ) {  // "city picker" or "date/time picker"
        sectionHeight = 32;
        if (component == 0)  sectionHeight = 32;
        if (component == 1)  sectionHeight = 32;
        if (component == 2)  sectionHeight = 32;
        if (component == 3)  sectionHeight = 32;
        if (component == 4)  sectionHeight = 32;
        if (component == 5)  sectionHeight = 32;
        if (component == 6)  sectionHeight = 32;
        if (component == 7)  sectionHeight = 32;
    }
    if ([ gbl_pickerToUse isEqualToString: @"city picker"     ] ) {  // "city picker" or "date/time picker"
//        sectionHeight = 32;
        sectionHeight = 100;
//  NSLog(@"gbl_numCityLines =%ld",gbl_numCityLines );
//        if (gbl_numCityLines == 1) sectionHeight = 32;
//        if (gbl_numCityLines == 2) sectionHeight = 64;
//        if (gbl_numCityLines == 3) sectionHeight = 96;

//        sectionHeight = 70;
//        sectionHeight = 56;
//        sectionHeight = 48;
//        sectionHeight = 56;
//        sectionHeight = 46;
//        sectionHeight = 40;
//        sectionHeight = 38;
//        sectionHeight = 42;
        sectionHeight = 40;
    }

    return sectionHeight;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView  widthForComponent: (NSInteger)component
{
    int sectionWidth;
    sectionWidth = 40;

    if ([ gbl_pickerToUse isEqualToString: @"date/time picker"] ) {  // "city picker" or "date/time picker"
        sectionWidth = 40;

        //    if (component == 0)  sectionWidth = 55;  // yr
        if (component == 0)  sectionWidth = 60;  // yr
        //    if (component == 1)  sectionWidth = 40;  // mth
//        if (component == 1)  sectionWidth = 44;  // mth
//        if (component == 1)  sectionWidth = 40;  // mth
        if (component == 1)  sectionWidth = 42;  // mth

//        if (component == 2)  sectionWidth = 27;  // dy
//        if (component == 2)  sectionWidth = 30;  // dy
//        if (component == 2)  sectionWidth = 25;  // dy
        if (component == 2)  sectionWidth = 27;  // dy

        if (component == 3)  sectionWidth =  8;  // spacer
        //    if (component == 4)  sectionWidth = 27;  // hr

//        if (component == 4)  sectionWidth = 26;  // hr
        if (component == 4)  sectionWidth = 25;  // hr

        if (component == 5)  sectionWidth =  4;  // colon

        if (component == 6)  sectionWidth = 27;  // min
        if (component == 7)  sectionWidth = 35;  // am pm
        //    if (component == 3)  sectionWidth = 27;  // hr
        //    if (component == 4)  sectionWidth = 27;  // min
        //    if (component == 5)  sectionWidth = 35;  // am pm
    }
    if ([ gbl_pickerToUse isEqualToString: @"city picker"     ] ) {  // "city picker" or "date/time picker"
//        sectionWidth = 200;
        sectionWidth =  gbl_widthForLabelsForCityProvCoun; 
    }

    return sectionWidth;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row
                                               inComponent: (NSInteger)component
{
tn();trn("in didSelectRow in some  PICKER !!   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  NSLog(@"gbl_pickerToUse =[%@]",gbl_pickerToUse );
  NSLog(@"row=[%ld]",(long)row);
  NSLog(@"component=[%ld]",(long)component);

    gbl_editingChangeDATEHasOccurred = 1;   // default 0 at startup (after hitting "Edit" button on home page)

    if ([ gbl_pickerToUse isEqualToString: @"date/time picker"] ) {  // "city picker" or "date/time picker"


        gbl_lastInputFieldTapped = @"date";
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse11       =%@",gbl_pickerToUse );

        trn("in didSelectRow in BIRTH DATE  PICKER !! ");
    NSLog(@"row=%ld",(long)row);
    NSLog(@"component=%ld",(long)component);
      NSLog(@"gbl_rollerBirth_yyyy =%@",gbl_rollerBirth_yyyy );
      NSLog(@"gbl_rollerBirth_mth  =%@",gbl_rollerBirth_mth  );
      NSLog(@"gbl_rollerBirth_dd   =%@",gbl_rollerBirth_dd   );
      NSLog(@"gbl_rollerBirth_hour =%@",gbl_rollerBirth_hour );
      NSLog(@"gbl_rollerBirth_min  =%@",gbl_rollerBirth_min  );
      NSLog(@"gbl_rollerBirth_amPm =%@",gbl_rollerBirth_amPm );



        NSInteger myNewIndex;
        int daysinmonth[12]={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int rollerMM, rollerDD, rollerYYYY;
        // build gbl_lastSelectedDay  "yyyymmdd"  from  roller values
        //
            NSString *mm_format;   // like "01" instead of "Jan"


//            [self.pickerViewDateTime selectRow: myIndex inComponent: 0 animated: YES]; // This is how you manually SET(!!) a selection!
//            [self.pickerViewDateTime selectRow:       0 inComponent: 1 animated: YES]; // mth  = jan
//            [self.pickerViewDateTime selectRow:       0 inComponent: 2 animated: YES]; // day  = 01
//            // 3 = spacer
//            [self.pickerViewDateTime selectRow:      11 inComponent: 4 animated: YES]; // hr   = 12
//            // 5 = colon
//            [self.pickerViewDateTime selectRow:       1 inComponent: 6 animated: YES]; // min  = 01   2nd one
//            [self.pickerViewDateTime selectRow:       1 inComponent: 7 animated: YES]; // ampm = 12   2nd one

            // set mm value  (could be changed if component = 0)
            NSInteger indexInMths = [self.array_Months indexOfObject: gbl_rollerBirth_mth];
            mm_format = [NSString stringWithFormat:@"%02d",  (int) (indexInMths + 1)];    // mm is one-base, arr idx is zero-based

            if (component == 0) {
//                gbl_rollerBirth_yyyy = [self pickerView:  self.pickerViewDateTime
                gbl_rollerBirth_yyyy = [self pickerView:  self.pickerViewDateTime
                                            titleForRow: [self.pickerViewDateTime  selectedRowInComponent: 0 ]
//                                             viewForRow: [self.pickerViewDateTime  selectedRowInComponent: 0 ]
                                           forComponent: 0  ];
            }
            if (component == 1) {
                gbl_rollerBirth_mth  = [self pickerView:  self.pickerViewDateTime  // like "Jan"
                                            titleForRow: [self.pickerViewDateTime  selectedRowInComponent: 1 ]
                                           forComponent: 1  ];
                mm_format = [NSString stringWithFormat:@"%02d",  (int) (row + 1)];    // mm is one-base, row is zero-based
            }
            if (component == 2) {
                gbl_rollerBirth_dd   = [self pickerView:  self.pickerViewDateTime
                                            titleForRow: [self.pickerViewDateTime  selectedRowInComponent: 2 ]
                                           forComponent: 2  ];
            }
            if (component == 4) {
                gbl_rollerBirth_hour = [self pickerView:  self.pickerViewDateTime
                                            titleForRow: [self.pickerViewDateTime  selectedRowInComponent: 4 ]
                                           forComponent: 4  ];
            }
            if (component == 6) {
                gbl_rollerBirth_min  = [self pickerView:  self.pickerViewDateTime
                                            titleForRow: [self.pickerViewDateTime  selectedRowInComponent: 6 ]
                                           forComponent: 6  ];
            }
            if (component == 7) {
                gbl_rollerBirth_amPm = [self pickerView:  self.pickerViewDateTime
                                            titleForRow: [self.pickerViewDateTime  selectedRowInComponent: 7 ]
                                           forComponent: 7  ];
            }
      NSLog(@"gbl_rollerBirth_yyyy =%@",gbl_rollerBirth_yyyy );
      NSLog(@"gbl_rollerBirth_mth  =%@",gbl_rollerBirth_mth  );
      NSLog(@"gbl_rollerBirth_dd   =%@",gbl_rollerBirth_dd   );
      NSLog(@"gbl_rollerBirth_hour =%@",gbl_rollerBirth_hour );
      NSLog(@"gbl_rollerBirth_min  =%@",gbl_rollerBirth_min  );
      NSLog(@"gbl_rollerBirth_amPm =%@",gbl_rollerBirth_amPm );





            // FIX ROLLER POSITION DATA
            // here we have all the changed roller data
            //
            // 1) invalid day of month on rollers
            //    IF the day of the month is more than the number of days in that month and year
            //       FIX THE DAY OF THE MONTH, gbl_rollerBirth_dd,  to the real last day of that month
            //

            /// NO  NO  NO  NO  NO  NO  NO  NO  NO  NO  NO  NO  NO  NO   (due to privacy on birthdate)
            // 2) roller date is before date of birth
            //    
            //
            do {
  NSLog(@"FIX ROLLER POSITION DATA!");
            
                rollerMM   = [mm_format            intValue];
                rollerDD   = [gbl_rollerBirth_dd   intValue]; 
                rollerYYYY = [gbl_rollerBirth_yyyy intValue]; 
                //nki(rollerMM); ki(rollerDD); ki(rollerYYYY);

                // 1)  invalid day of month on rollers  m d y
                if (    rollerYYYY % 400 == 0
                    || (rollerYYYY % 100 != 0 && rollerYYYY % 4 == 0))   daysinmonth[1] = 29; // if leap year, make 29 days in february

                if (rollerDD > daysinmonth[rollerMM-1]) {
                    rollerDD = daysinmonth[rollerMM-1]; // day of month too big, make equal to last day in that month and year
                    gbl_rollerBirth_dd = [NSString stringWithFormat:@"%02d", rollerDD];

                    // set the changed value on the day  roller
                    myNewIndex = rollerDD - 1;               // initMM and initDD are "one-based" real m and d values
                    [self.pickerViewDateTime selectRow:myNewIndex inComponent: 2 animated:YES]; // This is how you manually SET(!!) a selection!
                }





    //            // 2) roller date  m d y  is before date of birth
    //            if (rollerYYYY == gbl_intBirthYear  &&
    //                rollerMM    < gbl_intBirthMonth )  {   // put mth and dd rollers to BIRTHDATE
    //
    //                // set the changed value on the mth  roller
    //                myNewIndex = gbl_intBirthMonth - 1;               // initMM and initDD are "one-based" real m and d values
    //                [self.outletFor_YMD_picker selectRow: myNewIndex inComponent: 0 animated:YES]; // This is how you manually SET(!!) a selection!
    //
    //                // set the changed value on the day  roller
    //                myNewIndex = gbl_intBirthDayOfMonth - 1;               // initMM and initDD are "one-based" real m and d values
    //                [self.outletFor_YMD_picker selectRow: myNewIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!
    //
    //
    //                gbl_rollerBirth_mth = self.arrayMonths[gbl_intBirthMonth - 1];
    //                gbl_rollerBirth_dd  = [NSString stringWithFormat:@"%02ld", (long)gbl_intBirthDayOfMonth];
    //            }
    //            if (rollerYYYY == gbl_intBirthYear  &&
    //                rollerMM   == gbl_intBirthMonth &&
    //                rollerDD    < gbl_intBirthDayOfMonth )  {   // put dd roller to birthdate
    //
    //                // set the changed value on the day  roller
    //                myNewIndex = gbl_intBirthDayOfMonth - 1;               // initMM and initDD are "one-based" real m and d values
    //                //kin((int)myNewIndex);
    //                [self.outletFor_YMD_picker selectRow: myNewIndex inComponent: 1 animated:YES]; // This is how you manually SET(!!) a selection!
    //
    //                gbl_rollerBirth_dd = [NSString stringWithFormat:@"%02ld", (long)gbl_intBirthDayOfMonth];
    //            }
    //

            } while (FALSE);   // FIX ROLLER POSITION DATA
             

    //
    //        // for remember  data  // fmt "yyyymmdd"
    //        gbl_lastSelectedDay =  [NSString stringWithFormat:@"%@%@%@",  // fmt "yyyymmdd"
    //            gbl_rollerBirth_yyyy,
    //            mm_format,
    //            gbl_rollerBirth_dd    ];  // "yyyymmdd"
    //            //NSLog(@"gbl_lastSelectedDay =%@",gbl_lastSelectedDay );

    //
    //        // get day of week for screen
    //        //
    //        //char *N3_day_of_week[] = { "Sun","Mon","Tue","Wed","Thu","Fri","Sat",""};
    //        NSArray *array_3letterDaysOfWeek = [[NSArray alloc]
    //            initWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat", nil];
    //        int my_day_of_week_idx;
    //        my_day_of_week_idx = day_of_week(rollerMM, rollerDD, rollerYYYY);  // mambutil.c
    //

            // show  selected day field on screen
            //
            NSString *myFormattedStr =  [NSString stringWithFormat:@"%@  %@ %@  %@:%@ %@",  // fmt "2016 Dec 25  12:01 am"
    //            array_3letterDaysOfWeek[my_day_of_week_idx],
                gbl_rollerBirth_yyyy,
                gbl_rollerBirth_mth,
                gbl_rollerBirth_dd,
                gbl_rollerBirth_hour,
                gbl_rollerBirth_min,
                gbl_rollerBirth_amPm
            ];

            gbl_selectedBirthInfo = myFormattedStr ;
            gbl_rollerBirthInfo   = myFormattedStr ;  // only shows stuff actually selected on the rollers

    //        gbl_lastSelectedDayFormattedForEmail = myFormattedStr;  // save for email format


    //        NSString *myFormattedStr2 =  [NSString stringWithFormat:@"%@ %@, %@",  // fmt "Dec 25,  2016"
    //            gbl_rollerBirth_mth,
    //            gbl_rollerBirth_dd,
    //        gbl_lastSelectedDayFormattedForTitle = myFormattedStr2;  // save for title format in tblrpts1
    //







//<.>  commenting this out leaves the rollers there
            // display YMDHMA  selected
            //
//    //<.>  TODO
    nbn(300);
      NSLog(@"myFormattedStr=%@", myFormattedStr);
    gbl_selectedBirthInfo = myFormattedStr;  // used to update field in cellforrow

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            self.outletToSelectedBirthInfo.text = myFormattedStr;

            NSIndexPath *indexPathBirthInfoLabel = [NSIndexPath indexPathForRow: 5 inSection: 0];

//                [self.tableView beginUpdates];
    //        [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
            [self.tableView reloadRowsAtIndexPaths:  @[ indexPathBirthInfoLabel ]
                                  withRowAnimation: UITableViewRowAnimationFade ];
//                                  withRowAnimation: UITableViewRowAnimationNone ];
//                                  withRowAnimation: UITableViewRowAnimationRight ];
//                                  withRowAnimation: UITableViewRowAnimationMiddle ];

//                [self.tableView endUpdates];

//            [gbl_myname             resignFirstResponder];
//            [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//            [gbl_mybirthinformation resignFirstResponder]; 

            //
            // All UIResponder objects have an inputView property.
            // The inputView of a UIResponder is the view that will be shown in place of the keyboard
            // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
            //
             [gbl_mybirthinformation becomeFirstResponder];
  NSLog(@"-didsel in picker -- VASSIGN gbl_mybirthinformation BECOME_FIRST_RESPONDER ---------------- " );
    });


nbn(301);
//    // want to never dismiss pickerview on didselect
//    [gbl_mybirthinformation becomeFirstResponder];
//    self.pickerViewDateTime.hidden     =  NO; 
//    gbl_mybirthinformation.hidden = NO;
nbn(302);

  NSLog(@"SELECTED a date  picker value");

    } // end date/time   didSelectRow

  NSLog(@"gbl_pickerToUse =[%@]",gbl_pickerToUse );


    if ([ gbl_pickerToUse isEqualToString: @"city picker"     ] ) {  // "city picker" or "date/time picker"

        gbl_lastInputFieldTapped = @"city";
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse15       =%@",gbl_pickerToUse );

  NSLog(@"SELECTED a city  picker value");

        // update city,prov,coun label fields
        //
        //[self getCurrentCityProvCounForRownum: gbl_lastPicklistSelectedRownum]; // populates gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun
        [ self getCurrentCityProvCounForRownum: row ]; // populates gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun

        [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath

    } // city picker

trn("!!!!!!!!!  END OF  didSelectRow in some  PICKER !!   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); tn();

} // didSelectRow  for PICKER


// ---  end of --------------------------------------------------------------------------------------------------
// ---  end of ----------------------   UIPickerView stuff ------------------------------------------------------
// ---  end of --------------------------------------------------------------------------------------------------




@end


//        NSIndexPath *indexPathLabelCity = [NSIndexPath indexPathForRow: 2 inSection: 0];
//        NSIndexPath *indexPathLabelProv = [NSIndexPath indexPathForRow: 3 inSection: 0];
//        NSIndexPath *indexPathLabelCoun = [NSIndexPath indexPathForRow: 4 inSection: 0];
//        NSIndexPath *indexPathLabelCity = [NSIndexPath indexPathForRow: 5 inSection: 0];
//        NSIndexPath *indexPathLabelProv = [NSIndexPath indexPathForRow: 6 inSection: 0];
//        NSIndexPath *indexPathLabelCoun = [NSIndexPath indexPathForRow: 7 inSection: 0];
//
//        NSArray *indexPathsToUpdate = [NSArray arrayWithObjects: indexPathLabelCity, indexPathLabelProv, indexPathLabelCoun , nil];
//


//        NSIndexPath *indexPathLabelCityProvCoun = [NSIndexPath indexPathForRow: 3 inSection: 0];
//
//        NSArray *indexPathsToUpdate = [NSArray arrayWithObjects: indexPathLabelCityProvCoun, nil];
//        [self.tableView beginUpdates];
//        [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
//                              withRowAnimation: UITableViewRowAnimationNone ];
//        [self.tableView endUpdates];
//
        // update place labels

//        gbl_timeOfPrevCityKeystroke = gbl_timeOfCurrCityKeystroke; // set city keystroke interval times
////        NSDate *timeNow             = [NSDate date];
//        CFTimeInterval timeNow      = CACurrentMediaTime();  // returns double CFTimeInterval
//        gbl_timeOfCurrCityKeystroke = timeNow;                     // set city keystroke interval times
//

//- (void)updateNameLabel
//{
//  NSLog(@"in updateNameLabel");
//
//    // update name label field  update field in cellForRowAtIndexpath
//    //
//    NSIndexPath *indexPathLabelCityProvCoun = [NSIndexPath indexPathForRow: 1 inSection: 0];
//
//    NSArray *indexPathsToUpdate = [NSArray arrayWithObjects: indexPathLabelCityProvCoun, nil];
//    [self.tableView beginUpdates];
//    [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
//                          withRowAnimation: UITableViewRowAnimationNone ];
//    [self.tableView endUpdates];
//
//} // end of updateNameLabel
//

//  DEPRECATED in 9.0
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//  NSLog(@"in  alertView clickedButtonAtIndex !!");
//  NSLog(@"buttonIndex=[%ld]",buttonIndex);
//    switch(buttonIndex) {
//        case 0: //"No" pressed
//  NSLog(@"ALERT  CHOOSE  CASE 00000");
//                //do something?
//            break;
//        case 1: //"Yes" pressed
//  NSLog(@"ALERT  CHOOSE  CASE 11111");
//                //here you pop the viewController
////            [self.navigationController popViewControllerAnimated:YES];
//
//        // actually do the "Back" action
//        //
//        [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller
//            break;
//        default:
//  NSLog(@"ALERT  CHOOSE  default");
//          break;
//    }
//}
//

//    gbl_enteredCity = tmpArray3[0];
//    gbl_enteredProv = tmpArray3[1];
//    gbl_enteredCoun = tmpArray3[2];
//NSString *gbl_initPromptName;  // for values, see appdel .m
//NSString *gbl_initPromptCity;
//NSString *gbl_initPromptProv;
//NSString *gbl_initPromptCoun;
//NSString *gbl_initPromptDate;

//<.>  TODO 
//  NSLog(@"-- USAGE  gbl_justCancelledOutOfCityPicker --  in  shouldChangeCharactersInRange --  set gbl_intervalBetweenLast2Keystrokes");
////    if (gbl_justCancelledOutOfCityPicker == 1)   gbl_intervalBetweenLast2Keystrokes = 0.0;
//    if (gbl_justCancelledOutOfCityPicker == 1) {
////        gbl_intervalBetweenLast2Keystrokes = 0.0;
//
//
//
//  gbltmpint = gbl_justCancelledOutOfCityPicker ;
//        gbl_justCancelledOutOfCityPicker = 0;    // turn it off here
//  NSLog(@"--onc ----- USAGE gbl_justCancelledOutOfCityPicker ---------------- old=[%ld]  new=[%ld] ---", gbltmpint, gbl_justCancelledOutOfCityPicker );
//
//
//
//    } else {
//        ;
////        gbl_intervalBetweenLast2Keystrokes = gbl_timeOfCurrCityKeystroke - gbl_timeOfPrevCityKeystroke;  // CALC
//    }

// qOLD
//  NSLog(@"=====  SET INTERVAL1  ================== gbl_intervalBetweenLast2Keystrokes=%g",gbl_intervalBetweenLast2Keystrokes);
//  NSLog(@"gbl_typedCharPrev=[%@]  gbl_typedCharCurr=[%@]",gbl_typedCharPrev, gbl_typedCharCurr);
//  NSLog(@"gbl_timeOfPrevCityKeystroke        =%g",gbl_timeOfPrevCityKeystroke        );
//  NSLog(@"gbl_timeOfCurrCityKeystroke        =%g",gbl_timeOfCurrCityKeystroke        );
//  NSLog(@"myTimeNow                          =%g",myTimeNow             );
//  NSLog(@"============================================================");
//


//    if (gbl_justCancelledOutOfCityPicker == 1) {
//nbn(601);
//tn(); NSLog(@"cancel picker  cancel picker  cancel picker  cancel picker  cancel picker  gbl_justCancelledOutOfCityPicker=[%ld]",gbl_justCancelledOutOfCityPicker);
//        
//  NSLog(@"set textField.txt = gbl_myCitySoFar  xxxxxxxxx 556  xxxxxxxxx ");
//
//        textField.text = gbl_myCitySoFar;  // note that this just had final char chopped
//
//  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
//  NSLog(@"textField.text=[%@]",textField.text);
//
//        gbl_justCancelledOutOfCityPicker = 0;
//  NSLog(@"JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ  gbl_justCancelledOutOfCityPicker =%ld",(long)gbl_justCancelledOutOfCityPicker );
//
//    } else {
//
//        && [textField.text          isEqualToString: @""  ]     // here first character typed for city is SPACE

