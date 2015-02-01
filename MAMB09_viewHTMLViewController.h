//
//  MAMB09_viewHTMLViewController.h
//  Me&myBFFs
//
//  Created by Richard Koskela on 2014-11-19.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface MAMB09_viewHTMLViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *outletWebView;

// all globals
// now in gbl_fromHomeCurrentSelectionPSV
//@property (strong, nonatomic) NSString *fromHomeCurrentSelectionPSV;     // CSV  for per or grp or pair of people
//@property (strong, nonatomic) NSString *fromHomeCurrentSelectionType; // like "group" or "person" or "pair"
//@property (strong, nonatomic) NSString *fromHomeCurrentEntity;        // like "group" or "person" or "member"
//
//// @property (strong, nonatomic) NSString *fromUserSecondPerson;         // CSV  for per or grp or pair of people
//
//
//@property (strong, nonatomic) NSString *selectedYear;           // from selYearViewController  yyyy
//@property (strong, nonatomic) NSString *selectedPersonFromAll;  // from selPersonFromAllViewController
//@property (strong, nonatomic) NSString *selectedGroup;          // from selGroupViewController
//@property (strong, nonatomic) NSString *selectedDay ;           // from selDayViewController  yyyymmdd
//@property (strong, nonatomic) NSString *selectedPersonFromPair; // from selPersonFromPairViewController

//@property (strong, nonatomic) NSString *fromUserYearToDO;             // user-selected year
//@property (strong, nonatomic) NSString *fromUser_YYYYMMDD_ToDO;       // user-selected year

@end
