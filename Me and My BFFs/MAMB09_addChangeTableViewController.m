//
//  MAMB09_addChangeTableViewController.m
//  Me&myBFFs
//
// MIT License
//
// Copyright (c) 2017 softwaredev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

//#include <CoreServices/CoreServices.h>   // these 4 are for  start = mach_absolute_time();  jjj lll mmm nnn ppp qqq
//#include <mach/mach.h>
//#include <mach/mach_time.h>
//#include <unistd.h>


#import "MAMB09_addChangeTableViewController.h"
//#import "MAMB09_selectReportsTableViewController.h"
#import "rkdebug_externs.h"
#import "MAMB09AppDelegate.h"   // to get globals
#import "mamblib.h"
//#import "MAMB09_UITextField_noCopyPaste.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

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



// =================================================================================================
//  Displaying the Keyboard
// =================================================================================================
//  When the user taps a view, the system automatically designates that view as the first responder.
//  When this happens to a view that contains editable text, the view initiates an editing session for that text.
//  At the beginning of that editing session, the view asks the system to display the keyboard, if it is not already visible.
//  If the keyboard is already visible,
//  the change in first responder causes text input from the keyboard to be redirected to the newly tapped view.
//  
//  Because the keyboard is displayed automatically when a view becomes the first responder,
//  you often do not need to do anything to display it.
//  However, you can programmatically display the keyboard for an editable text view by calling that view’s
//        becomeFirstResponder    method.
//  Calling this method makes the target view the first responder and begins the editing process just as if the user had tapped on the view.
//  
//  If your app manages several text-based views on a single screen,
//  it is a good idea to track which view is currently the first responder so that you can dismiss the keyboard later.
//  
//  Dismissing the Keyboard
//  Although it typically displays the keyboard automatically, the system does not dismiss the keyboard automatically.
//  Instead, it is your app’s responsibility to dismiss the keyboard at the appropriate time.
//  Typically, you would do this in response to a user action. For example, you might dismiss the keyboard
//  when the user taps the Return or Done button on the keyboard or taps some other button in your app’s interface.
//  Depending on how you configured the keyboard,
//  you might need to add some additional controls to your user interface to facilitate the keyboard’s dismissal.
//  
//  To dismiss the keyboard, you call the resignFirstResponder method of the text-based view that is currently the first responder.
//  When a text view RESIGNS ITS FIRST RESPONDER STATUS,
//      - it ends its current editing session
//      - notifies its delegate of that fact
//      - dismisses the keyboard
//  In other words, if you have a variable called myTextField
//  that points to the UITextField object that is currently the first responder,
//  dismissing the keyboard is as simple as doing the following:
//  
//      [myTextField resignFirstResponder];
//  Everything from that point on is handled for you automatically by the text object.
//  
//  
// =================================================================================================
//   KEYBOARD NOTIFICATIONS            Receiving Keyboard Notifications
// =================================================================================================
//  https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
//
//  When the keyboard is shown or hidden, iOS sends out the following notifications to any registered observers:
//
//    UIKeyboardWillShowNotification
//    UIKeyboardDidShowNotification
//    UIKeyboardWillHideNotification
//    UIKeyboardDidHideNotification
//
// =================================================================================================



//#import "QuartzCore"  
//#import <QuartzCore/QuartzCore.h>
//#import "QuartzCore/QuartzCore.h"  // for rounded corners uitextview


@interface MAMB09_addChangeTableViewController ()


@end





    char city_prov_coun_PSVs[26 * 128];    // [max num 25 * fixed length of 128]  for search city using typed so far
    int  num_PSVs_found;                   // zero-based                          for search city using typed so far

//    char psvName[32], psvMth[4], psvDay[4], psvYear[8], psvHour[4], psvMin[4], psvAmPm[4], psvCity[64], psvProv[64], psvCountry[64];
//    char psvLongitude[16], psvHoursDiff[8], returnPSV[64];
//    const char *my_psvc; // psv=pipe-separated values
//    char my_psv[128];
//

    NSString *fldName, *fldMth, *fldDay, *fldYear, *fldHour, *fldMin, *fldAmPm, *fldCity, *fldProv, *fldCountry, *fldKindOfSave;
    NSString *fldNameG;
//    NSString *fldLongitude, *fldHoursDiff;





@implementation MAMB09_addChangeTableViewController

//
//// The copy:, cut:, delete:, paste:, select:, and selectAll: methods   this list is ACTION LIST
////
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender { //  NOTE  still shows paste
//  NSLog(@"in canPerformAction  pppppppppppppppppppppppppppppppppppppppppppp pppppppp pppppppp ppppppppp");
//  NSLog(@"function=[%s] sender=[%@] selector=[%s]",   __FUNCTION__,   sender,  sel_getName(action) );
//
//    NSString *myStringForAction;
//    myStringForAction = NSStringFromSelector(action);
//
//  NSLog(@"myStringForAction =[%@]",myStringForAction );
//  NSLog(@" EVERYTHING   return NO");
//       return NO;
//
////
//////  NSLog(@"NSStringFromSelector(action)=[%@]",NSStringFromSelector(action));
////
//////    if (action == @selector(delete:))
////
////    // allow copy, cut
////    if ([ myStringForAction isEqualToString: @"cut:" ])   
////    {
////  NSLog(@"myStringForAction=[cut:]  return NO");
////       return NO;
////    }
////    if ([ myStringForAction isEqualToString: @"copy:" ])   
////    {
////  NSLog(@"myStringForAction=[copy:]  return NO");
////       return NO;
////    }
////
//////    if ([ myStringForAction isEqualToString: @"delete:" ])
//////    {
//////  NSLog(@"myStringForAction=[delete:]  return NO");
//////       return NO;
//////    }
////    if ([ myStringForAction isEqualToString: @"paste:" ])   
////    {
////  NSLog(@"myStringForAction=[paste:]  return NO");
////       return NO;
////    }
////    if ([ myStringForAction isEqualToString: @"selectAll:" ])
////    {
////  NSLog(@"myStringForAction=[selectAll:]  return NO" );
////       return NO;
////    }
////
////    if ([ myStringForAction isEqualToString: @"makeTextWritingDirectionRightToLeft:" ])  
////    {
////  NSLog(@"myStringForAction=[makeTextWritingDirectionRightToLeft:]  return NO");
////       return NO;
////    }
////    if ([ myStringForAction isEqualToString: @"makeTextWritingDirectionRightToLeft:" ])  
////    {
////  NSLog(@"myStringForAction=[makeTextWritingDirectionLeftTORight:]  return NO");
////       return NO;
////    }
////
////    // no delete: no share:  allowed  ( vars beginning with "_"   protected ? )
////
//////    return [super canPerformAction:action withSender:sender];
////
////  NSLog(@"action=[%@]  return YES", myStringForAction);
////    return YES;
////
//}
//
//





//
//// The copy:, cut:, delete:, paste:, select:, and selectAll: methods
//// are invoked when users tap the corresponding command
//// in the menu managed by the UIMenuController shared instance.
////
//- (BOOL)canPerformAction: (SEL)action
//              withSender: (id)sender
//{
//  NSLog(@"canPerformAction=!");
//    return NO;
//}
//
//


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


//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    NSLog(@"gestureRecognizerShouldBegin:0x%x", (int)gestureRecognizer);
//  NSLog(@"gestureRecognizer.numberOfTouches =[%ld]", (long)gestureRecognizer.numberOfTouches);
//  NSLog(@"NSStringFromClass([gestureRecognizer class])                    =[%@]",NSStringFromClass([gestureRecognizer class]) );
//  NSLog(@"[gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]=[%d]",[gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]);
//  NSLog(@"[gestureRecognizer description ]=[%@]",[gestureRecognizer description ]);
//
//
//  NSLog(@" returning YES  all the time !");tn();
//        return YES;
//
//
//
//    if (gbl_haveEnteredGestureRecognizerShouldBegin == 0) {
//        gbl_haveEnteredGestureRecognizerShouldBegin = 1;
//  NSLog(@" returning YES  the first time !");tn();
//        return YES;
//    }
//
//  NSLog(@" returning NO  rest of the time !");tn();
//return NO;
//
//
//
//    NSInteger myNumberOfTapsRequired;
//    myNumberOfTapsRequired = 0;
//
//    NSArray *myarr  = [ [gestureRecognizer description] componentsSeparatedByString: @";" ] ;
//    for (NSString *item in myarr)
//    {
////  NSLog(@"item=[%@]",item);
//
//
//        NSRange range = [item  rangeOfString: @"numberOfTapsRequired"  options: NSCaseInsensitiveSearch ];
////  NSLog(@"range.location =[%d]",range.location );
////  NSLog(@"found: %@", (range.location != NSNotFound) ? @"Yes" : @"No");
//        if (range.location != NSNotFound) {
//            // here item contains string "numberOfTapsRequired"   like    item=[ numberOfTapsRequired = 2]
//            // find first integer in string  item       
//            //
//            // If the number is not always at the beginning:
//            NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet ];
//            myNumberOfTapsRequired    = [[item stringByTrimmingCharactersInSet:nonDigits] intValue ];
//  NSLog(@"myNumberOfTapsRequired    =[%ld]", (long) myNumberOfTapsRequired    );
//            break;   // myNumberOfTapsRequired   can occur twice
//        }
//    }
//  NSLog(@"myNumberOfTapsRequired    =[%ld]", (long) myNumberOfTapsRequired    );
//
//
////
////    // if this is a UITapGestureRecognizert  (assume double tap)
////    // and number of taps required is > 1
////    // do not process it.
////    //
////    if (    [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]
////         &&  myNumberOfTapsRequired > 1                             )
////    {
////  NSLog(@"return NO");  tn();
////       return NO;
////    } else {
////  NSLog(@"return YES");  tn();
////       return YES;
////    }
////
//
//  NSLog(@"gbl_firstResponder_current  =[%@]",gbl_firstResponder_current );
//  NSLog(@"gbl_firstResponder_previous =[%@]",gbl_firstResponder_previous );
//    if ([gbl_firstResponder_current isEqualToString: @"name" ] )
//    {
//        if ([gbl_firstResponder_previous isEqualToString: @"name" ] )
//        {
//  NSLog(@"1st responder=name, prev=name returning NO !");tn();
//            return NO;
//        } else {
//           if (gbl_firstResponder_previous == nil ) {
//
//  NSLog(@"1st responder=name, prev= NIL returning NO !");tn();
//            return NO;
//           } else {
//  NSLog(@"1st responder=name, prev= different from name and NOT NIL   returning YES !");tn();
//            return YES;
//           }
//        }
//
//    } else {
//  NSLog(@"1st responder NOT =name,  returning NO !");tn();
//        return NO;
//    } 
//
//  NSLog(@"at end returning YES !");tn();
//return YES;
//
//
//
//
//} // end of gestureRecognizerShouldBegin
//
//


//
//// never called
//- (void)touchesEnded: (NSSet *)   touches
//           withEvent: (UIEvent *) event
// {
//  NSLog(@"in touchesEnded !  1 ");
//    [super touchesEnded: touches withEvent: event];
//
//  NSLog(@"in touchesEnded !  2 ");
//
//     if(((UITouch *)[touches anyObject]).tapCount == 2)
//    {
//    NSLog(@"DOUBLE TOUCH");
//    }
//}
//



//- (void) processSingleTap:(UITapGestureRecognizer *)sender { NSLog(@"process SINGLE Tap  do nothing"); }
//- (void) processDoubleTap:(UITapGestureRecognizer *)sender { NSLog(@"process DOUBLE Tap  do nothing"); }
//- (void) processDoubleTap:(UITapGestureRecognizer *)recognizer {

//- (void) processDoubleTap:(UITapGestureRecognizer *)sender {
//  NSLog(@"process DOUBLE Tap  xxx  do nothing");
//
////<.>
////// Selecting the last 5 characters before the caret would be like this:
////
////// Get current selected range , this example assumes is an insertion point or empty selection
////UITextRange *selectedRange = [textField selectedTextRange];
////
////// Calculate the new position, - for left and + for right
////UITextPosition *newPosition = [textField positionFromPosition:selectedRange.start offset:-5];
////
////// Construct a new range using the object that adopts the UITextInput, our textfield
////UITextRange *newRange = [textField textRangeFromPosition:newPosition toPosition:selectedRange.start];
////
////// Set new range
////[textField setSelectedTextRange:newRange];
////<.>
////
//
//
////
////// Construct a new range using the object that adopts the UITextInput, our textfield
//////UITextRange *newRange = [textField textRangeFromPosition:newPosition toPosition:selectedRange.start];
////if (gbl_myname == nil) gbl_myname.text = @"";
//////UITextRange *newRange = [gbl_myname  textRangeFromPosition: (UITextPosition * _NonNull) 0   toPosition: (UITextPosition * _NonNull) 0 ];
////UITextRange *newRange = [gbl_myname  textRangeFromPosition: (UITextPosition * ) 0   toPosition: (UITextPosition * ) 0 ];
//////UITextRange *newRange = [@"abc"  textRangeFromPosition: 0   toPosition: 0 ];
////
////// Set new range
////[gbl_myname  setSelectedTextRange: newRange ];
////
//
//
//
//
////     if (recognizer.state == UIGestureRecognizerStateRecognized) {
////         gbl_myname.selectedTextRange =   (UITextRange * _Nullable)  NSMakeRange(0, 0 ,0 ,0 );
////     }
//} // end of  (void) processDoubleTap:(UITapGestureRecognizer *)sender 
//

//- (void) processTripleTap:(UITapGestureRecognizer *)sender { NSLog(@"process TripleTap  do nothing"); }
//- (void) processQuad__Tap:(UITapGestureRecognizer *)sender { NSLog(@"process Quad__Tap  do nothing"); }
//- (void) processPenta_Tap:(UITapGestureRecognizer *)sender { NSLog(@"process Penta_tap  do nothing"); }



//- (void) process_dblTapRecog_InNameFld: (UITapGestureRecognizer *)sender { NSLog(@"in process_dblTapRecog_InNameFld!  do nothing"); }
//- (void) process_dblTapRecog_InNameCell:(UITapGestureRecognizer *)sender { NSLog(@"in process_dblTapRecog_InNameCell!  do nothing"); }


//- (void) touchDownIn_gbl_mynameFld: (id)sender
//{
//  NSLog(@"in touchDownIn_gbl_myname !  do nothing");
//}
//

//- (void) touchDownIn_gbl_mynameCell: (id)sender
//{
//  NSLog(@"in touchDownIn_gbl_mynameCell !  do nothing");
//}
//


// there is no menu select/...  BUT   this still allows blue-handle selection 
//
-(void)myMenuWillBeShown  // NSNotification  for DISABLE showing of select/paste/cut etc (flashes a bit, but only the 1st time)
{
  NSLog(@"in myMenuWillBeShown !");

    UIMenuController *theMenu = [UIMenuController sharedMenuController];

    [theMenu setMenuVisible: NO   animated: NO ];


//    UIMenuController *menu = [UIMenuController sharedMenuController];

//    [menu setMenuVisible: NO];

//    [menu performSelector: @selector(setMenuVisible:)
//               withObject: [NSNumber numberWithBool: NO]
////               afterDelay: 0.1
//               afterDelay: 0.2
//    ]; //also tried 0 as interval both look quite similar

} // end of myMenuWillBeShown  


-(void)keyboardWillShowAction  // selector for    UIKeyboardWillShowNotification
{
tn();
  NSLog(@"in keyboardWillShowAction !");
    gbl_keyboardIsShowing = 1;
tn();
}

-(void)keyboardWillHideAction  // selector for    UIKeyboardWillHideNotification  
{
tn();
  NSLog(@"in keyboardWillHideAction !");
    gbl_keyboardIsShowing = 0;
tn();
}



//
//-(void)myTextFieldBeganEditing
//{
//tn();
//  NSLog(@"in myTextFieldBeganEditing!");
////    gbl_myname.userInteractionEnabled = NO;
////  NSLog(@"gbl_myname.userInteractionEnabled = NO!");
//
////    [gbl_singleTapGestureRecognizer    setCancelsTouchesInView: YES];
//  NSLog(@"[gestureRecognizer description ]=[%@]",[gbl_singleTapGestureRecognizer description ]);
//}
//
//
//-(void)myTextFieldEndedEditing
//{
//tn();
//  NSLog(@"in myTextFieldEndedEditing!");
////    gbl_myname.userInteractionEnabled = NO;
////  NSLog(@"gbl_myname.userInteractionEnabled = NO!");
//
////    [gbl_singleTapGestureRecognizer    setCancelsTouchesInView: NO];
//  NSLog(@"[gestureRecognizer description ]=[%@]",[gbl_singleTapGestureRecognizer description ]);
//}
//
//


//- (void) processSingleTap:(UITapGestureRecognizer *)sender
//{
//  NSLog(@"processSingleTap   do nothing");
//  NSLog(@"[gestureRecognizer description ]=[%@]",[sender description ]);
//}


- (void)viewDidLoad
{
tn();
  NSLog(@"viewDidLoad in add/change");
    [super viewDidLoad];


  nbn(705);

  NSLog(@"gbl_homeUseMODE =[%@]", gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState =[%@]", gbl_homeEditingState );


//    if (   [gbl_fromHomeCurrentSelectionType isEqualToString: @"person" ]
//        && [gbl_homeEditingState             isEqualToString: @"add"    ]
//    )
//    {
//
//        // BEFORE adding person,  alert for  PERSONAL PRIVACY
//        //
//  nbn(706);
//        NSString *saveMsg;
//
////        saveMsg = [NSString stringWithFormat: @"\nAfter you save the birth data for a new person, NOBODY, neither you nor this device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\n So, if you ever want to look at the birth information of this new person in the future, you need to write it down somewhere safe outside this app." 
////        ];
//        saveMsg = [NSString stringWithFormat: @"\nAfter you save the birth data for a new person, NOBODY, neither you nor this device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\n So, if you ever want to look at the birth information of this new person in the future, you need to write it down NOW somewhere safe outside this app." 
//        ];
//
//        UIAlertController* myalert = [UIAlertController alertControllerWithTitle: @"Personal Privacy"
//                                                                       message: saveMsg 
//                                                                preferredStyle: UIAlertControllerStyleAlert  ];
//         
//        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
//                                                            style: UIAlertActionStyleDefault
//                                                          handler: ^(UIAlertAction * action) {
//            NSLog(@"Ok button pressed");
//        } ];
//         
//        [myalert addAction:  okButton];
//
//        [self.navigationController presentViewController: myalert  animated: YES  completion: nil ];
//
//  nbn(707);
////                return;
//
////                  [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
//        // BEFORE adding person,  alert for  PERSONAL PRIVACY
//    }
//




//    gbl_haveEnteredGestureRecognizerShouldBegin = 0;

    gbl_justLookedAtInfoScreen = 0;
  NSLog(@"gbl_justLookedAtInfoScreen  in ViewDidLoad in add/change =[%ld]",(long)gbl_justLookedAtInfoScreen );

    gbl_myname.delegate = self;

    //    scrollView.bounces = NO;
    self.tableView.bounces   = NO;


// add removeObs...

//    [[NSNotificationCenter defaultCenter] addObserver: self  // DISABLE showing of select/paste/cut etc (flashes a bit)
//                                             selector: @selector(myTextFieldBeganEditing)
//                                                 name: UITextFieldTextDidBeginEditingNotification   // <<<====----
////                                               object: nil
//                                               object: gbl_myname
//    ];
//    [[NSNotificationCenter defaultCenter] addObserver: self  // DISABLE showing of select/paste/cut etc (flashes a bit)
//                                             selector: @selector(myTextFieldEndedEditing)
//                                                 name: UITextFieldTextDidEndEditingNotification   // <<<====----
////                                               object: nil
//                                               object: gbl_myname
//    ];
//



//    [gbl_myname  addTarget: self
//                    action: @selector(touchDownIn_gbl_mynameFld: )
//          forControlEvents: UIControlEventAllTouchEvents
////          forControlEvents: UIControlEventTouchDown
//    ];
//

            //typedef enum UIControlEvents : NSUInteger {
            //   UIControlEventTouchDown               = 1 << 0,
            //   UIControlEventTouchDownRepeat         = 1 << 1,
            //   UIControlEventTouchDragInside         = 1 << 2,
            //   UIControlEventTouchDragOutside        = 1 << 3,
            //   UIControlEventTouchDragEnter          = 1 << 4,
            //   UIControlEventTouchDragExit           = 1 << 5,
            //   UIControlEventTouchUpInside           = 1 << 6,
            //   UIControlEventTouchUpOutside          = 1 << 7,
            //   UIControlEventTouchCancel             = 1 << 8,
            //   
            //   UIControlEventValueChanged            = 1 << 12,
            //   UIControlEventPrimaryActionTriggered  = 1 << 13,
            //   UIControlEventEditingDidBegin         = 1 << 16,
            //   UIControlEventEditingChanged          = 1 << 17,
            //   UIControlEventEditingDidEnd           = 1 << 18,
            //   UIControlEventEditingDidEndOnExit     = 1 << 19,
            //   
            //   UIControlEventAllTouchEvents          = 0x00000FFF,
            //   UIControlEventAllEditingEvents        = 0x000F0000,
            //   UIControlEventApplicationReserved     = 0x0F000000,
            //   UIControlEventSystemReserved          = 0xF0000000,
            //   UIControlEventAllEvents               = 0xFFFFFFFF 
            //} UIControlEvents;
            //




    // -------------------------------------
    //    self.multipleTouchEnabled = NO;
    // -------------------------------------
    // When set to YES, the receiver receives all touches associated with a multi-touch sequence.
    // When set to NO, the receiver receives only the first touch event in a multi-touch sequence.
    // The default value of this property is NO.
    // 
    // Other views in the same window can still receive touch events when this property is NO.
    // If you want this view to handle multi-touch events exclusively,
    //  set the values of both this property and the exclusiveTouch property to YES.
    // 
    // -------------------------------------
    //    self.exclusiveTouch       = YES;
    // -------------------------------------
    // Setting this property to YES causes the receiver to block
    // the delivery of touch events to other views in the same window.
    // The default value of this property is NO.
    //
    self.view.multipleTouchEnabled = NO;
//    self.view.exclusiveTouch       = YES;




        //----------------------------------
        //CancelsTouchesInView
        //----------------------------------
        //name gets focus  firstrespond
        //set gesture tap in name
        //set CancelsTouchesInView = YES
        //name loses  firstrespond
        //removeGestureRecognizer
        //----------------------------------

//    gbl_singleTapGestureRecognizer = [
//       [UITapGestureRecognizer alloc] initWithTarget: gbl_myname 
////       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( processSingleTap: )
//    ];
//    [gbl_singleTapGestureRecognizer    setNumberOfTapsRequired: 1];
//    [gbl_singleTapGestureRecognizer setNumberOfTouchesRequired: 1];
//
//    [gbl_singleTapGestureRecognizer    setCancelsTouchesInView: NO];
////    [gbl_singleTapGestureRecognizer    setCancelsTouchesInView: YES];
//
////    [gbl_singleTapGestureRecognizer requireGestureRecognizerToFail: gbl_doubleTapGestureRecognizer ];
////    gbl_singleTapGestureRecognizer.delaysTouchesBegan        = YES;   
////    gbl_singleTapGestureRecognizer.delegate                  = self;   
//    [self.view addGestureRecognizer: gbl_singleTapGestureRecognizer ];
//





//    gbl_oneTapRecog_InNameFld = [
//       [UITapGestureRecognizer alloc] initWithTarget: gbl_myname 
////       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( process_oneTapRecog_InNameFld: )
//    ];

//    [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 1];
//    [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
////    [gbl_doubleTapGestureRecognizer requireGestureRecognizerToFail: gbl_dblTapRecog_InNameFld ];
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = YES;   
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = NO;   
////    gbl_doubleTapGestureRecognizer.cancelsTouchesInView        = YES;   
//
//    gbl_doubleTapGestureRecognizer.delegate                  = self;   
////    [self.view addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//    [gbl_myname addGestureRecognizer: gbl_oneTapRecog_InNameFld ];
//
//
//    gbl_dblTapRecog_InNameFld = [
//       [UITapGestureRecognizer alloc] initWithTarget: gbl_myname 
////       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( process_dblTapRecog_InNameFld : )
//    ];
//    [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 2];
//    [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
//    [gbl_doubleTapGestureRecognizer requireGestureRecognizerToFail: gbl_oneTapRecog_InNameFld ];
////    [gbl_doubleTapGestureRecognizer requireGestureRecognizerToFail: gbl_tripleTapGestureRecognizer ];
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = YES;   
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = NO;   
////    gbl_doubleTapGestureRecognizer.cancelsTouchesInView        = YES;   
//
//    gbl_doubleTapGestureRecognizer.delegate                  = self;   
////    [self.view addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//    [gbl_myname addGestureRecognizer: gbl_dblTapRecog_InNameFld ];
//



    gbl_didAddDoneButtonInAddChange = 0;   // 1=yes, 0=no  set=0 in add/change viewDidLoad  set=1 when Done is added to nav bar
tn();
NSLog(@"in ADD CHANGE  viewDidLoad!");

  gbl_currentMenuPlusReportCode = @"HOMEaddchange";   // add/change screen   (used in info screen)

  NSLog(@"gbl_homeUseMODE               =[%@]",gbl_homeUseMODE     );
  NSLog(@"gbl_homeEditingState          =[%@]",gbl_homeEditingState);
  NSLog(@"gbl_lastSelectedPerson        =[%@]",gbl_lastSelectedPerson);
  NSLog(@"gbl_currentMenuPlusReportCode =[%@]",gbl_currentMenuPlusReportCode );




    // add a method (processMultipleTap) to run on double tap/triple tap etc
    //
//    gbl_penta_TapGestureRecognizer = [
//       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( processPenta_Tap: )
//    ];
//    [gbl_penta_TapGestureRecognizer    setNumberOfTapsRequired: 5];
//    [gbl_penta_TapGestureRecognizer setNumberOfTouchesRequired: 1];
//    gbl_penta_TapGestureRecognizer.delaysTouchesBegan        = YES;      
//    gbl_penta_TapGestureRecognizer.delegate                  = self;   
//    [self.view addGestureRecognizer: gbl_penta_TapGestureRecognizer ];
//
//    gbl_quad__TapGestureRecognizer = [
//       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( processQuad__Tap: )
//    ];
//    [gbl_quad__TapGestureRecognizer    setNumberOfTapsRequired: 4];
//    [gbl_quad__TapGestureRecognizer setNumberOfTouchesRequired: 1];
//    gbl_quad__TapGestureRecognizer.delaysTouchesBegan        = YES;     
//    gbl_quad__TapGestureRecognizer.delegate                  = self;   
//    [self.view addGestureRecognizer: gbl_quad__TapGestureRecognizer ];
//


//    gbl_tripleTapGestureRecognizer = [
//       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( processTripleTap: )
//    ];
//    [gbl_tripleTapGestureRecognizer    setNumberOfTapsRequired: 3];
//    [gbl_tripleTapGestureRecognizer setNumberOfTouchesRequired: 1];
//    [gbl_doubleTapGestureRecognizer requireGestureRecognizerToFail: gbl_doubleTapGestureRecognizer ];
//    gbl_tripleTapGestureRecognizer.delaysTouchesBegan        = YES;    
//    gbl_tripleTapGestureRecognizer.delegate                  = self;   
//    [self.view addGestureRecognizer: gbl_tripleTapGestureRecognizer ];
//



//    gbl_doubleTapGestureRecognizer = [
////       [UITapGestureRecognizer alloc] initWithTarget: gbl_myname 
//       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( processDoubleTap: )
//    ];
//    [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 2];
//    [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
////    [gbl_doubleTapGestureRecognizer requireGestureRecognizerToFail: gbl_tripleTapGestureRecognizer ];
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = YES;   
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = NO;   
//
//    gbl_doubleTapGestureRecognizer.cancelsTouchesInView        = YES;   
//
//    gbl_doubleTapGestureRecognizer.delegate                  = self;   
////    [self.view addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//    [gbl_myname addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//

//nbn(47);
//    // try doubleTapGestureRecognizer that does nil
//    gbl_doubleTapGestureRecognizer = [
//       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: nil
//    ];
//    [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 2];
//    [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
////    gbl_doubleTapGestureRecognizer.cancelsTouchesInView        = YES;   
//    gbl_doubleTapGestureRecognizer.delegate                  = self;   
////    [self.view addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//    [gbl_myname addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//








    if (   [gbl_homeEditingState  isEqualToString: @"add" ])   {
        NSInteger numper;
        numper = 0;
        for (NSString *perrec in  gbl_arrayPer) {
            if ( [perrec hasPrefix: @"~" ] ) continue;
            numper = numper + 1;
        }
        if (numper >= gbl_MAX_persons) {
  NSLog(@"numper          =[%ld]",(long)numper );
  NSLog(@"gbl_MAX_persons =[%ld]",(long)gbl_MAX_persons);
  NSLog(@"put up dialogue  Reached Maximum Number of People");        
        }
    }


  NSLog(@"self.tableView.userInteractionEnabled 1 in add/change viewDidLoad=[%d]",self.tableView.userInteractionEnabled );

    //    // 20160309  allow edit, etc of example "~" data
    //    // NO editing allowed for #allpeople or any example data ("~")
    //    // HOWEVER  gbl_homeEditingState = "add"  always allows editing 
    //    //
    //    if (   [gbl_fromHomeCurrentSelectionType isEqualToString: @"person" ]
    //        && (
    //               [gbl_lastSelectedPerson hasPrefix: @"~" ]
    //           )
    //       )
    //    {
    //        self.tableView.userInteractionEnabled =  NO;
    //    }
    //
    if (   [gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ]
        && (
               [gbl_lastSelectedGroup hasPrefix: @"#" ]
         //            || [gbl_lastSelectedGroup hasPrefix: @"~" ]
           )
       )
    {
        self.tableView.userInteractionEnabled =  NO;
    }

    //    if (   [gbl_homeEditingState  isEqualToString: @"add" ])
    if (   [gbl_homeUseMODE  isEqualToString: @"edit mode" ])    // not "report mode"
    {
        self.tableView.userInteractionEnabled = YES;

        // gbl_mycitySearchString.inputView = nil ;          // this has to be here to put up keyboard
        gbl_mycitySearchString.inputView = nil ;  // get rid of picker input view   // necessary ?  works?=yes
    }
  NSLog(@"self.tableView.userInteractionEnabled 2 in add/change viewDidLoad=[%d]",self.tableView.userInteractionEnabled );




    self.tableView.allowsMultipleSelectionDuringEditing = NO;

    gbl_lastSelectedPersonBeforeChange = gbl_lastSelectedPerson;   // like "~Dave"   used in YELLOW gbl_homeUseMODE "edit mode"
    gbl_lastSelectedGroupBeforeChange  = gbl_lastSelectedGroup ;   // like "~Dave"   used in YELLOW gbl_homeUseMODE "edit mode"


//
////UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeTapGesture:)];
//UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:gbl_myname action:@selector(didRecognizeTapGesture:)];
////[self.textField.superview addGestureRecognizer:tapGesture];
////[gbl_myname.superview addGestureRecognizer:tapGesture];
////[gbl_myname addGestureRecognizer:tapGesture];
//[self.tableView addGestureRecognizer:tapGesture];
//tapGesture.delegate = self;
//


    gbl_editingChangeNAMEHasOccurred = 0;  // default 0 at startup (after hitting "Edit" button on home page)
    gbl_editingChangeCITYHasOccurred = 0;  // default 0 at startup (after hitting "Edit" button on home page)
    gbl_editingChangeDATEHasOccurred = 0;  // default 0 at startup (after hitting "Edit" button on home page)

    gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"

    gbl_rollerBirthInfo   = @"" ;      // init // only shows stuff actually selected on the rollers


     // Disable the swipe to make sure you get your chance to save  
     // self.navigationController?.interactivePopGestureRecognizer.enabled = false
//     self.navigationController.interactivePopGestureRecognizer.enabled = false ;




// Note that there is also the "replace" menu item which cannot be disabled (in a safe way) from canPerformAction:withSender.
// To turn off paste, disable spell checking via the UITextField's UIInputTraits protocol. – Adam Kaplan Jan 10 at 17:49



    [[NSNotificationCenter defaultCenter] addObserver: self  // DISABLE showing of select/paste/cut etc (flashes a bit)
                                             selector: @selector(myMenuWillBeShown)
                                                 name: UIMenuControllerWillShowMenuNotification   // <<<====----
//                                               object: nil
                                               object: gbl_myname
    ];

    [[NSNotificationCenter defaultCenter] addObserver: self  // DISABLE showing of select/paste/cut etc (flashes a bit)
                                             selector: @selector(myApplicationDidBecomeActiveActions)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil
    ];


    [[NSNotificationCenter defaultCenter] addObserver: self  // DISABLE showing of select/paste/cut etc (flashes a bit)
                                             selector: @selector(keyboardWillShowAction)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil
    ];
    [[NSNotificationCenter defaultCenter] addObserver: self  // DISABLE showing of select/paste/cut etc (flashes a bit)
                                             selector: @selector(keyboardWillHideAction)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil
    ];



//
//    UIMenuController *menu = [UIMenuController sharedMenuController];
//    [menu setMenuVisible: NO];
//    [menu performSelector: @selector(setMenuVisible:)
//               withObject: [NSNumber numberWithBool: NO]
////               afterDelay: 0.1
//               afterDelay: 0.0
//    ]; //also tried 0 as interval both look quite similar



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


//
//I created UIView Class Extension and added this two functions. and when i want to disable view touch i just call [view makeExclusiveTouch];
//
//- (void) makeExclusiveTouchForViews:(NSArray*)views {
//    for (UIView * view in views) {
//        [view makeExclusiveTouch];
//    }
//}
//
//- (void) makeExclusiveTouch {
//    self.multipleTouchEnabled = NO;
//    self.exclusiveTouch = YES;
//    [self makeExclusiveTouchForViews:self.subviews];
//}
//
//

    self.pickerViewDateTime.delegate   = self;
    self.pickerViewDateTime.dataSource = self;
    self.pickerViewDateTime.hidden     =  NO;
//    self.pickerViewDateTime.multipleTouchEnabled = NO;
//    self.pickerViewDateTime.exclusiveTouch       = YES;


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
    //  2.  gbl_ToolbarForCityKeyboardWithPicklist    "Clear"        tor     "Wheel >" 
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
//        self.outletToButtonToGetPicklist = [[UIBarButtonItem alloc]initWithTitle: @"Picklist >"  
//        self.outletToButtonToGetPicklist = [[UIBarButtonItem alloc]initWithTitle: @"Wheel >"  
        self.outletToButtonToGetPicklist = [[UIBarButtonItem alloc]initWithTitle: gbl_titleForWheelButton
                                                                           style: UIBarButtonItemStylePlain
                                                                          target: self
                                                                          action: @selector( oncityInputViewPicklistButton: )
        ];

//        [self.outletToButtonToGetPicklist setTitleTextAttributes: @{
//    //                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size: 18.0],
//    //                    NSFontAttributeName: [UIFont fontWithName:@"Menlo-Bold" size: 18.0],
////                        NSFontAttributeName: [UIFont fontWithName:@"Menlo-Bold" size: 19.0],
//                        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size: 18.0],
//             NSForegroundColorAttributeName: [UIColor blueColor]
//        } forState: UIControlStateNormal];
//



//        gbl_dateButtonToClearKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"Clear Birth Date"  
        gbl_dateButtonToClearKeyboard = [[UIBarButtonItem alloc]initWithTitle: @"Clear"  
                                                                        style: UIBarButtonItemStylePlain
                                                                       target: self
                                                                       action: @selector( onDateInputViewClearButton: )
        ];



        //        self.outletToButtonToGetPicklist.tintColor = [UIColor yellowColor];
        //        self.outletToButtonToGetPicklist.tintColor = [UIColor redColor];
//                self.outletToButtonToGetPicklist.tintColor = [UIColor blackColor];
//                self.outletToButtonToGetPicklist.tintColor = [UIColor grayColor];
//                self.outletToButtonToGetPicklist.tintColor = [UIColor blueColor];
                self.outletToButtonToGetPicklist.tintColor = gbl_color_cAplDarkerBlue;




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
        gbl_ToolbarForGroupName     = [[UIToolbar alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
        gbl_ToolbarForBirthDate     = [[UIToolbar alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
        gbl_ToolbarForCityPicklist  = [[UIToolbar alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
        gbl_ToolbarForCityKeyboard  = [[UIToolbar alloc] initWithFrame: gbl_ToolbarForCityPicklist.bounds ];


        gbl_ToolbarForPersonName.translucent   = NO;  // prevent black background flash when returning from INFO screen
        gbl_ToolbarForGroupName.translucent    = NO;  // prevent black background flash when returning from INFO screen
        gbl_ToolbarForBirthDate.translucent    = NO;  // prevent black background flash when returning from INFO screen
        gbl_ToolbarForCityPicklist.translucent = NO;  // prevent black background flash when returning from INFO screen
        gbl_ToolbarForCityKeyboard.translucent = NO;  // prevent black background flash when returning from INFO screen

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
        gbl_ToolbarForBirthDate.translucent    = NO;  // prevent black background flash when returning from INFO screen


//        gbl_ToolbarForCityKeyboardHavingPicklist = [[UIToolbar alloc] initWithFrame: gbl_ToolbarForCityPicklist.bounds ];
//        gbl_ToolbarForCityKeyboardWithNoPicklist = [[UIToolbar alloc] initWithFrame: gbl_ToolbarForCityPicklist.bounds ];

//        gbl_ToolbarForCityPicklist               = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//        gbl_ToolbarForCityKeyboardHavingPicklist = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//        gbl_ToolbarForCityKeyboardWithNoPicklist = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0 320, 44)];


        // make arrays of buttons for the Toolbars
        //
        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"person" ] )
        {
            gbl_buttonArrayForPersonName    =  [NSArray arrayWithObjects:  // like  " Clear ... Type Person Name  ___      "
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
        }  //  gbl_fromHomeCurrentSelectionType = "person" 


        // make arrays of buttons for the Toolbars
        //
        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ] )
        {
                // for group 
            gbl_buttonArrayForGroupName     =  [NSArray arrayWithObjects:  // like  " Clear ... Type Group Name  ___      "
                gbl_nameButtonToClearKeyboard, gbl_flexibleSpace,
                gbl_title_groupName          , gbl_flexibleSpace,
                gbl_flexibleSpace            , nil ]; 

            // put the array of buttons in the Toolbar
            [gbl_ToolbarForGroupName    setItems: gbl_buttonArrayForGroupName  animated: YES];
        }  //  gbl_fromHomeCurrentSelectionType = "person" 




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
    self.array_am_pm       = [[NSMutableArray alloc]init];
 
    for (int i = 1; i <= 31; i++) {
        [self.array_DaysOfMonth addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    //NSLog(@"self.arrayMonths=%@",self.arrayMonths);
    for (int i = 1; i <= 12; i++) {
        [self.array_Hours_1_12 addObject:[NSString stringWithFormat:@"%02d", i]];  // values 1-12
    }
    for (int i = 0; i <= 59; i++) {
        [self.array_Min_0_59 addObject:[NSString stringWithFormat:@"%02d", i]];
    }
    [self.array_am_pm addObject: @"am" ];
    [self.array_am_pm addObject: @"pm" ];

//  NSLog(@" self.array_BirthYearsToPick.count !!!   =%ld",     self.array_BirthYearsToPick.count);
  NSLog(@" self.array_Months.count      =%ld", (unsigned long)self.array_Months.count);
  NSLog(@" self.array_DaysOfMonth.count;=%ld", (unsigned long)self.array_DaysOfMonth.count);
  NSLog(@" self.array_Hours_1_12.count  =%ld", (unsigned long)self.array_Hours_1_12.count);
  NSLog(@" self.array_Min_0_59.count    =%ld", (unsigned long)self.array_Min_0_59.count);
  NSLog(@" self.array_am_pm.count       =%ld", (unsigned long)self.array_am_pm.count);

    do {    // populate array array_BirthYearsToPick for uiPickerView and init picker and init birth info label field  (130 lines)
 
//        // get the current year
//        //
//        NSCalendar *gregorian = [NSCalendar currentCalendar];          // Get the Current Date and Time
//
// //        NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit)
// //                                                        fromDate:[NSDate date]];
//        NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitDay| NSCalendarUnitMonth | NSCalendarUnitYear)
//                                                        fromDate:[NSDate date]];

        // set elsewhere now
        //        gbl_currentYearInt  = [dateComponents year];
        //        gbl_currentMonthInt = [dateComponents month];
        //        gbl_currentDayInt   = [dateComponents day];

        NSLog(@"gbl_currentYearInt  =%ld",(long)gbl_currentYearInt  );
        NSLog(@"gbl_currentMonthInt =%ld",(long)gbl_currentMonthInt );
        NSLog(@"gbl_currentDayInt   =%ld",(long)gbl_currentDayInt   );
        
// NOT USED        
//        gbl_currentDay_yyyymmdd = [NSString stringWithFormat:@"%04ld%02ld%02ld",
//                                       (long)gbl_currentYearInt,
//                                       (long)gbl_currentMonthInt,
//                                       (long)gbl_currentDayInt     ];

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


        // for (NSInteger pickyr = gbl_earliestYear; pickyr <=  gbl_currentYearInt + 1; pickyr++) x  // only allow to go to next calendar year


        for (NSInteger pickyr = gbl_earliestYear;
//             pickyr <=  gbl_currentYearInt + 1;
             pickyr <=  gbl_currentYearInt + gbl_num_yrs_past_current_yr;
             pickyr++
        ) {  // only allow to go to next calendar year

            [self.array_BirthYearsToPick addObject: [@(pickyr) stringValue] ];
        }
  NSLog(@"self.array_BirthYearsToPick.count=%lu",(unsigned long)self.array_BirthYearsToPick.count);
        

        //  INIT DATE PICKER roller values   for "add"
        //
        if (   (   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
                || [gbl_homeUseMODE      isEqualToString: @"report mode" ]    // 'add' "+" is now on both brown and yellow home screens
               )
            && [gbl_homeEditingState isEqualToString: @"add" ]
        ) {
            gbl_rollerBirth_yyyy  = @"2000"; 
            gbl_rollerBirth_mth   = @"Jan";
            gbl_rollerBirth_dd    = @"01";
            gbl_rollerBirth_hour  = @"12";
            gbl_rollerBirth_min   = @"01";
            gbl_rollerBirth_amPm  = @"PM";

            NSString *myInitDateFormatted = gbl_initPromptDate ; // is @"Birth Date and Time"
  NSLog(@"myInitDateFormatted =%@",myInitDateFormatted );


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
            NSInteger myIndex;
            myIndex = [self.array_BirthYearsToPick  indexOfObject: @"2000"];  // start roller on year 2000

            // for (id member in self.array_BirthYearsToPick)    // loop thru year array

//            if (myIndex == NSNotFound) {
//                myIndex = yearsToPickFrom3.count - 1;
//            }

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

        } //  INIT DATE PICKER roller values   for "add"


//
//        //  INIT DATE PICKER roller values   for "view or change"
//        //
//        if (   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
//            && [gbl_homeEditingState isEqualToString: @"view or change" ]
//        ) {
//
//            gbl_rollerBirth_yyyy  = @"2000"; 
//            gbl_rollerBirth_mth   = @"Jan";
//            gbl_rollerBirth_dd    = @"01";
//            gbl_rollerBirth_hour  = @"12";
//            gbl_rollerBirth_min   = @"01";
//            gbl_rollerBirth_amPm  = @"PM";
//
//            NSString *myInitDateFormatted = gbl_initPromptDate ; // is @"Birth Date and Time"
//  NSLog(@"myInitDateFormatted =%@",myInitDateFormatted );
//
//
//            gbl_selectedBirthInfo = myInitDateFormatted;  // initial display of birth time info
//
//            // display YMDHMA  initial value
//            //
//            NSInteger myIndex;
//            myIndex = [self.array_BirthYearsToPick  indexOfObject: @"2000"];  // start roller on year 2000
//
//            // for (id member in self.array_BirthYearsToPick)    // loop thru year array
//
//            if (myIndex == NSNotFound) {
//                myIndex = yearsToPickFrom3.count - 1;
//            }
//
//            dispatch_async(dispatch_get_main_queue(), ^{    //  INIT  PICKER roller values
//
//                [self.pickerViewDateTime selectRow: myIndex inComponent: 0 animated: YES]; // This is how you manually SET(!!) a selection!
//                [self.pickerViewDateTime selectRow:       0 inComponent: 1 animated: YES]; // mth  = jan
//                [self.pickerViewDateTime selectRow:       0 inComponent: 2 animated: YES]; // day  = 01
//                // 3 = spacer
//                [self.pickerViewDateTime selectRow:      11 inComponent: 4 animated: YES]; // hr   = 12
//                // 5 = colon
//                [self.pickerViewDateTime selectRow:       1 inComponent: 6 animated: YES]; // min  = 01   2nd one
//                [self.pickerViewDateTime selectRow:       1 inComponent: 7 animated: YES]; // ampm = 12   2nd one
//            });
//
//        } 
//



    } while( false);  // populate array array_BirthYearsToPick for uiPickerView


  NSLog(@"gbl_justEnteredAddChangeView=[%ld]",(long)gbl_justEnteredAddChangeView);

    if (gbl_justEnteredAddChangeView == 1 )  // 1=y,0=n
    {
        gbl_justEnteredAddChangeView  = 0;

//        if (            gbl_myname.isFirstResponder == 1) {
//    nbn(821);
//            [gbl_myname             resignFirstResponder];
//        }
//        if (gbl_mycitySearchString.isFirstResponder == 1) {
//    nbn(822);
//
//            [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//        }
//        if (gbl_mybirthinformation.isFirstResponder == 1) {
//    nbn(823);
//            [gbl_mybirthinformation resignFirstResponder]; 
//        }

        // this got rid of input accssory showing on  edit > chg city > done > + > keyboard is showing

        [gbl_myname             resignFirstResponder];
        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
        [gbl_mybirthinformation resignFirstResponder]; 
    }

//    gbl_fieldTap_goingto = @"date";



//nbn(357);
//    [self doStuff_2_OnEnteringForeground];  // position highlight


nbn(358);
// put up name keyboard for person ALSO  - not just group
//    if (   [gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ] )
//    {
        [gbl_myname becomeFirstResponder];
//    }



    [self disp_gblsWithLabel: @"end of ViewDidLoad" ];

  NSLog(@"END ViewDidLoad   add/change");
tn();
} // viewDidLoad




// --------------------------------------------
//    isMovingFromParentViewController
// --------------------------------------------
//  Returns      a Boolean value that indicates that the view controller is in the process of being removed from its parent.
//  Declaration  OBJECTIVE-C - (BOOL)isMovingFromParentViewController
//  Return Value YES if the view controller is disappearing because it was removed from a container view controller, otherwise NO.
//  Discussion   This method returns YES only when called from inside the viewWillDisappear: and viewDidDisappear: methods.
//
// --------------------------------------------
//    isBeingDismissed
// --------------------------------------------
//  Returns      a Boolean value that indicates whether the view controller is in the process of being dismissed by one of its ancestors.
//  Declaration  OBJECTIVE-C - (BOOL)isBeingDismissed
//  Return Value YES if the view controller was previously presented
//               and is in the process of being dismissed by one of its ancestors, otherwise NO.
//  Discussion   This method returns YES only when called from inside the viewWillDisappear: and viewDidDisappear: methods.


// --------------------------------------------
//   isMovingToParentViewController
// --------------------------------------------
//  Returns      a Boolean value that indicates that the view controller is in the process of being added to a parent.
//  Declaration  OBJECTIVE-C - (BOOL)isMovingToParentViewController
//  Return Value YES if the view controller is appearing because it was added as a child of a container view controller, otherwise NO.
//   Discussion  This method returns YES only when called from inside the viewWillAppear: and viewDidAppear: methods.
//
// --------------------------------------------
//    isBeingPresented
// --------------------------------------------
//  Returns      a Boolean value that indicates whether the view controller is in the process of being presented by one of its ancestors.
//  Declaration  OBJECTIVE-C - (BOOL)isBeingPresented
//  Return Value YES if the view controller is appearing because it was presented by another view controller, otherwise NO
//  Discussion   This method returns YES only when called from inside the viewWillAppear: and viewDidAppear: methods.
//



- (void) myApplicationDidBecomeActiveActions
{
NSLog(@"in myApplicationDidBecomeActiveActions (notification action)   in add/change   ");
   // here, we want to resign all firstresponders unless we came from info
   //
   // here, we want to resign all firstresponders when returning from being dismissed

} // end of  myApplicationDidBecomeActiveActions



- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()  in add/change   ");


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // when view first appears on screen   after arg seconds
  tn();NSLog(@"igx in viewDidAppear add/change top    after ENDIgnor  ignoring=[%d]", [[UIApplication sharedApplication] isIgnoringInteractionEvents]);


    [self disp_gblsWithLabel: @"end of ViewDidAppear" ];

        // put up city picklist, if necessary
        //
  NSLog(@" put up city picklist, if necessary");
        if (gbl_justLookedAtInfoScreen ==  1) {

            // this is set to 0 in viewDidLoad  and 1 in INFO screen
            //            gbl_justLookedAtInfoScreen  =  0;

            // put up city picker, if it was up before going to info screen
            //
            if (   [gbl_firstResponder_current isEqualToString: @"city" ]
                && [gbl_mycityInputView        isEqualToString: @"picker" ] )
            {
  NSLog(@" put up city picklist !");
                [self putUpCityPicklist ];                                         // TODO putUpCityPicklist only called twice




//  needed?    [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"


                [self.pickerViewCity selectRow: gbl_lastSelectedCityPickerRownum  inComponent: 0 animated: YES]; // mth  = jan

                // populates gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun
//                [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, Prov, Coun
                [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath
            }
            return;
        }



} // viewDidAppear



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
//- (BOOL)shouldAutorotate {
//  NSLog(@"in ADD   shouldAutorotate !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    return YES;
//}
//
//// - (NSUInteger)supportedInterfaceOrientations
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//  NSLog(@"in ADD   supportedInterfaceOrientations !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    return UIInterfaceOrientationMaskPortrait;
//}
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  NSLog(@"in add/change supportedInterfaceOrientations !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    return UIInterfaceOrientationMaskAll;
    return UIInterfaceOrientationMaskPortrait;

}
- (BOOL)shouldAutorotate {
  NSLog(@"in HOME shouldAutorotate !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return NO;  // means do not call supportedInterfaceOrientations
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
tn();
  NSLog(@"in viewWillAppear! in ADD CHANGE");




  NSLog(@"gbl_homeUseMODE     =[%@]",gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
  NSLog(@"gbl_fromHomeCurrentEntity       =%@",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
  NSLog(@"gbl_fromHomeCurrentEntityName   =[%@]",gbl_fromHomeCurrentEntityName);
  NSLog(@"gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV);


    gbl_justEnteredAddChangeView = 1;  // 1=y,0=n

tn();trn("--qx--- in ADD/CHANGE viewWillAppear  TOP ==================================================================");
  NSLog(@"gbl_myname.text        =[%@]",gbl_myname.text);
  NSLog(@"gbl_mycityprovcounLabel=[%@]",gbl_mycityprovcounLabel.text);
  NSLog(@"gbl_mybirthinformatione=[%@]",gbl_mybirthinformation.text);
  NSLog(@"gbl_userSpecifiedPersonName  =[%@]",gbl_userSpecifiedPersonName  );
  NSLog(@"gbl_userSpecifiedCity        =[%@]",gbl_userSpecifiedCity        );
  NSLog(@"gbl_userSpecifiedProv        =[%@]",gbl_userSpecifiedProv        );
  NSLog(@"gbl_userSpecifiedCoun        =[%@]",gbl_userSpecifiedCoun        );
  NSLog(@"gbl_selectedBirthInfo        =[%@]",gbl_selectedBirthInfo        );
  NSLog(@"gbl_DisplayName              =[%@]",gbl_DisplayName );
  NSLog(@"gbl_DisplayDate              =[%@]",gbl_DisplayDate );
  NSLog(@"gbl_DisplayCity              =[%@]",gbl_DisplayCity );
  NSLog(@"gbl_DisplayProv              =[%@]",gbl_DisplayProv );
  NSLog(@"gbl_DisplayCoun              =[%@]",gbl_DisplayCoun );
  NSLog(@"gbl_enteredCity              =[%@]",gbl_enteredCity );
  NSLog(@"gbl_enteredProv              =[%@]",gbl_enteredProv );
  NSLog(@"gbl_enteredCoun              =[%@]",gbl_enteredCoun );
trn("-------------------------------------------");
  NSLog(@"gbl_fromHomeCurrentSelectionPSV    = [%@]",gbl_fromHomeCurrentSelectionPSV);
  NSLog(@"gbl_justEnteredAddChangeView       = [%ld]",(long)gbl_justEnteredAddChangeView);
  NSLog(@"gbl_myCitySoFar                    = [%@]",gbl_myCitySoFar );
  NSLog(@"gbl_lastSelectedGroup              = [%@]",gbl_lastSelectedGroup);
  NSLog(@"gbl_lastSelectedPerson             = [%@]",gbl_lastSelectedPerson);
  NSLog(@"gbl_lastSelectedPersonBeforeChange = [%@]",gbl_lastSelectedPersonBeforeChange);
  NSLog(@"gbl_lastSelectedGroupBeforeChange  = [%@]",gbl_lastSelectedGroupBeforeChange);
  NSLog(@"gbl_rollerBirthInfo                = [%@]",gbl_rollerBirthInfo);
trn("-------------------------------------------"); tn();





//    gbl_dblTapRecog_InNameCell = nil;  // force create a gesture recognizer for cell
//    gbl_oneTapRecog_InNameCell = nil;  // force create a gesture recognizer for cell


    if (   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
        && [gbl_homeEditingState isEqualToString: @"view or change" ]
    ) {
        gbl_citySetEditingValue  = 1;  // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
        gbl_citySetPickerValue   = 1;  // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
        gbl_citySetLabelValue    = 1;  // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow

        gbl_dateSetEditingValue  = 1;  // 1=y,0=n  // set initial values when first entering Date in "edit mode"  yellow

    } else {
        gbl_citySetEditingValue  = 0;  // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
        gbl_citySetPickerValue   = 0;  // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
        gbl_citySetLabelValue    = 0;  // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow

        gbl_dateSetEditingValue  = 0;  // 1=y,0=n  // set initial values when first entering Date in "edit mode"  yellow

    }

    // grab all personal information of gbl_fromHomeCurrentSelectionPSV 
    //
        // 2015-12-11 15:37:58.275 Me and My BFFs[2970:1143000] gbl_homeUseMODE     =[edit mode]
        // 2015-12-11 15:37:58.275 Me and My BFFs[2970:1143000] gbl_homeEditingState=[view or change]
        //
    if (   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
        && [gbl_homeEditingState isEqualToString: @"view or change" ]
    ) {

        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"person" ] )
        {  // in edit or view mode    "person" gbl_fromHomeCurrentSelectionType  

            // do field stuff    from gbl_fromHomeCurrentSelectionPSV 
            // but only if we're not just returning from info screen
            //
            if (gbl_justLookedAtInfoScreen ==  0) {

                //
                //        // NSString object to C
                //        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding];  // for personality
                //
                //        strcpy(my_psv, my_psvc);
                //        ksn(my_psv);
                //        
                //        strcpy(psvName, csv_get_field(my_psv, "|", 1));
                //        strcpy(psvMth,  csv_get_field(my_psv, "|", 2));
                //        strcpy(psvDay,  csv_get_field(my_psv, "|", 3));
                //        strcpy(psvYear, csv_get_field(my_psv, "|", 4));
                //        strcpy(psvHour, csv_get_field(my_psv, "|", 5));
                //        strcpy(psvMin,  csv_get_field(my_psv, "|", 6));
                //        strcpy(psvAmPm, csv_get_field(my_psv, "|", 7));
                //        strcpy(psvCity, csv_get_field(my_psv, "|", 8));
                //        strcpy(psvProv, csv_get_field(my_psv, "|", 9));
                //        strcpy(psvCountry, csv_get_field(my_psv, "|", 10));
                //ksn(psvMth);ks(psvDay);ks(psvYear);ks(psvHour);ks(psvMin);ks(psvAmPm);tn();
                //ksn(psvCity);ks(psvProv);ks(psvCountry);tn();
                //        
                //        // get longitude and timezone hoursDiff from Greenwich
                //        // by looking up psvCity, psvProv, psvCountry
                //        //
                //        seq_find_exact_citPrvCountry(returnPSV, psvCity, psvProv, psvCountry);
                //        
                //        strcpy(psvHoursDiff,  csv_get_field(returnPSV, "|", 1));
                //        strcpy(psvLongitude,  csv_get_field(returnPSV, "|", 2));
                //ksn(psvHoursDiff);
                //ksn(psvLongitude);
                //

                NSArray *fields = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"];
                fldName      =  fields[ 0];
                fldMth       =  fields[ 1];
                fldDay       =  fields[ 2];
                fldYear      =  fields[ 3];
                fldHour      =  fields[ 4];
                fldMin       =  fields[ 5];
                fldAmPm      =  fields[ 6];
                fldCity      =  fields[ 7];
  NSLog(@"citych #43  %-24s =[%@] $$$  viewWillAppear top $$$$$$$$$$$$$$$$$$$$", "fldCity " , fldCity );
                fldProv      =  fields[ 8];
                fldCountry   =  fields[ 9];
                fldKindOfSave  = fields[10];;

                if (   [fldKindOfSave  isEqualToString: @"hs" ] )
                {
                    gbl_kindOfSave = @"no look no change save";  // this var is used throughout
                } else {
                    gbl_kindOfSave = @"regular save";        // this var is used throughout
                }



        // NO MORE choose kind of save  (personal privacy)
        //
//        fldKindOfSave  = @"hs";
//        gbl_kindOfSave = @"no look no change save";  // set default  // this var is used throughout





  NSLog(@"fldName   = [%@]",fldName);
  NSLog(@"fldMth    = [%@]",fldMth);
  NSLog(@"fldDay    = [%@]",fldDay);
  NSLog(@"fldYear   = [%@]",fldYear);
  NSLog(@"fldHour   = [%@]",fldHour);
  NSLog(@"fldMin    = [%@]",fldMin);
  NSLog(@"fldAmPm   = [%@]",fldAmPm);
  NSLog(@"fldCity   = [%@]",fldCity);
  NSLog(@"fldProv   = [%@]",fldProv);
  NSLog(@"fldCountry= [%@]",fldCountry);
  NSLog(@"fldKindOfSave= [%@]",fldKindOfSave);

                if (   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
                    && [gbl_homeEditingState isEqualToString: @"view or change" ]
                ) {
                    gbl_myCitySoFar = fldCity;
  NSLog(@"citych #42  %-24s =[%@] $$$  viewWillAppear top $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar " , gbl_myCitySoFar );
                    gbl_enteredCity = fldCity;
  NSLog(@"citych #41  %-24s =[%@] $$$  viewWillAppear top $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity );
                    gbl_enteredProv = fldProv;
                    gbl_enteredCoun = fldCountry;
  NSLog(@"SET gbl_myCitySoFar #01=[%@]",gbl_myCitySoFar );

                } else {
                    gbl_myCitySoFar = @"";
                    gbl_enteredCity = @"";
  NSLog(@"citych #40  %-24s =[%@] $$$  viewWillAppear top $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity );
                    gbl_enteredProv = @"";
                    gbl_enteredCoun = @"";
  NSLog(@"SET gbl_myCitySoFar #02=[%@]",gbl_myCitySoFar );
                }

  NSLog(@" -1 gbl_myCitySoFar  =[%@]",gbl_myCitySoFar );
  NSLog(@" -1 gbl_enteredCity  =[%@]",gbl_enteredCity );
  NSLog(@" -1 gbl_enteredProv  =[%@]",gbl_enteredProv );
  NSLog(@" -1 gbl_enteredCoun  =[%@]",gbl_enteredCoun );


//            RIGHT CURLY BRACKET   // if (gbl_justLookedAtInfoScreen ==  0) 



            //  INIT DATE PICKER roller values   for "view or change"
            //
            if (   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
                && [gbl_homeEditingState isEqualToString: @"view or change" ]
            ) {
                // gbl_rollerBirth_yyyy  = @"2000"; 
                // gbl_rollerBirth_mth   = @"Jan";
                // gbl_rollerBirth_dd    = @"01";
                // gbl_rollerBirth_hour  = @"12";
                // gbl_rollerBirth_min   = @"01";
                // gbl_rollerBirth_amPm  = @"pm";
                //
                gbl_rollerBirth_yyyy  = fldYear;

    //            gbl_rollerBirth_mth   = fldMth;
                // self.array_Months      = [[NSArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
                gbl_rollerBirth_mth   = self.array_Months[ [fldMth intValue] - 1 ];

                gbl_rollerBirth_dd    = fldDay;
                gbl_rollerBirth_hour  = fldHour;
                gbl_rollerBirth_min   = fldMin;
    //            gbl_rollerBirth_amPm  = fldAmPm;
                gbl_rollerBirth_amPm  = @"am"; // default  (should never happen)
                if ( [fldAmPm isEqualToString: @"0" ] )  gbl_rollerBirth_amPm  = @"am";
                if ( [fldAmPm isEqualToString: @"1" ] )  gbl_rollerBirth_amPm  = @"pm";

                //            NSString *myInitDateFormatted = gbl_initPromptDate ; // is @"Birth Date and Time"
//      NSLog(@"myInitDateFormatted =%@",myInitDateFormatted );
//      NSLog(@" 0 gbl_rollerBirth_yyyy =%@",gbl_rollerBirth_yyyy );
//      NSLog(@" 0 gbl_rollerBirth_mth  =%@",gbl_rollerBirth_mth  );
//      NSLog(@" 0 gbl_rollerBirth_dd   =%@",gbl_rollerBirth_dd   );
//      NSLog(@" 0 gbl_rollerBirth_hour =%@",gbl_rollerBirth_hour );
//      NSLog(@" 0 gbl_rollerBirth_min  =%@",gbl_rollerBirth_min  );
//      NSLog(@" 0 gbl_rollerBirth_amPm =%@",gbl_rollerBirth_amPm );


                // show  selected day field on screen    fmt "2016 Dec 25  12:01 am"
                //
                //    self.array_BirthYearsToPick 
                //    self.array_Months      
                //    self.array_DaysOfMonth
                //    self.array_Hours_1_12
                //    self.array_Min_0_59 
                //    self.array_am_pm   
                //
                NSString *myFormattedStr =  [NSString stringWithFormat: @"%@  %@ %@  %@:%@ %@",  // fmt "2016 Dec 25  12:01 am"
                                                                    //            array_3letterDaysOfWeek[my_day_of_week_idx],
    //                gbl_rollerBirth_yyyy,
    //                self.array_Months     [ [gbl_rollerBirth_mth   intValue] - 1 ], // starts at one
    //                self.array_DaysOfMonth[ [gbl_rollerBirth_dd    intValue] - 1 ], // starts at one
    //                self.array_Hours_1_12 [ [gbl_rollerBirth_hour  intValue] - 1 ], // starts at one
    //                self.array_Min_0_59   [ [gbl_rollerBirth_min   intValue]     ], // starts at zero
    //                self.array_am_pm      [ [gbl_rollerBirth_amPm  intValue]     ]  // starts at zero

                    gbl_rollerBirth_yyyy,
                    self.array_Months     [ [fldMth   intValue] - 1 ], // starts at one
                    self.array_DaysOfMonth[ [fldDay   intValue] - 1 ], // starts at one
                    self.array_Hours_1_12 [ [fldHour  intValue] - 1 ], // starts at one
                    self.array_Min_0_59   [ [fldMin   intValue]     ], // starts at zero
                    self.array_am_pm      [ [fldAmPm  intValue]     ]  // starts at zero
                ];

                gbl_selectedBirthInfo = myFormattedStr ;
                gbl_rollerBirthInfo   = myFormattedStr ;  // only shows stuff actually selected on the rollers


                // display YMDHMA  initial value on rollers
                //
                NSInteger myIdxInPicker_Year, myIdxInPicker_Mth, myIdxInPicker_Day, myIdxInPicker_Hour, myIdxInPicker_Min, myIdxInPicker_AmPm;

    //            myIdxInPicker_Year     = [self.array_BirthYearsToPick  indexOfObject: gbl_rollerBirth_yyyy];
    //            myIdxInPicker_Mth      = [gbl_rollerBirth_mth  intValue] - 1; // starts at one
    //            myIdxInPicker_Day      = [gbl_rollerBirth_dd   intValue] - 1; // starts at one  
    //            myIdxInPicker_Hour     = [gbl_rollerBirth_hour intValue] - 1; // starts at one 
    //            myIdxInPicker_Min      = [gbl_rollerBirth_min  intValue]    ; // min starts at zero, not one
    //            myIdxInPicker_AmPm     = [gbl_rollerBirth_amPm intValue]    ; // ampm starts at zero, not one

                myIdxInPicker_Year = [self.array_BirthYearsToPick  indexOfObject: gbl_rollerBirth_yyyy ];

//                if (myIdxInPicker_Year == NSNotFound) {
//                    myIdxInPicker_Year = yearsToPickFrom3.count - 1;
//                }

      NSLog(@"myIdxInPicker_Year=[%ld]",(long)myIdxInPicker_Year);
                myIdxInPicker_Mth      = [fldMth  intValue] - 1; // starts at one
      NSLog(@"myIdxInPicker_Mth =[%ld]",(long)myIdxInPicker_Mth );
                myIdxInPicker_Day      = [fldDay  intValue] - 1; // starts at one  
      NSLog(@"myIdxInPicker_Day =[%ld]",(long)myIdxInPicker_Day );
                myIdxInPicker_Hour     = [fldHour intValue] - 1; // starts at one 
      NSLog(@"myIdxInPicker_Hour=[%ld]",(long)myIdxInPicker_Hour);
                myIdxInPicker_Min      = [fldMin  intValue]    ; // min starts at zero, not one
      NSLog(@"myIdxInPicker_Min =[%ld]",(long)myIdxInPicker_Min );
                myIdxInPicker_AmPm     = [fldAmPm intValue]    ; // ampm starts at zero, not one
      NSLog(@"myIdxInPicker_AmPm=[%ld]",(long)myIdxInPicker_AmPm);

                // for (id member in self.array_BirthYearsToPick)    // loop thru year array

//                if (myIdxInPicker_Year == NSNotFound) {                // should not happen
//                    myIdxInPicker_Year = yearsToPickFrom3.count - 1;   // ?
//                }

                dispatch_async(dispatch_get_main_queue(), ^{    //  INIT  PICKER roller values

                    [self.pickerViewDateTime selectRow: myIdxInPicker_Year inComponent: 0 animated: YES]; // This is how you manually SET(!!) a selection!
                    [self.pickerViewDateTime selectRow: myIdxInPicker_Mth  inComponent: 1 animated: YES]; // mth  = jan
                    [self.pickerViewDateTime selectRow: myIdxInPicker_Day  inComponent: 2 animated: YES]; // day  = 01
                    // 3 = spacer
                    [self.pickerViewDateTime selectRow: myIdxInPicker_Hour inComponent: 4 animated: YES]; // hr   = 12
                    // 5 = colon
                    [self.pickerViewDateTime selectRow: myIdxInPicker_Min  inComponent: 6 animated: YES]; // min  = 01   2nd one
                    [self.pickerViewDateTime selectRow: myIdxInPicker_AmPm inComponent: 7 animated: YES]; // ampm = 12   2nd one
                });

            } 
                
            gbl_myname.text = fldName;
  NSLog(@"citych #39  %-24s =[%@] $$$  viewWillAppear  $$$$$$$$$$$$$$$$$$$$", "gbl_myname" , gbl_myname.text);

            gbl_enteredCity        = fldCity; 
  NSLog(@"citych #38  %-24s =[%@] $$$  viewWillAppear  $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity);
            gbl_enteredProv        = fldProv;
            gbl_enteredCoun        = fldCountry;
            // end of [gbl_homeUseMODE      isEqualToString: @"edit mode" ] && [gbl_homeEditingState isEqualToString: @"view or change" ]

} // if (gbl_justLookedAtInfoScreen ==  0) 

        } // end of   "person" gbl_fromHomeCurrentSelectionType 





        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ] )
        {  // "group"

            NSArray *fieldsG = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"];

            fldNameG        = fieldsG[0];
            gbl_myname.text = fldNameG;
  NSLog(@"gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"fldNameG                        =[%@]",fldNameG  );
  NSLog(@"gbl_myname.text                 =[%@]",gbl_myname.text );

        } // end of  "group" gbl_fromHomeCurrentSelectionType 

        // this WAS view/change mode 
    } else {
        // this is add mode 

        // set "Name"  initial prompt, but only if its not set already
        // So, if we have just looked at info screen, do not set it
        //
        if (gbl_justLookedAtInfoScreen ==  1) {
            // name is set already
        } else  {
            gbl_myname.text = gbl_initPromptName;
  NSLog(@"citych #37  %-24s =[%@] $$$  viewWillAppear  $$$$$$$$$$$$$$$$$$$$", "gbl_myname" , gbl_myname.text);
        }

        gbl_enteredCity        = gbl_initPromptCity;  // @"City or Town";  for display in gbl_mycityprovcounLabel= found city,prov,counl
  NSLog(@"citych #36  %-24s =[%@] $$$  viewWillAppear  $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity);
        gbl_enteredProv        = gbl_initPromptProv;  // @"State or Province";
        gbl_enteredCoun        = gbl_initPromptCoun;  // @"Country";

        gbl_kindOfSave = @"regular save";   // set default    // this var is used throughout

//        gbl_kindOfSave = @"no look no change save";  // set default  // this var is used throughout

    }

    gbl_previousCharTypedWasSpace = 0;                 // for no multiple consecutive spaces


    // set blue  or  yellow  background color
    //
    if (   [gbl_homeUseMODE      isEqualToString: @"report mode" ]
        && [gbl_homeEditingState isEqualToString: @"add" ]
    ) {
        self.view.backgroundColor     = gbl_colorHomeBG;     // BROWN
        gbl_colorEditingBG_current    = gbl_colorHomeBG;     // is now yellow or brown for add a record screen  (addChange view)
    } else {
        self.view.backgroundColor     = gbl_colorEditingBG;  // set YELLOW bg for editing screens
        gbl_colorEditingBG_current    = gbl_colorEditingBG;  // is now yellow or brown for add a record screen  (addChange view)
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
//        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave   // this worked to get "Save" title
                                                                                         target: self
                                                                                         action: @selector(pressedSaveDone:)];


//        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        UIBarButtonItem *navCancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                                                         target: self
                                                                                         action: @selector(pressedCancel:)];


//  NSLog(@"gbl_didAddDoneButtonInAddChange 1 =[%ld]",(long)gbl_didAddDoneButtonInAddChange );
        if (gbl_didAddDoneButtonInAddChange == 0)     // 1=yes, 0=no  set=0 in add/change viewDidLoad  set=1 when Done is added to nav bar
        {
             gbl_didAddDoneButtonInAddChange = 1;     // 1=yes, 0=no  set=0 in add/change viewDidLoad  set=1 when Done is added to nav bar
 
             dispatch_async(dispatch_get_main_queue(), ^{  
 
  //            self.navigationItem.leftBarButtonItems   =
  //                [self.navigationItem.leftBarButtonItems   arrayByAddingObject: navCancelButton]; // add CANCEL BUTTON
 
 
                 self.navigationItem.leftBarButtonItem    = navCancelButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item
  //            self.navigationItem.backBarButtonItem    = navCancelButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item
 
  

                 self.navigationItem.rightBarButtonItems  =
                     [self.navigationItem.rightBarButtonItems  arrayByAddingObject: gbl_flexibleSpace ]; // add spacer

                 self.navigationItem.rightBarButtonItems  =
                     [self.navigationItem.rightBarButtonItems  arrayByAddingObject: navSaveButton  ]; // add SAVE / DONE  BUTTON
 

                 self.navigationItem.rightBarButtonItems  =
                     [self.navigationItem.rightBarButtonItems  arrayByAddingObject: gbl_flexibleSpace ]; // add spacer

             });
        }
//  NSLog(@"gbl_didAddDoneButtonInAddChange 2 =[%ld]",(long)gbl_didAddDoneButtonInAddChange );


        if ( [gbl_homeEditingState isEqualToString: @"add" ]) {  // "add" for add a new person or group, "view or change" for tapped person or group

            gbl_helpScreenDescription = @"add";

            if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"] ) {
                dispatch_async(dispatch_get_main_queue(), ^{  
//                    [[self navigationItem] setTitle: @"Add Person"];
                    [[self navigationItem] setTitle: @"Add New Person"];
                });
            }
            if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"group"] ) {
                dispatch_async(dispatch_get_main_queue(), ^{   
//                    [[self navigationItem] setTitle: @"Add Group"];
                    [[self navigationItem] setTitle: @"Add New Group"];
                });
            }
        }

        if ( [gbl_homeEditingState isEqualToString: @"view or change" ]) {  

            gbl_helpScreenDescription = @"view or change";

//            CGFloat myScreenWidth, myFontSize;  // determine font size
//            myScreenWidth = self.view.bounds.size.width;
//            if (        myScreenWidth >= 414.0)  { myFontSize = 16.0; }  // 6+ and 6s+  and bigger
//            else if (   myScreenWidth  < 414.0   
//                     && myScreenWidth  > 320.0)  { myFontSize = 16.0; }  // 6 and 6s
//            else if (   myScreenWidth <= 320.0)  { myFontSize = 10.0; }  //  5s and 5 and 4s and smaller
//            else                                 { myFontSize = 16.0; }  //  other ?
//


            // from  http://stackoverflow.com/questions/12677059/how-to-control-title-font-in-uinavigationbar-title
            //
            // UILabel *bigLabel = [[UILabel alloc] init];
            //
            // bigLabel.text                      = @"1111111122222233333344444455555556666777888899999000000";
            // bigLabel.backgroundColor           = [UIColor clearColor];
            // bigLabel.textColor                 = [UIColor whiteColor];
            // bigLabel.font                      = [UIFont boldSystemFontOfSize:20];
            // bigLabel.adjustsFontSizeToFitWidth = YES;
            // [bigLabel sizeToFit];
            //
            // self.navigationItem.titleView = bigLabel;

            UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

            myNavBarLabel.textColor     = [UIColor blackColor];
            myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
            if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"] ) {
//                myNavBarLabel.text          = [NSString stringWithFormat:@"%@", gbl_lastSelectedPerson ];
                myNavBarLabel.text          = @"Edit Person";
            }
            if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"group"] ) {
//                myNavBarLabel.text          = [NSString stringWithFormat:@"%@", gbl_lastSelectedGroup ];
//                myNavBarLabel.text          = @"Change Group Name  ";
                myNavBarLabel.text          = @"Change Group Name ";
            }


// instead, use            myNavBarLabel.adjustsFontSizeToFitWidth = YES;  + do not set font size

        //            CGFloat myScreenWidth, myFontSize;  // determine font size
        //            myScreenWidth = self.view.bounds.size.width;
        //            if (        myScreenWidth >= 414.0)  { myFontSize = 16.0; }  // 6+ and 6s+  and bigger
        //            else if (   myScreenWidth  < 414.0   
        //                     && myScreenWidth  > 320.0)  { myFontSize = 16.0; }  // 6 and 6s
        //            else if (   myScreenWidth <= 320.0)  { myFontSize = 10.0; }  //  5s and 5 and 4s and smaller
        //            else                                 { myFontSize = 16.0; }  //  other ?
        //
        // CGFloat   gbl_heightForScreen;  // 6+  = 736.0 x 414  and 6s+  (self.view.bounds.size.width) and height
        //                                 // 6s  = 667.0 x 375  and 6
        //                                 // 5s  = 568.0 x 320  and 5 
        //                                 // 4s  = 480.0 x 320  and 5 
        //
//  NSLog(@"self.view.bounds.size.height  =[%f]",self.view.bounds.size.height  );

            if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
            ) {
                myNavBarLabel.font = [UIFont boldSystemFontOfSize: 17.0];
            }
            else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                     && self.view.bounds.size.width  > 320.0
            ) {
                myNavBarLabel.font = [UIFont boldSystemFontOfSize: 17.0];
            }
            else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
            ) {
                if ([myNavBarLabel.text isEqualToString: @"Edit Person"]) myNavBarLabel.font = [UIFont boldSystemFontOfSize: 14.0];
                else                                                      myNavBarLabel.font = [UIFont boldSystemFontOfSize: 12.0];
            }
            else if (   self.view.bounds.size.width <= 320.0   // ??
            ) {
                myNavBarLabel.font = [UIFont boldSystemFontOfSize: 12.0];
            }
//            myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 17.0];



//            myNavBarLabel.adjustsFontSizeToFitWidth = YES;
            [myNavBarLabel sizeToFit];

            dispatch_async(dispatch_get_main_queue(), ^{  
                self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
            });
        } // if ( [gbl_homeEditingState isEqualToString: @"view or change" ])   


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


tn();trn("--qx--- in ADD/CHANGE viewWillAppear  BOTTom ==================================================================");
  NSLog(@"gbl_myname.text        =[%@]",gbl_myname.text);
  NSLog(@"gbl_mycityprovcounLabel=[%@]",gbl_mycityprovcounLabel.text);
  NSLog(@"gbl_mybirthinformatione=[%@]",gbl_mybirthinformation.text);
  NSLog(@"gbl_userSpecifiedPersonName  =[%@]",gbl_userSpecifiedPersonName  );
  NSLog(@"gbl_userSpecifiedCity        =[%@]",gbl_userSpecifiedCity        );
  NSLog(@"gbl_userSpecifiedProv        =[%@]",gbl_userSpecifiedProv        );
  NSLog(@"gbl_userSpecifiedCoun        =[%@]",gbl_userSpecifiedCoun        );
  NSLog(@"gbl_selectedBirthInfo        =[%@]",gbl_selectedBirthInfo        );
  NSLog(@"gbl_DisplayName              =[%@]",gbl_DisplayName );
  NSLog(@"gbl_DisplayDate              =[%@]",gbl_DisplayDate );
  NSLog(@"gbl_DisplayCity              =[%@]",gbl_DisplayCity );
  NSLog(@"gbl_DisplayProv              =[%@]",gbl_DisplayProv );
  NSLog(@"gbl_DisplayCoun              =[%@]",gbl_DisplayCoun );
  NSLog(@"gbl_enteredCity              =[%@]",gbl_enteredCity );
  NSLog(@"gbl_enteredProv              =[%@]",gbl_enteredProv );
  NSLog(@"gbl_enteredCoun              =[%@]",gbl_enteredCoun );
trn("-------------------------------------------");
  NSLog(@"gbl_fromHomeCurrentSelectionPSV    = [%@]",gbl_fromHomeCurrentSelectionPSV);
  NSLog(@"gbl_justEnteredAddChangeView       = [%ld]",(long)gbl_justEnteredAddChangeView);
  NSLog(@"gbl_myCitySoFar                    = [%@]",gbl_myCitySoFar );
  NSLog(@"gbl_lastSelectedGroup              = [%@]",gbl_lastSelectedGroup);
  NSLog(@"gbl_lastSelectedPerson             = [%@]",gbl_lastSelectedPerson);
  NSLog(@"gbl_lastSelectedPersonBeforeChange = [%@]",gbl_lastSelectedPersonBeforeChange);
  NSLog(@"gbl_lastSelectedGroupBeforeChange  = [%@]",gbl_lastSelectedGroupBeforeChange);
  NSLog(@"gbl_rollerBirthInfo                = [%@]",gbl_rollerBirthInfo);
trn("-------------------------------------------"); tn();





} // end of   viewWillAppear


//action: @selector( onNameInputViewClearButton: )
- (IBAction) onNameInputViewClearButton: (id)sender {
  NSLog(@"in onNameInputViewClearButton!");

nbn(351);
//if(  gbl_editingChangeNAMEHasOccurred == nil) NSLog(@"gbl_editingChangeNAMEHasOccurred =[nil]");
//else  NSLog(@"gbl_editingChangeNAMEHasOccurred =[%@]", gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_editingChangeNAMEHasOccurred idxGrpOrPer =%ld", (long)gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
NSUInteger mybytes;
mybytes = [gbl_userSpecifiedPersonName  lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
NSLog(@"mybytes gbl_userSpecifiedPersonName          =[%i]", mybytes);
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
  NSLog(@"gbl_myname.text                            =[%@]", gbl_myname.text );
  NSLog(@"gbl_DisplayName                            =[%@]",  gbl_DisplayName);


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

nbn(352);
//if(  gbl_editingChangeNAMEHasOccurred == nil) NSLog(@"gbl_editingChangeNAMEHasOccurred =[nil]");
//else  NSLog(@"gbl_editingChangeNAMEHasOccurred =[%@]", gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_editingChangeNAMEHasOccurred idxGrpOrPer =%ld", (long)gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
mybytes = [gbl_userSpecifiedPersonName  lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
NSLog(@"mybytes gbl_userSpecifiedPersonName          =[%i]", mybytes);
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
  NSLog(@"gbl_myname.text                            =[%@]", gbl_myname.text );
  NSLog(@"gbl_DisplayName                            =[%@]",  gbl_DisplayName);


} // end of onNameInputViewClearButton


//action: @selector( onDateInputViewClearButton: )
- (IBAction) onDateInputViewClearButton: (id)sender {
  NSLog(@"in onDateInputViewClearButton!");

    gbl_rollerBirth_yyyy  = @"2000"; 
    gbl_rollerBirth_mth   = @"Jan";
    gbl_rollerBirth_dd    = @"01";
    gbl_rollerBirth_hour  = @"12";
    gbl_rollerBirth_min   = @"01";
    gbl_rollerBirth_amPm  = @"pm";

//    NSString *myInitDateFormatted = @"Birth Date and Time";  // use yr= 2000
    NSString *myInitDateFormatted = gbl_initPromptDate ;  // is @"Birth Date and Time" // use yr= 2000

    gbl_selectedBirthInfo = myInitDateFormatted;  // initial display of birth time info


    //  INIT  PICKER roller values
    //
//        NSString* myInitYear = [NSString stringWithFormat:@"%i", initYYYY];  // convert c int to NSString
    NSInteger myIndex;
    myIndex = [self.array_BirthYearsToPick  indexOfObject: @"2000"];  // start roller on year 2000

    // for (id member in self.array_BirthYearsToPick)    // loop thru year array

//    if (myIndex == NSNotFound) {
//        myIndex = yearsToPickFrom3.count - 1;
//    }

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

  NSLog(@"= 01 =====  BECOME first responder = gbl_mybirthinformation ");
             [gbl_mybirthinformation becomeFirstResponder];
    });



} // end of onDateInputViewClearButton




- (IBAction) oncityInputViewClearButton1: (id)sender {   // hit button "Clear City"  
  NSLog(@"in oncityInputViewClearButton1!");

    gbl_myCitySoFar                   = @"";
  NSLog(@"SET gbl_myCitySoFar #03=[%@]",gbl_myCitySoFar );
  NSLog(@"citych #34  %-24s =[%@] $$$  oncityInputViewClearButton1  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar" , gbl_myCitySoFar );


  NSLog(@"--- clrcit ---  111  ---------------------------------------------");
  NSLog(@"gbl_mycitySearchString.text      =[%@]", gbl_mycitySearchString.text);
  NSLog(@"gbl_myCitySoFar                  =[%@]", gbl_myCitySoFar);
  NSLog(@"gbl_enteredCity                  =[%@]", gbl_enteredCity);
  NSLog(@"gbl_lastSelectedCityPickerRownum =[%ld]",(long)gbl_lastSelectedCityPickerRownum );
  NSLog(@"gbl_lastSelectedCityPickerRownum =[%ld]",(long)gbl_lastSelectedCityPickerRownum );
  NSLog(@"--- clrcit -------------------------------------------------------");



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


  NSLog(@"SET gbl_myCitySoFar #56 with setCitySearchStringTitleTo" );
    [self setCitySearchStringTitleTo: @"Type City Name" ];

    gbl_lastSelectedCityPickerRownum = -1;   // FLAG to show city prompts instead of city

    gbl_enteredCity        = gbl_initPromptCity;  // @"City or Town";  for display in gbl_mycityprovcounLabel= found city,prov,counl
  NSLog(@"citych #33  %-24s =[%@] $$$  oncityInputViewClearButton1  $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity);
    gbl_enteredProv        = gbl_initPromptProv;  // @"State or Province";
    gbl_enteredCoun        = gbl_initPromptCoun;  // @"Country";


    // update city label field  (update field in cellForRowAtIndexpath)
    //
    [ self updateCityProvCoun ]; // update city/prov/couon field  in cellForRowAtIndexpath


  NSLog(@"--- clrcit ---  999  ---------------------------------------------");
  NSLog(@"gbl_mycitySearchString.text      =[%@]", gbl_mycitySearchString.text);
  NSLog(@"gbl_myCitySoFar                  =[%@]", gbl_myCitySoFar);
  NSLog(@"gbl_enteredCity                  =[%@]", gbl_enteredCity);
  NSLog(@"gbl_lastSelectedCityPickerRownum =[%ld]",(long)gbl_lastSelectedCityPickerRownum );
  NSLog(@"--- clrcit -------------------------------------------------------");


    [self showHide_ButtonToSeePicklist ];

//    [[self.view viewWithTag: gbl_tag_cityInputPicklistButton ] setHidden: YES ];

} // end of oncityInputViewClearButton1



// add the button "Wheel >"  to  the inputViewAccessory toolbar
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
  NSLog(@"mybarbutton.title       =[%@]", mybarbutton.title );

//        if ( [ mybarbutton.description  isEqualToString: self.outletToButtonToGetPicklist.description ] ) picklistButtonIsNowOnToolbar = 1;
//        else                                                                                              picklistButtonIsNowOnToolbar = 0;

        if ( [ mybarbutton.title  isEqualToString: gbl_titleForWheelButton ] ) picklistButtonIsNowOnToolbar = 1;  // "Wheel >"
        else                                                                   picklistButtonIsNowOnToolbar = 0;
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
  NSLog(@"Show ButtonToSeePicklist!");



        //#import <AudioToolbox/AudioToolbox.h>
//        AudioServicesPlaySystemSound(1257);  // like soft booboo
        AudioServicesPlaySystemSound(1057);  // tink.caf



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



    [self putUpCityPicklist ];                                         // putUpCityPicklist only called twice

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


tn();trn("gbl_mycitySearchString becomeFirstResponder        put up keyboard 1  KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
            // put up keyboard   works?=
            //
            // All UIResponder objects have an inputView property.
            // The inputView of a UIResponder is the view that will be shown in place of the keyboard
            // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
            //

    [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"

  NSLog(@"= 02 =====  BECOME first responder = gbl_mycitySearchString ");
            [gbl_mycitySearchString becomeFirstResponder];  // control textFieldShouldBeginEditing > textFieldDidBeginEditing > back here
  NSLog(@"--onc ----- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );



    [self showHide_ButtonToSeePicklist ];


NSLog(@"end of  oncityInputViewKeyboardButton!"); tn();
} // end of oncityInputViewKeyboardButton



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

                
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];

    [myappDelegate mamb_beginIgnoringInteractionEvents ];  // XXXXX  BEGIN  ignor #01   XXXXXXXXX  pressed Cancel  XXXXXXXXXXXXXXXXXXXXX
  tn();NSLog(@"igx in pressedCancel top after beginIgnor  ignoring=[%d]", [[UIApplication sharedApplication] isIgnoringInteractionEvents]);


     gbl_mycityInputView = @"keyboard";  // init to this in case we last used picker view
  NSLog(@"gbl_mycityInputView changed to =[%@]",gbl_mycityInputView );


    [gbl_myname             resignFirstResponder];
  NSLog(@"-didsel3a-- VASSIGN gbl_myname             RESIGN!FIRST_RESPONDER ---------------- " );
    [gbl_mybirthinformation resignFirstResponder]; 
  NSLog(@"-didsel3a-- VASSIGN gbl_mybirthinformation RESIGN!FIRST_RESPONDER ---------------- " );
    [gbl_mycitySearchString resignFirstResponder]; // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
  NSLog(@"-didsel3a-- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER ---------------- " );


  NSLog(@"gbl_enteredCity=[%@]",gbl_enteredCity);
  NSLog(@"gbl_enteredProv=[%@]",gbl_enteredProv);
  NSLog(@"gbl_enteredCoun=[%@]",gbl_enteredCoun);
  NSLog(@"gbl_DisplayCity=[%@]",gbl_DisplayCity ) ;
  NSLog(@"gbl_DisplayProv=[%@]",gbl_DisplayProv ) ;
  NSLog(@"gbl_DisplayCoun=[%@]",gbl_DisplayCoun ) ;


//    if (   gbl_editingChangeNAMEHasOccurred == 1
//        || gbl_editingChangeCITYHasOccurred == 1
//        || gbl_editingChangeDATEHasOccurred == 1
//    ) {
//nbn(700);
//        // here editing changes have happened
//
//        NSString *msg;            // set msg
//        if (   [gbl_homeEditingState isEqualToString:  @"add" ]
//            || [gbl_homeEditingState isEqualToString:  @"view or change" ]
//        ) {
//nbn(701);
//
//            if ([gbl_myname.text       isEqualToString: gbl_initPromptName ] ) gbl_DisplayName = @"";
//            else                                                               gbl_DisplayName = gbl_myname.text;
//
//            if ([gbl_enteredCity       isEqualToString: gbl_initPromptCity ] ) gbl_DisplayCity = @"";
//            else                                                               gbl_DisplayCity = gbl_enteredCity;
//            if ([gbl_enteredProv       isEqualToString: gbl_initPromptProv ] ) gbl_DisplayProv = @"";
//            else                                                               gbl_DisplayProv = gbl_enteredProv;
//            if ([gbl_enteredCoun       isEqualToString: gbl_initPromptCoun ] ) gbl_DisplayCoun = @"";
//            else                                                               gbl_DisplayCoun = gbl_enteredCoun;
//
//            if ([gbl_selectedBirthInfo isEqualToString: gbl_initPromptDate ] ) gbl_DisplayDate = @"";
//            else                                                               gbl_DisplayDate = gbl_selectedBirthInfo;
//
//            msg = [NSString stringWithFormat:
////                @"\nyou want to throw away what you entered for this new %@?\n\nName:  \"%@\"\nCity:  \"%@\"\nDate:  \"%@\"",
//                @"\nyou want to throw away what you entered for this new %@?\n\n\"%@\"\n\"%@\"\n\"%@\"",
//                gbl_fromHomeCurrentEntity,
//                gbl_DisplayName,
//                gbl_DisplayCity,
//                gbl_DisplayDate
//            ]; // "person" or "group"
//
//            if (   [gbl_DisplayName   isEqualToString: @"" ]
//                && [gbl_DisplayCity   isEqualToString: @"" ]
//                && [gbl_DisplayProv   isEqualToString: @"" ]
//                && [gbl_DisplayCoun   isEqualToString: @"" ]
//                && [gbl_DisplayDate   isEqualToString: @"" ]
//            ) {
//  NSLog(@" // 111a actually do the BACK action on when changes net out to nothing");
//                [self.navigationController popToRootViewControllerAnimated: YES]; // actually do the "Back" action
//            }
//
//        }
//nbn(702);
////        if ([gbl_homeEditingState isEqualToString:  @"view or change" ] ) {  
////            msg = @"\nthrow away your changes?";
////        }
//
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Are you Sure"
//                                                                       message: msg
//                                                                preferredStyle: UIAlertControllerStyleAlert  ];
////                                                                preferredStyle: UIAlertControllerStyleActionSheet  ];
//         
//        UIAlertAction* yesButton = [UIAlertAction actionWithTitle: @"Yes"
//                                                            style: UIAlertActionStyleDefault
//                                                          handler: ^(UIAlertAction * action) { // handler for "are you sure?" answer YES
//  NSLog(@"Yes button pressed xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//
//            gbl_myname.text              = gbl_initPromptName;
//            gbl_myCitySoFar              = @"";
//            gbl_editingChangeNAMEHasOccurred = 0;
//            gbl_editingChangeCITYHasOccurred = 0;
//            gbl_editingChangeDATEHasOccurred = 0;
//
//            gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"
//
//
//  NSLog(@" // 111 actually do the BACK action on Pressing YES to throw away");
//            [self.navigationController popToRootViewControllerAnimated: YES]; // actually do the "Back" action
//
//        } ];   // handler for "are you sure?" answer YES
//  //      Yes button pressed xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//
//        UIAlertAction* noButton = [UIAlertAction actionWithTitle: @"No"
//                                                            style: UIAlertActionStyleDefault
//                                                          handler: ^(UIAlertAction * action) {   // handler
//
//  NSLog(@" no button pressed"); // if "no" answer to throwing away changes, do nothing, just return
//            ;                   // if "no" answer to throwing away changes, do nothing, just return
//
//        } ];   // handler
//         
//        [alert addAction: yesButton];
//        [alert addAction:  noButton];
//
//        [self presentViewController: alert  animated: YES  completion: nil   ];
//
//
//  NSLog(@" // 111 actually do the BACK action on Pressing YES to throw away");
//        [self.navigationController popToRootViewControllerAnimated: YES]; // actually do the "Back" action
//
//    } else {
//        // here no editing changes have happened
//
//        // actually do the "Back" action
//        //
//  NSLog(@" // 222 actually do the BACK action ");
//        [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller
//    }


  NSLog(@"          POP  VIEW   #1");
  NSLog(@"SET gbl_myCitySoFar #05=[%@]",@"" );
        dispatch_async(dispatch_get_main_queue(), ^{  

            // here editing changes have happened or not
            // 
            // pop to root view controller (actually do the "Back" action)
            // 
            gbl_fromHomeCurrentSelectionPSV  = @"";

            gbl_lastSelectedCityPickerRownum = -1;  // ONLY is SET in 2 places   -1 =flag for getCurrentCityProvCounForRownum to show initpromts

            gbl_DisplayCity                                = @"";
            gbl_DisplayProv                                = @"";
            gbl_DisplayCoun                                = @"";

            gbl_enteredCity                                = @"";
            gbl_enteredProv                                = @"";
            gbl_enteredCoun                                = @"";

            gbl_userSpecifiedCity                          = @"";
            gbl_userSpecifiedProv                          = @"";
            gbl_userSpecifiedCoun                          = @"";

            gbl_myname.text                  = gbl_initPromptName;
  NSLog(@"citych #32  %-24s =[%@] $$$  pressedCancel  $$$$$$$$$$$$$$$$$$$$", "gbl_myname" , gbl_myname.text );
            gbl_myCitySoFar                  = @"";
            gbl_editingChangeNAMEHasOccurred = 0;
            gbl_editingChangeCITYHasOccurred = 0;
            gbl_editingChangeDATEHasOccurred = 0;
            gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"

            // FIXER  see city picklist, s/b kb   this worked!
            //        gbl_mycitySearchString.inputView = nil ;          // this has to be here to put up keyboard
            gbl_mycitySearchString.inputView = nil ;  // get rid of picker input view   // necessary ?  works?=yes


  [self disp_gblsWithLabel: @"at END OF pressed cancel 2" ];

//            [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller (actually do the "Back" action)
                [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
        });
  NSLog(@" // 333 actually do the BACK action ");


} // pressedCancel


-(bool) anySubViewScrolling: (UIView*)view
{
    //  NSLog(@"in anySubViewScrolling   in add / change !!");
    if( [ view isKindOfClass:[ UIScrollView class ] ] ) {
        UIScrollView* scroll_view = (UIScrollView*) view;
        if( scroll_view.dragging || scroll_view.decelerating ) return true;
    }

    for( UIView *sub_view in [ view subviews ] ) {
        if( [ self anySubViewScrolling:sub_view ] ) return true;
    }
    return false;
}



- (IBAction)pressedSaveDone:(id)sender
{
  NSLog(@"in pressedSAVEDONE!!");
  NSLog(@"gbl_myname.text=[%@]",gbl_myname.text       );
  NSLog(@"gbl_enteredCity=[%@]",gbl_enteredCity);
  NSLog(@"gbl_enteredProv=[%@]",gbl_enteredProv);
  NSLog(@"gbl_enteredCoun=[%@]",gbl_enteredCoun);
  NSLog(@"gbl_DisplayCity       =[%@]",gbl_DisplayCity ) ;
  NSLog(@"gbl_DisplayProv       =[%@]",gbl_DisplayProv ) ;
  NSLog(@"gbl_DisplayCoun       =[%@]",gbl_DisplayCoun ) ;
  NSLog(@"gbl_selectedBirthInfo =[%@]",gbl_selectedBirthInfo );
  NSLog(@"gbl_editingChangeNAMEHasOccurred=[%ld]",(long)gbl_editingChangeNAMEHasOccurred);
  NSLog(@"gbl_editingChangeCITYHasOccurred=[%ld]",(long)gbl_editingChangeCITYHasOccurred);


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // methods in appdele

//<.>
nbn(610); 
NSLog(@"qq gbl_fromHomeCurrentSelectionType               =[%@]",gbl_fromHomeCurrentSelectionType);
NSLog(@"qq gbl_fromHomeCurrentEntityName                  =[%@]",gbl_fromHomeCurrentEntityName);
NSLog(@"gbl_fromHomeCurrentEntityName =[%@]", gbl_fromHomeCurrentEntityName );
NSLog(@"gbl_fromHomeCurrentSelectionPSV =[%@]",  gbl_fromHomeCurrentSelectionPSV);
  NSLog(@"gbl_lastSelectedPerson             = [%@]",gbl_lastSelectedPerson);
  NSLog(@"gbl_lastSelectedPersonBeforeChange = [%@]",gbl_lastSelectedPersonBeforeChange);
  NSLog(@"gbl_lastSelectedGroup              = [%@]",gbl_lastSelectedGroup);
  NSLog(@"gbl_lastSelectedGroupBeforeChange  = [%@]",gbl_lastSelectedGroupBeforeChange);



[self disp_gblsWithLabel: @"pressedSaveDone TOP  (cannot chg example data)" ];


    // do NOT CHECK for "cannot change" if  gbl_homeEditingState = "add"
    if ( ! [gbl_homeEditingState isEqualToString: @"add" ] )  // do NOT CHECK for "cannot change" if  gbl_homeEditingState = "add"
    {

        if (   [gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ]
              && [gbl_lastSelectedGroupBeforeChange    hasPrefix: @"#"     ]   )
        {
        NSString *noEditMsg1;

            noEditMsg1 = [NSString stringWithFormat: @"\n" 
            ];

            UIAlertController* myalert = [UIAlertController alertControllerWithTitle: @"Cannot Change #allpeople Group"
                                                                           message: noEditMsg1 
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
             
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
                NSLog(@"Ok button pressed");
            } ];
             
            [myalert addAction:  okButton];

            [self.navigationController presentViewController: myalert  animated: YES  completion: nil ];

            return;
        }

        // put "CANNOT EDIT  example data  dialogue
        //
        if (
             (   [gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ]
//          && [gbl_fromHomeCurrentEntityName          hasPrefix: @"~"     ]
              && [gbl_lastSelectedGroupBeforeChange    hasPrefix: @"~"     ]
             )
             ||
             (   [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"]
//          && [gbl_fromHomeCurrentEntityName          hasPrefix: @"~"     ]
//<.>
              && [gbl_lastSelectedPersonBeforeChange  hasPrefix: @"~"     ]
             )
        )

//    if ( [gbl_myname.text  hasPrefix: @"~"] )

        {
nbn(611); 
        NSString *noEditMsg;

            noEditMsg = [NSString stringWithFormat: @"\n" 
            ];

            UIAlertController* myalert = [UIAlertController alertControllerWithTitle: @"Cannot Change Example Data"
                                                                           message: noEditMsg 
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
             
            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
                NSLog(@"Ok button pressed");
            } ];
             
            [myalert addAction:  okButton];

            [self.navigationController presentViewController: myalert  animated: YES  completion: nil ];

nbn(614);
    //    dispatch_async(dispatch_get_main_queue(), ^{  
    ////        [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
    ////[self dismissViewControllerAnimated:YES completion:Nil];
    ////[self dismissModalViewControllerAnimated:YES];  // deprecated ios 6.0
    //
    //    });

    //            [self dismissViewControllerAnimated: YES
    //                                     completion:NULL];


nbn(615);
            return;
        }
nbn(617);

    } // do NOT CHECK for "cannot change" if  gbl_homeEditingState = "add"



    // if the pickerview is scrolling right now, return
    //
    BOOL aSubViewIsScrolling;
//    aSubViewIsScrolling = [self anySubViewScrolling: self.view ];
    aSubViewIsScrolling = [self anySubViewScrolling: self.pickerViewDateTime ];

  NSLog(@"aSubViewIsScrolling =[%ld]",(long)aSubViewIsScrolling );
    if(aSubViewIsScrolling == YES) return;



    if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ] )
    { // group saveDone logic  --------- about 300 lines  --------------------------------------------------------------


nbn(341);
trn("group  savedone");
//if(  gbl_editingChangeNAMEHasOccurred == nil) NSLog(@"gbl_editingChangeNAMEHasOccurred =[nil]");
//else  NSLog(@"gbl_editingChangeNAMEHasOccurred =[%@]", gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_editingChangeNAMEHasOccurred idxGrpOrPer =%ld", (long)gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
NSUInteger mybytes = [gbl_userSpecifiedPersonName  lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
NSLog(@"mybytes gbl_userSpecifiedPersonName          =[%i]", mybytes);
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
  NSLog(@"gbl_myname.text                            =[%@]", gbl_myname.text );
  NSLog(@"gbl_DisplayName                            =[%@]",  gbl_DisplayName);


    if (   // if Name field is empty,  put up err msg  can not save   missing information
//           [gbl_DisplayName  isEqualToString: @"" ]
//        ||  gbl_DisplayName  == nil 
           [gbl_myname.text   isEqualToString: @"" ]
        ||  gbl_myname.text   == nil 
       )
    {
nbn(342);

        NSString *missingMsg =  @"Missing Information: Name";
       
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

        // cannot save because of missing information > stay in this screen
        //
        [self presentViewController: myAlert  animated: YES  completion: nil   ]; // cannot save because of missing information

        return;  // cannot save because of missing information > stay in this screen

    }
nbn(343);



//  NSLog(@"gbl_editingChangeNAMEHasOccurred =[%ld]",(long)gbl_editingChangeNAMEHasOccurred );

        if (   gbl_editingChangeNAMEHasOccurred == 0 )
        {


            return;   // <.> if in change of group name and name has not changed, do not do SAVE or DONE, do nothing
//
//            [myappDelegate mamb_beginIgnoringInteractionEvents ];  // XXXXX  BEGIN  ignor #02   grp   do back- no editing changes XXXXXXXXX
//  tn();NSLog(@"igx in pressedSaveDone group  editing HAS happened  after beginIgnor  ignoring=[%d]", [[UIApplication sharedApplication] isIgnoringInteractionEvents]);
//
//            // here editing changes have NOT happened
//            //
//  NSLog(@" // 111-0 actually do the BACK action  when Done hit and there are no editing changes");
//
//  NSLog(@"          POP  VIEW   #2");
//  NSLog(@"SET gbl_myCitySoFar #06=[%@]",@"" );
//            dispatch_async(dispatch_get_main_queue(), ^{  
//                // pop to root view controller (actually do the "Back" action)
//                // 
//                gbl_myname.text                  = gbl_initPromptName;
//                gbl_myCitySoFar                  = @"";
//  NSLog(@"citych #31  %-24s =[%@] $$$  pressedSaveDone  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar" , gbl_myCitySoFar);
//                gbl_editingChangeNAMEHasOccurred = 0;
//                gbl_editingChangeCITYHasOccurred = 0;
//                gbl_editingChangeDATEHasOccurred = 0;
//                gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"
//
////                [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller (actually do the "Back" action)
//                [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
//            });
//
//            return;
//
        } // editing changes have NOT happened  --  return


        //
        // here editing changes have happened
        //


        // set the current values in each field
        if ([gbl_myname.text       isEqualToString: gbl_initPromptName ] ) gbl_DisplayName = @"";
        else                                                               gbl_DisplayName = gbl_myname.text;


        if (   [gbl_DisplayName   isEqualToString: @"" ]
        ) {
NSLog(@" // 111a actually do the BACK action on when changes net out to nothing");

            [myappDelegate mamb_beginIgnoringInteractionEvents ];  // XXXXX  BEGIN  ignor #03   grp  do back- edit changes net to nothing XXXXXX
  tn();NSLog(@"igx in pressedSaveDone group, displayname="" after beginIgnor  ignoring=[%d]", [[UIApplication sharedApplication] isIgnoringInteractionEvents]);

  NSLog(@"          POP  VIEW   #3");
            dispatch_async(dispatch_get_main_queue(), ^{  
                // pop to root view controller (actually do the "Back" action)
                // 
                gbl_myname.text                  = gbl_initPromptName;
                gbl_editingChangeNAMEHasOccurred = 0;
                gbl_editingChangeCITYHasOccurred = 0;
                gbl_editingChangeDATEHasOccurred = 0;
                gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"

//                [self.navigationController popToRootViewControllerAnimated: YES]; // actually do the "Back" action
                [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
            });
            
            return;
        } // 111a actually do the BACK action on when changes net out to nothing");


        // before save of New Group,  check for missing information  name  same as prompt
        //
        if (   [gbl_DisplayName isEqualToString: @"" ]
        ) {
            // here info is missing
            NSString *namePrompt; NSString *cityPrompt; NSString *datePrompt;
            namePrompt = @"";     cityPrompt = @"";     datePrompt = @"";
            if (  [gbl_DisplayName isEqualToString: @"" ]) namePrompt = @" Name ";
            NSString *missingMsg =  [NSString stringWithFormat:@"Missing Information:\n%@",
                namePrompt
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

            // cannot save because of missing information > stay in this screen
            //
            [self presentViewController: myAlert  animated: YES  completion: nil   ]; // cannot save because of missing information

            return;  // cannot save because of missing information > stay in this screen

        } // before save of New Group,  check for missing information 

        // ONLY IF    [gbl_homeEditingState isEqualToString:  @"add" ] 
        //      OR    (
        //                  [gbl_homeEditingState isEqualToString:  @"view or change" ] 
        //              AND original name in the db record has changed (gbl_myname.txt is different)
        //            )
        //
        // before save of New Person,  CHECK IF ENTERED NAME ALREADY EXISTS in database
        // OR  save of changed person with changed name
        //
  NSLog(@"gbl_fromHomeCurrentEntityName=[%@]",gbl_fromHomeCurrentEntityName);
  NSLog(@"gbl_myname.text              =[%@]",gbl_myname.text);
  NSLog(@"gbl_DisplayName              =[%@]",gbl_DisplayName);

        if (  [gbl_homeEditingState isEqualToString:  @"add" ] 
            ||  (
                    [gbl_homeEditingState isEqualToString:  @"view or change" ] 
//                     && ! [fldName isEqualToString:  gbl_myname.text ] // this line = true if original name in db record (fldName) has changed 
                 && ! [gbl_fromHomeCurrentEntityName isEqualToString:  gbl_myname.text ] // this line = true if original name in db record (fldName) has changed 

                )
        ) {  // add mode - check for duplicate name     // here name has changed
            // here name has changed

            NSString *nameOfGrpOrPer;
            NSArray  *arrayGrpOrper;
//            NSInteger idxGrpOrPer;
//            idxGrpOrPer = -1;
            NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];

            // search thru gbl_arrayGrp
            for (id eltGrp in gbl_arrayGrp) { // search thru gbl_arrayPer
                arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet: mySeparators];
                nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

//                if ([nameOfGrpOrPer isEqualToString: gbl_DisplayName]) 
                if( [nameOfGrpOrPer caseInsensitiveCompare: gbl_DisplayName] == NSOrderedSame ) // strings are equal except for possibly case
                {
                    // here the name of New Person is in database

                    NSString *msg_alreadyThere = [
                        NSString stringWithFormat: @"You already have a Group with the name \"%@\".\n\nPlease make this new name different.",
                        nameOfGrpOrPer  // gbl_DisplayName
                    ];
                    UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Group Already There"
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

                    // cannot save because of duplicate name > stay in this screen
                    return;  // pressed "Done" > cannot save > stay in this screen

                }
            } // search thru gbl_arrayGrp for name already there 

        }  // add mode - check for duplicate name

      NSLog(@" // Actually do save of New Group   here");

        // Actually do save of New Group   here
        //

        // first build a Group database record in a string
        //

        NSString *myNewGroupRecord;
        myNewGroupRecord = [NSString stringWithFormat: @"%@||", gbl_DisplayName ];
  NSLog(@"myNewGroupRecord =[%@]",myNewGroupRecord );


        // before write of array data to file, disallow/ignore user interaction events
        //
        [myappDelegate mamb_beginIgnoringInteractionEvents ];  // XXXXX  BEGIN  ignor #04   grp   before grp write + go back XXXXXXXXXXXXX
  tn();NSLog(@"igx in pressedSaveDone group displayname="" after actually do save  BEGIN ignoring=[%d]", [[UIApplication sharedApplication] isIgnoringInteractionEvents]);


        // ONLY IF    [gbl_homeEditingState isEqualToString:  @"view or change" ] 
        // DELETE  the existing record first
        // before  adding the changed record above
        //
        if ([gbl_homeEditingState isEqualToString:  @"view or change" ] )
        {
//                NSString *prefixStr = [NSString stringWithFormat: @"%@|", gbl_DisplayName ];
            NSString *prefixStr = [NSString stringWithFormat: @"%@|", gbl_lastSelectedGroupBeforeChange ];

            NSInteger idx, foundIdx;  
            idx = 0;       foundIdx = -1;

            for (NSString *element in gbl_arrayGrp) {
                if ([element hasPrefix: prefixStr]) {
                    foundIdx = idx;
                    break;
                }
                idx = idx + 1;
            }
NSLog(@"foundIdx =[%ld]",(long)foundIdx );
            if (foundIdx == -1) {
                return;  // should not happen
            }

            // here, delete old array element before adding new changed Group Record above
            //
            [gbl_arrayGrp removeObjectAtIndex:  foundIdx ]; //  delete old array element before adding new changed GroupRecord above

        } // ONLY IF    [gbl_homeEditingState isEqualToString:  @"view or change" ] , DELETE  the existing record first

        // add the new Group database record in a string to the group array
        //
        [gbl_arrayGrp addObject: myNewGroupRecord]; // add the new Group database record in a string to the Group array


        [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"group"]; // write new array data to file
        [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"group"]; // read new data from file to array
        [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"group"]; // sort array by name


        // in change mode, if necessary, update MEMBERSHIP  file  (gbl_arrayMem)
        //
        if ([gbl_homeEditingState isEqualToString:  @"view or change" ] )
        {
//tn();
//  NSLog(@" // if necessary, update MEMBERSHIP  file  (gbl_arrayMem)");
//  NSLog(@"gbl_fromHomeCurrentEntityName =[%@]",gbl_fromHomeCurrentEntityName );
//  NSLog(@"gbl_myname.text               =[%@]",gbl_myname.text );

            BOOL originalNameHasChanged;

            // true if original name in db record has changed 
//            originalNameHasChanged = ! [gbl_fromHomeCurrentEntityName isEqualToString: gbl_myname.text ];

            originalNameHasChanged =   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
                                    && [gbl_homeEditingState isEqualToString: @"view or change" ]
                                    &&  ! [gbl_fromHomeCurrentEntityName isEqualToString: gbl_myname.text ] ;

            if (originalNameHasChanged )
            {
                [myappDelegate mambChangeGRPMEM_groupNameFrom: (NSString *) gbl_fromHomeCurrentEntityName 
                                                    toNewName: (NSString *) gbl_myname.text
                ];
                [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"member"]; // write new array data to file
   //           [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"member"]; // read new data from file to array
                [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"member"]; // sort array by name
//  NSLog(@"gbl_arrayMem in MEM UPDATE #1 =[%@]",gbl_arrayMem );
            }
        } // in change mode, if necessary, update MEMBERSHIP  file  (gbl_arrayMem)



        gbl_justAddedGroupRecord  = 1;  // cause reload of home data


        gbl_lastSelectedGroup           = gbl_DisplayName;  // this row (gbl_lastSelectedGroup) gets selection highlight in home tableview
        gbl_fromHomeCurrentSelectionPSV = myNewGroupRecord;
        gbl_fromHomeCurrentEntityName   = gbl_DisplayName;

tn();trn("ggggggggggggggggggggggggggggggggggggggggggggggg");
  NSLog(@"gbl_lastSelectedGroup            =[%@]",gbl_lastSelectedGroup );
  NSLog(@"gbl_fromHomeCurrentEntityName    =[%@]",gbl_fromHomeCurrentEntityName);
  NSLog(@"gbl_fromHomeCurrentSelectionPSV  =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"gbl_lastSelectionType            =[%@]",gbl_lastSelectionType            );
  NSLog(@"gbl_fromHomeCurrentSelectionType =[%@]",gbl_fromHomeCurrentSelectionType );
  NSLog(@"gbl_fromHomeCurrentEntity        =[%@]",gbl_fromHomeCurrentEntity        );
trn("ggggggggggggggggggggggggggggggggggggggggggggggg");
tn();


//        gbl_lastSelectedGroupBeforeChange  = gbl_lastSelectedGroup ;   // like "~Dave"   used in YELLOW gbl_homeUseMODE "edit mode"





//        // after write of array data to file, allow user interaction events again
//        //
//        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] == YES) {  // re-enable handling of touch-related events
//            [[UIApplication sharedApplication] endIgnoringInteractionEvents];       // typically call this after an animation or transitiion.
//NSLog(@"STOP IGnoring events");
//        }
  NSLog(@"igx  commented out end ignore here");

NSLog(@"          POP  VIEW   #6");
        dispatch_async(dispatch_get_main_queue(), ^{  
            // after saving new group, go back to home view

            // pop to root view controller (actually do the "Back" action)
            // 
            gbl_myname.text                  = gbl_initPromptName;
            gbl_myCitySoFar                  = @"";
  NSLog(@"citych #30  %-24s =[%@] $$$  pressedSaveDone  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar" , gbl_myCitySoFar);
            gbl_editingChangeNAMEHasOccurred = 0;
            gbl_editingChangeCITYHasOccurred = 0;
            gbl_editingChangeDATEHasOccurred = 0;
            gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"

            // FIXER  see city picklist, s/b kb   this worked!
            //        gbl_mycitySearchString.inputView = nil ;          // this has to be here to put up keyboard
            gbl_mycitySearchString.inputView = nil ;  // get rid of picker input view   // necessary ?  works?=yes


//                    [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller (actually do the "Back" action)
            [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action

            // is system "done" button function here

        });



        return;
    } // end of group saveDone logic  -----------------------------------------------------------------------------------




//<.>
    if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"person" ] )
    {  // person saveDone logic   =======================================================================================

    

nbn(441);
trn("person savedone");
//if(  gbl_editingChangeNAMEHasOccurred == nil) NSLog(@"gbl_editingChangeNAMEHasOccurred =[nil]");
//else  NSLog(@"gbl_editingChangeNAMEHasOccurred =[%@]", gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_editingChangeNAMEHasOccurred idxGrpOrPer =%ld", (long)gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
NSUInteger mybytes = [gbl_userSpecifiedPersonName  lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
NSLog(@"mybytes gbl_userSpecifiedPersonName          =[%i]", mybytes);
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
  NSLog(@"gbl_myname.text                            =[%@]", gbl_myname.text );
  NSLog(@"gbl_DisplayName                            =[%@]",  gbl_DisplayName);


    if (   // if Name field is empty,  put up err msg  can not save   missing information
//           [gbl_DisplayName  isEqualToString: @"" ]
//        ||  gbl_DisplayName  == nil 
           [gbl_myname.text   isEqualToString: @"" ]
        ||  gbl_myname.text   == nil 
       )
    {
nbn(442);

        NSString *missingMsg =  @"Missing Information: Name";
       
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

        // cannot save because of missing information > stay in this screen
        //
        [self presentViewController: myAlert  animated: YES  completion: nil   ]; // cannot save because of missing information

        return;  // cannot save because of missing information > stay in this screen

    }
nbn(443);


        if (   gbl_editingChangeNAMEHasOccurred == 0
            && gbl_editingChangeCITYHasOccurred == 0
            && gbl_editingChangeDATEHasOccurred == 0
        ) {
            // here editing changes have NOT happened

            return;  //  no response on hit Save   if all are blank

//
//  NSLog(@" // 222b actually do the BACK action  when Done hit and there are no editing changes");
//            
//
//            [myappDelegate mamb_beginIgnoringInteractionEvents ];  // XXXXX  BEGIN  ignor #05   per  do back- no edit changes  XXXXXXXXXXXXXXXX
//  tn();NSLog(@"igx in pressedSaveDone person  in no editing changes BEGIN ignoring=[%d]", [[UIApplication sharedApplication] isIgnoringInteractionEvents]);
//
//  NSLog(@"          POP  VIEW   #4");
//  NSLog(@"SET gbl_myCitySoFar #07=[%@]",@"" );
//            dispatch_async(dispatch_get_main_queue(), ^{  
//                // pop to root view controller (actually do the "Back" action)
//                // 
//                gbl_myname.text                  = gbl_initPromptName;
//                gbl_myCitySoFar                  = @"";
//  NSLog(@"citych #28  %-24s =[%@] $$$  pressedSaveDone  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar" , gbl_myCitySoFar);
//                gbl_editingChangeNAMEHasOccurred = 0;
//                gbl_editingChangeCITYHasOccurred = 0;
//                gbl_editingChangeDATEHasOccurred = 0;
//                gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"
//
////                [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller (actually do the "Back" action)
//                [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
//            });
//

        } // here editing changes have NOT happened



        if (   gbl_editingChangeNAMEHasOccurred == 1
            || gbl_editingChangeCITYHasOccurred == 1
            || gbl_editingChangeDATEHasOccurred == 1

        ) { // here editing changes have happened



                // set the current values in each screen field

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

  NSLog(@"citych #27  %-24s =[%@] $$$  pressedSaveDone  $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity " , gbl_enteredCity );


      NSLog(@" 2 gbl_DisplayProv       =[%@]",gbl_DisplayProv ) ;
      NSLog(@" 2 gbl_DisplayCoun       =[%@]",gbl_DisplayCoun ) ;
      NSLog(@" 2 gbl_selectedBirthInfo =[%@]",gbl_selectedBirthInfo );

                // 111b actually do the BACK action on when changes net out to nothing");
                //
                if (   [gbl_DisplayName   isEqualToString: @"" ]   // use gbl_Display*  for this, other below
                    && [gbl_DisplayCity   isEqualToString: @"" ]   // use gbl_Display*  for this, other below
                    && [gbl_DisplayProv   isEqualToString: @"" ]   // use gbl_Display*  for this, other below
                    && [gbl_DisplayCoun   isEqualToString: @"" ]   // use gbl_Display*  for this, other below
                    && [gbl_DisplayDate   isEqualToString: @"" ]   // use gbl_Display*  for this, other below
                ) {
      NSLog(@" // 111b actually do the BACK action on when changes net out to nothing");



                    [myappDelegate mamb_beginIgnoringInteractionEvents ];  // XXXXX  BEGIN  ignor #06   per  do back, edit changes net zeroXX
  tn();NSLog(@"igx in pressedSaveDone person  after changes net to zilch  BEGIN ignoring=[%d]", [[UIApplication sharedApplication] isIgnoringInteractionEvents]);

  NSLog(@"          POP  VIEW   #5");
  NSLog(@"SET gbl_myCitySoFar #08=[%@]",@"" );
                    dispatch_async(dispatch_get_main_queue(), ^{  
                        // pop to root view controller (actually do the "Back" action)
                        // 
                        gbl_myname.text                  = gbl_initPromptName;
                        gbl_myCitySoFar                  = @"";
  NSLog(@"citych #26  %-24s =[%@] $$$  pressedSaveDone  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar" , gbl_myCitySoFar );
                        gbl_editingChangeNAMEHasOccurred = 0;
                        gbl_editingChangeCITYHasOccurred = 0;
                        gbl_editingChangeDATEHasOccurred = 0;
                        gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"

//                        [self.navigationController popToRootViewControllerAnimated: YES]; // actually do the "Back" action
                       [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
                    });
                } // 111b actually do the BACK action on when changes net out to nothing");



                // before save of New Person,  check for missing information  name,city,date  same as prompt
                // and set prompts for missing info   missing_name, missing_city, missing_date;


//                if (   [gbl_DisplayName isEqualToString: @"" ]
//                    || [gbl_DisplayCity isEqualToString: @"" ]
//                    || [gbl_DisplayDate isEqualToString: @"" ]
//                ) {
//                    // here info is missing
//                    NSString *namePrompt; NSString *cityPrompt; NSString *datePrompt;
//                    namePrompt = @"";     cityPrompt = @"";     datePrompt = @"";
//                    if (  [gbl_DisplayName isEqualToString: @"" ]) namePrompt = @" Name ";
//                    if (  [gbl_DisplayCity isEqualToString: @"" ]) cityPrompt = @" Birth City or Town ";
//                    if (  [gbl_DisplayDate isEqualToString: @"" ]) datePrompt = @" Birth Date and Time ";
//        ...
//                }

[self disp_gblsWithLabel: @"pressedSaveDone -  missing name BEFORE" ];

                NSInteger missing_name, missing_city, missing_date;
                NSString *namePrompt; NSString *cityPrompt; NSString *datePrompt;
                missing_name = 0;   missing_city = 0;    missing_date = 0;
                  namePrompt = @"";   cityPrompt = @"";    datePrompt = @"";

nbn(558);
//if(  gbl_editingChangeNAMEHasOccurred == nil) NSLog(@"gbl_editingChangeNAMEHasOccurred =[nil]");
//else  NSLog(@"gbl_editingChangeNAMEHasOccurred =[%@]", gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_editingChangeNAMEHasOccurred idxGrpOrPer =%ld", (long)gbl_editingChangeNAMEHasOccurred );
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
NSUInteger mybytes = [gbl_userSpecifiedPersonName  lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
NSLog(@"mybytes gbl_userSpecifiedPersonName          =[%i]", mybytes);
NSLog(@"gbl_userSpecifiedPersonName                  =[%@]",gbl_userSpecifiedPersonName  );
  NSLog(@"gbl_myname.text                            =[%@]", gbl_myname.text );
  NSLog(@"gbl_DisplayName                            =[%@]",  gbl_DisplayName);


//                if ( 
//                       [gbl_userSpecifiedPersonName  isEqualToString: @"" ]
//                    ||  gbl_userSpecifiedPersonName  == nil  
//                    || [gbl_DisplayName  isEqualToString: @"" ]
//                    ||  mybytes  == 0  
//                    ||  gbl_editingChangeNAMEHasOccurred == nil  
//                    ||  gbl_editingChangeNAMEHasOccurred == 0  
//                   )
//
                if ( 
                       [gbl_DisplayName  isEqualToString: @"" ]
                    ||  gbl_DisplayName  == nil 
                   )
                {
nbn(559);
                    missing_name = 1;
                }
nbn(560);

//                if (   [gbl_userSpecifiedCity        isEqualToString: @"" ]
//                    ||  gbl_userSpecifiedCity        == nil                
//                   )
//                {   }
                if (   [gbl_myCitySoFar        isEqualToString: @"" ]
                    ||  gbl_myCitySoFar        == nil                


                   )
                {
                    missing_city = 1;
                }

                if (   [gbl_selectedBirthInfo        isEqualToString: @"" ]
                    ||  gbl_selectedBirthInfo        == nil
                    || [gbl_selectedBirthInfo isEqualToString: @"Birth Date and Time" ]  // beg prompt
                   )
                {
                    missing_date = 1;
                }

                if (   missing_name == 1
                    || missing_city == 1
                    || missing_date == 1  )
                {
                    // here info is missing, so build the prompts
                    //
                    NSString *namePrompt; NSString *cityPrompt; NSString *datePrompt;
                    namePrompt = @"";     cityPrompt = @"";     datePrompt = @"";

                    if (missing_name == 1) namePrompt = @" Name ";
                    if (missing_city == 1) cityPrompt = @" Birth City or Town ";
                    if (missing_date == 1) datePrompt = @" Birth Date and Time ";


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

                    // cannot save because of missing information > stay in this screen
                    //
                    [self presentViewController: myAlert  animated: YES  completion: nil   ]; // cannot save because of missing information

                    return;  // cannot save because of missing information > stay in this screen

                } // before save of New Person,  check for missing information 

    nbn(701);
                // ONLY IF    [gbl_homeEditingState isEqualToString:  @"add" ] 
                //      OR    (
                //                  [gbl_homeEditingState isEqualToString:  @"view or change" ] 
                //              AND original name in the db record has changed (gbl_myname.txt is different)
                //            )
                //
                // before save of New Person,  check if entered name already exists in database
                // OR  save of changed person with changed name
                //
                if (  [gbl_homeEditingState isEqualToString:  @"add" ] 
                    ||  (
                            [gbl_homeEditingState isEqualToString:  @"view or change" ] 
    //                     && ! [fldName isEqualToString:  gbl_myname.text ] // this line = true if original name in db record (fldName) has changed 
                         && ! [gbl_fromHomeCurrentEntityName isEqualToString:  gbl_myname.text ] // this line = true if original name in db record (fldName) has changed 

                        )
                ) {  // add mode - check for duplicate name     // here name has changed
    nbn(702);
                    // here name has changed

                    NSString *nameOfGrpOrPer;
                    NSArray  *arrayGrpOrper;
        //            NSInteger idxGrpOrPer;
        //            idxGrpOrPer = -1;
                    NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];

                    // search thru gbl_arrayPer
                    for (id eltPer in gbl_arrayPer) { // search thru gbl_arrayPer
        //                idxGrpOrPer = idxGrpOrPer + 1;
        //  NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
        //  NSLog(@"eltPer=%@", eltPer);
        //
        //  NSLog(@"nameOfGrpOrPer =[%@]",nameOfGrpOrPer );
        //  NSLog(@"gbl_DisplayName=[%@]",gbl_DisplayName);
                        arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
                        nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

        //                if ([nameOfGrpOrPer isEqualToString: gbl_DisplayName]) 
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

                            // cannot save because of duplicate name > stay in this screen
                            return;  // pressed "Done" > cannot save > stay in this screen

                        }
                    } // search thru gbl_arrayPer for name already there 

                }  // add mode - check for duplicate name
  nbn(704);


//      NSLog(@" // Actually do save of New Person   here");
//  NSLog(@"gbl_arrayMem before doActualPersonSave =[%@]",gbl_arrayMem );


                // Actually do save of New Person   here");

  NSLog(@" gbl_kindOfSave =[%@]", gbl_kindOfSave );

                // if person was saved with high security   (now, 20160616,   ALL people)
                // do not offer a  choice of kind of save (see below)
                // 
//                if (   [gbl_kindOfSave isEqualToString:  @"no look no change save" ] )
//                { }
                    [self doActualPersonSave ];

  NSLog(@"after  doActualPersonSave ( at END of   person saveDone logic  at end of  pressedSaveDone ) ! ");




  nbn(705);

                // since all hs saves, this does not run ever

// START OF old , unused CHOOSE KIND OF SAVE   CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
//
//                // choose kind of save
//                // offer to save person with no look no change
//                //
//                NSString *saveTitle;
//                NSString *saveMsg;
////                saveTitle = @"Choose Kind of Save\n";
//                saveTitle = @"Personal Privacy\n";
//
//                NSString *nameInPossessiveForm;
//                if (   [gbl_myname.text  hasSuffix: @"s" ]
//                    || [gbl_myname.text  hasSuffix: @"S" ]
//                    || [gbl_myname.text  hasSuffix: @"z" ]
//                    || [gbl_myname.text  hasSuffix: @"Z" ]  )
//                {
//                     nameInPossessiveForm = [NSString stringWithFormat: @"%@\'",  gbl_myname.text ];
//                } else {
//                     nameInPossessiveForm = [NSString stringWithFormat: @"%@\'s", gbl_myname.text ];
//                }
////                saveMsg = [NSString stringWithFormat: @"\n   The No Look, No Change Save prevents EVERYONE, including yourself and this device owner, from ever seeing or changing %@\'s birth date or city.\n\n", gbl_myname.text ];
////                saveMsg = [NSString stringWithFormat: @"\n   Hide Birth Information Save prevents EVERYONE, including yourself and this device owner, from ever seeing or changing %@\'s birth date or city.\n\n", gbl_myname.text ];
//                saveMsg = [NSString stringWithFormat: @"\n   After you save the birth data for %@,   NOBODY, neither you nor this device owner nor anybody else can ever again change or even look at the Birth City or Birth Date.\n\n   So, if you ever want to look at the birth information of this person in the future, you need to write it down somewhere safe outside this app.",  gbl_myname.text ];
//
//
//                NSMutableParagraphStyle *myParagraphStyle = [[NSMutableParagraphStyle alloc] init];
//                myParagraphStyle.alignment                = NSTextAlignmentLeft;
//                myParagraphStyle.headIndent               = 12;
////                myParagraphStyle.firstLineHeadIndent      = 12;
//
//
//                NSDictionary *myNeededAttribsMessage = @{
//                    //   e.g.
//                    ////                                      NSForegroundColorAttributeName: self.label.textColor,
//                    ////                                      NSBackgroundColorAttributeName: cell.textLabel.attributedText
//                    ////                                      NSBackgroundColorAttributeName: cell.textLabel.textColor
//                    //                                      NSFontAttributeName: cell.textLabel.font,
//                    //                                      NSBackgroundColorAttributeName: cell.textLabel.backgroundColor
//                    //
//                    //
//                    //            NSMutableAttributedString *myAttributedTextLabelExplain = 
//                    //                [[NSMutableAttributedString alloc] initWithString: allLabelExplaintext
//                    //                                                       attributes: myNeededAttribs     ];
//                    //
//    //                NSBackgroundColorAttributeName: retvalUILabel.attributedText.backgroundColor
//    //                NSBackgroundColorAttributeName: retvalUILabel.backgroundColor
//
//                      NSParagraphStyleAttributeName : myParagraphStyle,
//                      NSForegroundColorAttributeName: [UIColor blackColor],
//                      NSBackgroundColorAttributeName: gbl_colorEditingBG,
//                                 NSFontAttributeName: [UIFont systemFontOfSize: 16]
//
//                };
//                NSDictionary *myNeededAttribsTitle = @{
////                                 NSFontAttributeName: [UIFont boldSystemFontOfSize: 16]
////                      NSForegroundColorAttributeName: [UIColor blueColor],
////                      NSForegroundColorAttributeName: gbl_color_cAplBlue,
////                      NSForegroundColorAttributeName: [UIColor darkGrayColor],
//                      NSForegroundColorAttributeName: [UIColor blackColor],
//                                 NSFontAttributeName: [UIFont boldSystemFontOfSize: 18]
//
//                };
//
//  
//                NSMutableAttributedString *myAttributedMessage = [
//                    [ NSMutableAttributedString alloc ] initWithString: saveMsg
//                                                            attributes: myNeededAttribsMessage
//                ];
//                NSMutableAttributedString *myAttributedTitle = [
//                    [ NSMutableAttributedString alloc ] initWithString: saveTitle
//                                                            attributes: myNeededAttribsTitle
//                ];
//
//
//
//                UIAlertController *myActionSheet = [UIAlertController alertControllerWithTitle: saveTitle
//                                                                                       message: saveMsg
//                                                                                preferredStyle: UIAlertControllerStyleActionSheet];
//                [myActionSheet setValue: myAttributedTitle 
//                                 forKey: @"attributedTitle"
//                ];
//                [myActionSheet setValue: myAttributedMessage 
//                                 forKey: @"attributedMessage"
//                ];
//
//                [myActionSheet addAction: 
//                    [UIAlertAction actionWithTitle: @"Cancel"
//                                             style: UIAlertActionStyleCancel
//                                           handler: ^(UIAlertAction *action) {
//                                               [self dismissViewControllerAnimated: YES completion: ^{   }  ];
//                                           }
//                    ]
//                ];
//                [myActionSheet addAction:
////                    [UIAlertAction actionWithTitle: @"Regular Save"
//                    [UIAlertAction actionWithTitle: @"Save"
//                                             style: UIAlertActionStyleDefault
//                                           handler: ^(UIAlertAction *action) {
//  NSLog(@"pressed   regular save  (now hs) ");
////                                               gbl_kindOfSave = @"regular save";   // or  "no look no change save"
//                                               gbl_kindOfSave = @"no look no change save";   // or  "regular save"
//  NSLog(@"gbl_kindOfSave 11 =[%@]",gbl_kindOfSave);
////                                               [view dismissViewControllerAnimated: YES  completion: nil];
////                [self.navigationController popViewControllerAnimated: YES]; // "Back" out of save dialogue
////                [myActionSheet popViewControllerAnimated: YES]; // "Back" out of save dialogue
//                                               [self doActualPersonSave ];
//                                               [myActionSheet dismissViewControllerAnimated: YES  completion: nil];
//                                           }
//                    ]
//                ];
////
////                [myActionSheet addAction:
//////                    [UIAlertAction actionWithTitle: @"High Security Save"
//////                    [UIAlertAction actionWithTitle: @"No Look, No Change Save"
////                    [UIAlertAction actionWithTitle: @"Hide Birth Information Save"
////            //                                 style: UIAlertActionStyleDestructive
////                                             style: UIAlertActionStyleDefault
////                                           handler: ^(UIAlertAction *action) {
////
////  NSLog(@"pressed   no look no change save");
////                                               gbl_kindOfSave = @"no look no change save";   // or  "regular save"
////  NSLog(@"gbl_kindOfSave 12 =[%@]",gbl_kindOfSave);
//////                                               [self doMeInsideBlock ];
////                                               [self doActualPersonSave ];
////                                               [myActionSheet dismissViewControllerAnimated: YES  completion: nil];
//////                                               [self dismissViewControllerAnimated: YES completion: ^{   } ];
////                                           }
////                    ]
////                ];
////
//
//            //    myActionSheet.view.transparent = NO;
//            //    myActionSheet.view.backgroundColor = [UIColor whiteColor];
//            //    myActionSheet.view.backgroundColor = [UIColor greenColor];
//            //    myActionSheet.view.backgroundColor = gbl_colorHomeBG;
//            //    myActionSheet.view.tintColor =  [UIColor blackColor];  // colors choices
//            //                myActionSheet.view.backgroundColor = gbl_colorEditingBG;
//
//
//                // Present action sheet.
//                //
//                [self presentViewController: myActionSheet animated: YES completion: nil];
//
//  NSLog(@"gbl_kindOfSave 1 =[%@]",gbl_kindOfSave);
//                return;
//


//   END OF old , unused CHOOSE KIND OF SAVE   CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC




        } // here editing changes have happened

    } // end of person  saveDone logic   ================================================================================


//  NSLog(@"--- 000 -------------------------------------------------------");
//  NSLog(@"            gbl_myname.isFirstResponder=%d",gbl_myname.isFirstResponder);
//  NSLog(@"gbl_mycitySearchString.isFirstResponder=%d",gbl_mycitySearchString.isFirstResponder);
//  NSLog(@"gbl_mybirthinformation.isFirstResponder=%d",gbl_mybirthinformation.isFirstResponder);
//  NSLog(@"gbl_fieldTap_leaving  =%@",gbl_fieldTap_leaving );
//  NSLog(@"gbl_fieldTap_goingto  =%@",gbl_fieldTap_goingto );
//  NSLog(@"gbl_firstResponder_previous  =%@",gbl_firstResponder_previous );
//  NSLog(@"gbl_firstResponder_current   =%@",gbl_firstResponder_current  );
//  NSLog(@"---------------------------------------------------------------");
//

} // pressedSaveDone

//- (void) doMeInsideBlock  // for test
//{
//  NSLog(@"do me method inside block");
//}

- (void) doActualPersonSave
{
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m

                // before write of array data to file, disallow/ignore user interaction events
                //

//                if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] ==  NO) {  // suspend handling of touch-related events
//                    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];     // typically call this before an animation or transitiion.
//      NSLog(@"ARE  IGnoring events");
//                }
                  [myappDelegate mamb_beginIgnoringInteractionEvents ];  // XXXXX  BEGIN  ignor #07   per before write + do back XXXXXXXXXXXX

  tn();NSLog(@"igx in doActualPersonSave top   BEGIN ignoring=[%d]", [[UIApplication sharedApplication] isIgnoringInteractionEvents]);


                // Actually do save of New Person   here
                //

                // first build a Person database record in a string
                //
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

                // if( [nameOfGrpOrPer caseInsensitiveCompare: gbl_DisplayName] == NSOrderedSame ) // strings are equal except for possibly case
                NSString *mymthnum; 
                mymthnum = @"0"; 
                if      ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Jan" ] == NSOrderedSame) mymthnum = @"1";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Feb" ] == NSOrderedSame) mymthnum = @"2";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Mar" ] == NSOrderedSame) mymthnum = @"3";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Apr" ] == NSOrderedSame) mymthnum = @"4";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"May" ] == NSOrderedSame) mymthnum = @"5";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Jun" ] == NSOrderedSame) mymthnum = @"6";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Jul" ] == NSOrderedSame) mymthnum = @"7";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Aug" ] == NSOrderedSame) mymthnum = @"8";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Sep" ] == NSOrderedSame) mymthnum = @"9";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Oct" ] == NSOrderedSame) mymthnum = @"10";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Nov" ] == NSOrderedSame) mymthnum = @"11";
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Dec" ] == NSOrderedSame) mymthnum = @"12";

                NSString *myampmnum; 
                myampmnum = @"0"; 
                if      ([gbl_rollerBirth_amPm caseInsensitiveCompare: @"am" ]  == NSOrderedSame) myampmnum = @"0";
                else if ([gbl_rollerBirth_amPm caseInsensitiveCompare: @"pm" ]  == NSOrderedSame) myampmnum = @"1";

    //            NSString *myhour; 
    //            myhour = @"0"; 
    //            if      ([gbl_rollerBirth_hour caseInsensitiveCompare: @"1"  ]  == NSOrderedSame) myhour = @"1";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"2"  ]  == NSOrderedSame) myhour = @"2";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"3"  ]  == NSOrderedSame) myhour = @"3";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"4"  ]  == NSOrderedSame) myhour = @"4";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"5"  ]  == NSOrderedSame) myhour = @"5";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"6"  ]  == NSOrderedSame) myhour = @"6";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"7"  ]  == NSOrderedSame) myhour = @"7";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"8"  ]  == NSOrderedSame) myhour = @"8";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"9"  ]  == NSOrderedSame) myhour = @"9";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"10" ]  == NSOrderedSame) myhour = @"10";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"11" ]  == NSOrderedSame) myhour = @"11";
    //            else if ([gbl_rollerBirth_hour caseInsensitiveCompare: @"12" ]  == NSOrderedSame) myhour = @"12";
    //

[self disp_gblsWithLabel: @"doActual save -   BEFORE  build personRecord" ];

                NSString *myNewPersonRecord;
                NSString *mySaveCode;
                if ([gbl_kindOfSave isEqualToString:  @"regular save" ] )            mySaveCode = @"";
                if ([gbl_kindOfSave isEqualToString:  @"no look no change save" ] )  mySaveCode = @"hs";

NSString *fromHomePSV_City;
NSString *fromHomePSV_Prov;
NSString *fromHomePSV_Coun;
    if ( !       [gbl_fromHomeCurrentSelectionPSV isEqualToString: @"" ]
              ||  gbl_fromHomeCurrentSelectionPSV == nil                 
    ) {
fromHomePSV_City =  [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"][7]; // city get fld#1 (grpname) - arr is 0-based 
fromHomePSV_Prov =  [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"][8]; // prov get fld#2 (mbrname) - arr is 0-based 
fromHomePSV_Coun =  [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"][9]; // coun get fld#2 (mbrname) - arr is 0-based 
    }



  NSLog(@"fromHomePSV_City =[%@]",fromHomePSV_City );
  NSLog(@"fromHomePSV_Prov =[%@]",fromHomePSV_Prov );
  NSLog(@"fromHomePSV_Prov =[%@]",fromHomePSV_Coun );
  NSLog(@" gbl_userSpecifiedCity=[%@]", gbl_userSpecifiedCity);
  NSLog(@" gbl_userSpecifiedProv=[%@]", gbl_userSpecifiedProv);
  NSLog(@" gbl_userSpecifiedCoun=[%@]", gbl_userSpecifiedCoun);
  NSLog(@" gbl_currentMenuPlusReportCode=[%@]", gbl_currentMenuPlusReportCode);


//    MAMB09AppDelegate *myappDelegate= (MAMB09AppDelegate *) [[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
NSString *psvString;

trn("-----");
  NSLog(@"gbl_lastSelectedPerson =[%@]",gbl_lastSelectedPerson  );
psvString = [myappDelegate getPSVforPersonName: (NSString *) gbl_lastSelectedPerson ]; 
  NSLog(@"psvString 1 =[%@]",psvString  );
trn("-----");

  NSLog(@"gbl_myname.text =[%@]",  gbl_myname.text);
psvString = [myappDelegate getPSVforPersonName: (NSString *) gbl_myname.text ]; 
  NSLog(@"psvString 2 =[%@]",psvString  );
trn("-----");

  NSLog(@"gbl_userSpecifiedPersonName =[%@]",gbl_userSpecifiedPersonName  );
psvString = [myappDelegate getPSVforPersonName: (NSString *) gbl_userSpecifiedPersonName ]; 
  NSLog(@"psvString 3 =[%@]",psvString  );
trn("-----");

  NSLog(@"gbl_DisplayName =[%@]", gbl_DisplayName );
psvString = [myappDelegate getPSVforPersonName: (NSString *) gbl_DisplayName ]; 
  NSLog(@"psvString 4 =[%@]",psvString  );
trn("-----");



                    
NSString *cityToUse;
NSString *provToUse;
NSString *counToUse;

//
//// defaults
//cityToUse = fromHomePSV_City; 
//provToUse = fromHomePSV_Prov;
//counToUse = fromHomePSV_Coun;
//
//if ( [gbl_currentMenuPlusReportCode  isEqualToString: @"HOMEaddchange"] )
//{
//nbn(621);
//    cityToUse = gbl_userSpecifiedCity;  
//    provToUse = gbl_userSpecifiedProv;  
//    counToUse = gbl_userSpecifiedCoun;  
//
//    if (   [cityToUse isEqualToString: @"" ]
//        ||  cityToUse == nil  
//    ) {
//        cityToUse = fromHomePSV_City; 
//    }
//    if (   [provToUse isEqualToString: @"" ]
//        ||  provToUse == nil  
//    ) {
//        provToUse = fromHomePSV_Prov;
//    }
//    if (   [counToUse isEqualToString: @"" ]
//        ||  counToUse == nil  
//    ) {
//        counToUse = fromHomePSV_Coun;
//    }
//
//} else {
//nbn(622);
//
//    if (   [gbl_userSpecifiedCity isEqualToString: @"" ]
//        ||  gbl_userSpecifiedCity == nil  
//    ) {
//        cityToUse = fromHomePSV_City; 
//    }
//    if (   [gbl_userSpecifiedProv isEqualToString: @"" ]
//        ||  gbl_userSpecifiedProv == nil  
//    ) {
//        provToUse = fromHomePSV_Prov;
//    }
//    if (   [gbl_userSpecifiedCity isEqualToString: @"" ]
//        ||  gbl_userSpecifiedCity == nil  
//    ) {
//        counToUse = fromHomePSV_Coun;
//    }
//}
//

// e.g.
//_(-----)__
//2017-05-22 00:10:22.830224 Me and My BFFs[4253:2406882] gbl_lastSelectedPerson =[~Abigail]
//2017-05-22 00:10:22.830366 Me and My BFFs[4253:2406882] psvString 1 =[~Abigail|8|21|1994|1|20|0|Los Angeles|California|United States||]
//_(-----)__
//2017-05-22 00:10:22.830463 Me and My BFFs[4253:2406882] gbl_myname.text =[tstpa]
//2017-05-22 00:10:22.830724 Me and My BFFs[4253:2406882] psvString 2 =[(null)]
//_(-----)__
//2017-05-22 00:10:22.831083 Me and My BFFs[4253:2406882] gbl_userSpecifiedPersonName =[tstpa]
//2017-05-22 00:10:22.831222 Me and My BFFs[4253:2406882] psvString 3 =[(null)]
//_(-----)__
//2017-05-22 00:10:22.831309 Me and My BFFs[4253:2406882] gbl_DisplayName =[tstpa]
//2017-05-22 00:10:22.831513 Me and My BFFs[4253:2406882] psvString 4 =[(null)]
//_(-----)__
//
//_(-----)__
//2017-05-22 00:11:32.065894 Me and My BFFs[4253:2406882] gbl_lastSelectedPerson =[tstpa]
//2017-05-22 00:11:32.066038 Me and My BFFs[4253:2406882] psvString 1 =[tstpa|1|01|1999|12|01|1|T Hofke|North Brabant|Netherlands||]
//_(-----)__
//2017-05-22 00:11:32.066131 Me and My BFFs[4253:2406882] gbl_myname.text =[tstpaaa]
//2017-05-22 00:11:32.066402 Me and My BFFs[4253:2406882] psvString 2 =[(null)]
//_(-----)__
//2017-05-22 00:11:32.066497 Me and My BFFs[4253:2406882] gbl_userSpecifiedPersonName =[tstpa]
//2017-05-22 00:11:32.066958 Me and My BFFs[4253:2406882] psvString 3 =[tstpa|1|01|1999|12|01|1|T Hofke|North Brabant|Netherlands||]
//_(-----)__
//2017-05-22 00:11:32.067036 Me and My BFFs[4253:2406882] gbl_DisplayName =[tstpaaa]
//2017-05-22 00:11:32.067127 Me and My BFFs[4253:2406882] psvString 4 =[(null)]
//_(-----)__
//
//_(-----)__
//2017-05-22 00:13:21.764102 Me and My BFFs[4253:2406882] gbl_lastSelectedPerson =[tstpaaa]
//2017-05-22 00:13:21.764369 Me and My BFFs[4253:2406882] psvString 1 =[tstpaaa|1|01|1999|12|01|1|T Hofke|North Brabant|Netherlands|hs|]
//_(-----)__
//2017-05-22 00:13:21.764607 Me and My BFFs[4253:2406882] gbl_myname.text =[tstpaaabb]
//2017-05-22 00:13:21.764885 Me and My BFFs[4253:2406882] psvString 2 =[(null)]
//_(-----)__
//2017-05-22 00:13:21.765006 Me and My BFFs[4253:2406882] gbl_userSpecifiedPersonName =[tstpaaa]
//2017-05-22 00:13:21.765150 Me and My BFFs[4253:2406882] psvString 3 =[tstpaaa|1|01|1999|12|01|1|T Hofke|North Brabant|Netherlands|hs|]
//_(-----)__
//2017-05-22 00:13:21.765308 Me and My BFFs[4253:2406882] gbl_DisplayName =[tstpaaabb]
//2017-05-22 00:13:21.765567 Me and My BFFs[4253:2406882] psvString 4 =[(null)]
//_(-----)__
//
//_(-----)__
//2017-05-22 00:15:55.669888 Me and My BFFs[4253:2406882] gbl_lastSelectedPerson =[tstpaaabb]
//2017-05-22 00:15:55.670027 Me and My BFFs[4253:2406882] psvString 1 =[tstpaaabb|1|01|1999|12|01|1|T Hofke|North Brabant|Netherlands|hs|]
//_(-----)__
//2017-05-22 00:15:55.670299 Me and My BFFs[4253:2406882] gbl_myname.text =[tstpb]
//2017-05-22 00:15:55.670565 Me and My BFFs[4253:2406882] psvString 2 =[(null)]
//_(-----)__
//2017-05-22 00:15:55.670655 Me and My BFFs[4253:2406882] gbl_userSpecifiedPersonName =[tstpb]
//2017-05-22 00:15:55.670848 Me and My BFFs[4253:2406882] psvString 3 =[(null)]
//_(-----)__
//2017-05-22 00:15:55.670938 Me and My BFFs[4253:2406882] gbl_DisplayName =[tstpb]
//2017-05-22 00:15:55.671290 Me and My BFFs[4253:2406882] psvString 4 =[(null)]
//_(-----)__
//
//_(-----)__
//2017-05-22 00:16:44.199841 Me and My BFFs[4253:2406882] gbl_lastSelectedPerson =[tstpaaabb]
//2017-05-22 00:16:44.199957 Me and My BFFs[4253:2406882] psvString 1 =[tstpaaabb|1|01|1999|12|01|1|T Hofke|North Brabant|Netherlands|hs|]
//_(-----)__
//2017-05-22 00:16:44.200186 Me and My BFFs[4253:2406882] gbl_myname.text =[tstpaaazz]
//2017-05-22 00:16:44.200312 Me and My BFFs[4253:2406882] psvString 2 =[(null)]
//_(-----)__
//2017-05-22 00:16:44.200380 Me and My BFFs[4253:2406882] gbl_userSpecifiedPersonName =[tstpaaabb]
//2017-05-22 00:16:44.200464 Me and My BFFs[4253:2406882] psvString 3 =[tstpaaabb|1|01|1999|12|01|1|T Hofke|North Brabant|Netherlands|hs|]
//_(-----)__
//2017-05-22 00:16:44.200620 Me and My BFFs[4253:2406882] gbl_DisplayName =[tstpaaazz]
//2017-05-22 00:16:44.200750 Me and My BFFs[4253:2406882] psvString 4 =[(null)]
//_(-----)__
//
//


    // if gbl_userSpecifiedPersonName has a psv string of NOT NULL
    //     then use the city,prov,coun in there
    // else
    //     use the city,prov,coun in gbl_userSpecifiedCity  gbl_userSpecifiedProv gbl_userSpecifiedCoun
    //

    // get the PSV of gbl_userSpecifiedPersonName 
    NSString * PSV_of_gbl_userSpecifiedPersonName;
    PSV_of_gbl_userSpecifiedPersonName = [myappDelegate getPSVforPersonName: (NSString *) gbl_userSpecifiedPersonName ]; 
  NSLog(@"PSV_of_gbl_userSpecifiedPersonName  =[%@]",  PSV_of_gbl_userSpecifiedPersonName );


nbn(721);

    if ( gbl_editingChangeCITYHasOccurred == 1) {
nbn(7215);
        cityToUse = gbl_userSpecifiedCity;  
        provToUse = gbl_userSpecifiedProv;  
        counToUse = gbl_userSpecifiedCoun;  
    }
    else
    if ( ! (   [PSV_of_gbl_userSpecifiedPersonName isEqualToString: @"" ]
            ||  PSV_of_gbl_userSpecifiedPersonName == nil                 )
    ) {
nbn(722);
        // here the PSV string exists

        cityToUse =  [PSV_of_gbl_userSpecifiedPersonName componentsSeparatedByString: @"|"][7]; // city get fld#8  - arr is 0-based 
        provToUse =  [PSV_of_gbl_userSpecifiedPersonName componentsSeparatedByString: @"|"][8]; // prov get fld#9  - arr is 0-based 
        counToUse =  [PSV_of_gbl_userSpecifiedPersonName componentsSeparatedByString: @"|"][9]; // coun get fld#10 - arr is 0-based 

    } else {
nbn(723);
        cityToUse = gbl_userSpecifiedCity;  
        provToUse = gbl_userSpecifiedProv;  
        counToUse = gbl_userSpecifiedCoun;  
    }
nbn(724);


  NSLog(@" cityToUse =[%@]", cityToUse );
  NSLog(@" provToUse =[%@]", provToUse );
  NSLog(@" counToUse =[%@]", counToUse );


                myNewPersonRecord = [NSString stringWithFormat: @"%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|",
                    gbl_DisplayName,
    //                gbl_rollerBirth_mth,
                    mymthnum,
                    gbl_rollerBirth_dd,
                    gbl_rollerBirth_yyyy,
                    gbl_rollerBirth_hour,
    //                myhour,
                    gbl_rollerBirth_min,
    //                gbl_rollerBirth_amPm,
                    myampmnum,

//                    gbl_enteredCity,
//                    gbl_enteredProv,
//                    gbl_enteredCoun,
//                    gbl_userSpecifiedCity,
//                    gbl_userSpecifiedProv,
//                    gbl_userSpecifiedCoun,
//                    [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"][7], // city get fld#1 (grpname) - arr is 0-based 
//                    [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"][8], // prov get fld#2 (mbrname) - arr is 0-based 
//                    [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByString: @"|"][9], // coun get fld#2 (mbrname) - arr is 0-based 
                    cityToUse,
                    provToUse,
                    counToUse,



                    mySaveCode               // "" or "hs"
                ];
  NSLog(@"myNewPersonRecord =[%@]",myNewPersonRecord );
                


                // ONLY IF    [gbl_homeEditingState isEqualToString:  @"view or change" ] 
                // DELETE  the existing record first
                // before  adding the changed record above
                //
                if ([gbl_homeEditingState isEqualToString:  @"view or change" ] )
                {
  NSLog(@"view/change branch");
    //                NSString *prefixStr = [NSString stringWithFormat: @"%@|", gbl_DisplayName ];
                    NSString *prefixStr = [NSString stringWithFormat: @"%@|", gbl_lastSelectedPersonBeforeChange ];

                    NSInteger idx, foundIdx;  
                    idx = 0;       foundIdx = -1;

                    for (NSString *element in gbl_arrayPer) {
                        if ([element hasPrefix: prefixStr]) {
                            foundIdx = idx;
                            break;
                        }
                        idx = idx + 1;
                    }
  NSLog(@"foundIdx =[%ld]",(long)foundIdx );
                    if (foundIdx == -1) {
                        return;  // should not happen
                    }

                    // here, delete old array element before adding new changed personRecord above
                    //
                    [gbl_arrayPer removeObjectAtIndex:  foundIdx ]; //  delete old array element before adding new changed personRecord above

                } // ONLY IF    [gbl_homeEditingState isEqualToString:  @"view or change" ] , DELETE  the existing record first




                // add the new Person database record in a string to the person array
                //
                [gbl_arrayPer addObject: myNewPersonRecord]; // add the new Person database record in a string to the person array


                [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"person"]; // write new array data to file
                [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"person"]; // read new data from file to array
                [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"person"]; // sort array by name



                // if necessary, update MEMBERSHIP  file  (gbl_arrayMem)
                //
                BOOL originalNameHasChanged;
                // true if original name in db record has changed 
//  NSLog(@"gbl_homeUseMODE      =[%@]",gbl_homeUseMODE      );
//  NSLog(@"gbl_homeEditingState =[%@]",gbl_homeEditingState );
//  NSLog(@"gbl_fromHomeCurrentEntityName =[%@]",gbl_fromHomeCurrentEntityName );
//  NSLog(@"gbl_myname.text               =[%@]",gbl_myname.text );

//                originalNameHasChanged = ! [gbl_fromHomeCurrentEntityName isEqualToString: gbl_myname.text ];
                // original name has changed if this is edit mode + change mode and name is different
                originalNameHasChanged =   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
                                        && [gbl_homeEditingState isEqualToString: @"view or change" ]
                                        &&  ! [gbl_fromHomeCurrentEntityName isEqualToString: gbl_myname.text ] ;



                if (originalNameHasChanged )
                {
                    [myappDelegate mambChangeGRPMEM_memberNameFrom: (NSString *) gbl_fromHomeCurrentEntityName 
                                                         toNewName: (NSString *) gbl_myname.text
                    ];
                    [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"member"]; // write new array data to file
//                    [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"member"]; // read new data from file to array
                    [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"member"]; // sort array by name
//  NSLog(@"gbl_arrayMem in MEM UPDATE #2 =[%@]",gbl_arrayMem );
                }

                gbl_justAddedPersonRecord  = 1;  // cause reload of home data


                gbl_lastSelectedPerson     = gbl_DisplayName;  // this row (gbl_lastSelectedPerson) gets selection highlight in home tableview

                gbl_fromHomeCurrentSelectionPSV = myNewPersonRecord;
//      NSLog(@"gbl_lastSelectedPerson          =[%@]",gbl_lastSelectedPerson);
//      NSLog(@"gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );


//                // after write of array data to file, allow user interaction events again
//                //
//                if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] == YES) {  // re-enable handling of touch-related events
//                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];       // typically call this after an animation or transitiion.
//      NSLog(@"STOP IGnoring events");
//                }
//

  NSLog(@"          POP  VIEW   #6");
  NSLog(@"SET gbl_myCitySoFar #09=[%@]",@"" );
                dispatch_async(dispatch_get_main_queue(), ^{  
                    // after saving new person, go back to home view

                    // pop to root view controller (actually do the "Back" action)
                    // 

                    gbl_myname.text                  = gbl_initPromptName;
                    gbl_myCitySoFar                  = @"";
  NSLog(@"citych #24  %-24s =[%@] $$$  doActualPersonSave  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar" , gbl_myCitySoFar );
                    gbl_editingChangeNAMEHasOccurred = 0;
                    gbl_editingChangeCITYHasOccurred = 0;
                    gbl_editingChangeDATEHasOccurred = 0;
                    gbl_lastInputFieldTapped         = @"";  // 3 values are: "name", "city", "date"

//                    [self.navigationController popToRootViewControllerAnimated: YES]; // pop to root view controller (actually do the "Back" action)


                    [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action



                });
                // is system "done" button function here
    //            gbl_lastSelectedPersonBeforeChange = gbl_DisplayName;   // like "~Dave"   used in YELLOW gbl_homeUseMODE "edit mode"


  NSLog(@" end of doActualPersonSave");
} //  doActualPersonSave



//
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSLog(@"in canEditRowAtIndexPath!");
//  NSLog(@"indexPath.row =%ld",indexPath.row );
//
////
////    // Return NO if you do not want the specified item to be editable.
////    if (indexPath.row == 5 ) return  NO;
////    else                     return YES;
////
//
//    return YES;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath: (NSIndexPath *)indexPath
//{
//tn();
//NSLog(@"in editingStyleForRowAtIndexPath");
//    return UITableViewCellEditingStyleDelete;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)  editingStyle
//                                            forRowAtIndexPath: (NSIndexPath *)                indexPath
//{
//  NSLog(@"in commitEditingStyle");
//  NSLog(@"editingStyle=[%@]",editingStyle);
//    // If row is deleted, remove it from the list.
//
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
////        SimpleEditableListAppDelegate *controller = (SimpleEditableListAppDelegate *)[[UIApplication sharedApplication] delegate];
////        [controller removeObjectFromListAtIndex:indexPath.row];
////        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//  NSLog(@"in commitEditingStyle  2222222");
//    }
//
//}
//
//

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

    if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"person" ] )
    { 
      // rows are (index-usage)  0-spacer, 1-name, 2-spacer, 3-city, 4-spacer, 5-date
      // return 6;  // hidden gbl_mycitySearchString   moved to rownum=2 from rownum=6 (for scrollRectToVisible)

      // rows are (index-usage)  0-spacer, 1-name, 2-spacer, 3-city, 4-spacer, 5-date, 6-spacer, 7-group memberships
      //    note that row with index 2 has hidden field for city search string
      return 8;    


    } 
    if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ] )
    { 
      return 2;  // hidden gbl_mycitySearchString   moved to rownum=2 from rownum=6 (for scrollRectToVisible)
    } 

    return 1;  // should not happen
}


// textFieldShouldBeginEditing: is called just before the text field becomes active.
// This is a good place to customize the behavior of your application.
// In this instance, the background color of the text field changes when this method is called to indicate the text field is active.
//
- (BOOL)textFieldShouldBeginEditing: (UITextField *)textField
{
tn();   NSLog(@"in textFieldShouldBeginEditing ################################################## ");
  NSLog(@"textField.tag=[%ld]",(long)textField.tag);
  NSLog(@"textField.text=[%@]",textField.text);
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
  NSLog(@"gbl_myname.text=[%@]",gbl_myname.text);
//  NSLog(@"gbl_justCancelledOutOfCityPicker =%ld",gbl_justCancelledOutOfCityPicker );





    if (textField.tag == 2) {                 // city,prov,coun  LABEL

        if ( gbl_justLookedAtInfoScreen == 0) {

            if (gbl_citySetEditingValue == 1) {  // set initial value  when first entering City in "edit mode"  yellow

                gbl_citySetEditingValue  = 0;    // set initial value  when first entering City in "edit mode"  yellow
            
                gbl_myCitySoFar   = fldCity;
  NSLog(@"citych #23  %-24s =[%@] $$$  textFieldShouldEndEditing  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar" , gbl_myCitySoFar );
                textField.text    = fldCity;
  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
  NSLog(@"textField.text=[%@]",textField.text);

  NSLog(@"SET gbl_myCitySoFar #10=[%@]",gbl_myCitySoFar );

    //            if (   [gbl_homeUseMODE      isEqualToString: @"edit mode" ]
    //                && [gbl_homeEditingState isEqualToString: @"view or change" ]

                  if ( [gbl_homeEditingState isEqualToString: @"add" ]
                ) {
                    [self showCityProvCountryForTypedInCity:  gbl_myCitySoFar ];   // and possibly shown button  "Wheel >"
                }
            } 
        } // gbl_justLookedAtInfoScreen == 0

//        } else {
//            if (gbl_userSpecifiedCity != nil)
//            {
//                [self disp_gblsWithLabel: @"in textFieldShouldBeginEditing for city field" ];
//
//                // update picker row for city
////  NSLog(@"gbl_lastSelectedCityPickerRownum  =[%ld]",(long)gbl_lastSelectedCityPickerRownum  );
////                [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldBeginEditing > textFieldDidBeginEditing > back here
////                gbl_mycitySearchString.inputView = [self pickerViewCity] ;   // this is only place is set to pickerViewCity
////nbn(535);
////                [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do not show old data
////nbn(536);
////                [self.pickerViewCity selectRow: gbl_lastSelectedCityPickerRownum  inComponent: 0 animated: YES]; // mth  = jan
//            }
//        }
//


    } // end of (textField.tag == 2) {                 // city,prov,coun  LABEL





    [ self setFieldTap_currPrev ];

  NSLog(@"gbl_firstResponder_current =[%@]",gbl_firstResponder_current );

    if ( [gbl_firstResponder_current isEqualToString:  @"date" ] ) {      // this is the only place gbl_firstResponder_current  is USED
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


//tn();   did not work
//  NSLog(@"city FIXER in should begin edit ");
//        // FIXER
//        gbl_fieldTap_goingto       = @"city";
//        gbl_firstResponder_current = @"city";

  NSLog(@"                                    GOT A TAP  in   textField  CITY");
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse1        =%@",gbl_pickerToUse );
  NSLog(@"gbl_fieldTap_goingto                                        =[%@]",gbl_fieldTap_goingto       );
  NSLog(@"gbl_firstResponder_current                                  =[%@]",gbl_firstResponder_current );



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

//   [self setSelectedRange: NSMakeRange(0, 0) ];



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
//  //
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
    if (gbl_mybirthinformation.isFirstResponder == 1)  gbl_fieldTap_goingto = @"date";  // never happens (fld is neveer first responder)

  NSLog(@"gbl_fieldTap_goingto =%@  tap tap tap ",gbl_fieldTap_goingto );

    [ self setFieldTap_currPrev ];

    // gbl_mybirthinformation.tag                      = 3;
    //
    // note that birth date/time does not come here, instead, _(in didSelectRow in some  PICKER !!   !!!!!


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


    // trim spaces off end of textField.text
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
    [ self setFieldTap_currPrev ];



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

    [ self setFieldTap_currPrev ];


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
  NSLog(@"citych #21  %-24s =[%@] $$$  textFieldDidEndEditing  $$$$$$$$$$$$$$$$$$$$", "gbl_userSpecifiedCity " , gbl_userSpecifiedCity );
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

    [ self setFieldTap_currPrev ];
trn("END OF  textFieldDidEndEditing ########################################################################################## ");tn();

} // textFieldDidEndEditing


// determine   gbl_firstResponder_previous 
//             gbl_firstResponder_current
// using       gbl_fieldTap_leaving 
//             gbl_fieldTap_goingto
//
- (void) setFieldTap_currPrev 
{
tn();
  NSLog(@"in setFieldTap_currPrev ");
  NSLog(@"gbl_fieldTap_leaving =[%@]",gbl_fieldTap_leaving );
  NSLog(@"gbl_fieldTap_goingto =[%@]",gbl_fieldTap_goingto );


    if (   gbl_fieldTap_leaving == nil                                       // this is the only place gbl_fieldtap_* is used
        && gbl_fieldTap_goingto == nil  )  return;


    if ([ gbl_fieldTap_leaving isEqualToString: gbl_fieldTap_goingto ]) {    // this is the only place gbl_fieldtap_* is used
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
        gbl_firstResponder_previous = gbl_fieldTap_leaving;                 // this is the only place gbl_firstResponder_previous is SET
        gbl_firstResponder_current  = gbl_fieldTap_goingto;                 // this is the only place gbl_firstResponder_current  is SET

  NSLog(@"--- 222 -- firstResponder variable Change!!  ---------------------------");
  NSLog(@"            gbl_myname.isFirstResponder=%d",gbl_myname.isFirstResponder);
  NSLog(@"gbl_mycitySearchString.isFirstResponder=%d",gbl_mycitySearchString.isFirstResponder);
  NSLog(@"gbl_mybirthinformation.isFirstResponder=%d",gbl_mybirthinformation.isFirstResponder);
  NSLog(@"gbl_fieldTap_leaving  =%@",gbl_fieldTap_leaving );
  NSLog(@"gbl_fieldTap_goingto  =%@",gbl_fieldTap_goingto );
  NSLog(@"gbl_firstResponder_previous  =%@",gbl_firstResponder_previous );
  NSLog(@"gbl_firstResponder_current   =%@",gbl_firstResponder_current  );
  NSLog(@"---------------------------------------------------------------");


    }
} //  setFieldTap_currPrev 



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
NSLog(@"arg_typedCharAsNSString=[%@]",arg_typedCharAsNSString);

//  NSLog(@"=%@", [@"" stringByPaddingToLength:100 withString: @"abc" startingAtIndex:0]);

// log typed thing
//  if (arg_typedCharAsNSString.length != 0  && arg_typedCharAsNSString != nil) {
//NSLog(@"in textField: shouldChangeCharactersInRange: replacementString: =%@", [@"" stringByPaddingToLength: 20 withString: arg_typedCharAsNSString  startingAtIndex: 0] );
//  }

  //  NSLog(@"textField.description=%@",textField.description);
//  NSLog(@"textField.tag=%ld",(long)textField.tag);
//  NSLog(@"textField.text=[%@]",textField.text);
//  NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
//  NSLog(@"gbl_myname.text=[%@]",gbl_myname.text);
//  NSLog(@"gbl_previousCharTypedWasSpace =%ld",(long)gbl_previousCharTypedWasSpace );


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
               [gbl_myname.text isEqualToString: @""  ]     // here first character typed is SPACE
            ||  gbl_myname.text == nil                      // here first character typed is SPACE
           )
        && (   [gbl_myCitySoFar isEqualToString: @""  ] )
    )
    {
        return NO;
    }


    if (textField.tag == 2 ) {   // CITY 
//          gbl_myCitySoFar =  [NSString stringWithFormat:@"%@%@", textField.text,  arg_typedCharAsNSString ];

        if (gbl_myCitySoFar == nil) {
            gbl_myCitySoFar =  arg_typedCharAsNSString;
  NSLog(@"SET gbl_myCitySoFar #14=[%@]",gbl_myCitySoFar );
  NSLog(@"citych #20  %-24s =[%@] $$$ shouldChangeCharactersInRange $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar " , gbl_myCitySoFar );
        } else {
            gbl_myCitySoFar =  [NSString stringWithFormat:@"%@%@", gbl_myCitySoFar, arg_typedCharAsNSString ]; // APPEND typed char
  NSLog(@"SET gbl_myCitySoFar #15=[%@]",gbl_myCitySoFar );
  NSLog(@"citych #19  %-24s =[%@] $$$ shouldChangeCharactersInRange $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar " , gbl_myCitySoFar );
        }
        textField.text = gbl_myCitySoFar;
  NSLog(@"after APPEND typed char, gbl_myCitySoFar=[%@]",gbl_myCitySoFar );
  NSLog(@"textField.text                          =[%@]",textField.text );
  tn();
    }


    NSString *myNotFoundMsg;

    if ( [arg_typedCharAsNSString isEqualToString: @""] )    // backspace
    {
tn(); NSLog(@"HEY!    BACKSPACE     was pressed");
  NSLog(@"gbl_myCitySoFar1=%@",gbl_myCitySoFar);



        // because this is BACKSPACE KEY,  remove final char of arg gbl_myCitySoFar 
        //
        if ( textField.text != nil  &&  textField.text.length != 0 )
        {

            if (textField.tag == 2) { // city
//                gbl_myCitySoFar =  textField.text ;
//  NSLog(@"gbl_myCitySoFar2=%@",gbl_myCitySoFar);

                NSInteger tmpIndex = [gbl_myCitySoFar length];                                         // end char out of  gbl_myCitySoFar 
                if (tmpIndex > 0) {
  NSLog(@"SET gbl_myCitySoFar #17=[%@]",gbl_myCitySoFar );
                    gbl_myCitySoFar = [gbl_myCitySoFar substringToIndex: tmpIndex - 1];  // end char out of  gbl_myCitySoFar
  NSLog(@"citych #18  %-24s =[%@] $$$ shouldChangeCharactersInRange $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar " , gbl_myCitySoFar );
                }
NSLog(@"=gbl_myCitySoFar %@",gbl_myCitySoFar );

                [self showCityProvCountryForTypedInCity:  gbl_myCitySoFar ];   // and possibly shown button  "Wheel >"

                if (gbl_CITY_NOT_FOUND == YES) {

tn();
NSLog(@"gbl_myCitySoFar=[%@]",gbl_myCitySoFar );
kin(gbl_CITY_NOT_FOUND );

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


        if (textField.tag == 2) { // city
            if (gbl_myCitySoFar.length == 0) {
  NSLog(@"SET gbl_myCitySoFar #20 with setCitySearchStringTitleTo" );
                [self setCitySearchStringTitleTo: @"Type City Name" ]; //  update title of keyboard "toolbar"
            } else {
  NSLog(@"SET gbl_myCitySoFar #21 with setCitySearchStringTitleTo" );
                [self setCitySearchStringTitleTo: gbl_myCitySoFar   ]; //  update title of keyboard "toolbar"
            }

      NSLog(@"gbl_myCitySoFar=%@",gbl_myCitySoFar);
            // update place labels  (has one less char in gbl_myCitySoFar)
            // field updates in cellForRowAtIndexpath
            //
            [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath
        }

//        gbl_timeOfPrevCityKeystroke = gbl_timeOfCurrCityKeystroke; // set city keystroke interval times
//        CFTimeInterval timeNow      = CACurrentMediaTime();  // returns double CFTimeInterval
//        gbl_timeOfCurrCityKeystroke = timeNow;               // set city keystroke interval times

//    [self showHide_ButtonToSeePicklist ];

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
//        NSString *myMaxMsg;

//        myAlertTitle = [NSString stringWithFormat:@"Maximum %ld Characters", (long)gbl_MAX_lengthOfName ];
//        if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"] ) myMaxMsg =  @"for Person Name";
//        if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"group"] )  myMaxMsg =  @"for Group Name";
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Maximum 15 Characters"
//                                                                       message: myMaxMsg
//                                                                preferredStyle: UIAlertControllerStyleAlert  ];

        if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"person"] ) {
            myAlertTitle = [NSString stringWithFormat:@"Maximum %ld Characters\nfor Person Name", (long)gbl_MAX_lengthOfName ];
        } 
        if ( [gbl_fromHomeCurrentSelectionType isEqualToString: @"group"] ) {
            myAlertTitle = [NSString stringWithFormat:@"Maximum %ld Characters\nfor Group Name", (long)gbl_MAX_lengthOfName ];
        }

        UIAlertController* alert = [UIAlertController alertControllerWithTitle: myAlertTitle
                                                                       message: nil
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
//    NSString *allowedCharactersInCity = @"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-";
    NSString *allowedCharactersInCity = @"abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-";
//    NSString *allowedCharactersInName = [[NSString alloc] initWithUTF8String: gbl_allowedCharactersInName ];
//    NSString *allowedCharactersInCity = [[NSString alloc] initWithUTF8String: gbl_allowedCharactersInCity ];


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
        if (tmpIndex > 0) {
            gbl_myCitySoFar = [gbl_myCitySoFar substringToIndex: tmpIndex - 1];  // end char out of  gbl_myCitySoFar
  NSLog(@"SET gbl_myCitySoFar #31=[%@]",gbl_myCitySoFar );
  NSLog(@"citych #17  %-24s =[%@] $$$  cellForRow  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar " , gbl_myCitySoFar );
        }


NSLog(@"after remove last char (bad char) gbl_myCitySoFar=[%@]",gbl_myCitySoFar );
        return NO;
    }

//    NSLog(@"GOOD  GOOD   allowedCharacters contains typed char!");

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
        [self showCityProvCountryForTypedInCity:  gbl_myCitySoFar ];   // and possibly shown button  "Wheel >"

        if (gbl_CITY_NOT_FOUND == YES) {

  NSLog(@"\n  CITY NOT FOUND DIALOGUE  Start");


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
        if (tmpIndex > 0) {
  NSLog(@"SET gbl_myCitySoFar #33=[%@]",gbl_myCitySoFar );
            gbl_myCitySoFar = [gbl_myCitySoFar substringToIndex: tmpIndex - 1];  // end char out of  gbl_myCitySoFar
  NSLog(@"citych #16  %-24s =[%@] $$$  cellForRow  $$$$$$$$$$$$$$$$$$$$", "gbl_myCitySoFar " , gbl_myCitySoFar );
        }

NSLog(@"after remove last char (not found) gbl_myCitySoFar=[%@]",gbl_myCitySoFar );

  NSLog(@"\n   CITY NOT FOUND DIALOGUE  end\n");
            return NO;
        }



        //  update title of keyboard "toolbar"
        //

//        gbl_searchStringTitle.title = gbl_myCitySoFar; 
  NSLog(@"SET gbl_myCitySoFar #50 with setCitySearchStringTitleTo" );
    [self setCitySearchStringTitleTo: gbl_myCitySoFar ];

        // update city label field  update field in cellForRowAtIndexpath
        //
        [ self updateCityProvCoun ]; // update city/prov/couon field  in cellForRowAtIndexpath

    }  // is city field

//  NSLog(@"----- END OF  shouldChangeCharactersInRange  -----"); tn();


    if (textField.tag == 1) { // name
        gbl_editingChangeNAMEHasOccurred = 1;   // default 0 at startup (after hitting "Edit" button on home page)
        gbl_DisplayName = textField.text;  // latest value
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
//    UIFont *myFontSmaller3 = [UIFont fontWithName: @"Menlo" size: 13.0];
//    UIFont *myFontSmaller4 = [UIFont fontWithName:@"Menlo" size: 12.0];
//    UIFont *myFontSmaller5 = [UIFont fontWithName: @"Menlo" size: 10.0];
//    UIFont *myFontSmaller5 = [UIFont systemFontOfSize:10.0f];
//    UIFont *myFontSmaller5 = [UIFont boldSystemFontOfSize:12.0f];
//    UIFont *myFontSmaller5 = [UIFont systemFontOfSize:12.0f];
//    UIFont *myFontSmaller5 = [UIFont fontWithName:@"HelveticaNeue-Bold" size: 12.0];
//    UIFont *myFontSmaller5 = [UIFont fontWithName:@"HelveticaNeue" size: 12.0];
//    UIFont *myFontSmaller5 = [UIFont fontWithName:@"Menlo" size: 10.0];

//    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size: 18.0],

//    UIFont *myFontSmaller14 = [UIFont fontWithName: @"Menlo" size: 14.0];

    // invisible button for taking away the disclosure indicator
    //
    UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [UIButton buttonWithType: UIButtonTypeCustom];
    myInvisibleButton.backgroundColor = gbl_colorEditingBG_current;  //   [UIColor clearColor];

   
     if (indexPath.row == 0) {   //  filler row 0
        dispatch_async(dispatch_get_main_queue(), ^{        
            cell.userInteractionEnabled         = NO;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
        });
     }

     if (indexPath.row == 1) {   //  NAME of Person or Group


//    [cell addTarget: self
//                          action: @selector(touchDownIn_gbl_mynameCell: )
//                forControlEvents: UIControlEventTouchDown
//    ];


//
//        if (gbl_oneTapRecog_InNameCell == nil)
//        {
//            gbl_oneTapRecog_InNameCell = [
//               [UITapGestureRecognizer alloc] initWithTarget: cell.contentView
////       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                                      action: @selector( process_oneTapRecog_InNameCell: )
//            ];
//            [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 2];
//            [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
////    [gbl_doubleTapGestureRecognizer requireGestureRecognizerToFail: gbl_tripleTapGestureRecognizer ];
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = YES;   
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = NO;   
////    gbl_doubleTapGestureRecognizer.cancelsTouchesInView        = YES;   
//
//            gbl_doubleTapGestureRecognizer.delegate                  = self;   
////    [self.view addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//            [gbl_myname addGestureRecognizer: gbl_oneTapRecog_InNameCell ];
//        }
//
//        if (gbl_dblTapRecog_InNameCell == nil)
//        {
//            gbl_dblTapRecog_InNameCell = [
//               [UITapGestureRecognizer alloc] initWithTarget: cell.contentView
////       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                                      action: @selector( process_dblTapRecog_InNameCell: )
//            ];
//            [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 2];
//            [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
////    [gbl_doubleTapGestureRecognizer requireGestureRecognizerToFail: gbl_tripleTapGestureRecognizer ];
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = YES;   
////    gbl_doubleTapGestureRecognizer.delaysTouchesBegan        = NO;   
////    gbl_doubleTapGestureRecognizer.cancelsTouchesInView        = YES;   
//
//            gbl_doubleTapGestureRecognizer.delegate                  = self;   
////    [self.view addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//            [gbl_myname addGestureRecognizer: gbl_dblTapRecog_InNameCell ];
//        }
//



        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"group" ] )
        {   // do group   name row
  NSLog(@"group  name row (1)   gbl_myname.text =[%@]",gbl_myname.text );
  NSLog(@"gbl_homeUseMODE=[%@]",gbl_homeUseMODE);
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
  NSLog(@"gbl_fromHomeCurrentEntity    =[%@]",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_fromHomeCurrentEntityName=[%@]",gbl_fromHomeCurrentEntityName);

            gbl_myname.delegate = self;

            dispatch_async(dispatch_get_main_queue(), ^{

                cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
                cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
                gbl_myname.autocorrectionType       = UITextAutocorrectionTypeNo;
                gbl_myname.keyboardType             = UIKeyboardTypeASCIICapable; // disables emoji keyboard
                gbl_myname.backgroundColor          = gbl_colorEditingBGforInputField;

                if (   [gbl_myname.text isEqualToString: gbl_initPromptName ] 
                    &&  gbl_editingChangeNAMEHasOccurred == 0                 // default 0 at startup (after hitting "Edit" button on home page)
                    && ! [gbl_homeEditingState isEqualToString: @"view or change" ] 
                ) {
                    gbl_myname.text                     = gbl_initPromptName ; // is  @"Name"
                    gbl_myname.textColor                = [UIColor colorWithRed: 128.0/255.0    // use KVC    gray
                                                                          green: 128.0/255.0
                                                                           blue: 128.0/255.0
                                                                          alpha: 1.0         ] ;
                } else {
//                    gbl_myname.text                     = fldName;
                    gbl_myname.text                     = fldNameG;
                    gbl_myname.textColor                = [UIColor blackColor];
                }
    
                gbl_myname.spellCheckingType        =   UITextSpellCheckingTypeNo;

                gbl_myname.font                     = myFontMiddle;
                gbl_myname.borderStyle              = UITextBorderStyleRoundedRect;
                gbl_myname.textAlignment            = NSTextAlignmentLeft;
                gbl_myname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                gbl_myname.tag                      = 1;
                gbl_myname.autocapitalizationType   = UITextAutocapitalizationTypeNone;

    if (gbl_justLookedAtInfoScreen ==  0) {

        gbl_myname.inputAccessoryView = gbl_ToolbarForGroupName ; // for group name input field

      NSLog(@"gbl_myname.inputAccessoryView 01_G for group SET SET SET SET SET SET SET SET SET  SET ");

    } // end of if (gbl_justLookedAtInfoScreen ==  0)


                [cell addSubview: gbl_myname ];

            });
        }   // do group   name row





        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"person" ] )
        {   // do person   name row
  NSLog(@"person name row    gbl_myname.text =[%@]",gbl_myname.text );
  NSLog(@"gbl_homeUseMODE=[%@]",gbl_homeUseMODE);
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
  NSLog(@"gbl_fromHomeCurrentEntity=[%@]",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_fromHomeCurrentEntityName=[%@]",gbl_fromHomeCurrentEntityName);

            gbl_myname.delegate = self;

            dispatch_async(dispatch_get_main_queue(), ^{

    //            cell.textLabel.backgroundColor           = gbl_colorEditing;
                cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
                cell.selectionStyle                 = UITableViewCellSelectionStyleNone;

                gbl_myname.autocorrectionType       = UITextAutocorrectionTypeNo;
    //            gbl_myname.clearButtonMode          = UITextFieldViewModeWhileEditing ;
    //            gbl_myname.keyboardType             = UIKeyboardTypeNamePhonePad; // optimized for entering a person's name or phone number

                // UIKeyboardTypeASCIICapable   disables emoji keyboard
                gbl_myname.keyboardType             = UIKeyboardTypeASCIICapable; // disables emoji keyboard

    //            gbl_myname.backgroundColor          = gbl_colorEditing;
    //            gbl_myname.backgroundColor          = [UIColor yellowColor];
                gbl_myname.backgroundColor          = gbl_colorEditingBGforInputField;
    //            gbl_myname.backgroundColor          = currentBGfieldColor;


                if (   [gbl_myname.text isEqualToString: gbl_initPromptName ] 
                    &&  gbl_editingChangeNAMEHasOccurred == 0                 // default 0 at startup (after hitting "Edit" button on home page)
                    && ! [gbl_homeEditingState isEqualToString: @"view or change" ] 
                ) {
                    // set "Name"  initial prompt, but only if its not set already
                    // So, if we have just looked at info screen, do not set it
                    //
tn();

  NSLog(@"gbl_justLookedAtInfoScreen  in celForRow in add/change  =[%ld]",(long)gbl_justLookedAtInfoScreen );
                    if (gbl_justLookedAtInfoScreen ==  1) {
                       // it is set already
                    } else {
                       gbl_myname.text                     = gbl_initPromptName ; // is  @"Name"
                    }
                    gbl_myname.textColor                = [UIColor colorWithRed: 128.0/255.0    // use KVC    gray
                                                                          green: 128.0/255.0
                                                                           blue: 128.0/255.0
                                                                          alpha: 1.0         ] ;
                } else {
                    //  home didSelectRow gbl_fromHomeCurrentSelectionPSV =~Jackson|2|3|1993|0|1|1|Los Angeles|California|United States||z
                    gbl_myname.text                     = fldName;
                    gbl_myname.textColor                = [UIColor blackColor];
                }


                gbl_myname.spellCheckingType        =   UITextSpellCheckingTypeNo;
    //            gbl_myname.font                     = myFont;
                gbl_myname.font                     = myFontMiddle;
                gbl_myname.borderStyle              = UITextBorderStyleRoundedRect;
                gbl_myname.textAlignment            = NSTextAlignmentLeft;
                gbl_myname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                gbl_myname.tag                      = 1;
                gbl_myname.autocapitalizationType   = UITextAutocapitalizationTypeNone;

                gbl_userSpecifiedPersonName = gbl_myname.text;


                if (gbl_justLookedAtInfoScreen ==  0) {

                    gbl_myname.inputAccessoryView = gbl_ToolbarForPersonName ; // for person name input field
                  NSLog(@"gbl_myname.inputAccessoryView 01_B  SET SET SET SET SET SET SET SET SET  SET ");

                } // end of if (gbl_justLookedAtInfoScreen ==  0)


                [cell addSubview: gbl_myname ];
            });
        }   // do person   name row

     } //  NAME row (1)





     if (indexPath.row == 3)  // "LABEL" for  city,proc,coun  of Birth of Person
     {   // "LABEL" for  city,proc,coun  of Birth of Person

  NSLog(@"city row   gbl_fieldTap_goingto =[%@]",gbl_fieldTap_goingto );

        NSString *myTextCity;

  NSLog(@"fldCity        = [%@]",fldCity);
  NSLog(@"fldProv        = [%@]",fldProv);
  NSLog(@"fldCountry       [%@]",fldCountry);
  NSLog(@"fldKindOfSave =[%@]",fldKindOfSave );
  NSLog(@"gbl_kindOfSave =[%@]",gbl_kindOfSave );
  NSLog(@"gbl_enteredCity= [%@]",gbl_enteredCity);
  NSLog(@"gbl_enteredProv= [%@]",gbl_enteredProv);
  NSLog(@"gbl_enteredCoun= [%@]",gbl_enteredCoun);




        // log shows these 3 are out of date here

        // Therefore, get latest values using gbl_lastSelectedCityPickerRownum
        // with  getCurrentCityProvCounForRownum: (NSInteger) arg_rownum   // populates gbl_enteredCity, Prov, Coun
        [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, gbl_enteredProv, gbl_entere
  NSLog(@"!! fixer of gbl_enteredCity etc INSERTED HERE");




        gbl_DisplayCity = gbl_enteredCity;
  NSLog(@"citych #15  %-24s =[%@] $$$  cellForRow  $$$$$$$$$$$$$$$$$$$$", "gbl_DisplayCity " , gbl_DisplayCity );
        gbl_DisplayProv = gbl_enteredProv;
        gbl_DisplayCoun = gbl_enteredCoun;
  NSLog(@"3 gbl_enteredCity=[%@]",gbl_enteredCity);
  NSLog(@"3 gbl_enteredProv=[%@]",gbl_enteredProv);
  NSLog(@"3 gbl_enteredCoun=[%@]",gbl_enteredCoun);


        if ([gbl_homeEditingState isEqualToString: @"view or change" ] )
        {

            if ([gbl_kindOfSave isEqualToString: @"no look no change save" ] )
            {
                // OVErrIDE displayed city info  here, if gbl_kindOfSave   is  "no look no change save"
                //    put "Saved with No Look, No Change"

        NSString *exceptionalSearchStr = [NSString stringWithFormat:@" %@",
            gbl_initPromptCity  // is  gbl_initPromptCity  (@"Birth City or Town")  with LEADING SPACE  with LEADING SPACE
        ];



                    gbl_mycityprovcounLabel.attributedText =
//                 [[NSAttributedString alloc] initWithString: @" Saved with No Look, No Change\n Saved with No Look, No Change\n Saved with No Look, No Change"
//                 [[NSAttributedString alloc] initWithString: @" Hide Birth Information Save\n Hide Birth Information Save\n Hide Birth Information Save"
//                 [[NSAttributedString alloc] initWithString: @" Saved with Hide Birth Information\n Saved with Hide Birth Information\n Saved with Hide Birth Information"

//
//3727:                         NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Medium" size: 16.0f]
//             gbl_mybirthinformation.font             = myFontSmaller2;   // for no look, ...
//    UIFont *myFontSmaller2 = [UIFont fontWithName: @"Menlo" size: 16.0];
//
                 [[NSAttributedString alloc] initWithString: @" Personal Privacy\n Personal Privacy\n Personal Privacy"
                     attributes: @{
                         NSForegroundColorAttributeName:  [UIColor lightGrayColor] ,
                                    NSFontAttributeName: myFontSmaller2
                     }
                 ];
  NSLog(@"citych #14  %-24s =[%@] $$$  cellforr $$$$$$$$$$$$$$$$$$$$", "gbl_mycityprovcounLabelmyTextCity " , gbl_mycityprovcounLabel.attributedText );


//  NSLog(@"[gbl_mycityprovcounLabel.text =[%@]",gbl_mycityprovcounLabel.text );
//  NSLog(@"gbl_initPromptCity =[%@]",gbl_initPromptCity );
//            if ([gbl_mycityprovcounLabel.text hasPrefix: gbl_initPromptCity ] )  // is  @"Birth City or Town"
            if ([gbl_mycityprovcounLabel.text hasPrefix: exceptionalSearchStr ] )
            {
                gbl_mycityprovcounLabel.textColor         = [UIColor lightGrayColor];
//                gbl_mycityprovcounLabel.textColor         = gbl_colorPlaceHolderPrompt;
////                gbl_mycityprovcounLabel.textColor    = gbl_colorPlaceHolderPrompt; // gray   too dark
            } else {
                gbl_mycityprovcounLabel.textColor         = [UIColor lightGrayColor];
//                gbl_mycityprovcounLabel.textColor         = gbl_colorPlaceHolderPrompt;
            }
            gbl_mycityprovcounLabel.numberOfLines    = 0;
            gbl_mycityprovcounLabel.tag              = 2;
//            gbl_mycityprovcounLabel.font             = myFontSmaller2;
//            gbl_mycityprovcounLabel.font             = myFontSmaller3;
            gbl_mycityprovcounLabel.font             = myFontSmaller2;

//            gbl_mybirthinformation.font                    = myFontSmaller14;
//                    gbl_mycityprovcounLabel.font             = [UIFont fontWithName: @"Menlo" size: 10.0];


            gbl_mycityprovcounLabel.textAlignment    = NSTextAlignmentLeft;

//            gbl_mycityprovcounLabel.borderStyle              = UITextBorderStyleLine;
// gbl_mycityprovcounLabel.layer.borderColor = [UIColor greenColor].CGColor;
// gbl_mycityprovcounLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
// gbl_mycityprovcounLabel.layer.borderColor = gbl_colorPlaceHolderPrompt;  // compile error
  
//  gbl_mycityprovcounLabel.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:064.0/255.0 green:064.0/255.0 blue:064.0/255.0 alpha:1.0]); // gray   __bridge suggested by XCODE

// gbl_mycityprovcounLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;  // works, but too dak

            gbl_mycityprovcounLabel.layer.borderColor  = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor ; // gray

            gbl_mycityprovcounLabel.layer.borderWidth  = 1.0;
            gbl_mycityprovcounLabel.layer.cornerRadius = 8.0;


//            gbl_mycityprovcounLabel.backgroundColor  = gbl_colorEditingBG;
//            gbl_mycityprovcounLabel.backgroundColor  = [UIColor whiteColor];
            gbl_mycityprovcounLabel.backgroundColor  =  gbl_colorEditingBGforInputField;

            // If you want the clear button to be always visible,
            // then you need to set the text field's clearButtonMode property to UITextFieldViewModeAlways. 
//            gbl_mycityprovcounLabel.clearButtonMode  = UITextFieldViewModeAlways;
//           gbl_mycitySearchString.clearButtonMode  = UITextFieldViewModeAlways;




                dispatch_async(dispatch_get_main_queue(), ^{  

            cell.userInteractionEnabled         = YES;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
//            cell.contentView.backgroundColor    = currentBGfieldColor;

            [cell addSubview: gbl_mycityprovcounLabel ];


                });

                return cell;

            }   // if ([gbl_kindOfSave isEqualToString: @"no look no change save" ] )


  NSLog(@"city view/edit");
  NSLog(@"fldCity   =[%@]",fldCity);
  NSLog(@"fldProv   =[%@]",fldProv);
  NSLog(@"fldCountry=[%@]",fldCountry);
  NSLog(@"gbl_enteredCity=[%@]",gbl_enteredCity);
  NSLog(@"gbl_enteredProv=[%@]",gbl_enteredProv);
  NSLog(@"gbl_enteredCoun=[%@]",gbl_enteredCoun);
            if (gbl_citySetLabelValue == 1 ) {  // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
                gbl_citySetLabelValue  = 0;     // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
                myTextCity = [NSString stringWithFormat:@" %@\n %@\n %@", fldCity, fldProv, fldCountry ]; // edit current row
  NSLog(@"citych #12  %-24s =[%@] $$$  cellforr $$$$$$$$$$$$$$$$$$$$", "myTextCity " , myTextCity );

                gbl_userSpecifiedCity = fldCity;
                gbl_userSpecifiedProv = fldProv;
                gbl_userSpecifiedCoun = fldCountry;
            } else {
                myTextCity = [NSString stringWithFormat:@" %@\n %@\n %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
  NSLog(@"citych #11  %-24s =[%@] $$$  cellforr $$$$$$$$$$$$$$$$$$$$", "myTextCity " , myTextCity );

                gbl_userSpecifiedCity = gbl_enteredCity;
  NSLog(@"citych #10  %-24s =[%@] $$$  cellforr $$$$$$$$$$$$$$$$$$$$", "gbl_userSpecifiedCity " , gbl_userSpecifiedCity );
                gbl_userSpecifiedProv = gbl_enteredProv;
                gbl_userSpecifiedCoun = gbl_enteredCoun;
            }
  NSLog(@"gbl_userSpecifiedCity =[%@]",gbl_userSpecifiedCity );
  NSLog(@"gbl_userSpecifiedProv =[%@]",gbl_userSpecifiedProv );
  NSLog(@"gbl_userSpecifiedCoun =[%@]",gbl_userSpecifiedCoun );
tn();

//            myTextCity = [NSString stringWithFormat:@" %@\n %@\n %@", fldCity, fldProv, fldCountry ]; // edit current row

        } // end of ([gbl_homeEditingState isEqualToString: @"view or change" ] )


        else {  // is "add"
            myTextCity = [NSString stringWithFormat:@" %@\n %@\n %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
  NSLog(@"citych #09  %-24s =[%@] $$$  cellforr $$$$$$$$$$$$$$$$$$$$", "myTextCity " , myTextCity );
        }

  NSLog(@"myTextCity =[%@]",myTextCity );

//        UIColor *borderColor =  [UIColor lightGrayColor];  // too dark
        UIColor *borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];

        gbl_mycityprovcounLabel.layer.borderColor  = borderColor.CGColor;
        gbl_mycityprovcounLabel.layer.borderWidth  = 1.0;
        gbl_mycityprovcounLabel.layer.cornerRadius = 5.0;
//        gbl_mycityprovcounLabel .clipsToBounds = YES;


        NSString *exceptionalSearchStr = [NSString stringWithFormat:@" %@",
            gbl_initPromptCity  // is  gbl_initPromptCity  (@"Birth City or Town")  with LEADING SPACE  with LEADING SPACE
        ];



            gbl_mycityprovcounLabel.text             = myTextCity;    // ONLY place where  gbl_mycityprovcounLabel  is set
  NSLog(@"citych #08  %-24s =[%@] $$$  cellForRow  $$$$$$$$$$$$$$$$$$$$", "gbl_mycityprovcounLabel" , gbl_mycityprovcounLabel.text);

//  NSLog(@"[gbl_mycityprovcounLabel.text =[%@]",gbl_mycityprovcounLabel.text );
//  NSLog(@"gbl_initPromptCity =[%@]",gbl_initPromptCity );
//            if ([gbl_mycityprovcounLabel.text hasPrefix: gbl_initPromptCity ] )  // is  @"Birth City or Town"
            if ([gbl_mycityprovcounLabel.text hasPrefix: exceptionalSearchStr ] )
            {
                gbl_mycityprovcounLabel.textColor    = [UIColor grayColor];
//                gbl_mycityprovcounLabel.textColor    = gbl_colorPlaceHolderPrompt; // gray   too dark
            } else {
                gbl_mycityprovcounLabel.textColor    = [UIColor blackColor];
            }
            gbl_mycityprovcounLabel.numberOfLines    = 0;
            gbl_mycityprovcounLabel.tag              = 2;
            gbl_mycityprovcounLabel.font             = myFontSmaller2;
//            gbl_mybirthinformation.font                    = myFontSmaller14;
//
            gbl_mycityprovcounLabel.textAlignment    = NSTextAlignmentLeft;

//            gbl_mycityprovcounLabel.borderStyle              = UITextBorderStyleRoundedRect;
//           gbl_mycityprovcounLabel.borderStyle              = UITextBorderStyleLine;
//
//            gbl_mycityprovcounLabel.backgroundColor  = gbl_colorEditingBG;
//            gbl_mycityprovcounLabel.backgroundColor  = [UIColor whiteColor];
            gbl_mycityprovcounLabel.backgroundColor  =  gbl_colorEditingBGforInputField;

            // If you want the clear button to be always visible,
            // then you need to set the text field's clearButtonMode property to UITextFieldViewModeAlways. 
//            gbl_mycityprovcounLabel.clearButtonMode  = UITextFieldViewModeAlways;
//           gbl_mycitySearchString.clearButtonMode  = UITextFieldViewModeAlways;


  NSLog(@"dispatch_async for CITY !");
  NSLog(@"gbl_mycitySearchString.inputView =[%@]",gbl_mycitySearchString.inputView );

  NSLog(@"gbl_mycityInputView              =[%@]",gbl_mycityInputView );
  NSLog(@"gbl_mycitySearchString.inputView =[%@]",gbl_mycitySearchString.inputView );
  NSLog(@"gbl_keyboardIsShowing            =[%ld]",(long)gbl_keyboardIsShowing );
  NSLog(@"gbl_lastSelectedCityPickerRownum =[%ld]",(long)gbl_lastSelectedCityPickerRownum );
  NSLog(@"gbl_mycitySearchString.inputAccessoryView.description =[%@]",  gbl_mycitySearchString.inputAccessoryView.description);


    [self disp_gblsWithLabel: @"JUST before city cell addsubview" ];

//
//            // reminder: here user has tapped city field 
//            //
//            // if gbl_mycityInputView = "picker" AND current inputView is KB, make inputview picker
//            //
//nbn(0);
//            if (   [gbl_mycityInputView isEqualToString: @"picker" ] 
//                && gbl_keyboardIsShowing == 1                        )
//            {
//nbn(1);
//                [self putUpCityPicklist ];                                         // TODO putUpCityPicklist only called twice
//nbn(2);
//
//                // set city picker to show correct row selected
//                [self.pickerViewCity selectRow: gbl_lastSelectedCityPickerRownum  inComponent: 0 animated: YES]; // mth  = jan
//nbn(3);
//
////                // populates gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun
////                [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, Prov, Coun
////                [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath
//
////    [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do no show old data
//
//            }
//
//


//                [self putUpCityPicklist ];           // TODO putUpCityPicklist only called twice
//                [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, Prov, Coun
//                [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath
//                [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do not show old data
//                [self.pickerViewCity selectRow: gbl_lastSelectedCityPickerRownum   inComponent: 0 animated: YES];



        dispatch_async(dispatch_get_main_queue(), ^{         

            cell.userInteractionEnabled         = YES;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
//            cell.contentView.backgroundColor    = currentBGfieldColor;

            [cell addSubview: gbl_mycityprovcounLabel ];

        });





  NSLog(@"gbl_mycitySearchString.inputView2 =[%@]",gbl_mycitySearchString.inputView );


     } // row = 3   "LABEL" for  city,proc,coun  of Birth of Person






     if (indexPath.row == 4) {   //  filler 
        dispatch_async(dispatch_get_main_queue(), ^{        
            cell.userInteractionEnabled         = NO;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
        });
     }





     if (indexPath.row == 5)     // "LABEl" for  time of birth information
     {
  NSLog(@"date row                            DRAWING        CELL  having LABEl for  DATE/time of birth ");
  NSLog(@"                                    gbl_lastInputFieldTapped=[%@]",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse9        =[%@]",gbl_pickerToUse );
  NSLog(@"gbl_kindOfSave                                              =[%@]",gbl_kindOfSave);

        // OVErrIDE displayed date info  here, if gbl_kindOfSave   is  "no look no change save"
        //    put "Saved with no look no change"
        //
        if ([gbl_kindOfSave isEqualToString: @"no look no change save" ] )
        {


    //            gbl_mybirthinformation.clearButtonMode          = UITextFieldViewModeWhileEditing ;
    //            gbl_mybirthinformation.clearButtonMode          = UITextFieldViewModeAlways ;
    //            gbl_mybirthinformation.keyboardType             = UIKeyboardTypeNamePhonePad; // for entering a person's name or phone number
    //            gbl_mybirthinformation.backgroundColor          = gbl_colorEditing;
    //            gbl_mybirthinformation.backgroundColor          = [UIColor yellowColor];
                  gbl_mybirthinformation.backgroundColor = gbl_colorEditingBGforInputField;

    //            gbl_mybirthinformation.font                     = myFont;
//                gbl_mybirthinformation.font                     = myFontMiddle;
//                gbl_mybirthinformation.font                    = myFontSmaller14;
//            gbl_mycityprovcounLabel.font             = myFontSmaller2;
//             gbl_mybirthinformation.font             = myFontSmaller3;   // for no look, ...
//             gbl_mybirthinformation.font             = myFontSmaller4;   // for no look, ...
             gbl_mybirthinformation.font             = myFontSmaller2;   // for no look, ...

             gbl_mybirthinformation.borderStyle              = UITextBorderStyleRoundedRect;
//            gbl_mybirthinformation.borderStyle              = UITextBorderStyleLine;


                gbl_mybirthinformation.textAlignment            = NSTextAlignmentLeft;
//                gbl_mybirthinformation.text                     = @" Saved with No Look, No Change";
//                gbl_mybirthinformation.text                     = @" Saved with Hide Birth Information";
//                gbl_mybirthinformation.text                     = @" Hide Birth Information Save";
//                gbl_mybirthinformation.text                     = @" Saved with Hide Birth Information";
                gbl_mybirthinformation.text                     = @" Personal Privacy";

//                gbl_mybirthinformation.textColor                = [UIColor greenColor]; // is @"Birth Date and Time" 
                gbl_mybirthinformation.textColor                = [UIColor lightGrayColor]; // is @"Birth Date and Time" 
                gbl_mybirthinformation.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //            gbl_mybirthinformation.tag                      = 6;
                gbl_mybirthinformation.tag                      = 3;
                gbl_mybirthinformation.autocapitalizationType   = UITextAutocapitalizationTypeNone;

                gbl_mybirthinformation.autocorrectionType       = UITextAutocorrectionTypeNo;


            dispatch_async(dispatch_get_main_queue(), ^{        

    //            cell.textLabel.backgroundColor           = gbl_colorEditing;
                cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
//                cell.userInteractionEnabled         = YES;
                cell.userInteractionEnabled         = NO;
                cell.selectionStyle                 = UITableViewCellSelectionStyleNone;

                [cell addSubview: gbl_mybirthinformation ];
            });

            return cell;
        }


        // right here,  determine if last field tapped is gbl_mybirthinformation field, if so become firstResponder to putup date picker
        // 
        if ([gbl_lastInputFieldTapped isEqualToString: @"date"]) {

tn();trn("DATE field was drawn  hey   hey   hey   hey   hey   hey   hey   ");
            //
            // All UIResponder objects have an inputView property.
            // The inputView of a UIResponder is the view that will be shown in place of the keyboard
            // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
            //
  NSLog(@"= 03 =====  BECOME first responder = gbl_mybirthinformation ");
            [gbl_mybirthinformation becomeFirstResponder]; 
  NSLog(@"-didsel5--- VASSIGN gbl_mybirthinformation BECOME_FIRST_RESPONDER ---------------- " );
        }

        NSString *myBirthTimeInformation;
        myBirthTimeInformation = gbl_initPromptDate ;  // is @"Birth Date and Time" 


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




            gbl_mybirthinformation.autocorrectionType       = UITextAutocorrectionTypeNo;
//            gbl_mybirthinformation.clearButtonMode          = UITextFieldViewModeWhileEditing ;
//            gbl_mybirthinformation.clearButtonMode          = UITextFieldViewModeAlways ;
//            gbl_mybirthinformation.keyboardType             = UIKeyboardTypeNamePhonePad; // for entering a person's name or phone number
//            gbl_mybirthinformation.backgroundColor          = gbl_colorEditing;
//            gbl_mybirthinformation.backgroundColor          = [UIColor yellowColor];
              gbl_mybirthinformation.backgroundColor = gbl_colorEditingBGforInputField;

//            gbl_mybirthinformation.font                     = myFont;
//            gbl_mybirthinformation.font                     = myFontMiddle;
//            gbl_mybirthinformation.font                    = myFontSmaller14;
            gbl_mybirthinformation.font                     = myFontSmaller2;
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




        dispatch_async(dispatch_get_main_queue(), ^{        

//            cell.textLabel.backgroundColor           = gbl_colorEditing;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
            cell.userInteractionEnabled         = YES;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;

            [cell addSubview: gbl_mybirthinformation ];
        });

        // reload  cell having display of birth info selected so far 
        //
        NSIndexPath *indexPathBirthInfoLabel = [NSIndexPath indexPathForRow: 5 inSection: 0];

        // update display of selected date
        //
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:  @[ indexPathBirthInfoLabel ]
                              withRowAnimation: UITableViewRowAnimationFade ];
//                                  withRowAnimation: UITableViewRowAnimationRight ];
        [self.tableView endUpdates];

     } // (indexPath.row == 5)     BIRTH INFORMATION   // "LABEl" for  time of birth information





     if (indexPath.row == 2) {   // data entry for  City of Birth of Person  THIS is HIDDEN and stuck in rownum=2 for scrollRectToVisible use
  NSLog(@"data entry for  City of Birth of Person!");

        dispatch_async(dispatch_get_main_queue(), ^{

            gbl_mycitySearchString.delegate = self;

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


//            cell.textLabel.backgroundColor           = gbl_colorEditing;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
//            cell.userInteractionEnabled         = YES;
            cell.userInteractionEnabled         = NO;
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


            [cell addSubview: gbl_mycitySearchString ];

// out        gbl_mycitySearchLabel.text = @"Search";
//            gbl_mycitySearchLabel.font = myFontSmaller2;
//            [cell addSubview: gbl_mycitySearchLabel ];
//

        });

//  NSLog(@"cell.textLabel.text =%@",cell.textLabel.text );
//  NSLog(@"cell.textLabel.attributedText =%@",cell.textLabel.attributedText );

     } //  CITY SEARCH string



//   textfield properties
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
      // 20160417   2 new rows on bottom
      // rows are (index-usage)  0-spacer, 1-name, 2-spacer, 3-city, 4-spacer, 5-date, 6-spacer, 7-group memberships
      // 

     if (indexPath.row == 6) {   //  filler 
  NSLog(@"in cellforrow  row=6");
        dispatch_async(dispatch_get_main_queue(), ^{        
            cell.userInteractionEnabled         = NO;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
            cell.selectionStyle                 = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
        });
     }


     if (indexPath.row == 7) {   //  multi-line label  listing groups the person belongs to

  NSLog(@"in cellforrow  row=7");

//            gbl_whatMemberships.delegate   = self;

            // only show memberships in edit mode
            //
            NSString *myLabelText;
            NSMutableString *myMemberships = [[NSMutableString alloc] init];

            if (   [gbl_homeEditingState  isEqualToString: @"add" ])   {
                myLabelText  = @"";
            } else {
//                myLabelText  = @"mxxWWWWWiiiiiWWWlll cc is a member of these groups:  #allpeople, oijsdf, wewlwekjrl;, ciejjie, sodkfjok, #allpeople2, oijsdf, wewlwekjrl;, ciejjie, sodkfjok, #allpeople3, oijsdf, wewlwekjrl;, ciejjie, sodkfjok, #allpeople4, oijsdf, wewlwekjrl;, ciejjie, sodkfjok, #allpeople5, oijsdf, wewlwekjrl;, ciejjie, sodkfjok";
//                myLabelText  = @"mxxWWWWWiiiiiWWWlll cc is a member of these groups:  #allpeople, oijsdf, wewlwekjrl";

//                myMemberships = @"#allpeople";
                [myMemberships appendString: @"#allpeople" ];
                for (NSString *myMemberRec in gbl_arrayMem) {

                    NSArray *psvArray;
                    NSString *currGroup;
                    NSString *currMember;
                    
                    psvArray = [myMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
                    currGroup  = psvArray[0];
                    currMember = psvArray[1];

                    if ([currMember isEqualToString: gbl_lastSelectedPerson ] )
                    {
                        // append ", " membername 
                        [myMemberships appendString: @", " ];
                        [myMemberships appendString: currGroup ];
                    }
                } // for each groupmember


                myLabelText = [NSString stringWithFormat:     // gbl_lastSelectedPerson gbl_fromHomeCurrentEntityName
                    @"%@ is a member of these groups: %@",
                    gbl_lastSelectedPerson,
                    myMemberships
                ];

            }



        //            CGFloat myScreenWidth, myFontSize;  // determine font size
        //            myScreenWidth = self.view.bounds.size.width;
        //            if (        myScreenWidth >= 414.0)  { myFontSize = 16.0; }  // 6+ and 6s+  and bigger
        //            else if (   myScreenWidth  < 414.0   
        //                     && myScreenWidth  > 320.0)  { myFontSize = 16.0; }  // 6 and 6s
        //            else if (   myScreenWidth <= 320.0)  { myFontSize = 10.0; }  //  5s and 5 and 4s and smaller
        //            else                                 { myFontSize = 16.0; }  //  other ?
        //
        // CGFloat   gbl_heightForScreen;  // 6+  = 736.0 x 414  and 6s+  (self.view.bounds.size.width) and height
        //                                 // 6s  = 667.0 x 375  and 6
        //                                 // 5s  = 568.0 x 320  and 5 
        //                                 // 4s  = 480.0 x 320  and 5 
        //
//  NSLog(@"self.view.bounds.size.height  =[%f]",self.view.bounds.size.height  );

            UILabel *myLabel;
            CGFloat myLabelWidth;
            CGFloat myLabelHeight;
            UIFont *myLabelFont;

            myLabelFont   = [UIFont fontWithName:@"Menlo" size: 10.0];   // initialize to get rid of warning
            myLabelWidth  = 240.0f;                                      // initialize to get rid of warning
            myLabelHeight =  50.0f;                                      // initialize to get rid of warning

            if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
            ) {
                myLabelFont   = [UIFont fontWithName:@"Menlo" size: 12.0];
                myLabelWidth  = 320.0f;
                myLabelHeight =  90.0f;
            }
            else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                     && self.view.bounds.size.width  > 320.0
            ) {
                myLabelFont   = [UIFont fontWithName:@"Menlo" size: 11.0];
                myLabelWidth  = 290.0f;
                myLabelHeight =  70.0f;
            }
            else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
            ) {
                myLabelFont   = [UIFont fontWithName:@"Menlo" size: 10.0];
                myLabelWidth  = 260.0f;
                myLabelHeight =  65.0f;
            }
            else if (   self.view.bounds.size.width <= 320.0   // ??
            ) {
                myLabelFont   = [UIFont fontWithName:@"Menlo" size: 10.0];
                myLabelWidth  = 240.0f;
                myLabelHeight =  50.0f;
            }
            myLabel      = [[UILabel alloc] initWithFrame:CGRectMake( 1.0f, 1.0f, myLabelWidth, myLabelHeight )]; 
            myLabel.font = myLabelFont;



            // fragile magic - do not change anything
            //
            dispatch_async(dispatch_get_main_queue(), ^{  

                myLabel.text            = myLabelText;             
                myLabel.lineBreakMode   = NSLineBreakByWordWrapping;  
                myLabel.numberOfLines   = 0;                          // set number of lines to zero
                myLabel.backgroundColor = gbl_colorEditingBG_current;
                myLabel.textColor = [UIColor darkGrayColor ];
//                myLabel.backgroundColor = [UIColor cyanColor ];
                [myLabel sizeToFit];                                 // resize label - can make label vertically long, so scrolls


                UIScrollView *myScroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(32.0f, 8.0f, myLabelWidth, myLabelHeight )]; 


                myScroll.contentSize   =
                    CGSizeMake(myScroll.contentSize.width, myLabel.frame.size.height );           // set scroll view size

                myScroll.backgroundColor = gbl_colorEditingBG_current;

                [myScroll addSubview: myLabel];            // add myLabel to myScroll view

                [cell.contentView addSubview: myScroll ];  // add scroll view to main view
//                [cell addSubview: myScroll ];            // add scroll view to main view

                cell.userInteractionEnabled         = YES;
                cell.contentView.backgroundColor    = gbl_colorEditingBG_current;
//                cell.backgroundColor    = [UIColor greenColor] ;
            });

  NSLog(@"END of   cellforrow  row=7");

    }   //  multi-line label  listing groups the person belongs to



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
   
//   if (indexPath.row == 0) return  8;  // fill
   if (indexPath.row == 0) return 16;  // fill

//   if (indexPath.row == 1) return 40;  // name 
   if (indexPath.row == 1) return 50;  // name 

   if (indexPath.row == 2) return 16;  // fill

//   if (indexPath.row == 3) return 60;  // "LABEL" for  city,proc,coun  of Birth of Person
   if (indexPath.row == 3) return 80;  // "LABEL" for  city,proc,coun  of Birth of Person
   if (indexPath.row == 4) return  8;  // fill

//   if (indexPath.row == 5) return 40;  // "LABEl" for  time of birth information
   if (indexPath.row == 5) return 50;  // "LABEl" for  time of birth information

   // if (indexPath.row == 6) return 40;  // city seach field   ?
   //    note that row with index 2 has hidden field for city search string

   if (indexPath.row == 6) return 20;  // fill

//   if (indexPath.row == 7) return 40;  // label to list group memberships
//   if (indexPath.row == 7) return 60;  // label to list group memberships
   if (indexPath.row == 7) return 90;  // label to list group memberships

    return 32.0;

}  // ---------------------------------------------------------------------------------------------------------------------



// willSelectRowAtIndexPath message is sent to the UITableView Delegate
// after the user lifts their finger from a touch of a particular row
// and before didSelectRowAtIndexPath.
//
// willSelectRowAtIndexPath allows you to either confirm that the particular row can be selected,
// by returning the indexPath, or select a different row by providing an alternate indexPath.
//
//  Return nil if you do not want the row selected.
//
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath: (NSIndexPath*)indexPath {
tn();  
    NSLog(@"willSelectRowAtIndexPath! in  add/change");
    

    if (indexPath.row == 7) {
//  NSLog(@" // gbl_whatMemberships gets no highlight");
        return nil;  // gbl_whatMemberships gets no highlight
    }


    // DISALLOW  SELECTION  in high security case (city and date when person was saved with no look no change)
    //
    //     if (indexPath.row == 3)     // "LABEL" for  city,proc,coun  of Birth of Person
    //         gbl_mycityprovcounLabel.tag         = 2;
    //
    //     if (indexPath.row == 5)     // "LABEl" for  time of birth information
    //         gbl_mybirthinformation.tag          = 3;
    //
    UITableViewCell *myCell = [self.tableView  cellForRowAtIndexPath: indexPath];
    NSInteger myTag         = myCell.tag;
  NSLog(@"myTag         =[%ld]",(long)myTag         );
  NSLog(@"indexPath.row =[%ld]",(long)indexPath.row );

    if (   [gbl_kindOfSave isEqualToString:  @"no look no change save" ]
        && (
            indexPath.row == 3   ||   indexPath.row == 5
        )
    ) {
        return nil;
    }
    
    return(indexPath);  // allow selection by default

} // willSelectRowAtIndexPath




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
tn();    NSLog(@"in didSelectRowAtIndexPath!  in AddChange !!");
NSLog(@"indexPath.row =%ld",(long)indexPath.row );
    
//    if (indexPath.row == 7 ) {  // gbl_whatMemberships
//  NSLog(@"row = 7 return");
//        return;
//    }

  NSLog(@"gbl_currentMenuPlusReportCode=%@", gbl_currentMenuPlusReportCode);

    if (indexPath.row == 3 ) {  // LABEL for city,coun,prov    CITY  CITY  CITY  CITY  CITY  CITY  CITY  CITY CITY  CITY

        // put APPROPRIATE  inputview   KEYBOARD   or   CITY PICKER
        //
trn("kdkdkdkkk selected row 3 =city/prov/coun   kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");


        if ( [ gbl_mycityInputView  isEqualToString: @"picker" ] )
        {   // show city picker
  NSLog(@"removed resign/become for city   try to get old inputview (picker)");

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
  NSLog(@"= 04 =====  BECOME first responder = gbl_mycitySearchString ");
                [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldBeginEditing > textFieldDidBeginEditing > back here

  NSLog(@"-didsel3a-- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );

                // note above puts up keyboard


  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];

                gbl_mycitySearchString.inputView = [self pickerViewCity] ;   // this is only place is set to pickerViewCity
  NSLog(@"-didsel 1-- VASSIGN gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);

                [self putUpCityPicklist ];           // TODO putUpCityPicklist only called twice

                // populates gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun
//                [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, Prov, Coun

                [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath



                [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do not show old data


//                [self.pickerViewCity selectRow: 0   inComponent: 0 animated: YES];
                [self.pickerViewCity selectRow: gbl_lastSelectedCityPickerRownum   inComponent: 0 animated: YES];


            });

//            [self putUpCancelButtonOrNot  ];

  NSLog(@"UP  22   UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP  UP   ");

        } else {  // show city KB
            // show city KB



  NSLog(@"--- ooo -------- show city keyboard  --------------------------");
  NSLog(@"            gbl_myname.isFirstResponder=%d",gbl_myname.isFirstResponder);
  NSLog(@"gbl_mycitySearchString.isFirstResponder=%d",gbl_mycitySearchString.isFirstResponder);
  NSLog(@"gbl_mybirthinformation.isFirstResponder=%d",gbl_mybirthinformation.isFirstResponder);
  NSLog(@"gbl_fieldTap_leaving  =%@",gbl_fieldTap_leaving );
  NSLog(@"gbl_fieldTap_goingto  =%@",gbl_fieldTap_goingto );
  NSLog(@"gbl_firstResponder_previous  =%@",gbl_firstResponder_previous );
  NSLog(@"gbl_firstResponder_current   =%@",gbl_firstResponder_current  );
  NSLog(@"----------------- show city keyboard --------------------------");

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




//                self.pickerViewCity.hidden       =  NO;
                self.pickerViewCity.hidden       =  YES;





  NSLog(@"gbl_mycityInputView =[%@]",gbl_mycityInputView );

  gbltmpstr = [gbl_mycitySearchString.inputAccessoryView.description substringToIndex: 15];

                [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"

  NSLog(@"gbl_mycitySearchString.inputAccessoryView.description --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputAccessoryView.description substringToIndex: 15]);

                //
                // All UIResponder objects have an inputView property.
                // The inputView of a UIResponder is the view that will be shown in place of the keyboard
                // WHEN THE RESPONDER BECOMES THE FIRST RESPONDER.
                //
     //  ?? switch  becomefirst  and inputview=  ???
tn();
  NSLog(@"gbl_mycitySearchString   GOING TO       city    BECOME_FIRST_RESPONDER ---------------- " );
  NSLog(@"= 05 =====  BECOME first responder = gbl_mycitySearchString ");
                [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldBeginEditing > textFieldDidBeginEditing > back here
  NSLog(@"gbl_mycitySearchString   RETURNING FROM city    BECOME_FIRST_RESPONDER ---------------- " );
tn();

//                gbl_mycitySearchString.inputView = [self pickerViewCity] ; 



                // if city name char-typing is ongoing set title to  gbl_myCitySoFar
                //
//                if (gbl_myCitySoFar != nil  &&  gbl_myCitySoFar.length > 0) gbl_searchStringTitle.title = gbl_myCitySoFar;
//                else                                                        gbl_searchStringTitle.title = @"Type City Name";

//  NSLog(@"fldCity   = [%@]",fldCity);

                if (gbl_myCitySoFar != nil  &&  gbl_myCitySoFar.length > 0) {
  NSLog(@"SET gbl_myCitySoFar #52 with setCitySearchStringTitleTo" );
                    [self setCitySearchStringTitleTo: gbl_myCitySoFar ];
                } else {
  NSLog(@"SET gbl_myCitySoFar #53 with setCitySearchStringTitleTo" );
                    [self setCitySearchStringTitleTo: @"Type City Name" ];
                }

//[self setCitySearchStringTitleTo: fldCity ];
            });
        } // show kb

  NSLog(@"end of didSelectRowAtIndexPath   for row = 3");
tn();
    } // row == 3

} // didSelectRowAtIndexPath


//tableView: editingStyleForRowAtIndexPath
//tableView: commitEditingStyle: forRowAtIndexPath

//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//

/*
// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//}
*/

/*
// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
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
//    SOMETIMES  unhides inputview toolbar  right button "Wheel >" (gbl_titleForWheelButton)
//
- (void) showCityProvCountryForTypedInCity: (NSString *) arg_citySoFar     // either first one in 3 labels or picklist uitable
{
   
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
  NSLog(@"    ( for determining whether or  not to show   Right Button  \"Wheel >\"  )");  // (gbl_titleForWheelButton)
    idx_into_placetab = bin_find_first_city(  // **********  ==========   GET CITY,prov,coun
        arg_cityBeginsWith,
        gbl_numCitiesToTriggerPicklist,  // is type  int
        &num_PSVs_found,                 // is type  int  (0-based index to last string)
        city_prov_coun_PSVs              // array of chars holding fixed length "strings"
    );
kin(idx_into_placetab);
kin(num_PSVs_found);
tn();

    if (       idx_into_placetab == -1) {  // city not found beginning with string  arg_citySoFar  

        gbl_CITY_NOT_FOUND = 1;
        return;

    } else if (idx_into_placetab == -2) {  // -2  IF there are few enough cities to make a picklist
//    } else if (idx_into_placetab == -2  && num_PSVs_found > 1) {  // -2  IF there are few enough cities to make a picklist

//
//        // if num_PSVs_found is exactly one, do NOT offer a picklist for it
//        //
//        if (num_PSVs_found == 1) gbl_fewEnoughCitiesToMakePicklist = 0;
//        else                     gbl_fewEnoughCitiesToMakePicklist = 1;
//
        gbl_fewEnoughCitiesToMakePicklist = 1;


        gbl_pickerToUse                   = @"city picker";
  NSLog(@"gbl_pickerToUse  44      =[%@]",gbl_pickerToUse          );

  NSLog(@"  5  SHOW   Right Button  \"Wheel >\"  )");

//        gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityKeyboardHavingPicklist;
//        [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"

        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here

//    gbl_mycitySearchString.inputAccessoryView = nil;  // necessary  ?
//    gbl_mycitySearchString.inputView          = nil ; // necessary  ?
//    gbl_mycitySearchString.inputAccessoryView = nil;  // necessary  ?



  NSLog(@"gbl_mycityInputView =[%@]",gbl_mycityInputView );
        [self setCityInputAccessoryViewFor: gbl_mycityInputView ];  // arg is "keyboard" or "picker"
  NSLog(@"gbl_mycityInputView =[%@]",gbl_mycityInputView );


  NSLog(@"= 06 =====  BECOME first responder = gbl_mycitySearchString ");
        [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here


//        gbl_searchStringTitle.title = gbl_myCitySoFar;           //  update title of keyboard "toolbar"
  NSLog(@"SET gbl_myCitySoFar #54 with setCitySearchStringTitleTo" );
          [self setCitySearchStringTitleTo: gbl_myCitySoFar ];

//        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
//        [gbl_mycitySearchString becomeFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here

        // update city label field  update field in cellForRowAtIndexpath
        //
        [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath

// ?      gbl_searchStringTitle.title = gbl_myCitySoFar;           //  update title of keyboard "toolbar"
  NSLog(@"SET gbl_myCitySoFar #55 with setCitySearchStringTitleTo" );
        [self setCitySearchStringTitleTo: gbl_myCitySoFar ];



    } // else { // show latest city,prov,coun  beginning with city chars typed so far
//    }


    int idx_of_first_city_found;
    if (idx_into_placetab == -2 ) {


        // USE bin_find_first_city1    here   (NOTE the 1)
        //
        //
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
  NSLog(@"citych #07  %-24s =[%@] $$$  showCityProvCountryForTypedInCity  $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity " ,gbl_enteredCity  );
    gbl_DisplayCity = myLatestCity ;
  NSLog(@"citych #06  %-24s =[%@] $$$ showCityProvCountryForTypedInCity  $$$$$$$$$$$$$$$$$$$$", "gbl_DisplayCity" , gbl_DisplayCity );

    char myProvName [64];
    strcpy(myProvName, array_prov[gbl_placetab[idx_of_first_city_found].idx_prov]); 
    NSString *myLatestProv =  [NSString stringWithUTF8String: myProvName];  // convert c string to NSString
    gbl_enteredProv = myLatestProv ;
    gbl_DisplayProv = myLatestProv ;

    char myCounName [64];
    strcpy(myCounName, array_coun[gbl_placetab[idx_of_first_city_found].idx_coun]); 
    NSString *myLatestCoun =  [NSString stringWithUTF8String: myCounName];  // convert c string to NSString
    gbl_enteredCoun = myLatestCoun ;


    [self showHide_ButtonToSeePicklist ];
    gbl_DisplayCoun = myLatestCoun ;


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

- (void)viewWillDisappear:(BOOL)animated
{
     NSLog(@"in viewWillDisappear in  addChange   ! !");

    [super viewWillDisappear:animated];

    gbl_justPressedChangeGroupName = 0;  // reset to default


tn();trn("--qx--- in ADD/CHANGE viewWillDisappear  TOP ==================================================================");
  NSLog(@"gbl_myname.text        =[%@]",gbl_myname.text);
  NSLog(@"gbl_mycityprovcounLabel=[%@]",gbl_mycityprovcounLabel.text);
  NSLog(@"gbl_mybirthinformatione=[%@]",gbl_mybirthinformation.text);
  NSLog(@"gbl_userSpecifiedPersonName  =[%@]",gbl_userSpecifiedPersonName  );
  NSLog(@"gbl_userSpecifiedCity        =[%@]",gbl_userSpecifiedCity        );
  NSLog(@"gbl_userSpecifiedProv        =[%@]",gbl_userSpecifiedProv        );
  NSLog(@"gbl_userSpecifiedCoun        =[%@]",gbl_userSpecifiedCoun        );
  NSLog(@"gbl_selectedBirthInfo        =[%@]",gbl_selectedBirthInfo        );
  NSLog(@"gbl_DisplayName              =[%@]",gbl_DisplayName );
  NSLog(@"gbl_DisplayDate              =[%@]",gbl_DisplayDate );
  NSLog(@"gbl_DisplayCity              =[%@]",gbl_DisplayCity );
  NSLog(@"gbl_DisplayProv              =[%@]",gbl_DisplayProv );
  NSLog(@"gbl_DisplayCoun              =[%@]",gbl_DisplayCoun );
  NSLog(@"gbl_enteredCity              =[%@]",gbl_enteredCity );
  NSLog(@"gbl_enteredProv              =[%@]",gbl_enteredProv );
  NSLog(@"gbl_enteredCoun              =[%@]",gbl_enteredCoun );
trn("-------------------------------------------");
  NSLog(@"gbl_fromHomeCurrentSelectionPSV    = [%@]",gbl_fromHomeCurrentSelectionPSV);
  NSLog(@"gbl_justEnteredAddChangeView       = [%ld]",(long)gbl_justEnteredAddChangeView);
  NSLog(@"gbl_myCitySoFar                    = [%@]",gbl_myCitySoFar );
  NSLog(@"gbl_lastSelectedGroup              = [%@]",gbl_lastSelectedGroup);
  NSLog(@"gbl_lastSelectedPerson             = [%@]",gbl_lastSelectedPerson);
  NSLog(@"gbl_lastSelectedPersonBeforeChange = [%@]",gbl_lastSelectedPersonBeforeChange);
  NSLog(@"gbl_lastSelectedGroupBeforeChange  = [%@]",gbl_lastSelectedGroupBeforeChange);
  NSLog(@"gbl_rollerBirthInfo                = [%@]",gbl_rollerBirthInfo);
trn("-------------------------------------------"); tn();



    // self.isBeingDismissed   and   self.isMovingFromParentViewController
    // These methods returns YES only when called from inside the viewWillDisappear: and viewDidDisappear: methods.
    //
    if (self.isBeingDismissed || self.isMovingFromParentViewController) {

        // Handle the case of being dismissed or popped.
        //
        [[NSNotificationCenter defaultCenter] removeObserver: self
                                                        name: UIMenuControllerWillShowMenuNotification   // <<<====----
  //                                                  object: nil
                                                      object: gbl_myname
        ];

        [[NSNotificationCenter defaultCenter] removeObserver: self
                                                        name: UIApplicationDidBecomeActiveNotification
                                                      object: nil
        ];
    }



    // cleanup when leaving add/change screen
    // 
//    gbl_fieldTap_leaving       = nil;
//    gbl_fieldTap_goingto       = nil;
    gbl_firstResponder_current = nil;
//    gbl_mycityInputView        = @"keyboard";
//tn();trn("hide picker hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//        self.pickerViewCity.hidden         = YES;



//        gbl_mycityInputView                = @"keyboard";  


        gbl_mycitySearchString.inputView   = nil ;          // this has to be here to put up keyboard
        gbl_fewEnoughCitiesToMakePicklist  = 0;

//    gbl_citySetPickerValue = 1;   // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow




// did not work  - no kb comes up
//        // I'm using a UIPickerView as the inputView for a TextField (thus replacing the onscreen keyboard).
//        // I use the following delegate to dismiss the view.
//        //
//        //  - (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//        //      // Code logic
//        //      [[self view] endEditing:YES];
//        //  }
//        //
////        [[self view] endEditing:YES];
//tn();
//trn("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
//trn("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
//        [gbl_mycitySearchString endEditing: YES ];
//tn();
//


//    segEntityOutlet.backgroundColor = [UIColor whiteColor];

// now doing this when field changes
//  NSLog(@"INVALIDATING  timerToCheckCityPicklistTrigger");
//    [ gbl_timerToCheckCityPicklistTrigger invalidate ];



    [self disp_gblsWithLabel: @"end of ViewWillDisAppear" ];

} // viewWillDisappear





- (void) setCitySearchStringTitleTo: (NSString *) arg_toolbar_title 
{
tn(); NSLog(@"=in setCitySearchStringTitleTo");
  NSLog(@"arg_toolbar_title VNEW CitySearchStringTitleTo =[%@]",arg_toolbar_title  );

    if ( [ gbl_mycityInputView isEqualToString: @"picker" ] ) {  // (gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityPicklist;)

        gbl_title_cityPicklist.title = arg_toolbar_title;
  NSLog(@"citych #05  %-24s =[%@] $$$ setCitySearchStringTitleTo $$$$$$$$$$$$$$$$$$$$", "gbl_title_cityKeyboard" , gbl_title_cityKeyboard.title);

    }

    if ( [ gbl_mycityInputView isEqualToString: @"keyboard" ] ) {
        
//        if ( gbl_fewEnoughCitiesToMakePicklist == 1 ) {
//            gbl_title_cityKeyboardHavingPicklist.title = arg_toolbar_title;  // (gbl_ToolbarForCityKeyboardHavingPicklist)
//        } else {
//            gbl_title_cityKeyboardWithNoPicklist.title = arg_toolbar_title;  // (gbl_ToolbarForCityKeyboardWithNoPicklist)
//        }
        gbl_title_cityKeyboard.title = arg_toolbar_title;  // (gbl_ToolbarForCityKeyboardHavingPicklist)
  NSLog(@"citych #04  %-24s =[%@] $$$ setCitySearchStringTitleTo $$$$$$$$$$$$$$$$$$$$", "gbl_title_cityKeyboard" , gbl_title_cityKeyboard.title);
    }

} // setCitySearchStringTitleTo



// SET inputAccessoryView for CITY:     gbl_mycitySearchString.inputAccessoryView
//
////  For Keyboard inputView  "Clear"        tor     "Wheel >"  (hidden or not hidden depends on num cities <= 25)
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
        gbl_mycitySearchString.inputAccessoryView = gbl_ToolbarForCityPicklist;
  NSLog(@"gbl_mycitySearchString.inputAccessoryView 03 SET  picker  SET SET SET SET SET SET SET SET  SET ");

    }  // put up picker city inputView toolbar


    if ( [ arg_toolbarToUse isEqualToString: @"keyboard" ] ) {
        
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

  NSLog(@"-setCityInputAccessoryViewFor -- VASSIGN gbl_mycitySearchString.inputAccessoryView.description --- old=[%@]  new=[%@] ---", gbltmpstr, gbl_mycitySearchString.inputAccessoryView.description  );
//  [ gbl_mycitySearchString.inputAccessoryView.description substringToIndex: 15]

    [self showHide_ButtonToSeePicklist ];   // with gbl_titleForWheelButton

    }  // put up keyboard city inputView toolbar


//    [gbl_mycitySearchString.inputAccessoryView removeConstraints: [gbl_mycitySearchString.inputAccessoryView constraints]];
// B  [gbl_mycitySearchString reloadInputViews];

//    [gbl_mycitySearchString reloadInputViews];

NSLog(@"=OUT   setCityInputAccessoryViewFor ");
tn();
} // setCityInputAccessoryViewFor 



- (void)putUpCityPicklist   
{
tn();  NSLog(@"in putUpCityPicklist !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

  NSLog(@"gbl_mycityInputView=[%@]",gbl_mycityInputView);
  gbltmpstr = gbl_mycityInputView;
    gbl_mycityInputView = @"picker";     // = "keyboard" or "picker"

  NSLog(@"gbltmpstr          =[%@]",gbltmpstr );
  NSLog(@"gbl_mycityInputView=[%@]",gbl_mycityInputView);

  if (! [ gbl_mycityInputView isEqualToString: gbltmpstr ] ) {
    NSLog(@"-putup fn-- VASSIGN gbl_mycityInputView ---------------- old=[%@]  new=[%@] ---", gbltmpstr, gbl_mycityInputView );
  }

//  NSLog(@"gbl_currentCityPicklistIsForTypedSoFar =%@",gbl_currentCityPicklistIsForTypedSoFar );
  NSLog(@"gbl_myCitySoFar                        =%@",gbl_myCitySoFar );
//    if ([ gbl_currentCityPicklistIsForTypedSoFar isEqualToString: gbl_myCitySoFar ] )   return;   // picker up already for this typed so far
//                                                                                                  // like "toron"  or "toro"

//    gbl_currentCityPicklistIsForTypedSoFar = gbl_myCitySoFar;   // picker up already for this typed so far

    gbl_mycitySearchString.text = gbl_myCitySoFar;  // only place gbl_mycitySearchString.text is SET

  NSLog(@"citych #03  %-24s =[%@] $$$ putUpCityPicklist $$$$$$$$$$$$$$$$$$$$", "gbl_mycitySearchString " , gbl_mycitySearchString.text);
  NSLog(@"gbl_mycitySearchString.text=%@",gbl_mycitySearchString.text );


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
  NSLog(@"= 07 =====  BECOME first responder = gbl_mycitySearchString ");
        [gbl_mycitySearchString becomeFirstResponder];  
//        gbl_mycitySearchString.inputView = [self pickerViewCity] ; 

    });  // dispatch_async



    // show FIRST city,prov,coun  in picklist in the label for city/prov/coun
    //



  NSLog(@" !!  changehere! ");
//    [ self getCurrentCityProvCounForRownum: 0 ]; // populates gbl_enteredCity, Prov, Coun
    [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, Prov, Coun




    [ self updateCityProvCoun ];                 // update city/prov/couon field  in cellForRowAtIndexpath

    
    [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do no show old data


    // set city picker to show correct row selected
    //
tn();trn("pppppppp start gbl_citySetPickerValue ppppppppppppppppppppppppppp");
  NSLog(@"gbl_citySetPickerValue =[%ld]",(long)gbl_citySetPickerValue );
kin(num_PSVs_found);
  NSLog(@"fldCity=[%@]",fldCity);
  NSLog(@"fldProv=[%@]",fldProv);
  NSLog(@"fldCoun=[%@]",fldCountry);
  NSLog(@"gbl_mycityprovcounLabel.attributedText=[%@]",gbl_mycityprovcounLabel.attributedText);
  NSLog(@"gbl_mycityprovcounLabel.text          =[%@]",gbl_mycityprovcounLabel.text);
  NSLog(@"gbl_enteredCity=[%@]",gbl_enteredCity);
  NSLog(@"gbl_enteredProv=[%@]",gbl_enteredProv);
  NSLog(@"gbl_enteredCoun=[%@]",gbl_enteredCoun);

    if (gbl_citySetPickerValue == 1 ) {   // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
        gbl_citySetPickerValue  = 0;      // 1=y,0=n  // set initial value  when first entering City in "edit mode"  yellow
  NSLog(@"gbl_citySetPickerValue2=[%ld]",(long)gbl_citySetPickerValue );

        // in this case, picker should have row entered before (this is edit mode)
        
        // Find rownum in the picklist for fldCity + fldProv + fldCoun (row entered before)
        //
        // char city_prov_coun_PSVs[26 * 128];    // [max num 25 * fixed length of 128]  for search city using typed so far
        // int  num_PSVs_found;                   // zero-based                          for search city using typed so far
        // sprintf(my128PSV, "%s|%s|%s", city_buf, prov_buf, coun_buf);
        //
        int ll;                 ll = 0;
        int foundAtIdx; foundAtIdx = -1;
        char      myPSVbuf[128];
        NSString *myPSV_nsstring;
        NSString *candidateCity;
        NSString *candidateProv;
        NSString *candidateCoun;
        NSArray *tmpArray5;
        for (ll = 0; ll < num_PSVs_found; ll++)
        {
kin(ll);
            strcpy(myPSVbuf, city_prov_coun_PSVs + ll * 128);  // fixed rec =  128  chars
ksn(myPSVbuf);

             myPSV_nsstring = [NSString stringWithUTF8String: myPSVbuf ];  // convert c string to NSString
  NSLog(@"myPSV_nsstring =[%@]",myPSV_nsstring );

            NSCharacterSet *mySeps5 = [NSCharacterSet characterSetWithCharactersInString: @"|"];
            tmpArray5               = [myPSV_nsstring componentsSeparatedByCharactersInSet: mySeps5 ];

            candidateCity = tmpArray5[0];
            candidateProv = tmpArray5[1];
            candidateCoun = tmpArray5[2];
  NSLog(@"candidateCity =[%@]",candidateCity );
  NSLog(@"candidateProv =[%@]",candidateProv );
  NSLog(@"candidateCoun =[%@]",candidateCoun );
  
            if (   [candidateCity isEqualToString: fldCity] 
                && [candidateProv isEqualToString: fldProv] 
                && [candidateCoun isEqualToString: fldCountry] 
//            if (   [candidateCity isEqualToString: gbl_enteredCity] 
//                && [candidateProv isEqualToString: gbl_enteredProv] 
//                && [candidateCoun isEqualToString: gbl_enteredCoun] 

            ) {
                foundAtIdx = ll;
kin(foundAtIdx); 
            }

        }
        if (foundAtIdx == -1)  // not found at all
        {
            [self.pickerViewCity selectRow: 0           inComponent: 0 animated: YES];
        } else {
kin(foundAtIdx); 
            [self.pickerViewCity selectRow: foundAtIdx  inComponent: 0 animated: YES];
        }

    } else {
        [self.pickerViewCity selectRow: 0   inComponent: 0 animated: YES];
    }
trn("pppppppp  END  gbl_citySetPickerValue ppppppppppppppppppppppppppp");
tn();

    
  NSLog(@"--putup fn- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER ---------------- " );
  NSLog(@"--putup fn- VASSIGN6gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);
  NSLog(@"--putup fn- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER ---------------- " );

  gbltmpstr = [gbl_mycitySearchString.inputView.description substringToIndex: 15];
   gbl_mycitySearchString.inputView = [self pickerViewCity] ; 

  NSLog(@"--putup fn- VASSIGN21gbl_mycitySearchString.inputView --- old=[%@]  new=[%@] ---", gbltmpstr, [ gbl_mycitySearchString.inputView.description substringToIndex: 15]);


        [gbl_mycitySearchString resignFirstResponder];  // control goes to textFieldShouldEndEditing > textFieldDidEndEditing > back here
  NSLog(@"--putup fn- VASSIGN gbl_mycitySearchString RESIGN!FIRST_RESPONDER #2 ! ----------- " );

  NSLog(@"= 08 =====  BECOME first responder = gbl_mycitySearchString ");
        [gbl_mycitySearchString becomeFirstResponder];  
  NSLog(@"--putup fn- VASSIGN gbl_mycitySearchString BECOME_FIRST_RESPONDER #2 ! ----------- " );



        // sometimes city field has old city
  NSLog(@" // sometimes city field has old city ");

//                [self putUpCityPicklist ];           // TODO putUpCityPicklist only called twice
//                [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, Prov, Coun
                [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath


 NSLog(@"ppppp gbl_lastSelectedCityPickerRownum  =%ld",(long)gbl_lastSelectedCityPickerRownum );

                [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do not show old data
                [self.pickerViewCity selectRow: gbl_lastSelectedCityPickerRownum   inComponent: 0 animated: YES];


//    [self putUpCancelButtonOrNot  ];

  NSLog(@"end of  putUpCityPicklist !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");tn();
tn();

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
tn();
  NSLog(@"in updateCityProvCoun");
    // update city,prov,coun label fields

    // update city label field  update field in cellForRowAtIndexpath
    //
            //  myTextCity = [NSString stringWithFormat:@" %@\n %@\n %@", gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun ];
//            gbl_enteredCity = gbl_initPromptCity;
//            gbl_enteredProv = gbl_initPromptProv;
//            gbl_enteredCoun = gbl_initPromptCoun;

    NSIndexPath *indexPathLabelCityProvCoun = [NSIndexPath indexPathForRow: 3 inSection: 0];
  NSLog(@"indexPathLabelCityProvCoun =[%@]",indexPathLabelCityProvCoun );
    NSArray *indexPathsToUpdate = [NSArray arrayWithObjects: indexPathLabelCityProvCoun, nil];

  NSLog(@"indexPathsToUpdate =[%@]",indexPathsToUpdate );

    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths: indexPathsToUpdate
                              withRowAnimation: UITableViewRowAnimationNone ];
        [self.tableView endUpdates];
    });

  NSLog(@"end of updateCityProvCoun");
tn();
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
    //  NSLog(@" self.array_am_pm.count       =%ld", self.array_am_pm.count);
    //



        if (component == 0) return self.array_BirthYearsToPick.count;
        if (component == 1) return self.array_Months.count;
        if (component == 2) return self.array_DaysOfMonth.count;
        if (component == 3) return 1; // spacer
        if (component == 4) return self.array_Hours_1_12.count;
        if (component == 5) return 1; // colon
        if (component == 6) return self.array_Min_0_59.count;
        if (component == 7) return self.array_am_pm.count;
    //    if (component == 3) return self.array_Hours_1_12.count;
    //    if (component == 4) return self.array_Min_0_59.count;
    //    if (component == 5) return self.array_am_pm.count;
        
  NSLog(@"self.array_BirthYearsToPick.count;=%lu",(unsigned long)self.array_BirthYearsToPick.count);
        return 0;
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

//trn("in titleForRow in pickerview BIRTH !");
//NSLog(@"      row=%ld",(long)row);
//NSLog(@"component=%ld",(long)component);

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
    if (component == 7)  titleForRowRetval = [self.array_am_pm       objectAtIndex: row];

//NSLog(@"RETURN titleForRowRetval=%@",titleForRowRetval);

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
//    if (component == 5)  titleForRowRetval = [self.array_am_pm       objectAtIndex: row];
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
//  NSLog(@"in viewForRow !!  in PICKER    row=%ld",(long)row);
//  NSLog(@"gbl_pickerToUse=[%@]",gbl_pickerToUse);

    // NSString *gbl_fieldTap_leaving; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
    // NSString *gbl_fieldTap_goingto; // note that name and city are captured in should/did editing, date in viewForRow uipickerview
    //
    if (            gbl_myname.isFirstResponder == 1)  gbl_fieldTap_goingto = @"name";
    if (gbl_mycitySearchString.isFirstResponder == 1)  gbl_fieldTap_goingto = @"city"; 
    if (gbl_mybirthinformation.isFirstResponder == 1)  gbl_fieldTap_goingto = @"date";  // never happens (fld is neveer first responder)


//    [ self setFieldTap_currPrev ];

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
        if (component == 7)  retvalUILabel.text = [self.array_am_pm       objectAtIndex: row];
        //    if (component == 3)  retvalUILabel.text = [self.array_Hours_1_12  objectAtIndex: row];
        //    if (component == 4)  retvalUILabel.text = [self.array_Min_0_59    objectAtIndex: row];
        //    if (component == 5)  retvalUILabel.text = [self.array_am_pm       objectAtIndex: row];

        //    retvalUILabel.text = [pickerViewArray objectAtIndex:row];
//  NSLog(@"DATE text=%@", retvalUILabel.text);
    }

    if ([ gbl_pickerToUse isEqualToString: @"city picker"] ) {  // "city picker" or "date/time picker"
        
        if (component == 0) {

                //        &num_PSVs_found,                 // is type  int  (0-based index to last string)
                //        city_prov_coun_PSVs              // array of chars holding fixed length "strings"

            [ self getCurrentCityProvCounForRownum: row ]; // this row is picker row  // populates gbl_enteredCity, Prov, Coun

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
//                                           value: gbl_colorEditingBG_current
                                           value: [UIColor yellowColor]
                                           range: NSMakeRange(1, gbl_myCitySoFar.length)  // offset, length
            ];

            // set value of attributedText property of retvalUILabel
            retvalUILabel.attributedText = myAttributedTextLabel;


        }  // city,prov \n coun

    }

    return retvalUILabel;

} // viewForRow


// this is ONLY for rownum in array city_prov_coun_PSVs  which in used in this C function
//
//    idx_into_placetab = bin_find_first_city(  // **********  ==========   GET CITY,prov,coun
//        arg_cityBeginsWith,
//        gbl_numCitiesToTriggerPicklist,  // is type  int
//        &num_PSVs_found,                 // is type  int  (0-based index to last string)
//        city_prov_coun_PSVs              // array of chars holding fixed length "strings"
//    );
//
- (void) getCurrentCityProvCounForRownum: (NSInteger) arg_rownum   // populates gbl_enteredCity, Prov, Coun
{
//tn();
  NSLog(@"======================================");
  NSLog(@"in getCurrentCityProvCounForRownum");
  NSLog(@"arg_rownum=[%ld]",(long)arg_rownum);
  NSLog(@"gbl_lastSelectedCityPickerRownumx=[%ld]",(long)gbl_lastSelectedCityPickerRownum );

    char my_buff[256];
    NSMutableString *myContentsPSV;
    NSArray  *tmpArray3;


    // gbl_lastSelectedCityPickerRownum = -1;  // ONLY is SET in 2 places   -1 =flag for getCurrentCityProvCounForRownum to show initpromts
    //

    if (   arg_rownum == -1
        || gbl_lastSelectedCityPickerRownum == -1   // "clear city button"
    )  //  -1 =flag for getCurrentCityProvCounForRownum to show initpromts
    {
        gbl_lastSelectedCityPickerRownum = 0;
        gbl_enteredCity        = gbl_initPromptCity;  // @"City or Town";  for display in gbl_mycityprovcounLabel= found city,prov,counl
  NSLog(@"citych #00  %-24s =[%@] $$$ getCurrentCityProvCounForRownum  $$$$$$$$x$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity );
        gbl_enteredProv        = gbl_initPromptProv;  // @"State or Province";
        gbl_enteredCoun        = gbl_initPromptCoun;  // @"Country";

  NSLog(@"gbl_lastSelectedCityPickerRownum=[%ld]",(long)gbl_lastSelectedCityPickerRownum );
  NSLog(@"gbl_enteredCity =[%@]",gbl_enteredCity );
  NSLog(@"gbl_enteredProv =[%@]",gbl_enteredProv );
  NSLog(@"gbl_enteredCoun =[%@]",gbl_enteredCoun );

        return;
    }

    strcpy(my_buff, city_prov_coun_PSVs + arg_rownum * 128);  // fixed len rec = 128   get ROW   get ROW   get ROW  get ROW

    myContentsPSV = [NSMutableString stringWithUTF8String: my_buff];  // convert c string to NSString
  NSLog(@"myContentsPSV =[%@]",myContentsPSV );

    NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
    tmpArray3     = [myContentsPSV componentsSeparatedByCharactersInSet: mySeparators ];
//  NSLog(@"tmpArray3     =[%@]",tmpArray3     );
//  NSLog(@"tmpArray3.count =[%ld]",(long)tmpArray3.count );

    if (   tmpArray3 == nil
        || tmpArray3.count < 3 
        || gbl_justPressedAddButtonForNewPerson == 1   // "+" button in home in per mode
       )
    {
//  NSLog(@"1 got gbl_enteredCity from gbl_userSpecifiedCity");


  NSLog(@"gbl_justPressedAddButtonForNewPerson  a  =[%ld]",(long)gbl_justPressedAddButtonForNewPerson );
        if ( gbl_justPressedAddButtonForNewPerson == 1) {
            gbl_justPressedAddButtonForNewPerson = 0; 
        }
  NSLog(@"gbl_justPressedAddButtonForNewPerson  b  =[%ld]",(long)gbl_justPressedAddButtonForNewPerson );


        // screen said "null" 1st time
//        gbl_enteredCity = gbl_userSpecifiedCity;
//  NSLog(@"citych #02  %-24s =[%@] $$$ getCurrentCityProvCounForRownum  $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity );
//        gbl_enteredProv = gbl_userSpecifiedProv;
//        gbl_enteredCoun = gbl_userSpecifiedCoun;

        gbl_enteredCity        = gbl_initPromptCity;  // @"City or Town";  for display in gbl_mycityprovcounLabel= found city,prov,counl
  NSLog(@"citych #02  %-24s =[%@] $$$ getCurrentCityProvCounForRownum  $$$$$$$$x$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity );
        gbl_enteredProv        = gbl_initPromptProv;  // @"State or Province";
        gbl_enteredCoun        = gbl_initPromptCoun;  // @"Country";
    
    } else {

//  NSLog(@"2 got gbl_enteredCity from city_prov_coun_PSVs C  ");
        gbl_enteredCity = tmpArray3[0];
//  NSLog(@"citych #01  %-24.24@ =[%@] $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", @"", );
  NSLog(@"citych #01  %-24s =[%@] $$$ getCurrentCityProvCounForRownum  $$$$$$$$$$$$$$$$$$$$", "gbl_enteredCity" , gbl_enteredCity );

        gbl_enteredProv = tmpArray3[1];
        gbl_enteredCoun = tmpArray3[2];
    }


//  NSLog(@"!! REMOVED set of gbl_enteredCity here  ");  // get picker with  1 cestas + 2 cestas
  NSLog(@"gbl_lastSelectedCityPickerRownumx=[%ld]",(long)gbl_lastSelectedCityPickerRownum );
  NSLog(@"gbl_enteredCity =[%@]",gbl_enteredCity );
  NSLog(@"gbl_enteredProv =[%@]",gbl_enteredProv );
  NSLog(@"gbl_enteredCoun =[%@]",gbl_enteredCoun );


//                [self putUpCityPicklist ];           // TODO putUpCityPicklist only called twice
//                [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, Prov, Coun
//                [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath
//                [self.pickerViewCity reloadAllComponents]; // just in case things have changed, do not show old data
//                [self.pickerViewCity selectRow: gbl_lastSelectedCityPickerRownum   inComponent: 0 animated: YES];


//  NSLog(@"END of getCurrentCityProvCounForRownum");
  NSLog(@"======================================");
//tn();

} //  getCurrentCityProvCounForRownum




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
//    if (component == 5)  titleForRowRetval = [self.array_am_pm       objectAtIndex: row];
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


    // we want to allow picker, but no double tap selection
//        gbl_mybirthinformation.userInteractionEnabled = NO;
//       gbl_mybirthinformation.selection = NO;



    gbl_editingChangeDATEHasOccurred = 1;   // default 0 at startup (after hitting "Edit" button on home page)

    if ([ gbl_pickerToUse isEqualToString: @"date/time picker"] )
    {  // "city picker" or "date/time picker"


        gbl_lastInputFieldTapped = @"date";
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse11       =%@",gbl_pickerToUse );

        trn("in didSelectRow in BIRTH DATE  PICKER !! ");
//    NSLog(@"row=%ld",(long)row);
//    NSLog(@"component=%ld",(long)component);
//      NSLog(@" 1 gbl_rollerBirth_yyyy =%@",gbl_rollerBirth_yyyy );
//      NSLog(@" 1 gbl_rollerBirth_mth  =%@",gbl_rollerBirth_mth  );
//      NSLog(@" 1 gbl_rollerBirth_dd   =%@",gbl_rollerBirth_dd   );
//      NSLog(@" 1 gbl_rollerBirth_hour =%@",gbl_rollerBirth_hour );
//      NSLog(@" 1 gbl_rollerBirth_min  =%@",gbl_rollerBirth_min  );
//      NSLog(@" 1 gbl_rollerBirth_amPm =%@",gbl_rollerBirth_amPm );



        NSInteger myNewIndex;
        int daysinmonth[12]={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
        int rollerMM, rollerDD, rollerYYYY;
        // build gbl_lastSelectedDay  "yyyymmdd"  from  roller values
        //
//            NSString *mm_format;   // like "01" instead of "Jan"


//            [self.pickerViewDateTime selectRow: myIndex inComponent: 0 animated: YES]; // This is how you manually SET(!!) a selection!
//            [self.pickerViewDateTime selectRow:       0 inComponent: 1 animated: YES]; // mth  = jan
//            [self.pickerViewDateTime selectRow:       0 inComponent: 2 animated: YES]; // day  = 01
//            // 3 = spacer
//            [self.pickerViewDateTime selectRow:      11 inComponent: 4 animated: YES]; // hr   = 12
//            // 5 = colon
//            [self.pickerViewDateTime selectRow:       1 inComponent: 6 animated: YES]; // min  = 01   2nd one
//            [self.pickerViewDateTime selectRow:       1 inComponent: 7 animated: YES]; // ampm = 12   2nd one

            // set mm value  (could be changed if component = 0)

            // self.array_Months = [[NSArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
//            NSInteger indexInMths = [self.array_Months   indexOfObject: gbl_rollerBirth_mth];
//            mm_format = [NSString stringWithFormat:@"%02d",  (int) (indexInMths + 1)];    // mm is one-base, arr idx is zero-based


//            mm_format = [NSString stringWithFormat:@"%02d",  (int) gbl_rollerBirth_mth ];
//  NSLog(@"indexInMths =[%ld]",(long)indexInMths );
//  NSLog(@"mm_format 1 =[%@]",mm_format );

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
//                mm_format = [NSString stringWithFormat:@"%02d",  (int) (row + 1)];    // mm is one-base, row is zero-based
//  NSLog(@"mm_format 2 =[%@]",mm_format );
//  NSLog(@" 2 gbl_rollerBirth_mth  =%@",gbl_rollerBirth_mth  );
            }
            if (component == 2) {
                gbl_rollerBirth_dd   = [self pickerView:  self.pickerViewDateTime
                                            titleForRow: [self.pickerViewDateTime  selectedRowInComponent: 2 ]
                                           forComponent: 2  ];
//  NSLog(@" 2 gbl_rollerBirth_dd   =%@",gbl_rollerBirth_dd   );
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
//      NSLog(@" 2 gbl_rollerBirth_yyyy =%@",gbl_rollerBirth_yyyy );
//      NSLog(@" 2 gbl_rollerBirth_mth  =%@",gbl_rollerBirth_mth  );
//      NSLog(@" 2 gbl_rollerBirth_dd   =%@",gbl_rollerBirth_dd   );
//      NSLog(@" 2 gbl_rollerBirth_hour =%@",gbl_rollerBirth_hour );
//      NSLog(@" 2 gbl_rollerBirth_min  =%@",gbl_rollerBirth_min  );
//      NSLog(@" 2 gbl_rollerBirth_amPm =%@",gbl_rollerBirth_amPm );





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
  NSLog(@"FIX ROLLER POSITION DATA! ( invalid day of month on rollers  m d y)");

                // get C int for mm dd yyyy
                //
//                rollerMM   = [mm_format            intValue];
//                rollerMM   = [gbl_rollerBirth_mth  intValue];
                rollerMM = 1;  // default - should never happen
                if      ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Jan" ] == NSOrderedSame) rollerMM = 1;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Feb" ] == NSOrderedSame) rollerMM = 2;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Mar" ] == NSOrderedSame) rollerMM = 3;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Apr" ] == NSOrderedSame) rollerMM = 4;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"May" ] == NSOrderedSame) rollerMM = 5;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Jun" ] == NSOrderedSame) rollerMM = 6;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Jul" ] == NSOrderedSame) rollerMM = 7;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Aug" ] == NSOrderedSame) rollerMM = 8;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Sep" ] == NSOrderedSame) rollerMM = 9;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Oct" ] == NSOrderedSame) rollerMM = 10;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Nov" ] == NSOrderedSame) rollerMM = 11;
                else if ([gbl_rollerBirth_mth caseInsensitiveCompare:  @"Dec" ] == NSOrderedSame) rollerMM = 12;

                rollerDD   = [gbl_rollerBirth_dd   intValue]; 
                rollerYYYY = [gbl_rollerBirth_yyyy intValue]; 
                //nki(rollerMM); ki(rollerDD); ki(rollerYYYY);

                // 1)  invalid day of month on rollers  m d y
                if (    rollerYYYY % 400 == 0
                    || (rollerYYYY % 100 != 0 && rollerYYYY % 4 == 0))   daysinmonth[1] = 29; // if leap year, make 29 days in february

//kin(rollerYYYY);
//kin(rollerMM);
//kin(rollerDD);
                if (rollerDD > daysinmonth[rollerMM-1]) {
                    rollerDD = daysinmonth[rollerMM-1]; // day of month too big, make equal to last day in that month and year
                    gbl_rollerBirth_dd = [NSString stringWithFormat:@"%02d", rollerDD];

                    // set the changed value on the day  roller
                    myNewIndex = rollerDD - 1;               // initMM and initDD are "one-based" real m and d values
//  NSLog(@"myNewIndex =[%ld]",(long)myNewIndex );
                    [self.pickerViewDateTime selectRow:myNewIndex inComponent: 2 animated:YES]; // This is how you manually SET(!!) a selection!
                }

//      NSLog(@" 3 gbl_rollerBirth_yyyy =%@",gbl_rollerBirth_yyyy );
//      NSLog(@" 3 gbl_rollerBirth_mth  =%@",gbl_rollerBirth_mth  );
//      NSLog(@" 3 gbl_rollerBirth_dd   =%@",gbl_rollerBirth_dd   );
//      NSLog(@" 3 gbl_rollerBirth_hour =%@",gbl_rollerBirth_hour );
//      NSLog(@" 3 gbl_rollerBirth_min  =%@",gbl_rollerBirth_min  );
//      NSLog(@" 3 gbl_rollerBirth_amPm =%@",gbl_rollerBirth_amPm );







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

            // display YMDHMA  selected
            //
      NSLog(@"myFormattedStr=%@", myFormattedStr);
    gbl_selectedBirthInfo = myFormattedStr;  // used to update field in cellforrow

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
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
  NSLog(@"= 09 =====  BECOME first responder = gbl_mybirthinformation ");
             [gbl_mybirthinformation becomeFirstResponder];
  NSLog(@"-didsel in picker -- VASSIGN gbl_mybirthinformation BECOME_FIRST_RESPONDER ---------------- " );
    });


//    // want to never dismiss pickerview on didselect
//    [gbl_mybirthinformation becomeFirstResponder];
//    self.pickerViewDateTime.hidden     =  NO; 
//    gbl_mybirthinformation.hidden = NO;

  NSLog(@"SELECTED a date  picker value");

    } // end date/time   didSelectRow

  NSLog(@"gbl_pickerToUse =[%@]",gbl_pickerToUse );


    if ([ gbl_pickerToUse isEqualToString: @"city picker"     ] ) {  // "city picker" or "date/time picker"

        gbl_lastInputFieldTapped = @"city";
  NSLog(@"                                    gbl_lastInputFieldTapped=%@",gbl_lastInputFieldTapped);
  NSLog(@"                                    gbl_pickerToUse15       =%@",gbl_pickerToUse );

  NSLog(@"SELECTED a city  picker value");
  NSLog(@"SELECTED   city  picker ROW      =[%ld]",(long)row);
        gbl_lastSelectedCityPickerRownum = row;    // ONLY place     is SET  except for cancel (set to -1)
  NSLog(@"SET  gbl_lastSelectedCityPickerRownum =[%ld]",(long)gbl_lastSelectedCityPickerRownum );

        // update city,prov,coun label fields
        //
        //[self getCurrentCityProvCounForRownum: gbl_lastPicklistSelectedRownum]; // populates gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun
        [ self getCurrentCityProvCounForRownum: gbl_lastSelectedCityPickerRownum ]; // populates gbl_enteredCity, gbl_enteredProv, gbl_enteredCoun

        [ self updateCityProvCoun ]; // update city/prov/coun field  in cellForRowAtIndexpath

    } // city picker





trn("!!!!!!!!!  END OF  didSelectRow in some  PICKER !!   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"); tn();

} // didSelectRow  for PICKER


// ---  end of --------------------------------------------------------------------------------------------------
// ---  end of ----------------------   UIPickerView stuff ------------------------------------------------------
// ---  end of --------------------------------------------------------------------------------------------------


- (void) disp_gblsWithLabel: (NSString *) arg_dispLabel 
{
  NSString *myDispLabel =  [NSString stringWithFormat:@"#####  %@  #####################################################",  arg_dispLabel ];

  //  NSLog(@"=[%@]",);
tn(); 
  NSLog(@"##### beg of gbls #####################################!");
  NSLog(@"%@", myDispLabel);

//return;  // for less test output

//  NSLog(@"%@", @" ");
//  NSLog(@"qq gbl_DisplayCity                                =[%@]",gbl_DisplayCity);
//  NSLog(@"qq gbl_DisplayCoun                                =[%@]",gbl_DisplayCoun);
//  NSLog(@"qq gbl_DisplayDate                                =[%@]",gbl_DisplayDate);
//  NSLog(@"qq gbl_DisplayName                                =[%@]",gbl_DisplayName);
//
//  NSLog(@"qq gbl_DisplayProv                                =[%@]",gbl_DisplayProv);
//  NSLog(@"qq gbl_citySetEditingValue                        =[%ld]",(long)gbl_citySetEditingValue);
//  NSLog(@"qq gbl_citySetLabelValue                          =[%ld]",(long)gbl_citySetLabelValue);
//  NSLog(@"qq gbl_citySetPickerValue                         =[%ld]",(long)gbl_citySetPickerValue);
//  NSLog(@"qq gbl_currentDayInt                              =[%ld]",(long)gbl_currentDayInt);
//  NSLog(@"qq gbl_currentMenuPlusReportCode                  =[%@]",gbl_currentMenuPlusReportCode);
//  NSLog(@"qq gbl_currentMonthInt                            =[%ld]",(long)gbl_currentMonthInt);
//  NSLog(@"qq gbl_currentYearInt                             =[%ld]",(long)gbl_currentYearInt);
//  NSLog(@"qq gbl_editingChangeCITYHasOccurred               =[%ld]",(long)gbl_editingChangeCITYHasOccurred);
//  NSLog(@"qq gbl_editingChangeDATEHasOccurred               =[%ld]",(long)gbl_editingChangeDATEHasOccurred);
//  NSLog(@"qq gbl_editingChangeNAMEHasOccurred               =[%ld]",(long)gbl_editingChangeNAMEHasOccurred);
//  NSLog(@"qq gbl_enteredCity                                =[%@]",gbl_enteredCity);
//  NSLog(@"qq gbl_enteredCoun                                =[%@]",gbl_enteredCoun);
//  NSLog(@"qq gbl_enteredProv                                =[%@]",gbl_enteredProv);
//  NSLog(@"qq gbl_fewEnoughCitiesToMakePicklist              =[%ld]",(long)gbl_fewEnoughCitiesToMakePicklist);
//  NSLog(@"qq gbl_fieldTap_goingto                           =[%@]",gbl_fieldTap_goingto);
//  NSLog(@"qq gbl_fieldTap_leaving                           =[%@]",gbl_fieldTap_leaving);
//  NSLog(@"qq gbl_firstResponder_current                     =[%@]",gbl_firstResponder_current);
//  NSLog(@"qq gbl_firstResponder_previous                    =[%@]",gbl_firstResponder_previous);
//  NSLog(@"qq gbl_fromHomeCurrentEntity                      =[%@]",gbl_fromHomeCurrentEntity);
//  NSLog(@"qq gbl_fromHomeCurrentEntityName                  =[%@]",gbl_fromHomeCurrentEntityName);
//  NSLog(@"qq gbl_fromHomeCurrentSelectionPSV                =[%@]",gbl_fromHomeCurrentSelectionPSV);
//  NSLog(@"qq gbl_fromHomeCurrentSelectionType               =[%@]",gbl_fromHomeCurrentSelectionType);
//  NSLog(@"qq gbl_homeEditingState                           =[%@]",gbl_homeEditingState);
//  NSLog(@"qq gbl_homeUseMODE                                =[%@]",gbl_homeUseMODE);
//  NSLog(@"qq gbl_initPromptCity                             =[%@]",gbl_initPromptCity);
//  NSLog(@"qq gbl_initPromptCoun                             =[%@]",gbl_initPromptCoun);
//  NSLog(@"qq gbl_initPromptDate                             =[%@]",gbl_initPromptDate);
//  NSLog(@"qq gbl_initPromptName                             =[%@]",gbl_initPromptName);
//  NSLog(@"qq gbl_initPromptProv                             =[%@]",gbl_initPromptProv);
//  NSLog(@"qq gbl_intBirthDayOfMonth                         =[%ld]",(long)gbl_intBirthDayOfMonth);
//  NSLog(@"qq gbl_intBirthMonth                   ;          =[%ld]",(long)gbl_intBirthMonth);
//  NSLog(@"qq gbl_intBirthYear                               =[%ld]",(long)gbl_intBirthYear);
//  NSLog(@"qq gbl_justAddedGroupRecord                       =[%ld]",(long)gbl_justAddedGroupRecord);
//  NSLog(@"qq gbl_justAddedPersonRecord                      =[%ld]",(long)gbl_justAddedPersonRecord);
//  NSLog(@"qq gbl_justEnteredAddChangeView                   =[%ld]",(long)gbl_justEnteredAddChangeView);
//  NSLog(@"qq gbl_justLookedAtInfoScreen                     =[%ld]",(long)gbl_justLookedAtInfoScreen);
//  NSLog(@"qq gbl_justPressedChangeGroupName                 =[%ld]",(long)gbl_justPressedChangeGroupName);
//  NSLog(@"qq gbl_kindOfSave                                 =[%@]",gbl_kindOfSave);
//  NSLog(@"qq gbl_lastInputFieldTapped                       =[%@]",gbl_lastInputFieldTapped);
//  NSLog(@"gbl_lastSelectedCityPickerRownum                  =[%ld]",(long)gbl_lastSelectedCityPickerRownum);
//  NSLog(@"qq gbl_lastSelectedDay                            =[%@]",gbl_lastSelectedDay);
//  NSLog(@"qq gbl_lastSelectedGroup                          =[%@]",gbl_lastSelectedGroup);
//  NSLog(@"qq gbl_lastSelectedGroupBeforeChange              =[%@]",gbl_lastSelectedGroupBeforeChange);
//  NSLog(@"qq gbl_lastSelectedPerson                         =[%@]",gbl_lastSelectedPerson);
//  NSLog(@"qq gbl_lastSelectedPersonBeforeChange             =[%@]",gbl_lastSelectedPersonBeforeChange);
//  NSLog(@"qq gbl_myCitySoFar                                =[%@]",gbl_myCitySoFar);
//  NSLog(@"qq gbl_mybirthinformation.text                    =[%@]",gbl_mybirthinformation.text);
//  NSLog(@"qq gbl_mybirthinformation.userInteractionEnabled  =[%d]",gbl_mybirthinformation.userInteractionEnabled);
//  NSLog(@"qq gbl_mycityInputView                            =[%@]",gbl_mycityInputView);
//  NSLog(@"qq gbl_mycitySearchString.text                    =[%@]",gbl_mycitySearchString.text);
//  //  NSLog(@"qq gbl_mycityprovcounLabel.attributedText         =[%@]",gbl_mycityprovcounLabel.attributedText);
//  NSLog(@"qq gbl_mycityprovcounLabel.text                   =[%@]",gbl_mycityprovcounLabel.text);
//  NSLog(@"qq gbl_myname.text                                =[%@]",gbl_myname.text);
//  NSLog(@"qq gbl_myname.userInteractionEnabled              =[%d]",gbl_myname.userInteractionEnabled);
//  NSLog(@"qq gbl_pickerToUse                                =[%@]",gbl_pickerToUse);
//  NSLog(@"qq gbl_rollerBirthInfo                            =[%@]",gbl_rollerBirthInfo);
//  NSLog(@"qq gbl_rollerBirth_amPm                           =[%@]",gbl_rollerBirth_amPm);
//  NSLog(@"qq gbl_rollerBirth_dd                             =[%@]",gbl_rollerBirth_dd);
//  NSLog(@"qq gbl_rollerBirth_hour                           =[%@]",gbl_rollerBirth_hour);
//  NSLog(@"qq gbl_rollerBirth_min                            =[%@]",gbl_rollerBirth_min);
//  NSLog(@"qq gbl_rollerBirth_mth                            =[%@]",gbl_rollerBirth_mth);
//  NSLog(@"qq gbl_rollerBirth_yyyy                           =[%@]",gbl_rollerBirth_yyyy);
//  NSLog(@"qq gbl_selectedBirthInfo                          =[%@]",gbl_selectedBirthInfo);
//  NSLog(@"qq gbl_title_birthDate.title                      =[%@]",gbl_title_birthDate.title);
//  NSLog(@"qq gbl_title_cityKeyboard.title                   =[%@]",gbl_title_cityKeyboard.title);
//  NSLog(@"qq gbl_title_cityPicklist.title                   =[%@]",gbl_title_cityPicklist.title);
//  NSLog(@"qq gbl_userSpecifiedCity                          =[%@]",gbl_userSpecifiedCity);
//  NSLog(@"qq gbl_userSpecifiedCoun                          =[%@]",gbl_userSpecifiedCoun);
//  NSLog(@"qq gbl_userSpecifiedPersonName                    =[%@]",gbl_userSpecifiedPersonName);
//  NSLog(@"qq gbl_userSpecifiedProv                          =[%@]",gbl_userSpecifiedProv);
//


  NSLog(@" ");
  NSLog(@"%@", myDispLabel);
  NSLog(@"##### end of gbls #####################################!");
tn(); 

} // end of disp_gblsWithLabel


@end

