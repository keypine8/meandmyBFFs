//
//  MAMB09_addChangeTableViewController.h
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-06-29.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>

// NSMutableArray *yearsToPickFrom3;  /* for pickerYearInLife */


@interface MAMB09_addChangeTableViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate, UITextViewDelegate, UIScrollViewDelegate>

//@interface MAMB09_addChangeTableViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>



// @property (weak, nonatomic) IBOutlet UIPickerView *outletFor_YMDHMA_picker;
//@property (weak, nonatomic) IBOutlet UILabel      *outletToSelectedBirthInfo;
//@property (weak, nonatomic) IBOutlet UIView *outletToSelectedBirthInfo;

@property  (strong, nonatomic)          UIPickerView *pickerViewCity;
@property  (strong, nonatomic)          UIPickerView *pickerViewDateTime;
// @property (weak, nonatomic) IBOutlet UIPickerView *outletFor_YMD_picker;

@property (strong, nonatomic)          NSMutableArray *array_BirthYearsToPick;
@property (strong, nonatomic)          NSArray        *array_Months;
@property (strong, nonatomic)          NSMutableArray *array_DaysOfMonth;
@property (strong, nonatomic)          NSMutableArray *array_Hours_1_12;
@property (strong, nonatomic)          NSMutableArray *array_Min_0_59;
@property (strong, nonatomic)          NSMutableArray *array_am_pm;

// @property (strong, nonatomic) IBOutlet UITableView *outletToHomeTableview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *outletToButtonToGetPicklist;

@end

//<.>  iphone, dismiss keyboard when touching outside of UITextField
//
//   http://stackoverflow.com/questions/5306240/iphone-dismiss-keyboard-when-touching-outside-of-uitextfield
//
//  I mashed up a few answers.
//
//  Use an ivar that gets initialized during viewDidLoad:
//
//  UIGestureRecognizer *tapper;
//
//  - (void)viewDidLoad
//  {
//      [super viewDidLoad];
//      tapper = [[UITapGestureRecognizer alloc]
//                  initWithTarget:self action:@selector(handleSingleTap:)];
//      tapper.cancelsTouchesInView = NO;
//      [self.view addGestureRecognizer:tapper];
//  }
//  Dismiss what ever is currently editing:
//
//  - (void)handleSingleTap:(UITapGestureRecognizer *) sender
//  {
//      [self.view endEditing:YES];
//  }
//  shareimprove this answer
//  edited Nov 3 '13 at 18:41
//
//  community wiki
//  5 revs, 4 users 95%
//  drewish
//        
//  Fantastic, it works on UITableView!! it save my day!
// As a side note I will use [UITextField resignFirstResponder] instead of [UIView endEditing:]
//  because I have more UITextField and endEditing gives a wrong scrolling position
//  even if the new UITextField is visible. –  Dr.Luiji Nov 8 '12 at 10:42 
//        
//  TOOO GOOOD Answer :D –  iWatch Jan 10 '13 at 9:35
//



//<.>
//recipe
//  - make city of birth field hidden
//  - move city of birth field  to tableview row at bottom
//  -  for city,prov,coun    make one white  UILabel  field (no inputview, 3 lines )
//
//  - when user taps on cityprovcoun UILabel  field
//       ENDED UP using didselectrow for this detection
//
//<.>
//        //    You can use this :
//        //
//        //        UITapGestureRecognizer *labelTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapped)];
//        //        labelTap.numberOfTapsRequired=1;
//        //        [yourLabel addGestureRecognizer:labelTap];
//        //
//        //    // handle the touch tap event inside labelTapped method:
//        //    -(void)labelTapped
//        //    {
//        //      //your code to handle tap
//        //    }
//        //
//        //
//        //  with  TAG  TAG  TAG  TAG  TAG  TAG  TAG  TAG  TAG  
//        //
//        //Creating the gesturerecognizer
//        //
//        //    UITapGestureRecognizer *detectTimeFrameChange =
//        //        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeFrameLabelTapped:)];
//        //    detectTimeFrameChange.numberOfTapsRequired = 1;
//        //    [backGroundView addGestureRecognizer:detectTimeFrameChange];
//        //
//        //Handling gesture
//        //
//        //-(void)timeFrameLabelTapped: (UITapGestureRecognizer*)recognizer{
//        //    if (recognizer.view.tag == 1) {
//        //        NSLog(@"One pressed");
//        //    }
//        //    else if (recognizer.view.tag == 2){
//        //        NSLog(@"2 pressed");
//        //    }
//        //}
//        //
//            You can use this :
//
//                UITapGestureRecognizer *tapDetectorForLabelCityProvCoun = [
//                    [UITapGestureRecognizer alloc] initWithTarget: self
//                                                           action: @selector(LabelCityProvCounWasTapped)
//                ];
//                tapDetectorForLabelCityProvCoun.numberOfTapsRequired=1;
//
//                [yourLabel addGestureRecognizer: tapDetectorForLabelCityProvCoun];
//
//            // handle the touch tap event inside LabelCityProvCounWasTapped method:
//            -(void)LabelCityProvCounWasTapped
//            {
//              //your code to handle tap
//            }
//
//
//    - call up keyboard by this  on field city of birth     
//            However, you can programmatically display the keyboard for an editable text view
//            by calling that view’s    BECOMEfIRSTrESPONDER   method.
//    - move city of birth field  to right above keyboard
//    - make city of birth field  NOT  hidden
//
//<.>
//
//
//Receiving Keyboard Notifications
//
//When the keyboard is shown or hidden, iOS sends out the following notifications to any registered observers:
//
//    UIKeyboardWillShowNotification
//    UIKeyboardDidShowNotification
//    UIKeyboardWillHideNotification
//    UIKeyboardDidHideNotification
//
//Each keyboard notification includes information about the size and position of the keyboard on the screen.
//You can access this information from the userInfo dictionary of each notification
//using the UIKeyboardFrameBeginUserInfoKey and UIKeyboardFrameEndUserInfoKey keys;
//the former gives the beginning keyboard frame, the latter the ending keyboard frame (both in screen coordinates).
//
//
//Displaying the Keyboard
//
//When the user taps a view, the system automatically designates that view as the first responder. When this happens to a view that contains editable text, the view initiates an editing session for that text. At the beginning of that editing session, the view asks the system to display the keyboard, if it is not already visible. If the keyboard is already visible, the change in first responder causes text input from the keyboard to be redirected to the newly tapped view.
//
//
//Because the keyboard is displayed automatically when a view becomes the first responder,
//you often do not need to do anything to display it.
//However, you can programmatically display the keyboard for an editable text view
//by calling that view’s    BECOMEfIRSTrESPONDER   method.
//Calling this method makes the target view the first responder and
//begins the editing process just as if the user had tapped on the view.
//
//
//If your app manages several text-based views on a single screen, it is a good idea to track which view is currently the first responder so that you can dismiss the keyboard later.
//
//
//Dismissing the Keyboard
//
//Although it typically displays the keyboard automatically, the system does not dismiss the keyboard automatically. Instead, it is your app’s responsibility to dismiss the keyboard at the appropriate time. Typically, you would do this in response to a user action. For example, you might dismiss the keyboard when the user taps the Return or Done button on the keyboard or taps some other button in your app’s interface. Depending on how you configured the keyboard, you might need to add some additional controls to your user interface to facilitate the keyboard’s dismissal.
//
//To dismiss the keyboard, you call the resignFirstResponder method of the text-based view that is currently the first responder. When a text view resigns its first responder status, it ends its current editing session, notifies its delegate of that fact, and dismisses the keyboard. In other words, if you have a variable called myTextField that points to the UITextField object that is currently the first responder, dismissing the keyboard is as simple as doing the following:
//
//[myTextField resignFirstResponder];
//Everything from that point on is handled for you automatically by the text object
//<.>
//
//Listing 5-1 shows the code for registering to receive keyboard notifications and shows the handler methods for those notifications. This code is implemented by the view controller that manages the scroll view, and the scrollView variable is an outlet that points to the scroll view object. The keyboardWasShown: method gets the keyboard size from the info dictionary of the notification and adjusts the bottom content inset of the scroll view by the height of the keyboard. It also sets the scrollIndicatorInsets property of the scroll view to the same value so that the scrolling indicator won’t be hidden by the keyboard. Note that the keyboardWillBeHidden: method doesn’t use the keyboard size; it simply sets the scroll view’s contentInset and scrollIndicatorInsets properties to the default value, UIEdgeInsetsZero.
//
//If the active text field is hidden by the keyboard, the keyboardWasShown: method adjusts the content offset of the scroll view appropriately.
//
//
//     ============== ------------         activeField   ------------------ ======================
//
//The active field is stored in a custom variable (called activeField in this example)
//that is a member variable of the view controller and
//set in the textFieldDidBeginEditing: delegate method, which is itself shown in Listing 5-2.
//(In this example, the view controller also acts as the delegate for each of the text fields.)
//
//
//Listing 5-1  Handling the keyboard notifications
//
//// Call this method somewhere in your view controller setup code.
//- (void)registerForKeyboardNotifications
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//            selector:@selector(keyboardWasShown:)
//            name:UIKeyboardDidShowNotification object:nil];
// 
//   [[NSNotificationCenter defaultCenter] addObserver:self
//             selector:@selector(keyboardWillBeHidden:)
//             name:UIKeyboardWillHideNotification object:nil];
// 
//}
// 
//// Called when the UIKeyboardDidShowNotification is sent.
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
// 
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
// 
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your app might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//
//        [self.scrollView scrollRectToVisible: activeField.frame animated:YES];   // <<<<<<===---
//
//    }
//}
// 
//// Called when the UIKeyboardWillHideNotification is sent
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification
//{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
//}
//
//
//Listing 5-2 shows some additional code used by the view controller to set and clear the activeField variable in the preceding example. During initialization, each text field in the interface sets the view controller as its delegate. Therefore, when a text field becomes active, it calls these methods. For more information on text fields and their delegate notifications, see Managing Text Fields and Text Views.
//
//
//Listing 5-2  Additional methods for tracking the active text field.
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    activeField = textField;
//}
// 
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    activeField = nil;
//}
//
//<.>
//

//  Constants
//  UIBarButtonSystemItemDone          The system Done button.   Localized. image: ../Art/UIBarButtonSystemItemDone.png
//
//  UIBarButtonSystemItemCancel        The system Cancel button. Localized. image: ../Art/UIBarSystemItemCancel.png
//
//  UIBarButtonSystemItemEdit          The system Edit button.   Localized. image: ../Art/UIBarSystemItemEdit.png
//
//  UIBarButtonSystemItemSave          The system Save button.   Localized. image: ../Art/UIBarButtonSystemItemSave.png
//
//  UIBarButtonSystemItemAdd           The system plus button containing an icon of a plus sign. image: ../Art/UIBarButtonAdd.pdf
//
//  UIBarButtonSystemItemFlexibleSpace Blank space to add between other items.
//                                     The space is distributed equally between the other items.
//                                     Other item properties are ignored when this value is set.
//

