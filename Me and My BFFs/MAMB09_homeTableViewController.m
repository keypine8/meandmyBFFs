//
//  MAMB09_homeTableViewController.m
//  Me and My BFFs
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

//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    code here
//})pressedChangeGroupName;
//
//When you tap a cell, the willSelectRowAtIndexPath and didSelectRowAtIndexPath are called - supplying you the currently selected NSIndexPath
//– tableView:willSelectRowAtIndexPath:
//– tableView:didSelectRowAtIndexPath:
//– tableView:willDeselectRowAtIndexPath:
//– tableView:didDeselectRowAtIndexPath:

// #import "mamblib.h"
#import "MAMB09_homeTableViewController.h"
#import "MAMB09_selectReportsTableViewController.h"
#import "rkdebug_externs.h"
#import "MAMB09AppDelegate.h"   // to get globals
#import "mamblib.h"



#import <AudioToolbox/AudioToolbox.h>
//AudioServicesPlaySystemSound(1103);  // C functions
//AudioServicesPlaySystemSound(1106);
//AudioServicesPlaySystemSound(1151);
//AudioServicesPlaySystemSound(1000);
//AudioServicesPlaySystemSound(1052);
//AudioServicesPlaySystemSound(1054);
//AudioServicesPlaySystemSound(1111);
//AudioServicesPlaySystemSound(1257);




@interface MAMB09_homeTableViewController ()

//@property (strong, nonatomic)  UILabel *lcl_disclosureIndicatorLabel;  // set in viewDidLoad

@end



    // globals to this source module
    //
    // is this now visible throughout  MAMB09_homeTableViewController.m ?   YES
    //
    NSString *lcl_groupNameToDelete;
    NSInteger lcl_arrayCountBeforeDelete;
    NSInteger lcl_arrayIndexToDelete;
    NSInteger lcl_arrayIndexOfNew_gbl_lastSelectedGroup;




@implementation MAMB09_homeTableViewController

//@synthesize mambyObjectList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLayoutSubviews {  // fill whole screen, no top/leftside gaps  in  webview  THIS WORKED
//    NSLog(@"in home viewDidLayoutSubviews!");

//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length, 0);



    // http://stackoverflow.com/questions/18552416/uiwebview-full-screen-size
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);


//        self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);  // this worked
//   self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44.0);  // infinite loop


//        // put the Toolbar onto bottom of what color view
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self.view addSubview: gbl_toolbarForwBack ];
//        });


//    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"]) { // what color
//        self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44.0);
//    } else {
//        self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }

} // end of viewDidLayoutSubviews 



//No this is not a bug. The behavior is explained here: developer.apple.com/library/ios/#featuredarticles/…
// "When UIKit receives an orientation notification, it uses the UIApplication object and the root view controller
// to determine whether the new orientation is allowed. If both objects agree that the new orientation is supported,
// then the user interface is rotated to the new orientation. Otherwise the device orientation is ignored."
// –  phix23 Oct 15 '12 at 12:19
//The same documentation also mentions the following, so I'm with @TheLearner about being a bug:
// "When a view controller is presented over the root view controller, the system behavior changes in two ways.
// First, the presented view controller is used instead of the root view controller
// when determining whether an orientation is supported"
// –  Oded Ben Dov Feb 19 '13 at 15:52 
//  	 	
//Personally I think this should fall on each view controller to be able to override this method
// as they are the View Controller.
// And by default, an app uses the orientations supported in the Target Summary
// –  Adam Carter Mar 27 '13 at 13:39
//
// - (NSUInteger)supportedInterfaceOrientations
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  NSLog(@"in HOME supportedInterfaceOrientations !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    return UIInterfaceOrientationMaskAll;
    return UIInterfaceOrientationMaskPortrait;

}
- (BOOL)shouldAutorotate {
  NSLog(@"in HOME shouldAutorotate !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return NO;  // means do not call supportedInterfaceOrientations
}

//
////- (void) processDoubleTap
//- (void) processDoubleTap:(UITapGestureRecognizer *)sender
//{
//  NSLog(@"GOT A DOUBLE tap");
//    gbl_scrollToCorrectRow = 1;
//    [self putHighlightOnCorrectRow ];
//}
//


//
//// http://stackoverflow.com/questions/11070874/how-can-i-distinguish-which-part-of-uitableviewcell-has-been-clicked
//// This delegate method determines if the handleTapInCell: method should be executed.
//// If it can find an indexPath from the users touch, then it returns YES otherwise it returns NO.
////
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
return YES;

//    UITableView *tmpTableView = (UITableView *)gestureRecognizer.view;
//    CGPoint p = [gestureRecognizer locationInView: gestureRecognizer.view ];
//    if ([tmpTableView indexPathForRowAtPoint:p]) {
//        return YES;
//    }
//    return NO;
}




//- (void)handleSwipeLeft: (UITapGestureRecognizer *)tap
//{
//tn();
//  NSLog(@"in handleSwipeLeft  in HOME! swipe");
//} // end of handleSwipeLeft


- (void)handleSingleTap :(UITapGestureRecognizer *)tap
{
tn();
  NSLog(@"in handleSingleTap  in HOME! ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
}


- (void)handleDoubleTapInCell:(UITapGestureRecognizer *)tap
{
tn();
  NSLog(@"in handleDoubleTapInCell  in HOME! ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");


    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"])             return;

    if (   [gbl_fromHomeCurrentEntity isEqualToString: @"group"]
        && [gbl_homeUseMODE           isEqualToString: @"report mode" ])   return; 

    // if double tap was in yellow group
    // and in a legal cell,
    // then segue to listmembers
    //

        UITableView *tmpTableView = (UITableView *)tap.view;

        CGPoint p = [tap locationInView: tap.view ];
        NSIndexPath* indexPathTappedIn = [tmpTableView indexPathForRowAtPoint: p ];
  NSLog(@"indexPathTappedIn =[%@]",indexPathTappedIn );
  NSLog(@"indexPathTappedIn.row =[%ld]", (long)indexPathTappedIn.row );



        if (indexPathTappedIn  == nil) return;  // no double tap in a cell


//    UITableViewCell *cellTappedIn = [tmpTableView cellForRowAtIndexPath: indexPathTappedIn ];

        gbl_fromHomeCurrentSelectionPSV = [gbl_arrayGrp objectAtIndex: indexPathTappedIn.row];  /* PSV */

        const char *my_psvc;  // psv=pipe-separated values
        char my_psv[1024], psvName[32];
        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
        strcpy(my_psv, my_psvc);
        strcpy(psvName, csv_get_field(my_psv, "|", 1));
        NSString *myNameOstr =  [NSString stringWithUTF8String:psvName];  // convert c string to NSString

        gbl_fromHomeCurrentEntityName = myNameOstr;  // like "~Anya" or "~Swim Team"

        if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"]) {
            gbl_lastSelectedGroup  = myNameOstr;
        }

  NSLog(@"gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"gbl_fromHomeCurrentEntityName   =[%@]",gbl_fromHomeCurrentEntityName );
  NSLog(@"gbl_lastSelectedGroup           =[%@]",gbl_lastSelectedGroup  );


        // segue to list members on double tap in yellow groups
        //
        gbl_groupMemberSelectionMode = @"none";  // to set this, have to tap "+" or "-" in selPerson

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myappDelegate mamb_beginIgnoringInteractionEvents ];

NSLog(@"sub_view #99");
        dispatch_async(dispatch_get_main_queue(), ^{                                
//                for( UIView *sub_view in [ self.view subviews ] )  // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
            for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
NSLog(@"sub_view =[%@]",sub_view );
NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
                if(sub_view.tag == 34) {
NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
                    [sub_view removeFromSuperview ];
                }
            }
            [self performSegueWithIdentifier: @"segueHomeToListMembers" sender:self]; // selPerson screen where you can "+" or "-" group members
        });



} // end of handleDoubleTapInCell  

//
////
////// Once we have determined if the user has clicked in a cell,
////// the handleTap: method is called,
////// which then decides if the user touched the image, or any other part of the cell.
//////
//- (void)handleSingleTapInCell:(UITapGestureRecognizer *)tap
//{
//tn();
//  NSLog(@"in handleSingleTapInCell  in HOME! ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
//    if (UIGestureRecognizerStateEnded == tap.state)
//    {
//
//        UITableView *tmpTableView = (UITableView *)tap.view;
//
//        CGPoint p = [tap locationInView: tap.view ];
//        NSIndexPath* indexPathTappedIn = [tmpTableView indexPathForRowAtPoint: p ];
//
////        [tmpTableView deselectRowAtIndexPath: indexPathTappedIn animated: NO ];
//
//        UITableViewCell *cellTappedIn = [tmpTableView cellForRowAtIndexPath: indexPathTappedIn ];
//        CGPoint pointInCell = [tap locationInView: cellTappedIn ];
//
//tn(); tr("tapped here in cell      = ");kd(pointInCell.x); kd(pointInCell.y);
//
////<.>
//        // if tap is in area of red delete circle with "-",
//        // then
//        //     move name to right to accomodate big red "Delete" button sliding in from the right
//        //     call delete cell  method
//        //
//        if (pointInCell.x <= 45.0)    // 0.0 - 45.0 within cell = hit area for red circle with "-" on left side of cell
//        {
//            if ( [gbl_homeUseMODE isEqualToString: @"edit mode" ])   // yellow
//            {
//
////        dispatch_async(dispatch_get_main_queue(), ^{
////                 cellTappedIn.textLabel.textAlignment = NSTextAlignmentRight;
//
////nbn(334);
////    NSArray*     rowsToReload = [NSArray arrayWithObjects: indexPathTappedIn , nil ];
////        [self.tableView reloadRowsAtIndexPaths: rowsToReload
////                              withRowAnimation: UITableViewRowAnimationLeft
////        ];
////
////nbn(335);
////
////        }); // end of  dispatch_async(dispatch_get_main_queue()
//
////
////               // name has shifted off or partly off left side of screen
////               // so put label with name 
////               //
//////               UILabel *nameToDeleteLabel = [[UILabel alloc]initWithFrame: CGRectMake(160, 0, 240, 44)];
//////               UILabel *nameToDeleteLabel = [[UILabel alloc]initWithFrame: CGRectMake(130, 0, 285, 44)];
////               UILabel *nameToDeleteLabel = [[UILabel alloc]initWithFrame: CGRectMake(100, 200, 285, 44)];
////               nameToDeleteLabel.text     = cellTappedIn.textLabel.text ;
////
////               nameToDeleteLabel.backgroundColor   = [UIColor redColor];
////               nameToDeleteLabel.textColor   = [UIColor whiteColor];
//////               nameToDeleteLabel.backgroundColor   = gbl_colorEditingBG;
//////               nameToDeleteLabel.textColor   = [UIColor blackColor];
////
////               nameToDeleteLabel.textAlignment = NSTextAlignmentCenter;
////
//////               [cellTappedIn addSubview: nameToDeleteLabel ];
////               [self.tableView addSubview: nameToDeleteLabel ];
////
//
//
////- (void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)  editingStyle  // DELETE METHOD, DELETE METHOD
////                                            forRowAtIndexPath: (NSIndexPath *)                indexPath
//
//
////tn();
////  NSLog(@"SHIFT name TO RIGHT here !");
////        // PROBLEM  name slides left off screen when you hit red round delete "-" button
////        //          and delete button slides from right into screen
////        //
////        // these 2 keep the name on screen when hit red round delete and big delete button slides from right
////        //
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////
////            cellTappedIn.indentationWidth = 12.0; // these 2 keep the name on screen 
//////            cellTappedIn.indentationLevel =  7;   // these 2 keep the name on screen // orig = 3
//////            cellTappedIn.indentationLevel =  9;   // these 2 keep the name on screen // orig = 3
////            cellTappedIn.indentationLevel =  8;   // these 2 keep the name on screen // orig = 3
////
////        }); // end of  dispatch_async(dispatch_get_main_queue()
////
//
////                 cellTappedIn.textLabel.frame.origin.x = cellTappedIn.textLabel.frame.origin.x +  2 * 45.0 ; 
//
////
////                //When users tap the insertion (green plus) control or Delete button associated with a UITableViewCell object in the table view, the table view sends this message to the data source, asking it to commit the change. (If the user taps the deletion (red minus) control, the table view then displays the Delete button to get confirmation.) 
////                //
////                [self commitEditingStyleGUTS: UITableViewCellEditingStyleDelete // DELETE METHOD, DELETE METHOD
////                           forRowAtIndexPath: indexPathTappedIn
////                ];
////
//
//            } // "edit mode"
//
//        } // tapped in cell where x = 0.0 - 45.0
//
////
//
////        CGPoint pointInTableView = [tap locationInView: self.tableView ];
////tn(); tr("tapped here in tableView = ");kd(pointInTableView.x); kd(pointInTableView.y);
//
////
////        // You can use the locationInView: method on UIGestureRecognizer.
////        // If you pass nil for the view, this method will return the location of the touch in the window.
////        //
//////        CGPoint pointInWindow   = [tap locationInView: nil ];
////        CGPoint pointInWindow   = [tap locationInView: self.view ];
////tn(); tr("tapped here in Window    = ");kd(pointInWindow.x); kd(pointInWindow.y);
////tn();
////
//////        if (CGRectContainsPoint(tmpCell.imageView.frame, pointInCell)) {
////        if (       CGRectContainsPoint(tmpCell.textLabel.frame, pointInCell) )
////        {
////  NSLog(@"  // user tapped tmpCell.textLabel");
////
////        } else {
//////            if ( [gbl_homeUseMODE isEqualToString: @"edit mode")   // yellow
//////            && CGRectContainsPoint(tmpCell.textLabel.frame, pointInCell))
//////        }
////  NSLog(@"  // user tapped CELL");
////        }
////
//
//
//
//    } // (UIGestureRecognizerStateEnded == tap.state) 
//
//  NSLog(@"end of  handleSingleTapInCell  in HOME! ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
//tn();
//
//} // end of handleSingleTapInCell:(UITapGestureRecognizer *)tap
//
//


//- (void)handleSingleTapInWindow:(UITapGestureRecognizer *)tap
//{
//tn();
//  NSLog(@"in handleSingleTapInWindow  in HOME! ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
//    if (UIGestureRecognizerStateEnded == tap.state) {
//
//        UITableView *tmpTableView = (UITableView *)tap.view;
//
//        CGPoint p = [tap locationInView: tap.view ];
//        NSIndexPath* indexPath = [tmpTableView indexPathForRowAtPoint: p ];
//
////        [tmpTableView deselectRowAtIndexPath: indexPath animated: NO ];
//
//        // You can use the locationInView: method on UIGestureRecognizer.
//        // If you pass nil for the view, this method will return the location of the touch in the window.
//        //
////        CGPoint pointInWindow   = [tap locationInView: nil ];
//        CGPoint pointInWindow   = [tap locationInView: self.view ];
//tn(); tr("tapped here in Window    = ");kd(pointInWindow.x); kd(pointInWindow.y);
//tn();
//
////        if (CGRectContainsPoint(tmpCell.imageView.frame, pointInCell)) {
//        if (       CGRectContainsPoint(self.view.frame, pointInWindow) )
//        {
//  NSLog(@"  // user tapped tmpCell.textLabel");
//        } else {
////            if ( [gbl_homeUseMODE isEqualToString: @"edit mode")   // yellow
////            && CGRectContainsPoint(tmpCell.textLabel.frame, pointInCell))
////        }
//  NSLog(@"  // user tapped CELL");
//        }
//    }
//}
//




- (void)viewDidLoad
{
    [super viewDidLoad];

    fopen_fpdb_for_debug();

tn();
  NSLog(@"in viewDidLoad   555  in HOME  HOME  ");
//  NSLog(@"gbl_arrayMem HOME viewdidload =[%@]",gbl_arrayMem );
    
nbn(376);
    MAMB09AppDelegate *myappDelegate= (MAMB09AppDelegate *) [[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
    [myappDelegate deleteAll_MAMB_files_fromInbox ]; // del from Inbox dir all "*.mamb"        // clear out for test



//AudioServicesPlaySystemSound(1057);  // tink.caf
//sleep(2);
//AudioServicesPlaySystemSound(1057);  // tink.caf
//sleep(2);
//AudioServicesPlaySystemSound(1057);  // tink.caf
//sleep(2);
//AudioServicesPlaySystemSound(1057);  // tink.caf
//sleep(2);
//
////AudioServicesPlaySystemSound(1029);
////sleep(2);
////AudioServicesPlaySystemSound(1006); 
////sleep(2);
////AudioServicesPlaySystemSound(1007); 
////sleep(2);
////AudioServicesPlaySystemSound(1103);  // C functions
////sleep(2);
////AudioServicesPlaySystemSound(1106);
////sleep(2);
////AudioServicesPlaySystemSound(1151);
////sleep(2);
////AudioServicesPlaySystemSound(1000);
////sleep(2);
////AudioServicesPlaySystemSound(1052);
////sleep(2);
////AudioServicesPlaySystemSound(1054);
////sleep(2);
////AudioServicesPlaySystemSound(1111);
////sleep(2);
////AudioServicesPlaySystemSound(1257);
////
//


    gbl_currentMenuPlusReportCode = @"HOME";  // also set in viewWillAppear for coming back to HOME from other places (INFO ptr)
  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );

//
//    // add a method (handleSwipeLeft) to run on SWIPE LEFT
//    //
//    gbl_swipeLeftGestureRecognizer = [
//        [UISwipeGestureRecognizer alloc] initWithTarget: self
//                                                 action: @selector( handleSwipeLeft: )
//    ];
//    [gbl_swipeLeftGestureRecognizer setDirection: (UISwipeGestureRecognizerDirectionLeft) ];
//    [self.tableView addGestureRecognizer: gbl_swipeLeftGestureRecognizer ];
//
//    self.tableView.allowsMultipleSelectionDuringEditing = NO;  // supposed to support  swipe to delete



//
//    // add a method (processDoubleTap) to run on double tap
//    //
//    gbl_doubleTapGestureRecognizer = [
//       [UITapGestureRecognizer alloc] initWithTarget: self 
//                                              action: @selector( processDoubleTap: )
//    ];
//    [gbl_doubleTapGestureRecognizer    setNumberOfTapsRequired: 2];
//    [gbl_doubleTapGestureRecognizer setNumberOfTouchesRequired: 1];
//    gbl_doubleTapGestureRecognizer.delaysTouchesBegan = YES;       // for uitableview
//    [self.tableView addGestureRecognizer: gbl_doubleTapGestureRecognizer ];
//

//
//    // to avoid tap in widened section index to act like a tap of cell
//    // when tapping on left side of section index 8 chars wide ("___TOP__")
//    //
//    UITapGestureRecognizer *singleTapInCell = [[UITapGestureRecognizer alloc] initWithTarget: self
//                                                                                      action: @selector( handleSingleTapInCell: )
//    ];
//    singleTapInCell.delegate                = self;
//    singleTapInCell.numberOfTapsRequired    = 1;
//    singleTapInCell.numberOfTouchesRequired = 1;
//    singleTapInCell.cancelsTouchesInView    = NO;
//
//    [self.tableView addGestureRecognizer: singleTapInCell];
//

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:    self action:@selector(handleSingleTap:)] ;
    singleTap.numberOfTapsRequired = 1; 
    [self.view addGestureRecognizer: singleTap];

    UITapGestureRecognizer *doubleTapInCell = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                                      action: @selector( handleDoubleTapInCell: )
    ];
    doubleTapInCell.delegate                = self;
    doubleTapInCell.numberOfTapsRequired    = 2;
    doubleTapInCell.numberOfTouchesRequired = 1;
    doubleTapInCell.cancelsTouchesInView    = NO;

    [self.tableView addGestureRecognizer: doubleTapInCell ];

    [singleTap requireGestureRecognizerToFail: doubleTapInCell ];


//    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
//    SEL mySelector = @selector(selfhandleSingleTapInWindow );

//    UITapGestureRecognizer *singleTapInWindow = [[UITapGestureRecognizer alloc] initWithTarget: mainWindow

//    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
//
//    UITapGestureRecognizer *singleTapInWindow = [[UITapGestureRecognizer alloc] initWithTarget: self
//                                                                                        action: @selector ( handleSingleTapInWindow: )
//    ];
//    singleTapInWindow.delegate = self;
//    singleTapInWindow.numberOfTapsRequired = 1;
//    singleTapInWindow.numberOfTouchesRequired = 1;
//    [self.view addGestureRecognizer: singleTapInWindow];
//
//
////
////// Actually UIWindow is subclass of UIView, that means you can add a gesture recognizer to it.
////// But how to make sure this will not have influence on real content of your app ?
//////
////// Make AppDelegate the delegate of UIGestureRecognizer that you just added, and override shouldReceiveTouch as follows:
//////
////- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
////{
////  NSLog(@"touch at %@", NSStringFromCGPoint([touch locationInView:touch.view]));
////  return NO;
////}
////
//

//
//
////    UITapGestureRecognizer *singleTapInWindow = [[UITapGestureRecognizer alloc] initWithTarget: self.super.view
////                                                                                      action: @selector( handleSingleTapInCell: )
////    ];
////
//
//

//    gbl_lastClick = [[[NSDate alloc] init] timeIntervalSince1970];

//    WWW width=[240.930176]
//    MMM width=[217.023926]
//
//CGSize siz = [@"WWWWWWWWWWWWWWW" sizeWithAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
//  NSLog(@"WWW width=[%f]",siz.width);
//       siz = [@"MMMMMMMMMMMMMMM" sizeWithAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
//  NSLog(@"MMM width=[%f]",siz.width);
//



 [ self shouldAutorotate ];
 [ self supportedInterfaceOrientations ];

    gbl_justAddedPersonRecord = 0;  // do not reload home array
    gbl_justAddedGroupRecord  = 0;  // do not reload home array

    self.tableView.allowsSelectionDuringEditing = YES;

    [self.navigationController.navigationBar setTranslucent: NO];
//     self.navigationController.navigationBar.barTintColor = [UIColor blueColor] ;
     self.navigationController.navigationBar.barTintColor = gbl_color_cAplTop;


    // assign height of tableview rows here
    


// try to reduce load time of first cal yr report   

//UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
//webView.delegate = self;   
//
//
//    [self.webView setUserInteractionEnabled:NO];
//    [self.webView loadHTMLString:finalString baseURL:nil];
//
//    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 1024,768)];
//    NSString *url=@"http://www.google.com";
//    NSURL *nsurl=[NSURL URLWithString:url];
//    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
//    [webview loadRequest:nsrequest];
//    [self.view addSubview:webview];
//
//

//
////    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
//
////    NSString *stringForHTML = @"X";
////    [webview loadHTMLString: stringForHTML   baseURL: nil];
//    [webview loadHTMLString: [NSString stringWithFormat:@"<html><body>X</body></html>"]  baseURL: nil];
//
//    [self.view addSubview:webview];
//nbn(5);
//

//    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
//    NSURLRequest *nsrequest=[NSURLRequest requestWithURL: nil];
//    [webview loadRequest: nsrequest];


//   UIWebView *webview =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
//   NSString *someHTML = [webview stringByEvaluatingJavaScriptFromString:@""];   




    // try to reduce load time of first cal yr report    this WORKED!
    // this WORKED!
    //
tn();
  NSLog(@"BEG  use javascript to  grab document.title - to try to reduce load time of first cal yr report   ");
    UIWebView *tmpwebview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 11, 11)];
    NSString *xtitle   = [tmpwebview stringByEvaluatingJavaScriptFromString:@"document.title"];  
  NSLog(@"END  use javascript to  grab document.title - to try to reduce load time of first cal yr report   ");
  NSLog(@"xtitle   =[%@]",xtitle   );
    //
    // this WORKED!




    // doStuffOnEnteringForeground sets these 3 from lastEntityStr
    //
    //   gbl_fromHomeCurrentEntity        
    //   gbl_fromHomeCurrentSelectionType
    //   gbl_lastSelectionType          
    //
//    gbl_fromHomeCurrentEntity        = @"person";  // set default on startup
//    gbl_fromHomeCurrentSelectionType = @"person";  // set default on startup
//    gbl_lastSelectionType            = @"person";  // set default on startup


  NSLog(@"EDIT BUTTON 1   gbl_homeUseMODE = @regular mode; ");
  NSLog(@"gbl_homeUseMODE 1   =[%@]",gbl_homeUseMODE );

    gbl_homeUseMODE = @"report mode";  // determines home mode  "edit mode" or "report mode"
  NSLog(@"gbl_homeUseMODE 2   =[%@]",gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
    // gbl_homeEditingState;  // if gbl_homeUseMODE = "edit mode" then either "add" or "view or change"   for tapped person or group

//    gbl_home_cell_AccessoryType        = UITableViewCellAccessoryDisclosureIndicator; // home mode regular with tap giving report list
//    gbl_home_cell_editingAccessoryType = UITableViewCellAccessoryNone;                // home mode regular with tap giving report list

    gbl_currentMenuPrefixFromHome    = @"homp";    // set default on startup



        //// start DO STUFF HERE


    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    

   
//
//        // UILabel for the disclosure indicator, ">",  for tappable cells
//        //
//        // set this up here since its used in cellForRow   over and over
//        //
////            NSString *myDisclosureIndicatorBGcolorName; 
////            NSString *myDisclosureIndicatorText; 
////            UIColor  *colorOfGroupReportArrow; 
////            UIFont   *myDisclosureIndicatorFont; 
//
////            colorOfGroupReportArrow   = [UIColor lightGrayColor];                 // blue background
////            colorOfGroupReportArrow   = [UIColor grayColor];                 // blue background
////            colorOfGroupReportArrow   = [UIColor redColor];                 // blue background
////            myDisclosureIndicatorFont = [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0]; // good
//
//tn();trn("arrow = red !");
//            NSAttributedString *myNewCellAttributedText3 = [
//                [NSAttributedString alloc] initWithString: @">"  
//                                               attributes: @{
//                        NSFontAttributeName :  [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0] ,  
//                        NSForegroundColorAttributeName: [UIColor redColor ]  
//                    }
//            ];
//
//            _lcl_disclosureIndicatorLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
//            _lcl_disclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
//            _lcl_disclosureIndicatorLabel.backgroundColor = gbl_colorReportsBG; 
////            lcl_disclosureIndicatorLabel.backgroundColor = [UIColor redColor];      
//        //
//        // end of  UILabel for the disclosure indicator, ">",  for tappable cells
//





    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // 

//    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: self.editButtonItem]; // ADD EDIT BUTTON

    // set up the two nav bar arrays, one with + button for add a record, one without
    //
            // try with always add button
    //
    if (gbl_haveSetUpHomeNavButtons == 0) {
nbn(100);
        gbl_haveSetUpHomeNavButtons = 1;


        UIBarButtonItem *navAddButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                                                                    target: self
                                                                                    action: @selector(navAddButtonAction:)];

//        UIImage *iconImage = [UIImage imageNamed: @"rounded_MAMB09_029.png"];
//        iconImage          = [iconImage imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
//        UIBarButtonItem *iconButton = [[UIBarButtonItem alloc] initWithImage: iconImage 
//                                                                       style: UIBarButtonItemStylePlain
//                                                                      target: self
//                                                                      action: nil
//        ];
//

//        UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rounded_MAMB09_029.png"]];
//        myImageView.frame = CGRectMake(0, 0, 30, 30);
//        UIBarButtonItem *iconButton = [[UIBarButtonItem alloc] initWithCustomView: myImageView];
//





        //        navAddButton.tintColor = [UIColor blackColor];   // colors text


//        gbl_homeLeftItemsWithAddButton = [NSMutableArray arrayWithArray: self.navigationItem.leftBarButtonItems ];

        dispatch_async(dispatch_get_main_queue(), ^{

            // try with always add button

            // self.navigationItem.leftBarButtonItems  = gbl_homeLeftItemsWithNoAddButton;
//            self.navigationItem.leftBarButtonItems     = gbl_homeLeftItemsWithAddButton;



            // at startup, add left top app icon button
            //
            self.navigationItem.leftBarButtonItem  = nil; 
            self.navigationItem.leftBarButtonItem  = gbl_icon_UIBarButtonItem;
            self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItems  arrayByAddingObject: navAddButton];



//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 44)];  // 3rd arg is horizontal length
//        spaceView.backgroundColor = [UIColor redColor];  // make visible for test
//            UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView: spaceView];
//            UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 44)];  // 3rd arg is horizontal length

  NSLog(@"EDIT BUTTON 1   set title  edit tab");

//           self.editButtonItem.title = @"";

//            UIView *tmpView = (UIView *)[self.editButtonItem performSelector:@selector(view)];
//            tmpView.layer.backgroundColor = [[UIColor clearColor] CGColor];

//            [self.editButtonItem  setTitleTextAttributes: @{
////                                     NSFontAttributeName: [UIFont fontWithName:@"Menlo-Bold" size: 19.0],
//                                     NSFontAttributeName: [UIFont fontWithName:@"Menlo-bold"  size: 11.0]
////                                     ,
////                          NSForegroundColorAttributeName: [UIColor blackColor ],
////                          NSBackgroundColorAttributeName: [UIColor cyanColor ]
//                                  }
//                                                forState: UIControlStateNormal
//            ];
//


//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-16.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 
//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-12.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 


//            [self.editButtonItem setImage: gbl_yellowEdit          // edit mode bg color for button
//            ];

            //            [self.editButtonItem setImage: nil        /vi
            // edit mode bg color for button
//            ];



//    self.editButtonItem.title = nil;   // this gets rid of left/right shift of Edit/Done buttons when pressed

//
//    // this gets set below to Edit or Done button image
//    [self.editButtonItem setImage:  [[UIImage alloc] init]];     // edit mode bg color for button



  NSLog(@"EDIT BUTTON 1   set yellow          ");
nbn(500);
            [self.editButtonItem setImage: gbl_yellowEdit ];     // edit mode bg color for button
            self.navigationItem.rightBarButtonItems =   // "editButtonItem" is magic Apple functionality
            [self.navigationItem.rightBarButtonItems arrayByAddingObject: self.editButtonItem]; //editButtonItem=ADD apple-provided EDIT BUTTON




        }); // end of  dispatch_async(dispatch_get_main_queue()

    } // end of   set up the two nav bar arrays, one with + button for add a record, one without



        // [myButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
//        [self.editButtonItem.titleLabel setTextAlignment: NSTextAlignmentCenter];

              // try this:
              //
              // barButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 14.0f]; // right adj
//           UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 16.0f]; // too big
//           UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 15.0f]; // right adj
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 18.0f];
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 14.0f];
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 16.0f]; // right adjust
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 17.0f]; // too  big
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica-Light" size: 17.0f]; // too big
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica-Light" size: 16.0f]; // right adjust
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica" size: 16.0f];  // right adj
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica" size: 18.0f];  // too big
//            UIFont *font1 = [UIFont fontWithName:@"Helvetica" size: 17.0f];  // too big
//            [self.editButtonItem setTitleTextAttributes:
//                                                         [NSDictionary dictionaryWithObjectsAndKeys:
//                                                             gbl_colorEditingBG, NSBackgroundColorAttributeName,
//                                                                          font1, NSFontAttributeName,
//                                                             nil
//                                                         ]
//                                               forState: UIControlStateNormal
//            ];


            // [[UIBarButtonItem appearance] setTitlePositionAdjustment: UIOffsetMake(0.0f, 5.0f)  forBarMetrics: UIBarMetricsDefault];
//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-6.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault];
//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-16.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // just right






//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItems arrayByAddingObject: addButton ];
//        });


//    // info button is there already so add Edit button with  arrayByAddingObject:
//    // 
//    UIBarButtonItem *myEditButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemEdit
//                                                                                  target: self      
//                                                                                  action: @selector(pressedEditButtonAction:)  ];
//    //
//    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myEditButton];
//



    [[NSNotificationCenter defaultCenter] addObserver: self  // run method doStuffOnEnteringForeground()  when entering Foreground
                                             selector: @selector(doStuffOnEnteringForeground)
                                                 name: UIApplicationWillEnterForegroundNotification
                                               object: nil  ];

nbn(14);
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(doStuffOnSignificantTimeChange)
                                                 name: UIApplicationSignificantTimeChangeNotification
                                               object: nil  ];

nbn(15);

    BOOL haveGrp, havePer, haveMem, haveGrpRem, havePerRem;


//
//// this works for getting the current date from internet   BUT  deprecated
//  NSLog(@"start getting date real");
//
//NSMutableURLRequest *myrequest = [[NSMutableURLRequest alloc]
//                                initWithURL:[NSURL URLWithString:@"http://google.com" ]];
//[myrequest setHTTPMethod:@"GET"];
//NSHTTPURLResponse *myhttpResponse = nil;
//[NSURLConnection sendSynchronousRequest:myrequest returningResponse:&myhttpResponse error:nil];
//NSString *mydateString = [[myhttpResponse allHeaderFields] objectForKey:@"Date"];
////NSDate *gooCurrentDate = [NSDate dateWithNaturalLanguageString:dateString locale:NSLocale.currentLocale];
////  NSLog(@"gooCurrentDate =[%@]",gooCurrentDate );
//  NSLog(@"mydateString =[%@]",mydateString );
//
//
//

    NSError *err01;


//        // remove all "*.txt" files from TMP directory before creating new one
//        //
//        NSArray *docFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: gbl_appDocDirStr error:NULL];
//        NSLog(@"docFiles.count=%lu",(unsigned long)docFiles.count);
//                for (NSString *fil in docFiles) {
//            NSLog(@"fil=%@",fil);
//            if ([fil hasSuffix: @"txt"]) {
//                NSLog(@"remove this txt    fil=%@",fil);
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", gbl_appDocDirStr, fil] error: &err01];
//                if (err01) { NSLog(@"error on rm fil %@ = %@", fil, err01 ); }
//            }
//            if ([fil hasPrefix: @"mambd"] || [fil hasPrefix: @"mambG"]    ) {
//                 NSLog(@"remove this mambd  fil=%@",fil);
//                //[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), fil] error: &err01];
//                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", gbl_appDocDirStr, fil] error: &err01];
//                if (err01) { NSLog(@"error on rm fil %@ = %@", fil, [err01 localizedFailureReason]); }
//            }
//        }
//












//
//
//    //   for test   TO SIMULATE first downloading the app-  when there are no data files
//    //   FOR test   remove all regular named files   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//    //
//    NSLog(@" FOR test   BEG   remove all regular named files   xxxxxxxxxx ");
//    [gbl_sharedFM removeItemAtURL: gbl_URLToLastEnt    error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm lastent %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToGroup      error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm group   %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToPerson     error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm person  %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToMember     error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm Member  %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToGrpRem     error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm GrpRem  %@", [err01 localizedFailureReason]); }
//    [gbl_sharedFM removeItemAtURL: gbl_URLToPerRem     error: &err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"rm PerRem  %@", [err01 localizedFailureReason]); }
//    NSLog(@" FOR test   END   remove all regular named files   xxxxxxxxxx ");
//    // end of   FOR test   remove all regular named files   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
//













//    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m


    haveGrp    = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
    havePer    = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
    haveMem    = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGrpRem];
    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerRem];




//    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m


    haveGrp    = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
    havePer    = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
    haveMem    = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGrpRem];
    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerRem];

tn();tr("test before check data files ");
ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);

    if ( haveGrp && havePer && haveMem ) {   // good to go
        NSLog(@"%@", @"use regular files!");

    } else {   // INIT with example data    (here  at least one  have = NO )

       // possibly implement later 
        //        if (haveGrp && havePer && !haveMem) {
        //            NSLog (@"building member file from other files");
        //            //  TODox
        //            // without this done,  here you lose all  members from all groups 
        //        } 
        //        else if (!haveGrp && havePer && haveMem) {
        //            NSLog (@"building group file from other files");
        //            //  TODOx
        //            // without this done,  here you lose all  groups 
        //        } else {
        //        }
        //

        NSLog(@"%@", @"use example data arrays!");

        // delete all data files, if present, and write and use example data arrays
        //
        if (!havePer) {

            //      remove all data named files (these cannot exist - no overcopy)
            [gbl_sharedFM removeItemAtURL: gbl_URLToGroup error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm group %@",  err01); }
            [gbl_sharedFM removeItemAtURL: gbl_URLToPerson error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm person %@", err01); }
            [gbl_sharedFM removeItemAtURL: gbl_URLToMember error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm member %@", err01); }
            [gbl_sharedFM removeItemAtURL: gbl_URLToGrpRem error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm grprem %@", err01); }
            [gbl_sharedFM removeItemAtURL: gbl_URLToPerRem error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error in rm perrem %@", err01); }

            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplegroup"];   // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayGrp%@",gbl_arrayGrp);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"exampleperson"];  // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayPer=%@",gbl_arrayPer);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplemember"];  // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayMem=%@",gbl_arrayMem);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"examplegrprem"];  // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayGrpRem=%@",gbl_arrayGrpRem);
            [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"exampleperrem"];  // write on init app
//    NSLog(@"home1viewDidLoad  gbl_arrayPerRem=%@",gbl_arrayPerRem);

        }
    } // check data files

//tn();tr("HOME   test after  check data files ");
//    haveGrp = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
//    havePer = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
//    haveMem = [gbl_sharedFM fileExistsAtPath: gbl_pathToMember];
//    haveGrpRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToGroup];
//    havePerRem = [gbl_sharedFM fileExistsAtPath: gbl_pathToPerson];
//    ki(haveGrp); ki(havePer); ki(haveMem); ki(haveGrpRem); kin(havePerRem);
//


    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"group"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"person"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"member"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"grprem"];
    [myappDelegate mambReadArrayFileWithDescription: (NSString *) @"perrem"];



//
//    // read data files  with regular names into arrays
//    // and sort the arrays in place by name
//    //




//    // test check full load after app 1st downloaded
//tn();trn(" HOME   AFTER READ   BEFORE SORT  data files ");
//    NSLog(@"home2viewDidLoad  gbl_arrayGrp=%@",gbl_arrayGrp);
//    NSLog(@"home2viewDidLoad  gbl_arrayPer=%@",gbl_arrayPer);
//    NSLog(@"home2viewDidLoad  gbl_arrayMem=%@",gbl_arrayMem);
//    NSLog(@"home2viewDidLoad  gbl_arrayGrpRem=%@",gbl_arrayGrpRem);
//    NSLog(@"home2viewDidLoad  gbl_arrayPerRem=%@",gbl_arrayPerRem);
//



    if (gbl_arrayGrp)    { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"group"]; }
    if (gbl_arrayPer)    { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"person"]; }
    if (gbl_arrayMem)    { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; }
    if (gbl_arrayGrpRem) { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"grprem"]; }
    if (gbl_arrayPerRem) { [myappDelegate  mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"perrem"]; }



//    // test
//tn();trn(" HOME   AFTER read data files (1)   with regular names into arrays // and sort the arrays in place by name");
//    NSLog(@"home2viewDidLoad  gbl_arrayGrp=%@",gbl_arrayGrp);
//    NSLog(@"home2viewDidLoad  gbl_arrayPer=%@",gbl_arrayPer);
//    NSLog(@"home2viewDidLoad  gbl_arrayMem=%@",gbl_arrayMem);
//    NSLog(@"home2viewDidLoad  gbl_arrayGrpRem=%@",gbl_arrayGrpRem);
//    NSLog(@"home2viewDidLoad  gbl_arrayPerRem=%@",gbl_arrayPerRem);
//

//  for test,   show all person records
tn();trn(" HOME   AFTER read data files (2)  with regular names into arrays // and sort the arrays in place by name");
        for (id perRec in gbl_arrayPer) {
//           NSLog(@"%@", perRec);
           NSLog(@"      @\"%@\",", perRec); // 20170215  put same format as in appdel.m

//        const char *my_perRec_cc;  // psv=pipe-separated values
//        my_perRec_cc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
//        char my_perRec_c[1024];
//        strcpy(my_perRec_c, my_perRec_c);
//ksn(my_perRec_c);
//<.>
//        const char *my_psvc;  // psv=pipe-separated values
//        my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
//        char my_psv[1024];
//        strcpy(my_psv, my_psvc);
//<.>
        }


// exit(1);  // for test do just once
// //break;  // for test, continue


    // check for data corruption  (should not happen)
    //
    NSInteger myCorruptDataErrNum;
    do {


        myCorruptDataErrNum =  [myappDelegate mambCheckForCorruptData ];  //  < --------------------------------------

  NSLog(@"myCorruptDataErrNum =[%ld]",(long)myCorruptDataErrNum );



        if (myCorruptDataErrNum > 0) {

            // got data errors here

  NSLog(@"myCorruptDataErrNum =[%ld]",(long)myCorruptDataErrNum );

            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myappDelegate mamb_beginIgnoringInteractionEvents ];


            // delete all non-example data from people, groups and members
            //
            // now delete from each gbl_arrayXxx  the non-example data
            // by  going backwards from the highest index to delete to the lowest
            //
//ksn("yyyyyy");
//NSLog(@"mem=[%@]", NSStringFromClass([gbl_arrayMem class]));   // showed nsarrayM   // this happened on an original ipad retinas
//NSLog(@"per=[%@]", NSStringFromClass([gbl_arrayPer class]));   // showed nsarrayM
//NSLog(@"grp=[%@]", NSStringFromClass([gbl_arrayGrp class]));   // showed nsarrayI  <--immutable
            
            for (NSInteger i = gbl_arrayMem.count - 1;  i >= 0;  i--) {
                if ([gbl_arrayMem[i] hasPrefix: @"~"]) continue; 
                [gbl_arrayMem removeObjectAtIndex: i ];
            }
            for (NSInteger i = gbl_arrayPer.count - 1;  i >= 0;  i--) {
                if ([gbl_arrayPer[i] hasPrefix: @"~"]) continue; 
                [gbl_arrayPer removeObjectAtIndex: i ];
            }
//NSLog(NSStringFromClass([gbl_arrayMem class]));
//NSLog(NSStringFromClass([gbl_arrayPer class]));
//NSLog(NSStringFromClass([gbl_arrayGrp class]));
            for (NSInteger i = gbl_arrayGrp.count - 1;  i >= 0;  i--) {
                if ([gbl_arrayGrp[i] hasPrefix: @"~"]) continue; 
                [gbl_arrayGrp removeObjectAtIndex: i ];
            }


            // write app-startup initial data arrays to files
            //
            [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"group" ]; // write new array data to file
            [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"group" ]; // read new data from file to array
            [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"group" ]; // sort array by name


            [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"person"]; // write new array data to file
            [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"person"]; // read new data from file to array
            [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"person"]; // sort array by name

            [myappDelegate mambWriteNSArrayWithDescription:              (NSString *) @"member"]; // write new array data to file
            [myappDelegate mambReadArrayFileWithDescription:             (NSString *) @"member"]; // read new data from file to array
            [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"member"]; // sort array by name


            [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.5 ];   


//
//            // http://stackoverflow.com/questions/25962559/uialertcontroller-text-alignment
//            //
//            // I have successfully used the following, for both aligning and styling the text of UIAlertControllers:
//            // 
//            // let paragraphStyle = NSMutableParagraphStyle()
//            // paragraphStyle.alignment = NSTextAlignment.Left
//            // 
//            // let messageText = NSMutableAttributedString(
//            //     string: "The message you want to display",
//            //     attributes: [
//            //         NSParagraphStyleAttributeName: paragraphStyle,
//            //         NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody),
//            //         NSForegroundColorAttributeName : UIColor.blackColor()
//            //     ]
//            // )
//            // 
//            // myAlert.setValue(messageText, forKey: "attributedMessage")
//            // You can do a similar thing with the title, if you use "attributedTitle", instead of "attributedMessage"
//            // 
//            // Eduardo 3,901
//            //   	 	
//            // Seems like this is private API use, did this make it into the App Store? – powerj1984 Jul 6 '15 at 14:10
//            // @powerj1984 yes, it did. – Eduardo Jul 6 '15 at 15:02
//            //
// 
//
//
//  Use this code instead       [self.navigationController presentViewController: myAlert  animated: YES  completion: nil ];



            // want left-justified alert text for long msg
            //
//   //#define FONT_SIZE 20
//   //#define FONT_HELVETICA @"Helvetica-Light"
//   //#define BLACK_SHADOW [UIColor colorWithRed:40.0f/255.0f green:40.0f/255.0f blue:40.0f/255.0f alpha:0.4f]
//   //NSString*myNSString = @"This is my string.\nIt goes to a second line.";                
//   
//   NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//                  paragraphStyle.alignment = NSTextAlignmentCenter;
//   //             paragraphStyle.lineSpacing = FONT_SIZE/2;
//   //             paragraphStyle.lineSpacing = -5;
//   
//   //                     UIFont * labelFont = [UIFont fontWithName:Menlo size: 16.0];
//   //                   UIColor * labelColor = [UIColor colorWithWhite:1 alpha:1];
//   //                       NSShadow *shadow = [[NSShadow alloc] init];
//   //                 [shadow setShadowColor : BLACK_SHADOW];
//   //                [shadow setShadowOffset : CGSizeMake (1.0, 1.0)];
//   //            [shadow setShadowBlurRadius : 1 ];
//   
//   //NSAttributedString *labelText = [[NSAttributedString alloc] initWithString :  myNSString
//   //       *myAttrString = [[NSAttributedString alloc] initWithString : mylin   // myNSString
//          myAttrString = [[NSMutableAttributedString alloc] initWithString : mylin   // myNSString
//              attributes : @{
//                  NSParagraphStyleAttributeName : paragraphStyle,
//   //                         NSFontAttributeName : compFont_16 
//                            NSFontAttributeName : compFont_14 
//   //               NSBaselineOffsetAttributeName : @-1.0
//              }
//          ];
//   //                 NSKernAttributeName : @2.0,
//   //                 NSFontAttributeName : labelFont
//   //      NSForegroundColorAttributeName : labelColor,
//   //              NSShadowAttributeName : shadow
//


            // want left-justified alert text for long msg
            //
            NSString *mymsg;
            mymsg = @"When corrupt data is found, the App has to delete all of your added people, groups and group members.\n\n   RECOVERY of DATA \n\nMethod 1:  Assuming you did backups, go to your latest email having the subject \"Me and My BFFs BACKUP\".  Follow the instructions in the email to restore the data.\n\nMethod 2:  Delete the App \"Me and My BFFs\" and install it again from the App store.  Doing this might restore the data for people, groups and members from apple backups.";

            NSMutableParagraphStyle *myParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            myParagraphStyle.alignment                = NSTextAlignmentLeft;

            NSMutableAttributedString *myAttrMessage;
            myAttrMessage = [[NSMutableAttributedString alloc] initWithString : mymsg   // myNSString
                attributes : @{
                    NSParagraphStyleAttributeName : myParagraphStyle,
//                   NSBackgroundColorAttributeName : gbl_color_cRed,
                              NSFontAttributeName : [UIFont boldSystemFontOfSize: 12.0]
                }
            ];
//            // myAlert.setValue(messageText, forKey: "attributedMessage")



            UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Found Corrupt Data"
                                                                           message: mymsg
                                                                    preferredStyle: UIAlertControllerStyleAlert  ];
             
            [myAlert setValue: myAttrMessage  forKey: @"attributedMessage" ];

            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                style: UIAlertActionStyleDefault
                                                              handler: ^(UIAlertAction * action) {
                NSLog(@"Ok button pressed    for corrupt data");
            } ];
             
            [myAlert addAction:  okButton];

            // was using this:
            //[self presentViewController: myAlert  animated: YES  completion: nil   ];
            //
            // but was getting this:   Warning :-Presenting view controllers on detached view controllers is discouraged
            //
            // finally, this got rid of the warning:
            //
            [self.navigationController presentViewController: myAlert  animated: YES  completion: nil ];

            // tried all these:
            //
            // To avoid getting the warning in a push navigation, you can directly use :
            // 
            // [self.view.window.rootViewController presentViewController:viewController animated:YES completion:nil];
            // And then in your modal view controller, when everything is finished, you can just call :
            // 
            // [self dismissViewControllerAnimated:YES completion:nil];
            //
            //[self.view.window.rootViewController presentViewController:viewController animated:YES completion:nil];
            //[self.view.window.rootViewController presentViewController: myAlert  animated: YES  completion: nil ];
            //
            // run on rootviewcontroller
            //            id rootVC = [[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];
            //            [rootViewController presentViewController: myAlert  animated: YES  completion: nil ];
            //You can access it using the below code if the rootViewController is a UIViewController
            //
            //ViewController *rootController=(ViewController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
            //But if it's a UINavigationController you can use the code below.
            //
            //UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
            //ViewController *rootController=(ViewController *)[nav.viewControllers objectAtIndex:0];
            //
            //        UINavigationController *nav=(UINavigationController *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
            //nbn(2); 
            //        ViewController *rootController=(ViewController *)[nav.viewControllers objectAtIndex:0];
            //nbn(3); 
            //       [rootController presentViewController: myAlert  animated: YES  completion: nil ];
            //
            //    [sourceViewController.navigationController.view.layer addAnimation: transition 
            //    self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar is NOT visible 


        } // got corrupt data


    } while (FALSE);  // check for data corruption  (should not happen)




//trn("hey");    // ONE TIME TEST
//  NSLog(@"gbl_recOfAllPeopleIhaveAdded =[%@]",gbl_recOfAllPeopleIhaveAdded );
//    [gbl_arrayGrp   addObject: gbl_recOfAllPeopleIhaveAdded ];  // for text <.>  add all people    TODO  
//    [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription: (NSString *) @"group" ]; // sort array by name  // for text <.>  add all people    TODO  





    [self doStuffOnEnteringForeground];  // read   lastEntity stuff




    // for test  LOOK AT all files in doc dir
    NSArray *docFiles2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: gbl_appDocDirStr error:NULL];
  NSLog(@"docFiles2.count=%lu",(unsigned long)docFiles2.count);
    for (NSString *fil in docFiles2) { NSLog(@"doc fil=%@",fil); }
    // for test  LOOK AT all files in doc dir




// comment out       for test create empty Launch screen shot 
    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex or not after switch




//  NSLog(@"gbl_arrayMem HOME viewdidload BOTTOM =[%@]",gbl_arrayMem );

} // - (void)viewDidLoad




- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"The App received a Memory Warning"
//                                                    message: @"The system has determined that the \namount of available memory is very low."
//                                                   delegate: nil
//                                          cancelButtonTitle: @"OK"
//                                          otherButtonTitles: nil];
//
//    [alert show];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //return 0;
    return 1;
} // numberOfSectionsInTableView



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"in numberOfRowsInSection");
    // Return the number of rows in the section.

  NSLog(@"gbl_lastSelectionType     =[%@]",gbl_lastSelectionType );
  NSLog(@"gbl_ExampleData_show      =[%@]",gbl_ExampleData_show );
  NSLog(@"gbl_arrayGrp.count        =[%ld]",(long)gbl_arrayGrp.count);
  NSLog(@"gbl_ExampleData_count_grp =[%ld]",(long)gbl_ExampleData_count_grp );
  NSLog(@"gbl_arrayGrp              =[%@]",gbl_arrayGrp);

    if ([gbl_lastSelectionType isEqualToString:@"group"]) 
    {
        if ([gbl_ExampleData_show isEqualToString: @"yes"] )     
        {
nbn(200);
           gbl_numRowsToDisplayFor_grp = gbl_arrayGrp.count;
        } else {
nbn(201);
           // Here we do not want to show example data.
           // Because example data names start with "~", they sort last,
           // so we can just reduce the number of rows to exclude example data from showing on the screen.
           gbl_numRowsToDisplayFor_grp = gbl_arrayGrp.count - gbl_ExampleData_count_grp ;
        }
  NSLog(@"gbl_numRowsToDisplayFor_grp  return =[%ld]",(long)gbl_numRowsToDisplayFor_grp  );
        return gbl_numRowsToDisplayFor_grp;
    }

    if ([gbl_lastSelectionType isEqualToString:@"person"])
    {
        if ([gbl_ExampleData_show isEqualToString: @"yes"] )     
        {
           gbl_numRowsToDisplayFor_per = gbl_arrayPer.count;
        } else {
           // Here we do not want to show example data.
           // Because example data names start with "~", they sort last,
           // so we can just reduce the number of rows to exclude example data from showing on the screen.
           gbl_numRowsToDisplayFor_per = gbl_arrayPer.count - gbl_ExampleData_count_per ;
        }
  NSLog(@"gbl_numRowsToDisplayFor_per  return =[%ld]",(long)gbl_numRowsToDisplayFor_per  );
        return gbl_numRowsToDisplayFor_per;
    }
    return 1;  // should not happen

} // numberOfRowsInSection


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//  NSLog(@"in cellForRowAtIndexPath in HOME");
//  NSLog(@"indexPath.row =[%ld]",(long)indexPath.row );

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"MyCell1";
    
    // check to see if we can reuse a cell from a row that has just rolled off the screen
    // if there are no cells to be reused, create a new cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


    //   cell.selectedBackgroundView =  gbl_myCellBgView ;  // get my own background color for selected rows (see MAMB09AppDelegate.m)

//    NSLog(@"in cellForRowAtIndexPath 2222");
//    NSLog(@"all array[%@]", mambyObjectList);
//    NSLog(@"current  row=[%@]", [mambyObjectList objectAtIndex:indexPath.row]);




    // set the text attribute to the name of
    // whatever we are currently looking at in our array
    // name is 1st element in csv
    //
    // NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
    //
    NSString *currentLine, *nameOfGrpOrPer;

    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
        gbl_colorDIfor_home = gbl_colorSepara_grp ;
        currentLine = [gbl_arrayGrp objectAtIndex: indexPath.row];
    } else {
        if ([gbl_lastSelectionType isEqualToString:@"person"]) {
            currentLine = [gbl_arrayPer objectAtIndex: indexPath.row];
            gbl_colorDIfor_home = gbl_colorSepara_per ;
        } else {
            currentLine = @"Unknown";
        }
    }
    // NSLog(@"currentLine=%@",currentLine);



    _arr = [currentLine componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
    nameOfGrpOrPer = _arr[0];
    //NSLog(@"nameOfGrpOrPer=%@",nameOfGrpOrPer);


    // NSLog(@"gbl_home_cell_AccessoryType=[%d]",gbl_home_cell_AccessoryType);

//    // make label for cell text
//    //


//        CGFloat myScreenWidth, myFontSize;  // determine font size
//        if ([gbl_homeUseMODE isEqualToString: @"edit mode"]) {
//nbn(20);
//            myScreenWidth = self.view.bounds.size.width;
//            if (        myScreenWidth >= 414.0)  { myFontSize = 17.0; }  // 6+ and 6s+  and bigger
//            else if (   myScreenWidth  < 414.0   
//                     && myScreenWidth  > 320.0)  { myFontSize = 17.0; }  // 6 and 6s
//            else if (   myScreenWidth <= 320.0)  { myFontSize = 17.0; }  //  5s and 5 and 4s and smaller
//            else                                 { myFontSize = 17.0; }  //  other ?
//        } else {
//            myFontSize = 17.0;
//        }
//


            // make label for Disclosure Indicator   ">"
            //
            NSAttributedString *myNewCellAttributedText3 = [
                [NSAttributedString alloc] initWithString: @">"  
                                               attributes: @{
                        NSFontAttributeName :  [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0] ,  
//                        NSForegroundColorAttributeName: [UIColor grayColor ]  
//                        NSForegroundColorAttributeName: [UIColor darkGrayColor ]  
//                        NSForegroundColorAttributeName: gbl_colorDIfor_home   
                        NSForegroundColorAttributeName: [UIColor grayColor ]  
                    }
            ];

            UILabel *myDisclosureIndicatorLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
            myDisclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
            if ([gbl_lastSelectionType isEqualToString:@"group"])  myDisclosureIndicatorLabel.backgroundColor = gbl_colorHomeBG_grp; 
            if ([gbl_lastSelectionType isEqualToString:@"person"]) myDisclosureIndicatorLabel.backgroundColor = gbl_colorHomeBG_per; 

//    if ([gbl_homeUseMODE isEqualToString: @"report mode"]) 
//    {
//    } // brown regular mode, not yellow edit


//  NSLog(@"gbl_homeUseMODE =%@",gbl_homeUseMODE );

//  NSLog(@"before set access view");
    dispatch_async(dispatch_get_main_queue(), ^{                        


// no effect
//       self.tableView.autoresizesSubviews = NO;
//       cell.autoresizesSubviews = NO;
//       cell.contentView.autoresizesSubviews = NO;
//       cell.textLabel.autoresizesSubviews = NO;


//  cell.textLabel.text = @"";           // uncomment  for test create empty Launch screen shot 
//  cell.accessoryType        = nil;     // uncomment  for test create empty Launch screen shot
//  cell.editingAccessoryType = nil;     // uncomment  for test create empty Launch screen shot
  //
  // For instance let's say your app supports iPhones > 4s, so iPhone: 4s, 5, 5s, 6 and 6plus.
  // Make sure to make launch-images which have the following dimensions:
  //         iPhone4s    =  640 ×  960
  //         iPhone5, 5s =  640 × 1136
  //         iPhone6     =  750 x 1334
  //         iPhone6plus = 1242 x 2208
  //


//  ALSO for test only    comment out between here  and  <.x  below       Launch
// for test create empty Launch screen shot by commenting out from here to <.x

        cell.textLabel.text = nameOfGrpOrPer;

//tn();
//kd(self.view.bounds.size.width);
//kd(self.view.bounds.size.height);
//tn();
//kd(cell.textLabel.frame.size.width);
//kd(cell.textLabel.frame.size.height);
//tn();


        cell.textLabel.font       = [UIFont boldSystemFontOfSize: 17.0];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
//        cell.accessoryType        = gbl_home_cell_AccessoryType;           // home mode regular with tap giving record details
//        cell.editingAccessoryType = gbl_home_cell_editingAccessoryType;    // home mode edit    with tap giving record details

//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textAlignment = NSTextAlignmentLeft;

//        cell.autoresizingMask     = UIViewAutoresizingFlexibleRightMargin;
//        cell.autoresizingMask     = UIViewAutoresizingFlexibleWidth;


        // PROBLEM  name slides left off screen when you hit red round delete "-" button
        //          and delete button slides from right into screen
        //
//        cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
//        cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right

        // in yellow edit mode, for groups mode    row=0, "#allpeople"  is not editable
        //
        if (    [gbl_homeUseMODE            isEqualToString: @"edit mode" ]
             && [gbl_fromHomeCurrentEntity  isEqualToString: @"group"     ] 
             && indexPath.row               == 0                            )
        {
            // this worked great
            cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
            cell.indentationLevel =  6;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
        } else {
            cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
            cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
        }

        if ([gbl_homeUseMODE isEqualToString: @"edit mode"]) cell.tintColor = [UIColor blackColor];

        if ([gbl_homeUseMODE isEqualToString: @"report mode"]) 
        {
//        cell.accessoryView                       = gbl_disclosureIndicatorLabel;
            cell.accessoryView                       = myDisclosureIndicatorLabel;
            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

        } else {
            cell.accessoryView                       = nil;
            cell.accessoryType                       = UITableViewCellAccessoryNone;
        }



//        cell.autoresizingMask     = UIViewAutoresizingFlexibleRightMargin;


  //<.x for test create empty Launch screen shot  //  ALSO comment out between the 2  <.x above



    });
//  NSLog(@"after set access view");
  

//  NSLog(@"nameOfGrpOrPer=[%@]",nameOfGrpOrPer);
//  NSLog(@"END of  cellForRowAtIndexPath in HOME");
//tn();
    return cell;
} // cellForRowAtIndexPath


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in  willSelectRowAtIndexPath !  in HOME");


// comment this out and try making  rows in yellow edit mode   selectable  (same action as "i" accessory)
//
//    // rows in yellow edit mode  should not be selectable
//    //
//    // NSString *gbl_homeUseMODE;      // "edit mode" (yellow)   or   "report mode" (blue)
//    //
//    if ([gbl_homeUseMODE isEqualToString: @"edit mode"]) return nil;
//

    return indexPath; // By default, allow row to be selected
}



// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // -------------------------
{
    //  NSLog(@"in heightForRowAtIndexPath 1");

  return 44.0; // matches report height

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];

    //    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    //    [self.tableView setBackgroundColor: gbl_colorHomeBG];

    if (     [gbl_homeUseMODE isEqualToString: @"edit mode" ] ) [self.tableView setBackgroundColor: gbl_colorEditingBG];
    else if ([gbl_lastSelectionType isEqualToString:@"person"]) [self.tableView setBackgroundColor: gbl_colorHomeBG_per];
    else if ([gbl_lastSelectionType isEqualToString:@"group" ]) [self.tableView setBackgroundColor: gbl_colorHomeBG_grp];

    cell.backgroundColor = [UIColor clearColor];
}

//
//       // NO SWIPES
////
//// In your UITableView delegate, you can use tableView:didEndEditingRowAtIndexPath:
//// to get notified when the editing of the cell ends,
//// which is also the state when the Delete button is about to disappear.
////
////  ?  exists ? tableView:didBeginEditingRowAtIndexPath
////
////
//// This method is called when the user swipes horizontally across a row;
//// as a consequence, the table view sets its editing property to YES (thereby entering editing mode)
//// and displays a Delete button in the row identified by indexPath.
//// In this "swipe to delete" mode the table view does not display any insertion, deletion, and reordering controls.
//// This method gives the delegate an opportunity to adjust the application's user interface to editing mode.
//// When the table exits editing mode (for example, the user taps the Delete button), the table view calls tableView:didEndEditingRowAtIndexPath:.
////
//// NOTE
//// A swipe motion across a cell does not cause the display of a Delete button
//// unless the table view's data source implements the tableView:commitEditingStyle:forRowAtIndexPath: method.
////
//- (void)tableView:(UITableView *)tableView  willBeginEditingRowAtIndexPath: (NSIndexPath *)indexPath
//{
//tn();
//  NSLog(@"in willBeginEditingRowAtIndexPath!");
//} // end of willBeginEditingRowAtIndexPath
//
//
//// This method is called when the table view exits editing mode
//// after having been put into the mode by the user swiping across the row identified by indexPath.
//// As a result, a Delete button appears in the row;
//// however, in this "swipe to delete" mode the table view does not display any insertion, deletion, and reordering controls.
//// When entering this "swipe to delete" editing mode,
//// the table view sends a tableView:willBeginEditingRowAtIndexPath: message to the delegate to allow it to adjust its user interface.
////
//- (void)tableView:(UITableView *)tableView  didEndEditingRowAtIndexPath: (NSIndexPath *)indexPath
//{
//tn();
//  NSLog(@"in didEndEditingRowAtIndexPath!");
//} // end of didEndEditingRowAtIndexPath
//
//


/*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
*/

/*
// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}

*/

/*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
}
*/

/*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
*/


// Override to support conditional editing of the table view.
//    // Return NO if you do not want the specified item to be editable.
//
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSLog(@"in canEditRowAtIndexPath!");
//  NSLog(@"indexPath.ro               =%ld",indexPath.row );
//  NSLog(@"gbl_homeUseMODE            =[%@]",gbl_homeUseMODE);
//  NSLog(@"gbl_fromHomeCurrentEntity  =[%@]",gbl_fromHomeCurrentEntity  );

    // in yellow edit mode, for groups mode    row=0, "#allpeople"  is not editable
    //
    if (    [gbl_homeUseMODE            isEqualToString: @"edit mode" ]
         && [gbl_fromHomeCurrentEntity  isEqualToString: @"group"     ] 
         && indexPath.row               == 0                            )
    {
  NSLog(@"in canEditRowAtIndexPath!   returning NO ");
        return NO;   // in yellow edit mode, for groups mode    row=0, "#allpeople"  is not editable
    }

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath: (NSIndexPath *)indexPath
{
//tn();
//NSLog(@"in editingStyleForRowAtIndexPath");


    return UITableViewCellEditingStyleDelete;
}

//  DELETE METHODS
//
// Just to make sure I understand, when you swipe,               CanEditRow and EditingStyleForRow should be called immediately.
// Just to make sure I understand, when tap red circle with "-", CanEditRow and EditingStyleForRow should be called immediately.
// Then a "Delete" button should be drawn for you by iOS.
// After you tap the "Delete" button, CommitEditingStyle should be called. – sblom Jul 26 '12 at 3:26 
//

// When users tap the insertion (green plus) control or Delete button
// associated with a UITableViewCell object in the table view,
// the table view sends this message to the data source, asking it to commit the change.
// 
// (If the user taps the deletion (red minus) control,
// the table view then displays the Delete button to get confirmation.) 
// 

//   DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD DELETE METHOD
//
- (void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)  editingStyle  // DELETE METHOD, DELETE METHOD
                                            forRowAtIndexPath: (NSIndexPath *)                indexPath
{
tn();
  NSLog(@"in commitEditingStyle");
  NSLog(@"editingStyle =[%ld]",(long)editingStyle);
  NSLog(@"indexPath.row=%ld",(long)indexPath.row);

//  NSLog(@"gbl_arrayMem  start =[%@]",gbl_arrayMem);
tn();

    
    [self commitEditingStyleGUTS: editingStyle  // want to call this here and from  handleSingleTapInCell:(UITapGestureRecognizer *)tap
               forRowAtIndexPath: indexPath
    ];

    // cleanup for delete function (group delete)
    // 
    if ([gbl_lastSelectionType isEqualToString: @"group" ]) 
    {

  NSLog(@"now delete the row on the screen   ");
        // now delete the row on the screen
        // and put highlight on row number for  arrayIndexOfNew_gbl_lastSelectedPerson
        //
        dispatch_async(dispatch_get_main_queue(), ^{  

            [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]   // now delete the row on the screen
                                  withRowAnimation: UITableViewRowAnimationFade
            ];

            gbl_scrollToCorrectRow = 1;
            [self putHighlightOnCorrectRow ];

//            [self.tableView reloadData];

            // after write of array data to file, allow user interaction events again
            //
            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.5 ];    // after arg seconds
            [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

            });

    }  // group delete cleanup


  NSLog(@"end of  commitEditingStyle  (DELETE function)");

}  // end of commitEditingStyle
//
//   DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD DELETE METHOD



//- (void)tableView:(UITableView *)tableView commitEditingStyleGUTS: (UITableViewCellEditingStyle)  editingStyle  // DELETE METHOD, DELETE METHOD
//                                                forRowAtIndexPath: (NSIndexPath *)                indexPath
//
//   DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD  DELETE METHOD DELETE METHOD
//
- (void) commitEditingStyleGUTS: (UITableViewCellEditingStyle)  editingStyle  // DELETE METHOD GUTS, DELETE METHOD GUTS
              forRowAtIndexPath: (NSIndexPath *)                indexPath
{
tn();

  NSLog(@"in commitEditingStyleGUTS");
  NSLog(@"editingStyle =[%ld]",(long)editingStyle);
  NSLog(@"indexPath.row=%ld",(long)indexPath.row);


    //how can I get the text of the cell here?
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *personNameToDelete = cell.textLabel.text;

    if ([gbl_lastSelectionType isEqualToString: @"group" ])   lcl_groupNameToDelete = cell.textLabel.text;
  NSLog(@"lcl_groupNameToDelete =[%@]",lcl_groupNameToDelete );


  NSLog(@"personNameToDelete =[%@]",personNameToDelete );



    if (   editingStyle == UITableViewCellEditingStyleDelete
        && [gbl_lastSelectionType isEqualToString: @"person" ]
    )
    {
  NSLog(@"in commitEditingStyle  for person");

//
//    // Here the red delete button has slid over from the right edge
//    // pushing the name to the left partly or all out of sight off screen.
//    //
//    // So,  move the cell.textLabel to the right (back into sight)
//
//    // PROBLEM  name slides left off screen when you hit red round delete "-" button
//    //          and delete button slides from right into screen
//    //
//
//    UITableViewCell* cell   = [tableView cellForRowAtIndexPath:indexPath];
//
////    NSIndexPath* rowToReload  = [NSIndexPath indexPathForRow: 3 inSection: 0 ];
//    NSArray*     rowsToReload = [NSArray arrayWithObjects: indexPath, nil ];
//
//    dispatch_async(dispatch_get_main_queue(), ^{  
////        cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
////        cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
//        cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
//        cell.indentationLevel =  6;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
//
//        [self.tableView reloadRowsAtIndexPaths: rowsToReload
//                              withRowAnimation: UITableViewRowAnimationLeft
//        ];
//
//    });
//
//nbn(334);
//

        NSInteger arrayCountBeforeDelete;   // person
        NSInteger arrayIndexToDelete;
        NSInteger arrayIndexOfNew_gbl_lastSelectedPerson;

        arrayCountBeforeDelete = gbl_arrayPer.count;
        arrayIndexToDelete     = indexPath.row;


        // before write of array data to file, disallow/ignore user interaction events
        //
        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];

        [myappDelegate mamb_beginIgnoringInteractionEvents ];


        // delete the array element for this cell
        // here the array index to delete matches the incoming  indexPath.row
        //
        [gbl_arrayPer removeObjectAtIndex:  arrayIndexToDelete ]; 
  NSLog(@"DELETED Person =[%@]",personNameToDelete);
        // gbl_arrayPer  is now golden  (was sorted before)

        // was sorted before anyway, but sort it for safety
        [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"person"]; // sort array by name
        [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"person"]; // write new array data to file

    //  [myappDelegate mambReadArrayFileWithDescription:              (NSString *) @"person"]; // read new data from file to array


        // have to set new gbl_lastSelectedPerson  
        // have to set new gbl_fromHomeCurrentSelectionPSV
        //
        // to be the "nearest" person after this deleted one 
        // UNLESS deleted one IS the last person, then the one before.
        //
        if ( arrayIndexToDelete == arrayCountBeforeDelete - 1) {                       // if deleted last element
            arrayIndexOfNew_gbl_lastSelectedPerson  = arrayCountBeforeDelete - 1 - 1;  //      new = last element minus one
        } else {
            arrayIndexOfNew_gbl_lastSelectedPerson  = arrayIndexToDelete;              // else new = last element
        }
  NSLog(@"before gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"before gbl_lastSelectedPerson          =[%@]",gbl_lastSelectedPerson);

        gbl_fromHomeCurrentSelectionPSV  = gbl_arrayPer[arrayIndexOfNew_gbl_lastSelectedPerson];
        gbl_lastSelectedPerson           = [gbl_fromHomeCurrentSelectionPSV  componentsSeparatedByString:@"|"][0]; // get fld1 (name) 0-based 

  NSLog(@"after  gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"after  gbl_lastSelectedPerson          =[%@]",gbl_lastSelectedPerson);




        // delete all memberships of the deleted person
        //
        // searchfor element in gbl_arrayMem
        // matching   any group    and   member = del_me_indexPath.text
        // delete that element in gbl_arrayMem
        // 
        // Delete by  going backwards from the highest index value to the lowest
        //
        NSString *currGroupMemberRec;
        NSString *currGroupMemberName;  // name of group member 

        for (int i = (int)gbl_arrayMem.count - 1;  i >= 0 ;  i--) {

            currGroupMemberRec  = gbl_arrayMem[i];
            currGroupMemberName = [currGroupMemberRec componentsSeparatedByString: @"|"][1]; // get fld#2 (name) - arr is 0-based 

            if ( [currGroupMemberName isEqualToString: personNameToDelete ] )
            {
                // delete this array element
                [gbl_arrayMem removeObjectAtIndex:  i ]; 
  NSLog(@"DELETED membership =[%@]",currGroupMemberRec);
            }
        }  // for each group member of all groups
        // was sorted before anyway, but sort it for safety
        [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; // sort array by name
        [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"member"]; // write new array data to file
        gbl_justWroteMemberFile = 1;
        //
        // delete all memberships of the deleted person
tn();
  NSLog(@"after   delete all memberships of the deleted person!");
//  NSLog(@"gbl_arrayMem=[%@]",gbl_arrayMem);
tn();


        // now delete the row on the screen
        // and put highlight on row number for  arrayIndexOfNew_gbl_lastSelectedPerson
        //
        dispatch_async(dispatch_get_main_queue(), ^{  

            [self.tableView deleteRowsAtIndexPaths: [NSArray arrayWithObject: indexPath]   // now delete the row on the screen
                                  withRowAnimation: UITableViewRowAnimationFade
            ];

            gbl_scrollToCorrectRow = 1;
            [self putHighlightOnCorrectRow ];
        });


        // after write of array data to file, allow user interaction events again
        //
        [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.5 ];    // after arg seconds

  NSLog(@"end of delete  for   person");
    }  // if (editingStyle == UITableViewCellEditingStyleDelete)  AND  is person



    if (   editingStyle == UITableViewCellEditingStyleDelete
        && [gbl_lastSelectionType isEqualToString: @"group" ]
    )
    {
  NSLog(@"in commitEditingStyle  for group");

//        NSInteger arrayCountBeforeDelete;   // group
//        NSInteger arrayIndexToDelete;
//        NSInteger arrayIndexOfNew_gbl_lastSelectedGroup;

        lcl_arrayCountBeforeDelete = gbl_arrayGrp.count;

        // get array index into gbl_arrayGrp for lcl_groupNameToDelete
        //
        NSString *prefixStr9 = [NSString stringWithFormat: @"%@|", lcl_groupNameToDelete ];  // notice '|'
        NSInteger arrayIdxIntoArrayGrp;
        arrayIdxIntoArrayGrp = -1;
        for (NSString *elt in gbl_arrayGrp) {
            arrayIdxIntoArrayGrp = arrayIdxIntoArrayGrp + 1;
            if ([elt hasPrefix: prefixStr9]) { 
                lcl_arrayIndexToDelete = arrayIdxIntoArrayGrp;
                break;
            }
        }
        if (arrayIdxIntoArrayGrp == -1) return;  // should not happen     no delete if cannot find grp record

//        lcl_arrayIndexToDelete     = indexPath.row;
  NSLog(@"setting  lcl_arrayIndexToDelete to  =[%ld]",(long)lcl_arrayIndexToDelete     );
  NSLog(@"gbl_arrayGrp=[%@]",gbl_arrayGrp);


        //  kind of delete DIALOGUE   removed from right here
        // end of CHOOSE KIND OF DELETE  ======================================================================================


        // before write of array data to file, disallow/ignore user interaction events
        //
        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myappDelegate mamb_beginIgnoringInteractionEvents ];


        [self doActualGroupDelete ];


        // after write of array data to file, allow user interaction events again
        //
        [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.5 ];    // after arg seconds


  NSLog(@"end of delete  for   group");

    }  // if (editingStyle == UITableViewCellEditingStyleDelete)  AND  is GROUP


  NSLog(@" end of commitEditingStyleGUTS");

}  // end of commitEditingStyleGUTS



- (void) doActualGroupDelete  //  all db actions    screen actions come at the end in here
{
tn();
  NSLog(@"doActualGroupDelete ");
  NSLog(@"gbl_kindOfDelete=[%@]",gbl_kindOfDelete);


        // all DB STUFF for the delete follows here

        MAMB09AppDelegate *myappDelegate= (MAMB09AppDelegate *) [[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m

        // 1. of 3   DELETE THE   gbl_arrayGrp   ARRAY ELEMENT for this cell
        // here the array index to delete matches the incoming  indexPath.row
        //

//  has to be wrong, yet compiled      [gbl_arrayGrp removeObjectAtIndex:  handleSingleTapInCell ]; 
        [gbl_arrayGrp removeObjectAtIndex:  lcl_arrayIndexToDelete ]; 
  NSLog(@"DELETED Group  !");
  NSLog(@"lcl_arrayIndexToDelete=[%ld]", (long) lcl_arrayIndexToDelete);

        // gbl_arrayGrp  is now golden  (was sorted before)

        // was sorted before anyway, but sort it for safety
        [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"group"]; // sort array by name
        [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"group"]; // write new array data to file

    //  [myappDelegate mambReadArrayFileWithDescription:              (NSString *) @"group"]; // read new data from file to array


        // have to set new gbl_lastSelectedGroup  
        // have to set new gbl_fromHomeCurrentSelectionPSV
        //
        // to be the "nearest" group after this deleted one 
        // UNLESS deleted one IS the last group, then the one before.
        //
        if ( lcl_arrayIndexToDelete == lcl_arrayCountBeforeDelete - 1) {                       // if deleted last element
            lcl_arrayIndexOfNew_gbl_lastSelectedGroup  = lcl_arrayCountBeforeDelete - 1 - 1;  //      new = last element minus one
        } else {
            lcl_arrayIndexOfNew_gbl_lastSelectedGroup  = lcl_arrayIndexToDelete;              // else new = last element
        }
  NSLog(@"before gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"before gbl_lastSelectedGroup   I       =[%@]",gbl_lastSelectedGroup);

        gbl_fromHomeCurrentSelectionPSV  = gbl_arrayGrp[lcl_arrayIndexOfNew_gbl_lastSelectedGroup];
        gbl_lastSelectedGroup            = [gbl_fromHomeCurrentSelectionPSV  componentsSeparatedByString:@"|"][0]; // get fld1 (name) 0-based 

  NSLog(@"after  gbl_fromHomeCurrentSelectionPSV =[%@]",gbl_fromHomeCurrentSelectionPSV );
  NSLog(@"after  gbl_lastSelectedGroup           =[%@]",gbl_lastSelectedGroup);



  NSLog(@"2. of 3  DELETE ALL MEMBERSHIPS of  the deleted group!");

        // 2. of 3  DELETE ALL MEMBERSHIPS of the deleted group
        //
        // searchfor element in gbl_arrayMem
        // matching   any group    and   member = del_me_indexPath.text
        // delete that element in gbl_arrayMem
        // 
        // Delete by  going backwards from the highest index value to the lowest
        // 
        NSString *currGroupMemberRec;
        NSString *currGroupName;  // name of group 
        NSString *currMemberName;  // name of group mbr


//        for (int i=0;  i < gbl_arrayMem.count;  i++) 
        for (int i = (int)gbl_arrayMem.count - 1;  i >= 0 ;  i--) {

            currGroupMemberRec  = gbl_arrayMem[i];
            currGroupName       = [currGroupMemberRec componentsSeparatedByString: @"|"][0]; // get fld#1 (grpname) - arr is 0-based 
            currMemberName      = [currGroupMemberRec componentsSeparatedByString: @"|"][1]; // get fld#1 (grpname) - arr is 0-based 
//  NSLog(@"currGroupName       =[%@]",currGroupName       );
//  NSLog(@"currMemberName      =[%@]",currMemberName       );

            if ( [currGroupName isEqualToString: lcl_groupNameToDelete ] )
            {
                // delete this array element
                [gbl_arrayMem removeObjectAtIndex:  i ]; 
  NSLog(@"DELETED membership =[%@]", currGroupMemberRec);
            }
        }  // for each group member of all groups
        // was sorted before anyway, but sort it for safety
        [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; // sort array by name
        [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"member"]; // write new array data to file
        gbl_justWroteMemberFile = 1;
        //
        // delete all memberships of the deleted group


//<.> debug this 
//  NSLog(@"testing RETURN 1");
//return;

  // 20160414   group delete is always "delete group only"  and add "Delete Multiple People" to  > people > edit > bottom bar
        //        // 3. of 3  DELETE EACH  PERSON IN THE GROUP   // answer = NO     can there be ~ example people in the group ?
        //        //
        //
        //        if ([gbl_kindOfDelete isEqualToString: @"delete group and members" ])
        //        {
        //  NSLog(@"// 3. of 3  DELETE EACH  PERSON IN THE GROUP !");
        //            // delete each person in the deleted group from gbl_arrayPer 
        //
        //            // get array  gbl_namesInCurrentGroup
        //            [myappDelegate get_gbl_numMembersInCurrentGroup ];   // also populates gbl_numMembersInCurrentGroup  using  gbl_lastSelectedGroup
        //
        //
        //            // delete each member person in this group   from gbl_arrayPer 
        //            //
        //            NSString *prefixStr7;
        //
        //            for (NSString *mbrName  in  gbl_namesInCurrentGroup )  // delete all these persons from  gbl_arrayPer
        //            {
        //  NSLog(@"mbrName=[%@]",mbrName);
        //                NSInteger idx;
        //                idx = -1;
        //                prefixStr7 = [NSString stringWithFormat: @"%@|", mbrName];  // notice '|'
        //                for (NSString *elt in gbl_arrayPer) {
        //                    idx = idx + 1;
        //                    if ([elt hasPrefix: prefixStr7]) { 
        //  NSLog(@"DELETED PERSON=[%@]", elt);
        //                        [gbl_arrayPer removeObjectAtIndex:  idx ]; // delete this array element
        //                        break;
        //                    }
        ////  NSLog(@"DID NOT DELETE PERSON=[%@]", prefixStr7 );
        //                }
        //
        //            } // for each member to delete
        //
        //
        //            // was sorted before anyway, but sort it for safety
        //            [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; // sort array by name
        //
        //            [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"member"]; // write new array data to file
        //            //  [myappDelegate mambReadArrayFileWithDescription:              (NSString *) @"person"]; // read new data from file to array
        //
        //
        //            gbl_justWrotePersonFile = 1;
        //
        //
        //        } // 3. of 3   delete each person in group  (if appropriate)
        //

  NSLog(@"near end of doActualGroupDelete");
  NSLog(@" next is    [self.navigationController popViewControllerAnimated: YES]; // actually do the \"Back\" action ");


    dispatch_async(dispatch_get_main_queue(), ^{  
        [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
    });


} // end of doActualGroupDelete 




#pragma mark - Navigation


-(IBAction)prepareForUnwindFromAddtoHome:(UIStoryboardSegue *)segue {
  NSLog(@" in prepareForUnwind !!! in HOME");
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in prepareForSegue() in home!");


  NSLog(@"segue.identifier =[%@]",segue.identifier );

    if ([segue.identifier isEqualToString:@"segueHomeToAddChange"]) {



        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        //        transition.subtype = direction;
        //        transition.subtype = kCATransitionFromBottom;
        //        transition.subtype = kCATransitionFromTop;
        //        transition.subtype = kCATransitionFromLeft;
        transition.subtype = kCATransitionFade;
        [self.view.layer addAnimation:transition forKey:kCATransition];

   UIViewController *sourceViewController = (UIViewController*)[segue sourceViewController];
    [sourceViewController.navigationController.view.layer addAnimation: transition 
                                                                forKey: kCATransition];

        [self.tableView setEditing: YES animated: YES];  // ?    turn cocoa editing mode off when this screen leaves

    }
} // end of  prepareForSegue 


-(IBAction) pressedChangeGroupName  
{
tn();
  NSLog(@"in  pressedChangeGroupName !");
  NSLog(@"gbl_lastSelectedGroup=[%@]",gbl_lastSelectedGroup);

    gbl_justPressedChangeGroupName = 1;

    gbl_homeEditingState = @"view or change";
    

    //  REMOVE OLD  gbl_toolbarHomeMaintenance 
    //
    for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
  NSLog(@"sub_view =[%@]",sub_view );
  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
        if(sub_view.tag == 34) {
  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
            [sub_view removeFromSuperview ];
        }
    }

    [self performSegueWithIdentifier: @"segueHomeToAddChange"  sender: self ]; //  

} // end of pressedChangeGroupName  



// 2016jun    CODE is in project, but was not used   //  MAMB09_selShareEntityTableViewController.m
//
////-(IBAction) pressedShareEntities    // People or Groups 
//-(IBAction) pressedShareEntities: (id)sender   // People or Groups 
//{
//  NSLog(@"in   pressedShareEntities! (Share People  or  Share Groups) in HOME");
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [myappDelegate mamb_beginIgnoringInteractionEvents ];
//
//  NSLog(@"sub_view removal #11, then goto selPerson");
//    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
//
//        //  REMOVE OLD  gbl_toolbarHomeMaintenance 
//        //
//        for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
//  NSLog(@"sub_view =[%@]",sub_view );
//  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
//            if(sub_view.tag == 34) {
//  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
//                [sub_view removeFromSuperview ];
//            }
//        }
//
//        // new segue "segueHomeToSelShareEntity"   to pick people  or  groups  to share
//        //
//        // here call screen to pick entities to share
//
//        [self performSegueWithIdentifier:@"segueHomeToSelShareEntity" sender:self]; 
//    });
//
//} // end of pressedShareEntities
//
//
//
// 2016jun    CODE is in project, but was not used   //  MAMB09_selShareEntityTableViewController.m

-(IBAction) pressedSeeMembersButton: (id)sender   
{
  NSLog(@"in  pressedSeeMembersButton,   go to  selPerson screen with group members");
  
            //   CASE_B   - tap on name in cell - for "group"   get group list (selPerson screen where you can "+" or "-" group members)

            gbl_groupMemberSelectionMode = @"none";  // to set this, have to tap "+" or "-" in selPerson

            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myappDelegate mamb_beginIgnoringInteractionEvents ];

  NSLog(@"sub_view #04");
            dispatch_async(dispatch_get_main_queue(), ^{                                
//                for( UIView *sub_view in [ self.view subviews ] )  // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
                for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
  NSLog(@"sub_view =[%@]",sub_view );
  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
                    if(sub_view.tag == 34) {
  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
                        [sub_view removeFromSuperview ];
                    }
                }
                [self performSegueWithIdentifier: @"segueHomeToListMembers" sender:self]; // selPerson screen where you can "+" or "-" group members
            });

} // end of pressedSeeMembersButton


// 20160401 put this button in HOME info at bottom
//
//-(IBAction) pressedBackupAll       // all People, all Groups
//{
//  NSLog(@"in   pressedBackupAll!  in HOME");
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [myappDelegate mamb_beginIgnoringInteractionEvents ];
//   
//
//    [myappDelegate mamb_beginIgnoringInteractionEvents ];
//   
//
//    [myappDelegate doBackupAll ];  //  all People, all Groups  
//
//  NSLog(@"back from [myappDelegate doBackupAll ];  ");
//
//} // end of pressedBackupAll
//



-(IBAction)pressedInfoButtonAction:(id)sender
{
  NSLog(@"in   infoButtonAction!  in HOME");
//tn();

    dispatch_async(dispatch_get_main_queue(), ^{                                
//                for( UIView *sub_view in [ self.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
        for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
  NSLog(@"sub_view =[%@]",sub_view );
  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
            if(sub_view.tag == 34) {
  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
                [sub_view removeFromSuperview ];
            }
        }
    });


    // if 2 rows have highlight, remove one

//
//    // If you only want to iterate through the visible cells, then use
//    NSArray *myVisibleCells = [self.tableView visibleCells];
//    for (UITableViewCell *myviscell in myVisibleCells) {
////  NSLog(@"cell.textLabel.text=[%@]",myviscell.textLabel.text);
////  NSLog(@"highlighted  butt  =[%d]",myviscell.highlighted );
////  NSLog(@"selected     butt  =[%d]",myviscell.selected    );
//    }
//

//        if (myviscell.selected  == NO) {
//            [myviscell setHighlighted: NO
//                             animated: NO  ];
//  NSLog(@"   set highlighted to NO");
            // get indexpath for cell
            // NSIndexPath *indexPath = [self.tableView indexPathForCell:cell] ;

//    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
//            [self.tableView deselectRowAtIndexPath: [self.tableView indexPathForCell: myviscell] // and remove yellow highlight
//                                          animated: NO
//            ];
//    });
//  NSLog(@"   deselect this cell ! ");

//  no        gbl_deselectThisCellOnReturnHome = myviscell;
//        }
//tn();

} // end of  infoButtonAction



// using setediting  INSTEAD
// WHEN TAPPED, THIS BUTTON AUTOMATICALLY TOGGLES BETWEEN AN eDIT AND dONE BUTTON AND
// CALLS YOUR VIEW CONTROLLER’S  setEditing:animated:  METHOD WITH APPROPRIATE VALUES.
//
//-(IBAction)pressedEditButtonAction:(id)sender
//{
//  NSLog(@"in   pressedEditButtonAction!  in HOME");
//
//  // gbl_homeEditingState   "add" for add a new person or group, "view or change" for tapped person or group
//  gbl_homeEditingState = @"view or change";  // this is default state when entering edit mode (addChangeViewController)
//
//  gbl_homeUseMODE = @"edit mode";   // determines home mode  @"edit mode" or @"report mode"
//  [self.tableView reloadData];
//
//
//} // end of  pressedEditButtonAction
//



-(IBAction)navAddButtonAction:(id)sender
{
  NSLog(@"in   navAddButtonAction!  in HOME       PRESSED ADD BUTTON (+)");




nbn(830);
  NSLog(@"gbl_fromHomeCurrentEntity=[%@]",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_MAX_persons         =[%ld]",(long)gbl_MAX_persons);
  NSLog(@"gbl_arrayPer.count      =[%ld]",(long)gbl_arrayPer.count );
  NSLog(@"gbl_MAX_groups          =[%ld]",(long)gbl_MAX_groups );
  NSLog(@"gbl_arrayGrp.count      =[%ld]",(long)gbl_arrayGrp.count );


    // BEFORE adding person, check for      NSInteger gbl_MAX_persons;              // 200 max in app and max in group
    //
    if (   gbl_arrayPer.count >= gbl_MAX_persons
        && [gbl_fromHomeCurrentEntity isEqualToString: @"person"]  )
    {

        // put up dialogue   hit max persons
        //
        NSString *tooManyPeopleMessage;

        tooManyPeopleMessage =  [ NSString stringWithFormat:
            @"\nThe app allows a maximum of %ld BFFs.",
//            @"\nThe app allows a maximum of %ld BFFs.\n\nYou can delete a person to make room for a new person.",
//            @"\nThe app allows a maximum of %ld BFFs.\n\nYou have to delete a person to make room for a new person.  There is no undo.",
            (long)gbl_MAX_persons
        ];

        UIAlertController* myalert = [UIAlertController alertControllerWithTitle: @"Too Many People"
                                                                       message: tooManyPeopleMessage 
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [myalert addAction:  okButton];

        [self.navigationController presentViewController: myalert  animated: YES  completion: nil ];

        return;
    } // BEFORE adding person, check for      NSInteger gbl_MAX_persons;              // 200 max in app and max in group



    // BEFORE adding group, check for      NSInteger gbl_MAX_groups;    
    //
    if (   gbl_arrayGrp.count >= gbl_MAX_groups                 // max in appdel.m
        && [gbl_fromHomeCurrentEntity isEqualToString: @"group"]  )
    {

        // put up dialogue   hit max groups
        //
        NSString *tooManyGroupsMessage;

        tooManyGroupsMessage =  [ NSString stringWithFormat:
            @"\nThe app allows a maximum of %ld groups.",
//            @"\nThe app allows a maximum of %ld groups.\n\nYou can delete a group to make room for a new group.",
            (long)gbl_MAX_groups
        ];

        UIAlertController* myalert = [UIAlertController alertControllerWithTitle: @"Too Many Groups"
                                                                       message: tooManyGroupsMessage 
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [myalert addAction:  okButton];

        [self.navigationController presentViewController: myalert  animated: YES  completion: nil ];

        return;
    } // BEFORE adding group, check for      NSInteger gbl_MAX_groups;





        self.tableView.userInteractionEnabled = YES;   // YES in addButtonAction
  NSLog(@"self.tableView.userInteractionEnabled in HOME navAddButtonAction=[%d]",self.tableView.userInteractionEnabled );


    gbl_homeEditingState = @"add";  // "add" for add a new person or group, "view or change" for tapped person or group


//    if ( self.editing == NO ) {
//        [self setEditing: YES   animated: YES ];
//    }

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];
   
  NSLog(@"sub_view #01");
    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  

        //  REMOVE OLD  gbl_toolbarHomeMaintenance 
        //
        for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
  NSLog(@"sub_view =[%@]",sub_view );
  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
            if(sub_view.tag == 34) {
  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
                [sub_view removeFromSuperview ];
            }
        }


        gbl_justPressedAddButtonForNewPerson = 0;
  NSLog(@"home gbl_justPressedAddButtonForNewPerson SET to 0=[%ld]",(long)gbl_justPressedAddButtonForNewPerson );

        if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"])          
        {
  NSLog(@"home gbl_justPressedAddButtonForNewPerson SET to 1=[%ld]",(long)gbl_justPressedAddButtonForNewPerson );
            gbl_justPressedAddButtonForNewPerson = 1;
        }


        [self performSegueWithIdentifier:@"segueHomeToAddChange" sender:self]; //  
    });

} // end of  navAddButtonAction



- (IBAction)actionSwitchEntity:(id)sender   // segemented control on home page   select person  or  group
{  // segemented control on home page   select person  or  group
    NSLog(@"in actionSwitchEntity() in home!");
  NSLog(@"gbl_fromHomeCurrentEntity        =[%@]",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_lastSelectionType            =[%@]",gbl_lastSelectionType            );


//    NSLog(@"gbl_LastSelectedPerson=%@",gbl_lastSelectedPerson);
//    NSLog(@"gbl_LastSelectedGroup=%@" ,gbl_lastSelectedGroup);
//    NSLog(@"gbl_lastSelectionType=%@" ,gbl_lastSelectionType);
//    NSLog(@"gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);

//    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
//        // NSLog(@"change grp to per!");
//        //_mambCurrentSelectionType = @"person";
//        gbl_fromHomeCurrentEntity        = @"person";
//        gbl_fromHomeCurrentSelectionType = @"person";
//        gbl_lastSelectionType            = @"person";
//        gbl_currentMenuPrefixFromHome              = @"homp"; 
//    } else if ([gbl_lastSelectionType isEqualToString:@"person"]){
//        // NSLog(@"change per to grp!");
//        //_mambCurrentSelectionType = @"person";
//        gbl_fromHomeCurrentEntity        = @"group";
//        gbl_fromHomeCurrentSelectionType = @"group";
//        gbl_lastSelectionType            = @"group";
//        gbl_currentMenuPrefixFromHome              = @"homg"; 
//    }
////    NSLog(@"gbl_fromHomeCurrentEntity        =%@",gbl_fromHomeCurrentEntity        );
////    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );
////    NSLog(@"gbl_lastSelectionType            =%@",gbl_lastSelectionType            );
////    NSLog(@"gbl_currentMenuPrefixFromHome              =%@",gbl_currentMenuPrefixFromHome);
//
//

//    [self putHighlightOnCorrectRow ];  // does not work here (too long to investigate)


    //
    //        // change  from group data on screen to person data   or vice-versa
    //        // but, disable user interaction for "mytime"
    //        // to prevent machine-gun pounding on next or prev key
    //        //
    //        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    //        [myappDelegate mamb_beginIgnoringInteractionEvents ];
    //        if (gbl_shouldUseDelayOnBackwardForeward == 1) {  // = 1 (0.5 sec  on what color update)
    //                                                          // = 0 (no delay on first show of screen)
    //            [self.view setUserInteractionEnabled: NO];                              // this works to disable user interaction for "mytime"
    //
    //            int64_t myDelayInSec   = 0.5 * (double)NSEC_PER_SEC;
    //            dispatch_time_t mytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);
    //
    //            dispatch_after(mytime, dispatch_get_main_queue(), ^{                     // do after delay of  mytime
    //
    //// DO STUFF HERE
    //                [self.outletWebView  loadHTMLString: myWhatColorHTML_FileContents  baseURL: nil];
    //// DO STUFF HERE
    //
    //                [self.view setUserInteractionEnabled: YES];                          // this works to disable user interaction for "mytime"
    //            });
    //        }
    //        [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
    //


    // change  from group data on screen to person data   or vice-versa
    // but, disable user interaction for "mytime"   (0.33 sec)
    // to prevent machine-gun pounding on next or prev key
    //


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];

    if ([gbl_fromHomeCurrentEntity isEqualToString: @"group"]) {
        _segEntityOutlet.selectedSegmentIndex = 0;
        _segEntityOutlet.userInteractionEnabled = YES;
        [_segEntityOutlet setEnabled: NO forSegmentAtIndex: 1];  // disable selection of "Person"
        _segEntityOutlet.userInteractionEnabled = NO;
    }
    if ([gbl_fromHomeCurrentEntity isEqualToString: @"person"]) {
        _segEntityOutlet.selectedSegmentIndex = 1;

        _segEntityOutlet.userInteractionEnabled = YES;
        [_segEntityOutlet setEnabled: NO forSegmentAtIndex: 0];  // disable selection of "Group"
        _segEntityOutlet.userInteractionEnabled = NO;
    }

//self.segmentedControl.tintColor = [UIColor cb_Grey1Color];
//self.segmentedControl.backgroundColor = [UIColor cb_Grey3Color];
// _segEntityOutlet.tintColor = [UIColor greenColor];
// _segEntityOutlet.backgroundColor = [UIColor cyanColor];
// _segEntityOutlet.tintColor = gbl_color_cAplTop;

  // _segEntityOutlet.backgroundColor = gbl_color_cAplTop;
//   _segEntityOutlet.backgroundColor = [UIColor yellowColor];
//NSDictionary *selectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
////                                    [UIFont cbGothamBookFontWithSize:13.0], NSFontAttributeName,
//                                    [UIColor lightGrayColor], NSForegroundColorAttributeName,
//                                    [UIColor greenColor], NSBackgroundColorAttributeName, nil];
//    [ _segEntityOutlet setTitleTextAttributes: selectedAttributes forState:UIControlStateNormal];
//
//     NSDictionary *unselectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
////                                      [UIFont cbGothamBookFontWithSize:13.0], NSFontAttributeName,
//                                      [UIColor blackColor], NSForegroundColorAttributeName,
//                                      [UIColor redColor], NSBackgroundColorAttributeName,
//                                      nil
//    ];
//

//   _segEntityOutlet.backgroundColor = gbl_reallyLightGray;
//NSDictionary *selectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
////                                    [UIFont cbGothamBookFontWithSize:13.0], NSFontAttributeName,
//                                    [UIColor yellowColor], NSForegroundColorAttributeName,
//                                    gbl_color_cAplDarkBlue, NSBackgroundColorAttributeName, nil];
//    [ _segEntityOutlet setTitleTextAttributes: selectedAttributes forState:UIControlStateNormal];
//
//     NSDictionary *unselectedAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
////                                      [UIFont cbGothamBookFontWithSize:13.0], NSFontAttributeName,
//                                     gbl_color_cAplDarkBlue, NSForegroundColorAttributeName,
////                                      [UIColor whiteColor], NSBackgroundColorAttributeName,
//                                     gbl_reallyLightGray, NSBackgroundColorAttributeName,
//                                      nil
//    ];
//    [ _segEntityOutlet setTitleTextAttributes: selectedAttributes forState:UIControlStateSelected];
//    [ _segEntityOutlet setTitleTextAttributes: unselectedAttributes forState:UIControlStateNormal];
//




//    int64_t myDelayInSec   = 0.5 * (double)NSEC_PER_SEC;
//    int64_t myDelayInSec   = 2.5 * (double)NSEC_PER_SEC;
//    int64_t myDelayInSec   = 0.5 * (double)NSEC_PER_SEC;
//    int64_t myDelayInSec   = 0.33 * (double)NSEC_PER_SEC;
    int64_t myDelayInSec   = 0.38 * (double)NSEC_PER_SEC;
    dispatch_time_t mytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);

    dispatch_after(mytime, dispatch_get_main_queue(), ^{       // do after delay of mytime    dispatch    dispatch    dispatch   dispatch  

//  NSLog(@"---------- 1 ---- in switchentity ----------------------------------------");
//  NSLog(@"gbl_currentMenuPrefixFromHome    =[%@]",gbl_currentMenuPrefixFromHome);
//  NSLog(@"gbl_lastSelectionType            =[%@]",gbl_lastSelectionType            );
//  NSLog(@"gbl_lastSelectedGroup            =[%@]",gbl_lastSelectedGroup     );
//  NSLog(@"gbl_lastSelectedPerson           =[%@]",gbl_lastSelectedPerson     );
//  NSLog(@"gbl_fromHomeCurrentSelectionType =[%@]",gbl_fromHomeCurrentSelectionType );
//  NSLog(@"gbl_fromHomeCurrentSelectionPSV  =[%@]",gbl_fromHomeCurrentSelectionPSV);
//  NSLog(@"gbl_fromHomeCurrentEntity        =[%@]",gbl_fromHomeCurrentEntity        );
//  NSLog(@"gbl_fromHomeCurrentEntityName    =[%@]",gbl_fromHomeCurrentEntityName   );
//  NSLog(@"--------------------------------------------------------------------------");
//
        //// start DO STUFF HERE
    if ([gbl_lastSelectionType isEqualToString:@"group"]) {

        // if, coming into switchEntity, gbl_lastSelectionType  is "group",
        // we need to change everything to "person" here

//  NSLog(@"change grp to per!");
        //_mambCurrentSelectionType = @"person";
        gbl_fromHomeCurrentEntity        = @"person";
        gbl_fromHomeCurrentSelectionType = @"person";
        gbl_lastSelectionType            = @"person";
        gbl_fromHomeCurrentEntityName    = gbl_lastSelectedPerson; 
        gbl_currentMenuPrefixFromHome    = @"homp"; 
        gbl_colorHomeBG                  = gbl_colorHomeBG_per;
        self.tableView.separatorColor    = gbl_colorSepara_per;

        gbl_fromHomeCurrentSelectionPSV = [myappDelegate getPSVforPersonName: (NSString *) gbl_lastSelectedPerson]; 

    } else if ([gbl_lastSelectionType isEqualToString:@"person"]){

        // if, coming into switchEntity, gbl_lastSelectionType  is "person",
        // we need to change everything to "group" here

//  NSLog(@"change per to grp!");
        //_mambCurrentSelectionType = @"person";
        gbl_fromHomeCurrentEntity        = @"group";
        gbl_fromHomeCurrentSelectionType = @"group";
        gbl_lastSelectionType            = @"group";
        gbl_fromHomeCurrentEntityName    = gbl_lastSelectedGroup;           
        gbl_currentMenuPrefixFromHome    = @"homg"; 
        gbl_colorHomeBG                  = gbl_colorHomeBG_grp;
        self.tableView.separatorColor    = gbl_colorSepara_grp;

        gbl_fromHomeCurrentSelectionPSV = [myappDelegate getPSVforGroupName: (NSString *) gbl_lastSelectedGroup]; 
    }
//tn();
//  NSLog(@"---------- 2 -------------------------------------------------------------");
//  NSLog(@"gbl_currentMenuPrefixFromHome    =[%@]",gbl_currentMenuPrefixFromHome);
//  NSLog(@"gbl_lastSelectionType            =[%@]",gbl_lastSelectionType            );
//  NSLog(@"gbl_lastSelectedGroup            =[%@]",gbl_lastSelectedGroup     );
//  NSLog(@"gbl_lastSelectedPerson           =[%@]",gbl_lastSelectedPerson     );
//  NSLog(@"gbl_fromHomeCurrentSelectionType =[%@]",gbl_fromHomeCurrentSelectionType );
//  NSLog(@"gbl_fromHomeCurrentSelectionPSV  =[%@]",gbl_fromHomeCurrentSelectionPSV);
//  NSLog(@"gbl_fromHomeCurrentEntity        =[%@]",gbl_fromHomeCurrentEntity        );
//  NSLog(@"gbl_fromHomeCurrentEntityName    =[%@]",gbl_fromHomeCurrentEntityName   );
//  NSLog(@"--------------------------------------------------------------------------");
//


  NSLog(@"in switchEntity,  do handleMaintenanceToolbar  ");
    [self handleMaintenanceToolbar ];


    if ([gbl_lastSelectionType isEqualToString: @"group"])  _segEntityOutlet.selectedSegmentIndex = 0; // highlight correct entity in seg ctrl
    if ([gbl_lastSelectionType isEqualToString: @"person"]) _segEntityOutlet.selectedSegmentIndex = 1; // highlight correct entity in seg ctrl

    [self.view setUserInteractionEnabled:  NO];                              // this works to disable user interaction for "mytime"


    NSString *nameOfGrpOrPer;
    NSInteger idxGrpOrPer;
    NSArray *arrayGrpOrper;
    idxGrpOrPer = -1;   // zero-based idx

        if ([gbl_fromHomeCurrentEntity isEqualToString: @"group"]) {
nbn(50);

NSLog(@"in switchEntity, GROUP  reload table here!");
            [self.tableView reloadData];
nbn(51);

            // highlight lastEntity row in tableview
            //


            // Check for gbl_lastSelectedPerson being example data person
            // and example data being turned off.
            // In that case, put top row on top of tableview
            //
            if ([gbl_ExampleData_show isEqualToString: @"no"]
                && (
                       [gbl_lastSelectedGroup hasPrefix: @"~" ] 
                    || (gbl_numRowsToDisplayFor_per == 0)
                   )
               )
            {
nbn(55);
               // set gbl_lastSelectedPerson  to whoever is in top row
               // put top row on top of tableview
               self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);

            } else {
                // normal case here

            
                // find index of _mambCurrentSelection (like "~Family") in gbl_arrayGrp
                for (id eltGrp in gbl_arrayGrp) {
                  idxGrpOrPer = idxGrpOrPer + 1;
                  //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
                  //NSLog(@"eltGrp=%@", eltGrp);

                  NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString: @"|"];
                  arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet:  mySeparators];
                  nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

                  //if ([nameOfGrpOrPer isEqualToString:  _mambCurrentSelection]) 
                  if ([nameOfGrpOrPer isEqualToString:  gbl_lastSelectedGroup]) {
                    break;
                  }
                }  // search thru gbl_arrayGrp
  NSLog(@"FOUND idxGrpOrPer! =%ld", (long)idxGrpOrPer);

                // get the indexpath of row num idxGrpOrPer in tableview
                //   assumes index of entity in gbl_array Per or Grp
                //   is the same as its index (row) in the tableview
                NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow: idxGrpOrPer inSection:0];

        //tn();trn("SCROLL 333333333333333333333333333333333333333333333333333333333");

  nbn(52);
                dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  

                    // select the row in UITableView
                    // This puts in the light grey "highlight" indicating selection
                    [self.tableView selectRowAtIndexPath:  foundIndexPath   // This puts in the light grey "highlight" indicating selection
                                                animated:  YES
                                          scrollPosition:  UITableViewScrollPositionNone];

                    //[self.tableView scrollToNearestSelectedRowAtScrollPosition:  foundIndexPath.row 
                    [self.tableView scrollToNearestSelectedRowAtScrollPosition:  UITableViewScrollPositionMiddle
                                                                      animated:  YES];

                });
            } // end of normal case here (highlight row)



            if ( [gbl_homeUseMODE isEqualToString: @"edit mode" ] ) {
                [self.tableView setBackgroundColor: gbl_colorEditingBG];
            }
        }  // end of "group"


        if ([gbl_fromHomeCurrentEntity isEqualToString: @"person"]) {


NSLog(@"in switchEntity, PERSON  reload table here!");
            [self.tableView reloadData];

            // highlight lastEntity row in tableview
            //
        

            // Check for gbl_lastSelectedPerson being example data person
            // and example data being turned off.
            // In that case, put top row on top of tableview
            //
            if ([gbl_ExampleData_show isEqualToString: @"no"]
                && (
                       [gbl_lastSelectedPerson hasPrefix: @"~" ] 
                    || (gbl_numRowsToDisplayFor_grp == 0)
                   )
               )
            {
nbn(55);
               // set gbl_lastSelectedPerson  to whoever is in top row
               // put top row on top of tableview
               self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);

            } else {
                // normal case here

                // find index of _mambCurrentSelection (like "~Dave") in gbl_arrayPer
                for (id eltPer in gbl_arrayPer) {
                    idxGrpOrPer = idxGrpOrPer + 1;
                    //NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
                    //NSLog(@"eltPer=%@", eltPer);
                    NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString: @"|"];
                    arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet:  mySeparators];
                    nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld

                    //if ([nameOfGrpOrPer isEqualToString:  _mambCurrentSelection]) 
                    if ([nameOfGrpOrPer isEqualToString:  gbl_lastSelectedPerson]) {
                        break;
                    }
                } // search thru gbl_arrayPer
  NSLog(@"FOUND! idxGrpOrPer=%ld", (long)idxGrpOrPer);

                // get the indexpath of row num idxGrpOrPer in tableview
                NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];

//tn();trn("SCROLL 444444444444444444444444444444444444444444444444444444444");
                dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
                    // select the row in UITableView
                    // This puts in the light grey "highlight" indicating selection
                    [self.tableView selectRowAtIndexPath: foundIndexPath 
                                                animated: YES
                                          scrollPosition: UITableViewScrollPositionNone];
                    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: foundIndexPath.row 
                    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                                      animated: YES];
                });

            } // end of normal case here (highlight row)

            if ( [gbl_homeUseMODE isEqualToString: @"edit mode" ] ) {
                [self.tableView setBackgroundColor: gbl_colorEditingBG];
            }
        }

        //// end DO STUFF HERE

//    _segEntityOutlet.userInteractionEnabled = YES;

    _segEntityOutlet.userInteractionEnabled = YES;
    [_segEntityOutlet setEnabled: YES forSegmentAtIndex: 0];  // enable selection of "Group"
    [_segEntityOutlet setEnabled: YES forSegmentAtIndex: 1];  // enable selection of "Person"


    [self.view setUserInteractionEnabled: YES];      




// comment out       for test create empty Launch screen shot 
    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex or not after switch



//nbn(145);
//    [self.tableView reloadSectionIndexTitles];


    }); // do after delay of  mytime // this works to disable user interaction for "mytime"


    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

//nbn(146);
//    [self.tableView reloadSectionIndexTitles];
//nbn(147);


} // end of   (IBAction)actionSwitchEntity:(id)sender {  // segemented control on home page



- (void)viewDidAppear:(BOOL)animated
{
tn();
NSLog(@"in viewDidAppear()  in HOME");
  NSLog(@"gbl_ExampleData_show=[%@]",gbl_ExampleData_show);
  NSLog(@"gbl_homeUseMODE     =[%@]",gbl_homeUseMODE );

//  NSLog(@"gbl_arrayMem HOME viewdidAppear TOP =[%@]",gbl_arrayMem );

//            if ([gbl_homeUseMODE isEqualToString: @"edit mode" ] )
//            {
//nbn(157);
////                self.navigationController.toolbar.hidden =  NO;
////                [self.navigationController setToolbarHidden:  NO   animated: YES ];
//                gbl_toolbarHomeMaintenance.hidden  =  NO;
//                gbl_toolbarHomeMaintenance.enabled =  NO;
//            } else {
//nbn(158);
////                self.navigationController.toolbar.hidden = YES;
////                [self.navigationController setToolbarHidden: YES   animated: YES ];
//                gbl_toolbarHomeMaintenance.hidden  = YES;
//                gbl_toolbarHomeMaintenance.enabled = YES;
//            }
//



    // if gbl_fromHomeCurrentEntityName is different from gbl_fromHomeLastEntityRemSaved
    // save the  remember array  gbl_arrayPerRem or gbl_arrayGrpRem
    //
//    NSLog(@"gbl_fromHomeCurrentEntityName  =%@",gbl_fromHomeCurrentEntityName  );
//    if (gbl_fromHomeCurrentEntityName ) { NSLog(@"gbl_fromHomeCurrentEntityName.length=%lu",(unsigned long)gbl_fromHomeCurrentEntityName.length); }
//    NSLog(@"gbl_fromHomeLastEntityRemSaved  =%@",gbl_fromHomeLastEntityRemSaved  );
//    if (gbl_fromHomeLastEntityRemSaved) { NSLog(@"gbl_fromHomeLastEntityRemSaved.length =%lu",(unsigned long)gbl_fromHomeLastEntityRemSaved.length );}
//    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );
//
//    BOOL cond1 =  gbl_fromHomeLastEntityRemSaved != nil ;
//    BOOL cond2 = ![gbl_fromHomeLastEntityRemSaved isEqualToString: gbl_fromHomeCurrentEntityName];
//

    if (gbl_ExampleData_show_switchChanged == 1)
    {
  NSLog(@"reload tableview because gbl_ExampleData_show_switchChanged == 1");

        gbl_ExampleData_show_switchChanged = 0;

        [self.tableView reloadData];

        gbl_scrollToCorrectRow = 1;
        [self putHighlightOnCorrectRow ];
    }
   
    if (   gbl_justAddedPersonRecord == 1
        || gbl_justAddedGroupRecord  == 1
    ) {
        gbl_justAddedPersonRecord  = 0;
        gbl_justAddedGroupRecord   = 0;
  NSLog(@"reload tableview because have added an entity");

        [self.tableView reloadData];

        gbl_scrollToCorrectRow = 1;
        [self putHighlightOnCorrectRow ];
    }

    if (gbl_fromHomeCurrentEntityName  &&  gbl_fromHomeCurrentEntityName.length != 0) { // have to have something to save

        if ( (  gbl_fromHomeLastEntityRemSaved == nil )    ||                                          // if  nil, save
             (  gbl_fromHomeLastEntityRemSaved != nil   &&
               ![gbl_fromHomeLastEntityRemSaved isEqualToString: gbl_fromHomeCurrentEntityName] ) )  // if not equal to last, save
        {

                MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];

                [myappDelegate mamb_beginIgnoringInteractionEvents ];
               

                if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {  
                    [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"perrem"];
                }
                if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"]) {
                    [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"grprem"];  
                }

                gbl_fromHomeLastEntityRemSaved = gbl_fromHomeCurrentEntityName;


                [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.6 ];    // after arg seconds
        }
    }   // save the  remember array  gbl_arrayPerRem or gbl_arrayGrpRem
    


//tn();trn("SCROLL 555555555555555555555555555555555555555555555555555555555");

    // deselect    every visible row except selected one
    // unhighlight every visible row except selected one
    //
    NSArray *myVisibleCells = [self.tableView visibleCells]; // If you only want to iterate through the visible cells, then use
tn();
    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
        for (UITableViewCell *myviscell in myVisibleCells) {

//  NSLog(@"cell.textLabel.text=[%@]",myviscell.textLabel.text);
//  NSLog(@"highlighted  viewdidappear     =[%d]",myviscell.highlighted );
//  NSLog(@"selected     viewdidappear     =[%d]",myviscell.selected    );
            if (myviscell.selected == 0) {
                [self.tableView deselectRowAtIndexPath: [self.tableView indexPathForCell: myviscell] // and remove yellow highlight
                                              animated: NO
                ];
                [myviscell setHighlighted: NO
                                 animated: NO  ];
//  NSLog(@"   DID DESELECT!!  ");
//  NSLog(@"   DID UNhighlight!!  ");
//  NSLog(@"   set highlighted to NO");
            }
        }
    });

    // select (highlight) the selected cell
    //
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//NSLog(@"myIdxPath5=%@",myIdxPath);
//NSLog(@"myIdxPath.row5=%ld",(long)myIdxPath.row);
    if(myIdxPath) {
        [self.tableView selectRowAtIndexPath: myIdxPath
                                    animated: YES
                              scrollPosition: UITableViewScrollPositionNone
//                              scrollPosition:UITableViewScrollPositionMiddle];
        ];
    }


    //[self.tableView reloadData]; tn();trn("reload reload reload reload reload reload reload reload reload reload reload reload ");

    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                      animated: YES];



    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

} // end of viewDidAppear



- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"in willDeselectRowAtIndexPath() in HOME!");

    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.

    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
 
    // NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);

    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [gbl_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [gbl_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);


//    // put this back to default  indentationLevel = 3
//    //
//    // PROBLEM  name slides left off screen when you hit red round delete "-" button
//    //          and delete button slides from right into screen
//    //
//    // these 2 keep the name on screen when hit red round delete and big delete button slides from right
//    //
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
//    NSArray*     rowsToReload = [NSArray arrayWithObjects: indexPath, nil ];
//    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//
//        cell.indentationWidth = 12.0; // these 2 keep the name on screen 
//        cell.indentationLevel =  3;   // these 2 keep the name on screen // = 7 when user hit red circle with "-"
//
//        [self.tableView reloadRowsAtIndexPaths: rowsToReload
//                              withRowAnimation: UITableViewRowAnimationLeft
//        ];
//
//    }); // end of  dispatch_async(dispatch_get_main_queue()
//
    

    // here deselect "previously" selected row
    // and remove yellow highlight
    //NSLog(@"willDeselectRowAtIndexPath()  DESELECT #######################################################");
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath   // and remove yellow highlight
                                  animated: NO];
//                                  animated: YES];
    return previouslyselectedIndexPath;

} // end of willDeselectRowAtIndexPath




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
  NSLog(@"in HOME  didSelectRowAtIndexPath ");
  NSLog(@"gbl_colorHomeBG=[%@]",gbl_colorHomeBG);


    // in yellow edit mode, for groups mode    row=0, "#allpeople"  is not editable
    //
    if (    [gbl_homeUseMODE            isEqualToString: @"edit mode" ]
         && [gbl_fromHomeCurrentEntity  isEqualToString: @"group"     ] 
         && indexPath.row               == 0                            )
    {
        // put up dialogue   cannot edit group  #allpeople
        //
        UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"Cannot Edit #allpeople"
//                                                                       message: @"The app automatically maintains it."
                                                                       message: @"The app automatically maintains that Group."
                                                                preferredStyle: UIAlertControllerStyleAlert  ];
         
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
         
        [alert addAction:  okButton];

        [self presentViewController: alert  animated: YES  completion: nil   ];
        
    }

//    gbl_mynow = [[[NSDate alloc] init] timeIntervalSince1970];
//
//  NSLog(@"gbl_mynow        =[%f]",gbl_mynow );
//  NSLog(@"gbl_lastClick    =[%f]",gbl_lastClick );
//  NSLog(@"gbl_lastIndexPath=[%@]",gbl_lastIndexPath);
//
//    if ((gbl_mynow - gbl_lastClick < 0.3) && [indexPath isEqual: gbl_lastIndexPath]) {
//        // Double tap here
//  NSLog(@"Double Tap!");
//  return;
//    }
//    gbl_lastClick = gbl_mynow;
//    gbl_lastIndexPath = indexPath;



    // selecting home row in yellow "edit mode" gives you  view or change mode
    //
    if ( [gbl_homeUseMODE isEqualToString: @"edit mode" ] )
    {
        gbl_homeEditingState = @"view or change";  // "add" for add a new person or group, "view or change" for tapped person or group
    }

    if ( [gbl_homeUseMODE isEqualToString: @"report mode" ] )
    {
        gbl_homeEditingState = nil;
        ;  // just go ahead with regular report selection functionality
    }
  NSLog(@"gbl_homeEditingState =[%@]",gbl_homeEditingState );

//    [self codeForCellTapOrAccessoryButtonTapWithIndexPath: indexPath ];
    [self codeForCellTapWithIndexPath: indexPath ];


//
////     // deselect previous row, select new one  (grey highlight)
////     //
////     // When the user selects a cell, you should respond by deselecting the previously selected cell (
////     // by calling the deselectRowAtIndexPath:animated: method) as well as by
////     // performing any appropriate action, such as displaying a detail view.
////     // 
////     NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];  // this is the "previously" selected row now
////     [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath  // deselect "previously" selected row and remove light grey highlight
////                                   animated: NO];
//// 
////     NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow]; // get the indexpath of current row
////     if(myIdxPath) {
////         [self.tableView selectRowAtIndexPath:myIdxPath // puts highlight on this row (?)
////                                     animated:YES
////                               scrollPosition:UITableViewScrollPositionNone];
////     }
//
//
//// tn();     NSLog(@"in didSelectRowAtIndexPath in home !!!!!!!!!!  BEFORE  !!!!!!!!!!!!!");
////             NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
////             NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
////             NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);
////             NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
////             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
////             NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
////             NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
////             NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
////             NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
////             //NSLog(@"=%@",);
//// NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//
//
//    // this is the "currently" selected row now
//    //NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
//    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//    
//
//    // below is from prep for segue
//    gbl_savePrevIndexPath  = myIdxPath;
//    NSLog(@"gbl_savePrevIndexPath=%@",gbl_savePrevIndexPath);
//    gbl_fromHomeCurrentEntity = gbl_lastSelectionType; // "group" or "person"
//    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
//        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
//        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
//    }
//    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"]) {
//        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
//        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
//    }
//    NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
//    NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
//    NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//    NSLog(@"home didSelectRow gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//    NSLog(@"home didSelectRow gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
//    // above is from prep for segue
//
//
//    const char *my_psvc;  // psv=pipe-separated values
//    char my_psv[1024], psvName[32];
//    my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
//    strcpy(my_psv, my_psvc);
//    strcpy(psvName, csv_get_field(my_psv, "|", 1));
//    NSString *myNameOstr =  [NSString stringWithUTF8String:psvName];  // convert c string to NSString
//
//    gbl_fromHomeCurrentEntityName = myNameOstr;  // like "~Anya" or "~Swim Team"
//    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {
//        gbl_lastSelectedPerson = myNameOstr;
//    }
//    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"]) {
//        gbl_lastSelectedGroup  = myNameOstr;
//    }
//
//
//// tn();     NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!  AFTER   !!!!!!!!!!!!!");
////             NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
////             NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
////             NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);
////             NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
////             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
////             NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
////             NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//             NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//             NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
////             //NSLog(@"=%@",);
//// NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//
////tn();trn("SCROLL 666666666666666666666666666666666666666666666666666666666");
//    // select the row in UITableView
//    // This puts in the light grey "highlight" indicating selection
//    //[self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
//    [self.tableView selectRowAtIndexPath: myIdxPath
//                                animated: YES
//                          scrollPosition: UITableViewScrollPositionNone];
//
//    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
//    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//                                                      animated: YES];
//    b(31);
//
//
//    if ([gbl_homeUseMODE isEqualToString: @"edit mode" ] )   // = yellow
//    {
//  NSLog(@"go to add change ON TAP of ROW");
//
//        // Because background threads are not prioritized and will wait a very long time
//        // before you see results, unlike the mainthread, which is high priority for the system.
//        //
//        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
//        //
//        dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
//            [self performSegueWithIdentifier:@"segueHomeToAddChange" sender:self]; //  
//        });
//
//    } else {
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
//            [self performSegueWithIdentifier:@"segueHomeToReportList" sender:self]; //  
//        });
//    }
//
//    b(32);
//        
//

} // end of  didSelectRowAtIndexPath: (NSIndexPath *) indexPath


-(void) viewWillAppear:(BOOL)animated
{
tn();
 NSLog(@"in viewWillAppear() in home   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  NSLog(@"gbl_ExampleData_show=[%@]",gbl_ExampleData_show);


    gbl_haveAddedNavBarRightItems = 0;  // init


nbn(376);
    MAMB09AppDelegate *myappDelegate= (MAMB09AppDelegate *) [[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
    [myappDelegate deleteAll_MAMB_files_fromInbox ]; // del from Inbox dir all "*.mamb"        // clear out for test


//  NSLog(@"gbl_arrayMem viewWillAppear   =[%@]",gbl_arrayMem );


//
//    // put on a bottom FOOTER to account for BOTTOM TOOLBAR if this is yellow edit mode
//    //
//    if ([gbl_homeUseMODE isEqualToString:@"edit mode"]) {
//
//       // magic 44 is the specified height of bottom footer
//        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44.0);
//
//        UIView *footer = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1, 44)];  // magic 44 is the specified height of bottom footer
//        footer.backgroundColor = [UIColor clearColor];
//        self.tableView.tableFooterView = footer;
//
//
//    } else {
//        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height       );
//
//        self.tableView.tableFooterView = nil;
//    }
//


    //   gbl_homeUseMODE;      // "edit mode" (yellow)   or   "report mode" (blue)
    if ([gbl_homeUseMODE isEqualToString:@"edit mode"]) {

        [self.tableView setEditing: YES animated: YES];  // turn cocoa editing mode on

    } else {

        [self.tableView setEditing: NO  animated: YES];  // turn cocoa editing mode off
    }


    gbl_currentMenuPlusReportCode = @"HOME";  // also set in viewDidAppear for coming back to HOME from other places (INFO ptr)
  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );


    // HIDE BOTTOM TOOLBAR (used for edit mode - tap edit button)
    //
//    gbl_toolbarHomeMaintenance              = nil;
    self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar is NOT visible 



//
//    // BOTTOM TOOLBAR (used for edit mode - tap edit button)
//    //
//    if ([gbl_homeUseMODE isEqualToString:@"edit mode"])
//    {
//        self.navigationController.toolbarHidden =  NO;  // ensure that the bottom of screen toolbar is NOT visible 
//    } else {
//        self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar IS     visible 
//    }

nbn(140);
    [self handleMaintenanceToolbar ];

//            if ([gbl_homeUseMODE isEqualToString: @"edit mode" ] )
//            {
//nbn(157);
////                self.navigationController.toolbar.hidden =  NO;
////                [self.navigationController setToolbarHidden:  NO   animated: YES ];
////                [self.view setToolbarHidden:  NO   animated: YES ];
//                [ [self.view viewWithTag: 34 ] setHidden:  NO ];  // no labels, but white rect
//            } else {
//nbn(158);
////                self.navigationController.toolbar.hidden = YES;
////                [self.navigationController setToolbarHidden: YES   animated: YES ];
////                [self.view setToolbarHidden: YES   animated: YES ];  xx
////                self.gbl_toolbarHomeMaintenance = nil;
////                [self.view viewWithTag: 34 ].hidden = YES;
//
////                [ [self.view viewWithTag: 34 ] setHidden: YES ];  // no labels, but white rect
////                self.navigationController.toolbar.hidden = YES;
//            }
//

}  // end of   viewWillAppear


- (void) handleMaintenanceToolbar  // put it up or hide it
{
  NSLog(@" in handleMaintenanceToolbar! in HOME ");
  NSLog(@"gbl_homeUseMODE =[%@]",gbl_homeUseMODE );

//    if ([gbl_homeUseMODE isEqualToString: @"report mode" ] )   // = brown
//    {
//        gbl_toolbarHomeMaintenance              = nil;
//        self.navigationController.toolbarHidden =  NO;  // ensure that the bottom of screen toolbar IS NOT visible 
//nbn(150);
//        return;
//    }

//nbn(151);
//    gbl_toolbarHomeMaintenance              = nil;
//    self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar is NOT visible 



    // remove the subview (gbl_toolbarHomeMaintenance  - tag=34 MAGIC ) from before, if any
    // 
  NSLog(@"sub_view #02");
//  UIView *ptrToView = (UITextField *)[self.view viewWithTag: 2 ];
  UIView *ptrToView = [self.view viewWithTag: 34 ];
  NSLog(@"ptrToView =[%@]",ptrToView );


    for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
  NSLog(@"sub_view =[%@]",sub_view );
  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
        if(sub_view.tag == 34)
        {
  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
            [sub_view removeFromSuperview ];
        }
    }

    // here, there is no bottom toolbar
    //
    if (   [gbl_homeUseMODE       isEqualToString: @"edit mode" ]
        && [gbl_lastSelectionType isEqualToString: @"person"] )  
    {
        return;   // no bottom toobar for yellow people
    }
    


//
////    if ([gbl_homeUseMODE isEqualToString: @"edit mode" ] )   // = yellow
////    {
//        NSString *shareTitle; 
////        if ([gbl_lastSelectionType isEqualToString:@"person"])  shareTitle = @"Share_people_by_email";
//        if ([gbl_lastSelectionType isEqualToString: @"person"])  shareTitle = @"Share people by email";
////        if ([gbl_lastSelectionType isEqualToString:@"group" ])  shareTitle = @"Share_groups_by_email";
////        if ([gbl_lastSelectionType isEqualToString:@"group" ])  shareTitle = @"Share_groups";
//        if ([gbl_lastSelectionType isEqualToString: @"group" ])  shareTitle = @"Share groups";
//
//        UIBarButtonItem *shareEntity = [[UIBarButtonItem alloc]initWithTitle: shareTitle
//                                                                   style: UIBarButtonItemStylePlain
//                                                                //style: UIBarButtonItemStyleBordered
//                                                                  target: self
//                                                                  action: @selector(pressedShareEntities)]; // People or Groups 
//

        //    [buttonItem setTitleTextAttributes:@{
        //         NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:26.0],
        //         NSForegroundColorAttributeName: [UIColor greenColor]
        //    } forState:UIControlStateNormal];
        //

        UIBarButtonItem *seeMembersButton = [[UIBarButtonItem alloc]initWithTitle: @"Members"
                                                                   style: UIBarButtonItemStylePlain
                                                                //style: UIBarButtonItemStyleBordered
                                                                  target: self
                                                                  action: @selector(pressedSeeMembersButton: )
        ]; 
        [seeMembersButton setTitleTextAttributes: @{
//            UIFont *font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size: 18.0f];
//                         NSFontAttributeName: [UIFont boldSystemFontOfSize: 14.0],
//              NSForegroundColorAttributeName: [UIColor greenColor]                            
//                         NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Bold" size: 18.0f]
//                         NSFontAttributeName: [UIFont boldSystemFontOfSize: 18.0],
//                         NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Medium" size: 18.0f]
//                         NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Medium" size: 16.0f]
                         NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Medium" size: 17.0f]
              }
                                        forState: UIControlStateNormal
        ];


        // choose fonts for bottom toolbar
        //
        // CGFloat   gbl_heightForScreen;  // 6+  = 736.0 x 414  and 6s+  (self.view.bounds.size.width) and height
        //                                 // 6s  = 667.0 x 375  and 6
        //                                 // 5s  = 568.0 x 320  and 5 
        //                                 // 4s  = 480.0 x 320  and 5 
        //
        //  NSLog(@"self.view.bounds.size.height  =[%f]",self.view.bounds.size.height  );
        UIFont *myBottomToolbarFont;
        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
            myBottomToolbarFont = [UIFont systemFontOfSize: 16.0];
        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            myBottomToolbarFont = [UIFont systemFontOfSize: 16.0];
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
            myBottomToolbarFont = [UIFont systemFontOfSize: 14];
        }
        else if (   self.view.bounds.size.width <= 320.0   // ??
        ) {
            myBottomToolbarFont = [UIFont systemFontOfSize: 15.0];
        }


//        [shareEntity setTitleTextAttributes: @{
//    //                    NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:26.0],
////                        NSFontAttributeName: [UIFont boldSystemFontOfSize: 20.0],
////                        NSFontAttributeName: [UIFont systemFontOfSize: 16.0],
////                        NSFontAttributeName: [UIFont systemFontOfSize: 14.0],
////                        NSFontAttributeName: [UIFont systemFontOfSize: 15.0],
////                        NSFontAttributeName: [UIFont systemFontOfSize: 16.0],
//                        NSFontAttributeName: myBottomToolbarFont,
//    //         NSForegroundColorAttributeName: [UIColor greenColor]
////             NSForegroundColorAttributeName: [UIColor blackColor]
//           }
//                                   forState: UIControlStateNormal
//        ];
//


        // 20160401 put this button in HOME info at bottom
        //
        //        UIBarButtonItem *backupAll   = [[UIBarButtonItem alloc]initWithTitle: @"Backup_all" 
        //                                                                   style: UIBarButtonItemStylePlain
        //                                                                  target: self
        //                                                                  action: @selector(pressedBackupAll)];
        //


//        UIBarButtonItem *changeGroupName   = [[UIBarButtonItem alloc]initWithTitle: @"Change_group_name" 
        UIBarButtonItem *changeGroupName   = [[UIBarButtonItem alloc]initWithTitle: @"Change group name" 
                                                                             style: UIBarButtonItemStylePlain
                                                                            target: self
                                                                            action: @selector(pressedChangeGroupName)];
//        [changeGroupName   setTitleTextAttributes: @{
//              NSFontAttributeName: myBottomToolbarFont,
//           }
//                                         forState: UIControlStateNormal
//        ];
//
        [changeGroupName   setTitleTextAttributes: @{
//              NSForegroundColorAttributeName: [UIColor greenColor]                            
//                         NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Medium" size: 17.0f]
//                         NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue" size: 16.5f]
                         NSFontAttributeName: [UIFont fontWithName: @"HelveticaNeue-Medium" size: 16.0f]
              }
                                        forState: UIControlStateNormal
        ];



        UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                                         target: self
                                                                                         action: nil];
        // create a Toolbar
//        UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
//        UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
//        gbl_toolbarForwBack = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];

    float my_screen_height;
    float my_status_bar_height;
    float my_nav_bar_height;
    float my_toolbar_height;

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];
    my_screen_height = currentScreenWidthHeight.height;

    CGSize myStatusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    my_status_bar_height   = MIN(myStatusBarSize.width, myStatusBarSize.height);

    my_nav_bar_height    =  self.navigationController.navigationBar.frame.size.height;


//  NSLog(@"cu33entScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
//  NSLog(@"cu33entScreenWidthHeight.height =%f",currentScreenWidthHeight.height );
    my_toolbar_height = 44.0;

  NSLog(@"my_screen_height                  =%f",my_screen_height );
  NSLog(@"my_status_bar_height              =%f",my_status_bar_height   );
  NSLog(@"my_nav_bar_height                 =%f",my_nav_bar_height    );
  NSLog(@"my_toolbar_height                 =%f",my_toolbar_height );


    float y_value_of_toolbar; 
    y_value_of_toolbar  = my_screen_height                                              - my_toolbar_height;
    gbl_toolbarHomeMaintenance.hidden =  NO;
  NSLog(@" SET toolbar hidden =  NO");

  NSLog(@"gbl_homeUseMODE =[%@]",gbl_homeUseMODE );
    if ([gbl_homeUseMODE isEqualToString:@"report mode"])
    {
  NSLog(@"SET toolbar hidden = YES");
        y_value_of_toolbar  = y_value_of_toolbar  + 100.0;  // MOVE the bottom toolbar off the bottom of the screen  *****
        gbl_toolbarHomeMaintenance.hidden = YES;
    }
    

  NSLog(@"y_value_of_toolbar  =%f",y_value_of_toolbar  );


    gbl_toolbarHomeMaintenance = [[UIToolbar alloc] initWithFrame:CGRectMake(
        0.0,
//            currentScreenWidthHeight.height - 44,
//        100.0,
        y_value_of_toolbar, 
        currentScreenWidthHeight.width,
        44.0)
    ];  // magic

    gbl_toolbarHomeMaintenance.tag         = 34;
    gbl_toolbarHomeMaintenance.translucent = NO;
    gbl_toolbarHomeMaintenance.backgroundColor = [UIColor whiteColor];


        // make array of buttons for the Toolbar
        //
        NSArray *myButtonArray;
        if ([gbl_lastSelectionType isEqualToString:@"group" ])
        {
            myButtonArray =  [NSArray arrayWithObjects:
//                myFlexibleSpace, shareEntity, myFlexibleSpace, changeGroupName, myFlexibleSpace,   nil
                myFlexibleSpace, seeMembersButton, myFlexibleSpace, changeGroupName, myFlexibleSpace,   nil

            ]; 
        }
//        if ([gbl_lastSelectionType isEqualToString:@"person"]) 
//        {
//            myButtonArray =  [NSArray arrayWithObjects:
//                myFlexibleSpace, shareEntity, myFlexibleSpace,  nil
//
//            ]; 
//        }
//

  NSLog(@"gbl_toolbarHomeMaintenance.tag         =[%ld]",(long)gbl_toolbarHomeMaintenance.tag         );
        // put the array of buttons in the Toolbar
        [gbl_toolbarHomeMaintenance setItems: myButtonArray   animated: NO];
nbn(156);


//        CATransition* myTransition = [CATransition animation];
//        //transition.startProgress = 0;
//        //transition.endProgress = 1.0;
//        //transition.type = kCATransitionPush;
//        //transition.subtype = kCATransitionFromRight;
//        myTransition.duration = 3.0;
// 
//        // Add the transition animation to layer
////        [gbl_toolbarHomeMaintenance.layer addAnimation: myTransition forKey:@"transition"];
//        [gbl_toolbarHomeMaintenance.layer addAnimation: myTransition forKey: nil];
//


        // put the Toolbar onto bottom of home screen view
        dispatch_async(dispatch_get_main_queue(), ^(void){
//             self.navigationController.toolbar.hidden = YES;


//            [self.view addSubview: gbl_toolbarHomeMaintenance ];

             [self.navigationController.view addSubview: gbl_toolbarHomeMaintenance ];

//   [self.navigationController.view addSubview: gbl_toolbarHomeMaintenance ];  // this worked  but in info, it stayed  also allows too fast
//             self.navigationController.toolbar.hidden = NO;
//            [self.navigationController.toolbar setItems: myButtonArray ]; 
//            self.navigationController.toolbar.items = myButtonArray; 
//             self.navigationController.toolbar.hidden = NO

  UIView *ptrToView = [self.navigationController.view viewWithTag: 34 ];
  NSLog(@"ptrToView =[%@]",ptrToView );
        });


//    }  // in "edit mode"  PUT  bottom toolbar  for home screen add Share_people_by_email (+ grp)   on bottom of screen

} // end of handleMaintenanceToolbar



- (void) doStuffOnSignificantTimeChange   // for   UIApplicationSignificantTimeChangeNotification
{
tn();
  NSLog(@"in  doStuffOnSignificantTimeChange  !!");

    MAMB09AppDelegate *myappDelegate= (MAMB09AppDelegate *) [[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m

    [myappDelegate gcy ];  // get real current year  and m and d



    // method gcy sends a notification when it is done
    // so that the following can be done:
    // 
    //      if we have valid data from gcy,
    //        then change all people current year if its different
    //
//

  NSLog(@"finished  doStuffOnSignificantTimeChange  !!");
} // end of doStuffOnSignificantTimeChange



- (void) doStuffOnEnteringForeground 
{
tn();trn("in doStuffOnEnteringForeground()   NOTIFICATION method     lastEntity stuff");


    //MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m




    // initialize current year from gbl_array_grp
    // gbl_cy_session_startup;   // format "20nn"  cy gotten from apl this session
    // gbl_cy_currentAllPeople;  // format "20nn"  cy gotten from grp allpeople
    // 
    // gbl_nameOfGrpHavingAllPeopleIhaveAdded; // "#allpeople"
//    // gbl_nameOfGrpHavingAllPeopleIhaveAdded; // "#meandmybffs"
    // gbl_recOfAllPeopleIhaveAdded;           //  = [ NSString stringWithFormat: @"%@||||||||||||||", // 15 flds for misc
    //


    // initialize current year from gbl_array_grp
    //
    NSString *prefixStr5 = [NSString stringWithFormat: @"%@|",gbl_nameOfGrpHavingAllPeopleIhaveAdded ];  // notice '|'
    for (NSString *elt in gbl_arrayGrp) {
        if ([elt hasPrefix: prefixStr5]) { 
            gbl_recOfAllPeopleIhaveAdded = elt;
            break;
        }
    }
  NSLog(@"gbl_recOfAllPeopleIhaveAdded =[%@]",gbl_recOfAllPeopleIhaveAdded );
    if (gbl_recOfAllPeopleIhaveAdded) {
        NSArray *myaparr  = [gbl_recOfAllPeopleIhaveAdded componentsSeparatedByString:@"|"];

        gbl_ExampleData_show    = myaparr [2]; // get fld#3 show example data switch     (0-based)  ("yes" or "no")

        gbl_cy_currentAllPeople = myaparr [4]; // get fld#5 year     (0-based)  (from "#allpeople" group rec)
        gbl_cm_currentAllPeople = myaparr [5]; // get fld#6 mth      (0-based)  (from "#allpeople" group rec)
        gbl_cd_currentAllPeople = myaparr [6]; // get fld#7 dayofmth (0-based)  (from "#allpeople" group rec)

        // THEREFORE  rely on value in allpeople record, like this -
        gbl_currentYearInt  = [gbl_cy_currentAllPeople intValue];  // have to set these 3 in case gcy never got to internet
        gbl_currentMonthInt = [gbl_cm_currentAllPeople intValue];  // have to set these 3 in case gcy never got to internet
        gbl_currentDayInt   = [gbl_cd_currentAllPeople intValue];  // have to set these 3 in case gcy never got to internet

    }
    // here, these 2 gbls are "nil" or a valid year

  NSLog(@"gbl_cy_currentAllPeople in doStuffOnEnteringForeground home after get allpeople =[%@]",gbl_cy_currentAllPeople );
  NSLog(@"gbl_cm_currentAllPeople in doStuffOnEnteringForeground home after get allpeople =[%@]",gbl_cm_currentAllPeople );
  NSLog(@"gbl_cd_currentAllPeople in doStuffOnEnteringForeground home after get allpeople =[%@]",gbl_cd_currentAllPeople );
  NSLog(@"gbl_currentYearInt      in doStuffOnEnteringForeground home after get allpeople =[%ld]",(long)gbl_currentYearInt );
  NSLog(@"gbl_currentMonthInt     in doStuffOnEnteringForeground home after get allpeople =[%ld]",(long)gbl_currentMonthInt );
  NSLog(@"gbl_currentDayInt       in doStuffOnEnteringForeground home after get allpeople =[%ld]",(long)gbl_currentDayInt );



    // date might have changed due to passage of time, so
    // 
    // get current date from internet on app startup
    // you need gbl_array_grp (done above)  to be there
    //
    //    MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
    [myappDelegate gcy ];  // get real current year for calendar year cap (= curr yr + 1)




    // get Document directory as URL and Str
    //
    gbl_sharedFM = [NSFileManager defaultManager];
    gbl_possibleURLs = [gbl_sharedFM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    gbl_appDocDirURL = nil;
    if ([gbl_possibleURLs count] >= 1) {
        gbl_appDocDirURL = [gbl_possibleURLs objectAtIndex:0];
    }
//    NSString *gbl_appDocDirStr = [gbl_appDocDirURL path];
    
    
        //    gbl_numRowsToTriggerIndexBar    = 90;
        //
        // CGFloat   gbl_heightForScreen;  // 6+  = 736.0 x 414  and 6s+  (self.view.bounds.size.width) and height
        //                                 // 6s  = 667.0 x 375  and 6
        //                                 // 5s  = 568.0 x 320  and 5 
        //                                 // 4s  = 480.0 x 320  and 5 
        //
        //  NSLog(@"self.view.bounds.size.height  =[%f]",self.view.bounds.size.height  );
        if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
        ) {
            gbl_numRowsToTriggerIndexBar    = 50;  
//            gbl_numRowsToTriggerIndexBar    = 20;   // for test
        }
        else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                 && self.view.bounds.size.width  > 320.0
        ) {
            gbl_numRowsToTriggerIndexBar    = 45;
//            gbl_numRowsToTriggerIndexBar    = 20;   // for test
        }
        else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
        ) {
            gbl_numRowsToTriggerIndexBar    = 38;
//            gbl_numRowsToTriggerIndexBar    = 20;   // for test
        }
        else if (   self.view.bounds.size.width <= 320.0   // ??
        ) {
            gbl_numRowsToTriggerIndexBar    = 33;
        }

    
    // lastEntity stuff  to (1) highlight correct entity in seg control at top and (2) highlight correct person-or-group
    //
    //

    [myappDelegate mamb_beginIgnoringInteractionEvents ];


    NSString *lastEntityStr = [myappDelegate mambReadLastEntityFile];

    //NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"=|"];
    NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"|"];
    _arr = [lastEntityStr componentsSeparatedByCharactersInSet: myNSCharacterSet];
     NSLog(@"_arr=%@", _arr);

    gbl_lastSelectionType            = _arr[0];  //  group OR person or pair
    gbl_fromHomeCurrentSelectionType = _arr[0];  //  group OR person or pair
    gbl_fromHomeCurrentEntity        = _arr[0];  //  group OR person or pair

    NSLog(@"gbl_lastSelectionType=%@",gbl_lastSelectionType);
    NSLog(@"gbl_fromHomeCurrentSelectionType =%@",gbl_fromHomeCurrentSelectionType );
    NSLog(@"gbl_fromHomeCurrentEntity        =[%@]",gbl_fromHomeCurrentEntity        );


//    if ([gbl_lastSelectionType isEqualToString:@"person"]) gbl_colorHomeBG = gbl_colorHomeBG_per;
//    if ([gbl_lastSelectionType isEqualToString:@"group" ]) gbl_colorHomeBG = gbl_colorHomeBG_grp;
//    self.tableView.backgroundColor = gbl_colorHomeBG;       // WORKS
//  NSLog(@"gbl_colorHomeBG=[%@]",gbl_colorHomeBG);


  NSLog(@"gbl_colorHomeBG     =[%@]",gbl_colorHomeBG );
  NSLog(@"gbl_homeUseMODE5    =[%@]",gbl_homeUseMODE );


    // set dependent gbl vars for highlighted group
    //
    if ([gbl_lastSelectionType isEqualToString:@"group"]) {
        gbl_lastSelectedGroup            = _arr[1];  // like "~Swim Team"
        gbl_lastSelectedPerson           = _arr[3];  // like "~Dave"
        gbl_colorHomeBG                  = gbl_colorHomeBG_grp;
        gbl_currentMenuPrefixFromHome    = @"homg";
        self.tableView.separatorColor    = gbl_colorSepara_grp;


    }
    if ([gbl_lastSelectionType isEqualToString:@"person"]) {
        gbl_lastSelectedPerson           = _arr[1];  // like "~Dave"
        gbl_lastSelectedGroup            = _arr[3];  // like "~Swim Team"
        gbl_colorHomeBG                  = gbl_colorHomeBG_per;
        gbl_currentMenuPrefixFromHome    = @"homp";
        self.tableView.separatorColor    = gbl_colorSepara_per;
    }





    // override 2 brown BG colors for YELLOW  if this is in edit mode
    if ([gbl_homeUseMODE       isEqualToString:@"edit mode"]) {
        gbl_colorHomeBG                  = gbl_colorEditingBG;  // temporary yellow color for editing 
    }

    self.tableView.backgroundColor = gbl_colorHomeBG;       // WORKS

    NSLog(@"in doStuffOnEnteringForeground gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
    NSLog(@"in doStuffOnEnteringForeground gbl_lastSelectedGroup =%@", gbl_lastSelectedGroup );
//    NSLog(@"gbl_colorHomeBG                                      =[%@]",gbl_colorHomeBG);


    if ([gbl_lastSelectionType isEqualToString:@"group"])  _segEntityOutlet.selectedSegmentIndex = 0; // highlight correct entity in seg ctrl
    if ([gbl_lastSelectionType isEqualToString:@"person"]) _segEntityOutlet.selectedSegmentIndex = 1; // highlight correct entity in seg ctrl

    gbl_scrollToCorrectRow = 1;
    [self putHighlightOnCorrectRow ];

   
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.3 ];    // after arg seconds

trn("at END of  doStuffOnEnteringForeground()   NOTIFICATION method     lastEntity stuff");
tn();
} // end of  doStuffOnEnteringForeground()


- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];  // will crash without this
}


     // comment out entire   // SECTION INDEX VIEW     for test create empty Launch screen shot 

//--------------------------------------------------------------------------------------------
// SECTION INDEX VIEW
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;  // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))


//
// iPhone UITableView. How do turn on the single letter alphabetical list like the Music App?
//
//
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
tn();
  NSLog(@"in sectionIndexTitlesForTableView !");

//return nil;  // test no section index

    // turn off section index if in yellow edit mode (make room for big "Delete" button on right)
    //
    if ( [gbl_homeUseMODE isEqualToString: @"edit mode" ]) return nil;   // yellow


    //   NSMutableArray *myEmptyArray = [NSMutableArray array];
    NSInteger myCountOfRows;
    myCountOfRows = 0;


    if ([gbl_lastSelectionType isEqualToString:@"group"]) 
    {
        if ([gbl_ExampleData_show isEqualToString: @"yes"])
        {
           myCountOfRows = gbl_arrayGrp.count;
        } else {
           // Here we do not want to show example data.
           // Because example data names start with "~", they sort last,
           // so we can just reduce the number of rows to exclude example data from showing on the screen.
           myCountOfRows = gbl_arrayGrp.count - gbl_ExampleData_count_grp ;
        }
    }

    if ([gbl_lastSelectionType isEqualToString:@"person"])
    {
        if ([gbl_ExampleData_show isEqualToString: @"yes"])
        {
           myCountOfRows = gbl_arrayPer.count;
        } else {
           // Here we do not want to show example data.
           // Because example data names start with "~", they sort last,
           // so we can just reduce the number of rows to exclude example data from showing on the screen.
           myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;
        }
    }

nbn(160);
  NSLog(@"myCountOfRows              =[%ld]", (long)myCountOfRows );
  NSLog(@"gbl_numRowsToTriggerIndexBar=[%ld]", (long)gbl_numRowsToTriggerIndexBar);
    if (myCountOfRows <= gbl_numRowsToTriggerIndexBar) {
nbn(161);
//        return myEmptyArray ;  // no sectionindex
        return nil ;  // no sectionindex
    }
nbn(162);

    NSArray *mySectionIndexTitles = [NSArray arrayWithObjects:  // 33 items  last index=32
//         @"A", @"B", @"C", @"D",  @"E", @"F", @"G", @"H", @"I", @"J",  @"K", @"L", @"M",
//         @"N", @"O", @"P",  @"Q", @"R", @"S", @"T", @"U", @"V",  @"W", @"X", @"Y", @"Z",   nil ];

//            @"TOP",
//         @" ", @" ", @" ", @" ",  @" ", @" ",
//         @" ", @" ", @" ", @" ",  @" ", @" ",
//         @" ", @" ", @" ", @" ",  @" ", @" ",
//         @" ", @" ", @" ", @" ",  @" ", @" ",
//            @"END",
//            nil

//            @"______",
//            @"__TOP_",
//         @"      ", @"      ", @"      ", @"      ",  @"      ", 
//            @"______",
//         @"      ", @"      ", @"      ", @"      ",  @"      ",
//            @"______",
//         @"      ", @"      ", @"      ", @"      ",  @"      ", 
//            @"______",
//         @"      ", @"      ", @"      ", @"      ",  @"      ", 
//            @"__END_",
//            @"______",
//            nil
//



//            @"___",
//            @"TOP",
//            @"   ", @"   ", @"   ", @"   ",  @"   ", 
//            @" _ ",
//            @"   ", @"   ", @"   ", @"   ",  @"   ",
//            @" _ ",
//            @"   ", @"   ", @"   ", @"   ",  @"   ", 
//            @" _ ",
//            @"   ", @"   ", @"   ", @"   ",  @"   ", 
//            @"END",
//            @"___",
//            nil
//



//            @"_________",
            @"_______",
            @"TOP",
            @"     ", @"     ", @"     ", @"     ",  @"     ", 
            @"__",
            @"     ", @"     ", @"     ", @"     ",  @"     ",
            @"__",
            @"     ", @"     ", @"     ", @"     ",  @"     ", 
            @"__",
            @"     ", @"     ", @"     ", @"     ",  @"     ", 
            @"END",
            @"_______",
//            @"_________",
            nil



    ];
//            @"END", nil ];
//            @"bottom", nil ];
//            @"_END_", nil ];


    gbl_numSectionIndexTitles = mySectionIndexTitles.count;

    return mySectionIndexTitles;


//
//    NSMutableSet    *mySetSectionIndexTitles = [[NSMutableSet alloc] init];
//    NSMutableArray  *myArrSectionIndexTitles;
//    NSMutableArray  *mutArrayNewTmp = [[NSMutableArray alloc] init];
//    NSString        *firstLetter, *pername, *grpname;
//
//    // grab ALL  first letters of all entities for use as section index titles
////    if ([gbl_lastSelectionType isEqualToString: @"group"])  {
////        myCountOfRows = gbl_arrayGrp.count;
////        for (NSString *grp in gbl_arrayGrp) {
////            firstLetter = [grp substringFromIndex: 1 ];
////            if ([firstLetter isEqualToString: @"~"]) continue;
////            [mySetSectionIndexTitles addObject: firstLetter ];
////        }
////        myArrSectionIndexTitles = [mySetSectionIndexTitles allObjects];
////    }
////
//    if ([gbl_lastSelectionType isEqualToString: @"person"])  {
//        myCountOfRows = gbl_arrayPer.count;
//        for (NSString *perrec in gbl_arrayPer) {
//  NSLog(@"perrec         =[%@]",perrec);
//            pername = [perrec  componentsSeparatedByString:@"|"][0];  // get fld1 (name) 0-based 
//  NSLog(@"pername =[%@]",pername );
//            if ([pername isEqualToString: @""]  || pername == nil) continue;
//            firstLetter = [pername substringToIndex: 1 ];
//  NSLog(@"firstLetter =[%@]",firstLetter );
//            if ([firstLetter isEqualToString: @"~"]) continue;
//            
//            firstLetter = [firstLetter uppercaseString];
//  NSLog(@"firstLetterU=[%@]",firstLetter );
//
//            [mySetSectionIndexTitles addObject: firstLetter ];
//        }
//    }
//  NSLog(@"mySetSectionIndexTitles =[%@]",mySetSectionIndexTitles );
//
//
//    // tremendous mystery  ??    but it works
//    //
//    NSSortDescriptor *mySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description"  ascending:YES];
//    myArrSectionIndexTitles = [mySetSectionIndexTitles sortedArrayUsingDescriptors:[NSArray arrayWithObject: mySortDescriptor ]];
//
//  NSLog(@"myArrSectionIndexTitles 1 =[%@]",myArrSectionIndexTitles);
//
//    return myArrSectionIndexTitles;
//




} // end of sectionIndexTitlesForTableView


//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
// {
//    [super touchesEnded:touches withEvent:event];
//
//  NSLog(@"in touchesEnded !");
//
//     if(((UITouch *)[touches anyObject]).tapCount == 2)
//    {
//    NSLog(@"DOUBLE TOUCH");
//    }
//}
//


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{

  NSLog(@"sectionForSectionIndexTitle!  in HOME");
  NSLog(@"title=[%@]",title);
  NSLog(@"atIndex=[%ld]",(long)index);



    // find first group starting with title letter (guaranteed to be there, see sectionIndexTitlesForTableView )
    NSInteger newRow;  newRow = 0;
    NSIndexPath *newIndexPath;
    NSInteger myCountOfRows;
    myCountOfRows = 0;

//    NSString *pername, *grpname;
//    if ([gbl_lastSelectionType isEqualToString:@"group"])  {
//        myCountOfRows = gbl_arrayGrp.count;
//        for (NSString *grp in gbl_arrayGrp) {
//            newRow = newRow + 1;
//            if ([grp hasPrefix: title])  break;
//        }
//    }
//    if ([gbl_lastSelectionType isEqualToString:@"person"])  {
//        myCountOfRows = gbl_arrayPer.count;
//        for (NSString *perrec in gbl_arrayPer) {
//            pername = [perrec  componentsSeparatedByString:@"|"][0]; // get fld1 (name) 0-based 
//  NSLog(@"pername =[%@]",pername );
//  NSLog(@"newRow  =[%ld]",(long)newRow );
//            if ([pername hasPrefix: @"~"]) continue;
//            newRow = newRow + 1;
//            if ([pername hasPrefix: title])  break;
//        }
//    }
//  NSLog(@"newRow =[%ld]",(long)newRow );
//
//    newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];
//    [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];
//


//    if ([gbl_lastSelectionType isEqualToString:@"group"])   myCountOfRows = gbl_arrayGrp.count;
//    if ([gbl_lastSelectionType isEqualToString:@"person"])  myCountOfRows = gbl_arrayPer.count;
    if ([gbl_lastSelectionType isEqualToString:@"group"]) 
    {
        if ([gbl_ExampleData_show isEqualToString: @"yes"] ) 
        {
           myCountOfRows = gbl_arrayGrp.count;
        } else {
           // Here we do not want to show example data.
           // Because example data names start with "~", they sort last,
           // so we can just reduce the number of rows to exclude example data from showing on the screen.
           myCountOfRows = gbl_arrayGrp.count - gbl_ExampleData_count_grp ;
        }
    }

    if ([gbl_lastSelectionType isEqualToString:@"person"])
    {
        if ([gbl_ExampleData_show isEqualToString: @"yes"] ) 
        {
           myCountOfRows = gbl_arrayPer.count;
        } else {
           // Here we do not want to show example data.
           // Because example data names start with "~", they sort last,
           // so we can just reduce the number of rows to exclude example data from showing on the screen.
           myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;
        }
    }


    if (     [title isEqualToString:@"TOP"]) newRow = 0;
    else if ([title isEqualToString:@"END"]) newRow = myCountOfRows - 1;
    else                                     newRow = ((double) (index + 1) / (double) gbl_numSectionIndexTitles ) * (double)myCountOfRows ;
//    else if ([title isEqualToString:@"     "]
//        || [title isEqualToString:@"__"]
//        || [title isEqualToString:@"_____"] 
//    )   newRow = ((double) (index + 1) / (double) gbl_numSectionIndexTitles ) * (double)myCountOfRows ;

    if (newRow == myCountOfRows)  newRow = newRow - 1;

  NSLog(@"gbl_numSectionIndexTitles =[%ld]",(long)gbl_numSectionIndexTitles );
  NSLog(@"newRow                    =[%ld]", (long)newRow);
  NSLog(@"myCountOfRows             =[%ld]", (long)myCountOfRows   );

//    if (   [title isEqualToString:@"x"] )
//    {  // position at row last used  (highlight row)
//nbn(151);
//        gbl_scrollToCorrectRow = 1;
//        [self putHighlightOnCorrectRow ];
//    }

    newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];
    [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];

    return index;

} // sectionForSectionIndexTitle


//
//// Return the index for the location of the first item in an array that begins with a certain character
//- (NSInteger)indexForFirstChar:(NSString *)character inArray:(NSArray *)array
//{
//    NSUInteger count = 0;
//    for (NSString *str in array) {
//        if ([str hasPrefix:character]) {
//          return count;
//        }
//        count++;
//    }
//    return 0;
//}
//
//
//// Return the index for the location of the first item in an array that begins with a certain character
//// Here is a modified version of Kyle's function that handles the case of clicking an index for which you do not have a string:
////
//- (NSInteger)indexForFirstChar:(NSString *)character inArray:(NSArray *)array
//{
//    char testChar = [character characterAtIndex:0];
////    __block int retIdx = 0;
////    __block int lastIdx = 0;
////    __block int retIdx = 0;
////    __block int lastIdx = 0;
//    __block unsigned long retIdx = 0;
//    __block unsigned long lastIdx = 0;
//
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        char firstChar = [obj characterAtIndex:0];
//
//        if (testChar == firstChar) {
//            retIdx = idx;
//            *stop = YES;
//        }
//
//        //if we overshot the target, just use whatever previous one was
//        if (testChar < firstChar) {
//            retIdx = lastIdx;
//            *stop = YES;
//        }
//
//        lastIdx = idx;
//    }];
//    return retIdx;
//}
//

// end of 
// iPhone UITableView. How do turn on the single letter alphabetical list like the Music App?

// end of SECTION INDEX VIEW
//--------------------------------------------------------------------------------------------


  // END of comment out entire    // SECTION INDEX VIEW     for test create empty Launch screen shot 



// ===  EDITING  ================================================================================

//
//   https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/EnablingEditModeinaViewController/EnablingEditModeinaViewController.html#//apple_ref/doc/uid/TP40007457-CH14-SW5
//
// When implementing your navigation interface, you can include a special Edit button in the navigation bar
// when your editable view controller is visible.
// (You can get this button by calling the editButtonItem method of your view controller.)
//
// WHEN TAPPED, THIS BUTTON AUTOMATICALLY TOGGLES BETWEEN AN eDIT AND dONE BUTTON AND
// CALLS YOUR VIEW CONTROLLER’S  setEditing:animated:  METHOD WITH APPROPRIATE VALUES.
//
// You can also call this method from your own code (or modify the value of your view controller’s editing property) to toggle between modes.
//

//
// SETEDITING
//
// When you call this method with the value of editing set to YES,
// the table view goes into editing mode by calling setEditing:animated: on each visible UITableViewCell object.
// Calling this method with editing set to NO turns off editing mode.
// In editing mode, the cells of the table might show an insertion or deletion control on the left side of each cell
// and a reordering control on the right side, depending on how the cell is configured.
// The data source of the table view can selectively exclude cells from editing mode by implementing tableView:canEditRowAtIndexPath:.
//
- (void)setEditing: (BOOL)flag // editButtomItem AUTOMATICALLY TOGGLES BETWEEN AN Edit(flag=y) & Done(flag=n) BUTTON AND CALLS setEditing
          animated: (BOOL)animated
{
    [super setEditing: flag animated: animated];

tn();  NSLog(@"setEditing !!!!!!  pressed Edit or Done  !!!!!!!!!!!!!!!");
  NSLog(@"=%d",flag);
  NSLog(@"=%d",animated);


    //    [self.editButtonItem setImage: nil ];     // edit mode bg color for button
    //    self.editButtonItem.title = @"";  
    self.editButtonItem.title = nil;   // this gets rid of left/right shift of Edit/Done buttons when pressed



    UIBarButtonItem *navAddButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                                                                   target: self
                                                                                   action: @selector(navAddButtonAction:)
    ];


    // this gets set below to Edit or Done button image
//    [self.editButtonItem setImage:  [[UIImage alloc] init]];     // edit mode bg color for button


//    if (flag == YES)   //  USER TAPPED  EDIT  BUTTON HERE
//    {
//        self.navigationController.toolbarHidden =  NO;  // ensure that the bottom of screen toolbar is NOT visible 
//    } else {           //  USER TAPPED  DONE  BUTTON HERE
//        self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar is NOT visible 
//    }


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];



    // delay was to prevent double/triple etc. clicks on Edit/Done button
    // delay abandoned  20160406  (caused flash when hit  Edit/Done )  (double clicks apparently OK);
    ////    int64_t myDelayInSec   = 2.33 * (double)NSEC_PER_SEC;
    ////    int64_t myDelayInSec   = 0.33 * (double)NSEC_PER_SEC;
    //    int64_t myDelayInSec   = 0.38 * (double)NSEC_PER_SEC;
    //    dispatch_time_t mytime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)myDelayInSec);
    //
    //    dispatch_after(mytime, dispatch_get_main_queue(), ^{                     // do after delay of  mytime
    //
    //


        //// start DO STUFF HERE

//    // HIDE BOTTOM TOOLBAR (used for edit mode - tap edit button)
//    //
//    self.navigationController.toolbarHidden = YES;  // ensure that the bottom of screen toolbar is NOT visible 



    // put on a bottom FOOTER to account for BOTTOM TOOLBAR if this is yellow edit mode
    //
    if (flag == YES) { // Change views to edit mode.   USER TAPPED EDIT BUTTON HERE

       gbl_homeUseMODE = @"edit mode";

       // magic 44 is the specified height of bottom footer
       self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44.0);

       UIView *footer = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1, 44)];  // magic 44 is the specified height of bottom footer
       footer.backgroundColor = [UIColor clearColor];
       self.tableView.tableFooterView = footer;


    } else {

       gbl_homeUseMODE = @"report mode";
       self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height       );

       self.tableView.tableFooterView = nil;
    }


    if (flag == YES) // Change views to edit mode.   USER TAPPED EDIT BUTTON HERE
    {                // Change views to edit mode.   USER TAPPED EDIT BUTTON HERE


  NSLog(@"EDIT BUTTON 2    ");
  NSLog(@"gbl_homeUseMODE 1   =[%@]",gbl_homeUseMODE );



        gbl_homeUseMODE = @"edit mode";   // determines home mode  @"edit mode" or @"report mode"
  NSLog(@"gbl_homeUseMODE 2   =[%@]",gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
nbn(300);

//  NSLog(@"gbl_homeLeftItemsWithAddButton=%@",gbl_homeLeftItemsWithAddButton);
//  NSLog(@"gbl_homeLeftItemsWithNoAddButton=%@",gbl_homeLeftItemsWithNoAddButton);
  NSLog(@"EDIT BUTTON 2   set yellow   BG color");

  NSLog(@"gbl_colorEditingBG=[%@]",gbl_colorEditingBG);

        // Change views to edit mode.   USER TAPPED EDIT BUTTON HERE

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

//<.>
//  NSLog(@"EDIT BUTTON 1   set yellow          ");
//nbn(500);
//            [self.editButtonItem setImage: gbl_yellowEdit ];     // edit mode bg color for button
//            self.navigationItem.rightBarButtonItems =   // "editButtonItem" is magic Apple functionality
//            [self.navigationItem.rightBarButtonItems arrayByAddingObject: self.editButtonItem]; //editButtonItem=ADD apple-provided EDIT BUTTON
//
//<.>
//

        // ORIG version:
        //
        //
        //            //    USER TAPPED EDIT BUTTON HERE
        //            //
        //            self.editButtonItem.title = nil;   // this gets rid of left/right shift of Edit/Done buttons when pressed
        //            // this gets set below to Edit or Done button image
        //            [self.editButtonItem setImage:  [[UIImage alloc] init]];     // edit mode bg color for button
        //            [self.editButtonItem setImage: gbl_brownDone ];     // report mode bg color for button
        //            [self.navigationItem.rightBarButtonItems arrayByAddingObject: self.editButtonItem]; //editButtonItem=ADD apple-provided EDIT BUTTON
        //
        //
        //  NSLog(@"EDIT BUTTON 2   set title  done tab");
        //
        //

nbn(335);
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
//    [self.navigationItem.rightBarButtonItems removeObject: self.editButtonItem]; //editButtonItem=ADD apple-provided EDIT BUTTON


//        self.editButtonItem.title = nil;   // this gets rid of left/right shift of Edit/Done buttons when pressed
////        self.editButtonItem.backgroundimage = nil; 
//        // this gets set below to Edit or Done button image
//        [self.editButtonItem setImage:  [[UIImage alloc] init]];     // edit mode bg color for button

        [self.editButtonItem setImage: gbl_brownDone ];     // report mode bg color for button

//
//

//    if (![self.navigationItem.rightBarButtonItems containsObject: self.editButtonItem ]) {
//        // The following line adds the object to the end of the array.  
//        // If you want to add the button somewhere else, use the `insertObject:atIndex:` 
//        // method instead of the `addObject` method.
//
//        [self.navigationItem.rightBarButtonItems addObject: self.editButtonItem]; //editButtonItem=ADD apple-provided EDIT BUTTON
//
////        [self setToolbarItems:toolbarButtons animated:YES];
//    }
//



//<.>
//
//            // remove left share icon and replace  with  app icon
//            //
//            self.navigationItem.leftBarButtonItem  = nil;
//            self.navigationItem.leftBarButtonItem  = gbl_icon_UIBarButtonItem ;
//            self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItems  arrayByAddingObject: navAddButton];
//
//<.>
//





  NSLog(@"EDIT BUTTON 2   set title  done tab");


// 2016jun    CODE is in project, but was not used   //  MAMB09_selShareEntityTableViewController.m
//
//2016 jun remove share icon for share people/groups
//
//            // remove left app icon and replace  with share icon
//            //
//            UIBarButtonItem *shareButton  = [[UIBarButtonItem alloc]
//                                            initWithBarButtonSystemItem: UIBarButtonSystemItemAction   // share icon
//                                                                 target: self
//                                                                 action: @selector(pressedShareEntities:)];
//            self.navigationItem.leftBarButtonItem  = nil;
//            self.navigationItem.leftBarButtonItem  = shareButton;
//            self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItems  arrayByAddingObject: navAddButton];
//


//        UIImage *iconImage = [UIImage imageNamed: @"rounded_MAMB09_029.png"];
//        iconImage          = [iconImage imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
//        UIBarButtonItem *iconButton = [[UIBarButtonItem alloc] initWithImage: iconImage 
//                                                                       style: UIBarButtonItemStylePlain
//                                                                      target: self
//                                                                      action: nil
//        ];

//            self.navigationItem.leftBarButtonItem  = iconButton; 
//            self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItems  arrayByAddingObject: navAddButton];
//
// 2016jun    CODE is in project, but was not used   //  MAMB09_selShareEntityTableViewController.m






//    self.navigationController.navigationBar.barTintColor =  gbl_colorEditing;  does whole nav bar



        gbl_colorHomeBG               = gbl_colorEditingBG;  // temporary yellow color for editing 

//        self.segmentedControl.backgroundColor = gbl_colorEditingBG;     // [UIColor cb_Grey3Color];
//        self.segEntityOutlet.backgroundColor = gbl_colorEditingBG;     


//
//        // UITableViewCellAccessoryDisclosureIndicator,    tapping the cell triggers a push action
//        // UITableViewCellAccessoryDetailDisclosureButton, tapping the cell allows the user to configure the cell’s contents
//        //
//
//        // GOLD:  http://stackoverflow.com/questions/18740594/in-ios7-uitableviewcellaccessorydetaildisclosurebutton-is-divided-into-two-diff
//        // This is the correct behavior.
//        // In iOS 7, 
//        // UITableViewCellAccessoryDetailDisclosureButton    you show both the "detail button" and the "disclosure indicator" 
//        // UITableViewCellAccessoryDetailButton              If you'd only like the "i" button
//        // UITableViewCellAccessoryDisclosureIndicator       if you'd only like the "disclosure indicator
//        // 
//        gbl_home_cell_AccessoryType        = UITableViewCellAccessoryNone;
////      gbl_home_cell_editingAccessoryType = UITableViewCellAccessoryDetailDisclosureButton; // home mode edit  with tap giving record details
//        gbl_home_cell_editingAccessoryType = UITableViewCellAccessoryDetailButton; // home mode edit    with tap giving record details
//
//


    

NSLog(@"in setEditing, PERSON  reload table here!  USER TAPPED EDIT BUTTON HERE");

        [self.tableView reloadData]; // reload to    edit mode    reload reload reload reload reload reload ");

//tn();trn("reload to    edit mode    reload reload reload reload reload reload ");



        });  // dispatch_async(dispatch_get_main_queue()




//
////        self.editButtonItem.tintColor = [UIColor redColor];   // colors text
//        NSInteger buttonctr;
//        buttonctr = 0;
//        for (UIView *myview in self.navigationController.navigationBar.subviews) {
////NSLog(@"NAV BAR subview class DESCRIPTION=[%@]", [[myview class] description]);
//
//// fun test
////if (buttonctr == 0)  myview.backgroundColor = [UIColor grayColor];
////if (buttonctr == 1)  myview.backgroundColor = [UIColor cyanColor];
////if (buttonctr == 2)  myview.backgroundColor = [UIColor blueColor];
////if (buttonctr == 3)  myview.backgroundColor = [UIColor greenColor];
////if (buttonctr == 4)  myview.backgroundColor = [UIColor redColor];
////if (buttonctr == 5)  myview.backgroundColor = [UIColor orangeColor];
////if (buttonctr == 6)  myview.backgroundColor = [UIColor blackColor];
//            buttonctr = buttonctr + 1;
//
//            if ([[[myview class] description] isEqualToString:@"UINavigationButton"]) {
////  NSLog(@"buttonctr =%ld", buttonctr);
//
////                myview.backgroundColor = gbl_colorEditing;
//
////                self.editButtonItem.tintColor = [UIColor blackColor];   // colors text
////                self.editButtonItem.tintColor = [UIColor redColor];   // colors text
//            }
//
//        }


    // NSInteger gbl_scrollToCorrectRow;  // flag to set every time before calling [self putHighlightOnCorrectRow ] in HOME
    //                                   // (do not want to scroll when hitting yellow/Edit and brown/Done)
    gbl_scrollToCorrectRow = 0;
    [self putHighlightOnCorrectRow ];




nbn(141);
    [self handleMaintenanceToolbar ];

        // Change views to   edit mode.



    } else { // Save the changes if needed and change the views to noneditable.   USER TAPPED  DONE BUTTON HERE


        //  USER TAPPED  DONE BUTTON HERE
        //  USER TAPPED  DONE BUTTON HERE
        //  USER TAPPED  DONE BUTTON HERE


        // Change views from edit mode.

  NSLog(@"EDIT BUTTON 3 ");
  NSLog(@"gbl_homeUseMODE 1   =[%@]",gbl_homeUseMODE );

        gbl_homeUseMODE = @"report mode";   // determines home mode  @"edit mode" or @"report mode"
  NSLog(@"gbl_homeUseMODE 2   =[%@]",gbl_homeUseMODE );
  NSLog(@"gbl_homeEditingState=[%@]",gbl_homeEditingState);
nbn(311);


  NSLog(@"EDIT BUTTON 3   ");
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

//
////            [self.editButtonItem setBackgroundImage: gbl_YellowBG          // regular report mode bg color for button
//            [self.editButtonItem setBackgroundImage: gbl_yellowEdit          // edit mode bg color for button
//                                           forState: UIControlStateNormal  
//                                         barMetrics: UIBarMetricsDefault
//            ];
//
////            self.navigationItem.leftBarButtonItems = gbl_homeLeftItemsWithAddButton;
//  NSLog(@"EDIT BUTTON 3   set title  edit tab");
////            self.editButtonItem.title = @"Edit\t";  // pretty good
//            self.editButtonItem.title = @"Edit";  // ok with no tab
//
//
////            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-12.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 
////            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-8.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 
//            [self.editButtonItem setTitlePositionAdjustment: UIOffsetMake(-16.0f, 0.0f)  forBarMetrics: UIBarMetricsDefault]; // 
//


//            [self.editButtonItem setImage: nil        // edit mode bg color for button
//            ];



    self.editButtonItem.title = nil;   // this gets rid of left/right shift of Edit/Done buttons when pressed
    // this gets set below to Edit or Done button image
            [self.editButtonItem setImage:  [[UIImage alloc] init]];  
            [self.editButtonItem setImage: gbl_yellowEdit        // edit mode bg color for button
            ];

            // ? apparently do not need this here, although it occurs on press edit button  why? - but it works.
            //
            // [self.navigationItem.rightBarButtonItems arrayByAddingObject: self.editButtonItem]; // apple-provided EDIT BUTTON

  NSLog(@"EDIT BUTTON 3   set yellow          ");


            // remove left share icon and replace  with  app icon    barbuttonitem
            //
            self.navigationItem.leftBarButtonItem  = nil;
            self.navigationItem.leftBarButtonItem  = gbl_icon_UIBarButtonItem ;
            self.navigationItem.leftBarButtonItems = [self.navigationItem.leftBarButtonItems  arrayByAddingObject: navAddButton];



  NSLog(@"gbl_haveAddedNavBarRightItems =[%ld]",(long)gbl_haveAddedNavBarRightItems );

            if (     [gbl_homeUseMODE isEqualToString: @"edit mode" ] ) [self.tableView setBackgroundColor: gbl_colorEditingBG];
            else if ([gbl_lastSelectionType isEqualToString:@"person"]) [self.tableView setBackgroundColor: gbl_colorHomeBG_per];
            else if ([gbl_lastSelectionType isEqualToString:@"group" ]) [self.tableView setBackgroundColor: gbl_colorHomeBG_grp];


 

        // try with add button always
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            self.navigationItem.leftBarButtonItems = gbl_homeLeftItemsWithNoAddButton;
//        });

//        gbl_colorHomeBG                = gbl_colorHomeBG_save;  // in order to put back after editing mode color

        if ([gbl_lastSelectionType isEqualToString:@"person"]) gbl_colorHomeBG = gbl_colorHomeBG_per;
        if ([gbl_lastSelectionType isEqualToString:@"group" ]) gbl_colorHomeBG = gbl_colorHomeBG_grp;
        self.tableView.backgroundColor = gbl_colorHomeBG;       // WORKS



//
//        // UITableViewCellAccessoryDisclosureIndicator,    tapping the cell triggers a push action
//        // UITableViewCellAccessoryDetailDisclosureButton, tapping the cell allows the user to configure the cell’s contents
//        //
//        gbl_home_cell_AccessoryType        = UITableViewCellAccessoryDisclosureIndicator; // home mode regular with tap giving report list
//        gbl_home_cell_editingAccessoryType = UITableViewCellAccessoryNone;                // home mode regular with tap giving report list
//
//

NSLog(@"in setEditing, PERSON  reload table here!  USER TAPPED DONE BUTTON HERE");
        [self.tableView reloadData]; // reload to regular mode    reload reload reload reload reload reload ");


   });  // dispatch_async(dispatch_get_main_queue()




//        tn();trn("reload to regular mode    reload reload reload reload reload reload ");

// forget all special colors
//        for (UIView *myview in self.navigationController.navigationBar.subviews) {
//            NSLog(@"%@", [[myview class] description]);
//            if ([[[myview class] description] isEqualToString:@"UINavigationButton"]) {
//
////                myview.backgroundColor = gbl_color_cAplTop;
//                self.editButtonItem.tintColor = gbl_color_cAplBlue;   // colors text
//            }
//
//        }
        
//        NSMutableArray *myMutableLeftItems = [NSMutableArray arrayWithArray: self.navigationItem.leftBarButtonItems ];
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [ myMutableLeftItems removeObjectAtIndex: 1 ];                 // remove add button from array
//            self.navigationItem.leftBarButtonItems = myMutableLeftItems;
//        });
//




//    [self putHighlightOnCorrectRow ];

    // NSInteger gbl_scrollToCorrectRow;  // flag to set every time before calling [self putHighlightOnCorrectRow ] in HOME
    //                                   // (do not want to scroll when hitting yellow/Edit and brown/Done)
    gbl_scrollToCorrectRow = 0;
    [self putHighlightOnCorrectRow ];



nbn(142);
    [self handleMaintenanceToolbar ];


    } // end of USER TAPPED  DONE BUTTON HERE

        //// end DO STUFF HERE



    [self.view setUserInteractionEnabled: YES];                          // this works to disable user interaction for "mytime"



// delay was to prevent double/triple etc. clicks on Edit/Done button
// delay abandoned  20160406  (caused flash when hit  Edit/Done )  (double clicks apparently OK);
//    }); // do after delay of  mytime = dispatch_after(mytime, dispatch_get_main_queue  // do after delay of  mytime



//nbn(141);
//    [self handleMaintenanceToolbar ];

    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

//    [self putHighlightOnCorrectRow ];


} // end of  setEditing: (BOOL)flag   animated: (BOOL)animated



//NSString *gbl_homeUseMODE;      // "edit mode" (yellow)   or   "report mode" (blue)
//NSString *gbl_homeEditingState; // if gbl_homeUseMODE = "edit mode"    then can be "add" or "view or change"   for tapped person or group
///
//- (void) codeForCellTapOrAccessoryButtonTapWithIndexPath:(NSIndexPath *)indexPath  // for  gbl_homeUseMODE  =  "edit mode" (yellow)
- (void) codeForCellTapWithIndexPath:(NSIndexPath *)indexPath  // for  gbl_homeUseMODE  =  "edit mode" (yellow)
{
tn();    NSLog(@"in codeForCellTapWithIndexPath:");
  NSLog(@"gbl_homeUseMODE           =[%@]",gbl_homeUseMODE           );
  NSLog(@"gbl_fromHomeCurrentEntity =[%@]",gbl_fromHomeCurrentEntity );

        // philosophy  on people list yellow  OR  on group list yellow 
        //
        // gbl_homeUseMODE isEqualToString: @"edit mode" // = yellow
        //   CASE_A   - tap on right side "i" button  ALWAYS  get add/change  screen
        //            - tap on left  side "-" button  ALWAYS  get delete  of person or group
        //   CASE_B   - tap on name in cell - for "group"   get group list (selPerson screen where you can "+" or "-" group members)
        //   CASE_C   - tap on name in cell - for "person"  get add/change  screen
        //

// 2016014  change behaviour to do edit details now, instead of nothing
// //      //   CASE_C   - tap on name in cell - for "person"  get nothing
//    if (   [gbl_homeUseMODE           isEqualToString: @"edit mode" ]     // = yellow
//        && [gbl_fromHomeCurrentEntity isEqualToString: @"person"]         // = group list
//        && gbl_accessoryButtonTapped                == 0              )   // tapped on row, not "i"
//    { 
//        //   CASE_C     - for "person"  get nothing
//        return;  // see above philosophy // if you tap on person name in yellow edit person list, do nothing
//    }
//

nbn(3);

//     // deselect previous row, select new one  (grey highlight)
//     //
//     // When the user selects a cell, you should respond by deselecting the previously selected cell (
//     // by calling the deselectRowAtIndexPath:animated: method) as well as by
//     // performing any appropriate action, such as displaying a detail view.
//     // 
//     NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];  // this is the "previously" selected row now
//     [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath  // deselect "previously" selected row and remove light grey highlight
//                                   animated: NO];
// 
//     NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow]; // get the indexpath of current row
//     if(myIdxPath) {
//         [self.tableView selectRowAtIndexPath:myIdxPath // puts highlight on this row (?)
//                                     animated:YES
//                               scrollPosition:UITableViewScrollPositionNone];
//     }


// tn();     NSLog(@"in didSelectRowAtIndexPath in home !!!!!!!!!!  BEFORE  !!!!!!!!!!!!!");
//             NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
//             NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
//             NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);
//             NSLog(@"gbl_fromHomeCurrentSelectionPSV=%@",gbl_fromHomeCurrentSelectionPSV);
//             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);
//             NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//             NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
//             NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
//             NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//             //NSLog(@"=%@",);
// NSLog(@"in didSelectRowAtIndexPath!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");


    // this is the "currently" selected row now
    //NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
//    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    NSIndexPath *myIdxPath = indexPath;  // method argument
    

    // set some gbl s

    // below is from prep for segue

    gbl_savePrevIndexPath  = myIdxPath;
    NSLog(@"gbl_savePrevIndexPath=%@",gbl_savePrevIndexPath);
    gbl_fromHomeCurrentEntity = gbl_lastSelectionType; // "group" or "person"
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayGrp objectAtIndex:myIdxPath.row];  /* PSV */
//        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
    }
    if ([gbl_fromHomeCurrentEntity isEqualToString:@"person"]) {
        gbl_fromHomeCurrentSelectionPSV      = [gbl_arrayPer objectAtIndex:myIdxPath.row];  /* PSV */
//        gbl_fromHomeCurrentSelectionArrayIdx = myIdxPath.row;
    }
//  NSLog(@"home didSelectRow CurrentSelectionArrayIdx=%ld",(long)myIdxPath.row);  not USED
  NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
  NSLog(@"home didSelectRow gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
  NSLog(@"home didSelectRow gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_fromHomeCurrentEntityName=[%@]",gbl_fromHomeCurrentEntityName);
  NSLog(@"home didSelectRow gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
    // above is from prep for segue


    const char *my_psvc;  // psv=pipe-separated values
    char my_psv[1024], psvName[32];
    my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
    strcpy(my_psv, my_psvc);
    strcpy(psvName, csv_get_field(my_psv, "|", 1));
    NSString *myNameOstr =  [NSString stringWithUTF8String:psvName];  // convert c string to NSString

    gbl_fromHomeCurrentEntityName = myNameOstr;  // like "~Anya" or "~Swim Team"
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {
        gbl_lastSelectedPerson = myNameOstr;
    }
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"]) {
        gbl_lastSelectedGroup  = myNameOstr;
    }

//             NSLog(@"gbl_fromHomeCurrentSelectionArrayIdx=%ld",(long)gbl_fromHomeCurrentSelectionArrayIdx);

  NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);



//tn();trn("SCROLL 666666666666666666666666666666666666666666666666666666666");
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    //[self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
    [self.tableView selectRowAtIndexPath: myIdxPath
                                animated: YES
                          scrollPosition: UITableViewScrollPositionNone];

    //[self.tableView scrollToNearestSelectedRowAtScrollPosition: myIdxPath.row
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                      animated: YES];

    if ([gbl_homeUseMODE isEqualToString: @"edit mode" ] )   // = yellow
    {
//  NSLog(@"go to add change ON TAP of ROW");

        // philosophy  on people list yellow  OR  on group list yellow 
        //
        // gbl_homeUseMODE isEqualToString: @"edit mode" // = yellow
        //   CASE_A   - tap on right side "i" button  ALWAYS  get add/change  screen
        //            - tap on left  side "-" button  ALWAYS  get delete  of person or group
        //   CASE_B   - tap on name in cell - for "group"   get group list (selPerson screen where you can "+" or "-" group members)
        //   CASE_C   - tap on name in cell - for "person"  get nothing  (see above)
        //

//
//        // oN TAP of accessory button (\"i\") in edit mode,   always  go to  add/change screen");
//        if (gbl_accessoryButtonTapped == 1)  {
//  NSLog(@"ON TAP of accessory button (\"i\"); // go to  add/change screen");
//
//            //   CASE_A   - tap on right side "i" button  ALWAYS  get add/change  screen
//
//            gbl_accessoryButtonTapped = 0;   // reset this to default  (could be = 1 here)
//
//            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
//            [myappDelegate mamb_beginIgnoringInteractionEvents ];
//
//            // Because background threads are not prioritized and will wait a very long time
//            // before you see results, unlike the mainthread, which is high priority for the system.
//            //
//            // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
//            //
//  NSLog(@"sub_view #03");
//            dispatch_async(dispatch_get_main_queue(), ^{                           
////                for( UIView *sub_view in [ self.view subviews ] )  // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
//                for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
//  NSLog(@"sub_view =[%@]",sub_view );
//  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
//                    if(sub_view.tag == 34) {
//  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
//                        [sub_view removeFromSuperview ];
//                    }
//                }
//                [self performSegueWithIdentifier: @"segueHomeToAddChange" sender:self]; //  
//            });
//            
//            return;
//        }
//



        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"group"])
        {

//  NSLog(@"ON TAP of ROW in yellow edit mode and Group list,   go to  selPerson screen with group members");
//  
//            //   CASE_B   - tap on name in cell - for "group"   get group list (selPerson screen where you can "+" or "-" group members)
//
//            gbl_groupMemberSelectionMode = @"none";  // to set this, have to tap "+" or "-" in selPerson
//
//            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
//            [myappDelegate mamb_beginIgnoringInteractionEvents ];
//
//  NSLog(@"sub_view #04");
//            dispatch_async(dispatch_get_main_queue(), ^{                                
////                for( UIView *sub_view in [ self.view subviews ] )  // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
//                for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
//  NSLog(@"sub_view =[%@]",sub_view );
//  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
//                    if(sub_view.tag == 34) {
//  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
//                        [sub_view removeFromSuperview ];
//                    }
//                }
//                [self performSegueWithIdentifier: @"segueHomeToListMembers" sender:self]; // selPerson screen where you can "+" or "-" group members
//            });
//
//            return;
//
        }  // group

        if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"person"])
        {

            gbl_accessoryButtonTapped = 0;   // reset this to default  (could be = 1 here)

            MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
            [myappDelegate mamb_beginIgnoringInteractionEvents ];

            // Because background threads are not prioritized and will wait a very long time
            // before you see results, unlike the mainthread, which is high priority for the system.
            //
            // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
            //
  NSLog(@"sub_view #05");
            dispatch_async(dispatch_get_main_queue(), ^{                           

  UIView *ptrToView = [self.view viewWithTag: 34 ];
  NSLog(@"ptrToView =[%@]",ptrToView );

//                for( UIView *sub_view in [ self.view subviews ] )  // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
                for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
  NSLog(@"sub_view =[%@]",sub_view );
  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
                    if(sub_view.tag == 34) {
  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
                        [sub_view removeFromSuperview ];
                    }
                }
                [self performSegueWithIdentifier: @"segueHomeToAddChange" sender:self]; //  
            });
            
            return;
        }


    }  // if edit mode

    else
    { // this is "report mode"  as opposed to "edit mode"

        if ([gbl_fromHomeCurrentEntity isEqualToString:@"group"])  {
            // check for not enough group members  to do a report

            // search in  gbl_arrayMem  for   gbl_lastSelectedGroup
            // count how many members
            // if not at least 2 members,  alert and return
            //
  NSLog(@"gbl_lastSelectedGroup =[%@]",gbl_lastSelectedGroup );

            NSInteger member_cnt;
            NSString *prefixStr = [NSString stringWithFormat: @"%@|", gbl_lastSelectedGroup ];

            if ([gbl_lastSelectedGroup isEqualToString: gbl_nameOfGrpHavingAllPeopleIhaveAdded])
            {
                // special group  "#allpeople"
                member_cnt = 0;
                for (NSString *element in gbl_arrayPer) {

                    if ([element hasPrefix: @"~"]) continue;
                    member_cnt = member_cnt + 1;
                }

            } else {
                // ordinary group
                member_cnt = 0;
                for (NSString *element in gbl_arrayMem) {
                    if ([element hasPrefix: prefixStr]) {
                        member_cnt = member_cnt + 1;
                    }
                }
            }

  NSLog(@"prefixStr  =[%@]",prefixStr );
  NSLog(@"member_cnt =[%ld]",(long) member_cnt );


            if (member_cnt  <  2) {

                // here info is missing
                NSString *missingMsg;
                
                if (member_cnt == 0) missingMsg = [ NSString stringWithFormat:
                    @"A group report needs\nat least 2 members.\n\nGroup \"%@\" has %ld members.",
                    gbl_lastSelectedGroup, (long)member_cnt
                ];
    //            UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Need more Group Members"
                UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Not enough Group Members"
                                                                                 message: missingMsg
                                                                          preferredStyle: UIAlertControllerStyleAlert  ];
                 
                UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                                    style: UIAlertActionStyleDefault
                                                                  handler: ^(UIAlertAction * action) {
                        NSLog(@"Ok button pressed");
                    }
                ];
                 
                [myAlert addAction:  okButton];

                // cannot goto report list   because of missing information > stay in this screen
                //
                [self presentViewController: myAlert  animated: YES  completion: nil   ];

                return;  // cannot goto rpt list   because of missing information > stay in this screen
            }
        } // if we are in group, check for enough members for a report

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myappDelegate mamb_beginIgnoringInteractionEvents ];

  NSLog(@"sub_view #06");
        dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
//            for( UIView *sub_view in [ self.view subviews ] )  // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
              for( UIView *sub_view in [ self.navigationController.view subviews ] ) { // remove subview (gbl_toolbarHomeMaintenance  - tag=34 ) , if existing
  NSLog(@"sub_view     =[%@]",sub_view );
  NSLog(@"sub_view.tag =[%ld]",(long)sub_view.tag );
                if(sub_view.tag == 34) {
  NSLog(@" REMOVED OLD  gbl_toolbarHomeMaintenance  ");
                    [sub_view removeFromSuperview ];
                }
            }
            [self performSegueWithIdentifier:@"segueHomeToReportList" sender:self]; //  
        });
    
        return;

    }  // regular mode

    b(32);
        
} // end of codeForCellTapWithIndexPath



//
// ===  end of EDITING  ================================================================================


- (void) putHighlightOnCorrectRow 
{
nbn(357);
  NSLog(@"in putHighlightOnCorrectRow  ");


// return; // uncomment  for test empty Launch image



  NSLog(@"gbl_lastSelectionType      =[%@]",gbl_lastSelectionType );
  NSLog(@"gbl_lastSelectedPerson     =[%@]",gbl_lastSelectedPerson);
  NSLog(@"gbl_lastSelectedGroup      =[%@]",gbl_lastSelectedGroup );
  NSLog(@"gbl_ExampleData_show       =[%@]",gbl_ExampleData_show );
  NSLog(@"gbl_scrollToCorrectRow     =[%ld]",(long)gbl_scrollToCorrectRow );



        if ([gbl_lastSelectionType isEqualToString:@"person"])
        {
            if ([gbl_ExampleData_show isEqualToString: @"yes"] )
            {
               gbl_numRowsToDisplayFor_per = gbl_arrayPer.count;
            } else {
               // Here we do not want to show example data.
               // Because example data names start with "~", they sort last,
               // so we can just reduce the number of rows to exclude example data from showing on the screen.
               gbl_numRowsToDisplayFor_per = gbl_arrayPer.count - gbl_ExampleData_count_per ;
            }
        }
        if ([gbl_lastSelectionType isEqualToString:@"group"])
        {
            if ([gbl_ExampleData_show isEqualToString: @"yes"] )
            {
               gbl_numRowsToDisplayFor_grp = gbl_arrayGrp.count;
            } else {
               // Here we do not want to show example data.
               // Because example data names start with "~", they sort last,
               // so we can just reduce the number of rows to exclude example data from showing on the screen.
               gbl_numRowsToDisplayFor_grp = gbl_arrayGrp.count - gbl_ExampleData_count_grp ;
            }
        }
  NSLog(@"gbl_numRowsToDisplayFor_per=[%ld]",(long)gbl_numRowsToDisplayFor_per);
  NSLog(@"gbl_numRowsToDisplayFor_grp=[%ld]",(long)gbl_numRowsToDisplayFor_grp);


        NSString  *nameOfGrpOrPer;
        NSInteger idxGrpOrPer;
        NSArray *arrayGrpOrper;

        NSString  *foundGrpRec;
        NSString  *foundGrpName;
        foundGrpRec  = nil;
        foundGrpName = nil;
        NSString  *foundPerRec;
        NSString  *foundPerName;
        foundPerRec  = nil;
        foundPerName = nil;

        idxGrpOrPer = -1;   // zero-based idx

        if ([gbl_lastSelectionType isEqualToString:@"group"]) {
nbn(100);
            if (gbl_numRowsToDisplayFor_grp == 0) return;

            // Check for gbl_lastSelectedPerson being example data person
            // and example data being turned off.
            // In that case, put highlight on top row
            //
            if ([gbl_ExampleData_show isEqualToString: @"no"]
                && [gbl_lastSelectedGroup hasPrefix: @"~" ]    )
            {
               // set gbl_lastSelectedPerson  to whoever is in top row
               // put top row on top of tableview
               self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
               return;
            }


tn();trn(" GRAB gbl_fromHomeCurrentSelectionPSV for group");
tn();trn(" GRAB gbl_fromHomeCurrentEntityName   for group");
  NSLog(@"gbl_lastSelectedGroup=[%@]",gbl_lastSelectedGroup);
            for (id eltGrp in gbl_arrayGrp) { // find index of gbl_lastSelectedGroup (like "~Family") in gbl_arrayGrp
              idxGrpOrPer = idxGrpOrPer + 1;
//  NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
//  NSLog(@"eltGrp=%@", eltGrp);
              NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
              arrayGrpOrper  = [eltGrp componentsSeparatedByCharactersInSet: mySeparators];
              nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld
//  NSLog(@"nameOfGrpOrPer =[%@]",nameOfGrpOrPer );

              if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedGroup]) {
                foundGrpRec  = eltGrp;
                foundGrpName = nameOfGrpOrPer;
                break;
              }
            } // search thru gbl_arrayGrp
    //NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

            gbl_fromHomeCurrentSelectionPSV  = foundGrpRec;
            gbl_fromHomeCurrentEntityName    = foundGrpName;
  NSLog(@"gbl_fromHomeCurrentSelectionPSV hi g =[%@]",gbl_fromHomeCurrentSelectionPSV  );
  NSLog(@"gbl_fromHomeCurrentEntityName   hi g =[%@]",gbl_fromHomeCurrentEntityName    );



            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  


        // get the indexpath of row num idxGrpOrPer in tableview
                NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow: idxGrpOrPer  inSection: 0];
        //tn();trn("SCROLL 111111111111111111111111111111111111111111111111111111111");

                if (gbl_scrollToCorrectRow == 1) {
                    // select the row in UITableView
                    // This puts in the light grey "highlight" indicating selection
                    [self.tableView selectRowAtIndexPath: foundIndexPath 
                                                animated: YES
                                          scrollPosition: UITableViewScrollPositionMiddle];
                } else {
                    // select the row in UITableView
                    // This puts in the light grey "highlight" indicating selection
                    [self.tableView selectRowAtIndexPath: foundIndexPath 
                                                animated: YES
                                          scrollPosition: UITableViewScrollPositionNone];
                }

                //  [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                //                                                    animated: YES];

                // NSInteger gbl_scrollToCorrectRow;  // flag to set every time before calling [self putHighlightOnCorrectRow ] in HOME
                                   // (do not want to scroll when hitting yellow/Edit and brown/Done)
                if (gbl_scrollToCorrectRow == 1) {
                    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                                      animated: YES];
                }
            });

        }   // if ([gbl_lastSelectionType isEqualToString:@"group"]) 



        if ([gbl_lastSelectionType isEqualToString:@"person"]) {
nbn(230);

            if (gbl_numRowsToDisplayFor_per == 0) return;
nbn(231);

            // Check for gbl_lastSelectedPerson being example data person
            // and example data being turned off.
            // In that case, put highlight on top row
            //
            if ([gbl_ExampleData_show isEqualToString: @"no"]
                && [gbl_lastSelectedPerson hasPrefix: @"~" ] )
            {
               // set gbl_lastSelectedPerson  to whoever is in top row
               // put top row on top of tableview
               self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
               return;
            }

//            NSLog(@"gbl_lastSelectedPerson=%@",gbl_lastSelectedPerson);
            
nbn(232);
            do { // highlight gbl_lastSelectedPerson row in tableview

//                for (id eltPer in gbl_arrayPer) {  // find index of gbl_lastSelectedPerson (like "~Dave") in gbl_arrayPer
//                    idxGrpOrPer = idxGrpOrPer + 1; 
////              NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
////              NSLog(@"eltPer=%@", eltPer);
//
//                  NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
//                  arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
//                  nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld
//
//                  if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedPerson]) {
//                    break;
//                  }
//                } // search thru gbl_arrayPer
////        NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);
//
//

tn();trn(" GRAB gbl_fromHomeCurrentSelectionPSV for person");
tn();trn(" GRAB gbl_fromHomeCurrentEntityName   for person");
  NSLog(@"gbl_lastSelectedPerson=[%@]",gbl_lastSelectedPerson);

                for (id eltPer in gbl_arrayPer) { // find index of gbl_lastSelectedPerson (like "~Ava") in gbl_arrayPer
                    idxGrpOrPer = idxGrpOrPer + 1;
//  NSLog(@"idxGrpOrPer =%ld", (long)idxGrpOrPer );
//  NSLog(@"eltPer=%@", eltPer);
                    NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
                    arrayGrpOrper  = [eltPer componentsSeparatedByCharactersInSet: mySeparators];
                    nameOfGrpOrPer = arrayGrpOrper[0];  // name is 1st fld
//  NSLog(@"nameOfGrpOrPer =[%@]",nameOfGrpOrPer );

                    if ([nameOfGrpOrPer isEqualToString: gbl_lastSelectedPerson]) {
                      foundPerRec  = eltPer;
                      foundPerName = nameOfGrpOrPer;
                      break;
                    }
                } // search thru gbl_arrayPer
    //NSLog(@"FOUND !=%ld", (long)idxGrpOrPer);

            gbl_fromHomeCurrentSelectionPSV  = foundPerRec;
            gbl_fromHomeCurrentEntityName    = foundPerName;
  NSLog(@"gbl_fromHomeCurrentSelectionPSV hi p =[%@]",gbl_fromHomeCurrentSelectionPSV  );
  NSLog(@"gbl_fromHomeCurrentEntityName   hi p =[%@]",gbl_fromHomeCurrentEntityName    );




                dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

                    // get the indexpath of row num idxGrpOrPer in tableview
                    NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow:idxGrpOrPer inSection:0];
    //        NSLog(@"foundIndexPath=%@",foundIndexPath);
    //        NSLog(@"foundIndexPath.row=%ld",(long)foundIndexPath.row);


                    // select the row in UITableView
                    // This puts in the light grey "highlight" indicating selection

                    if (gbl_scrollToCorrectRow == 1) {
                        [self.tableView selectRowAtIndexPath: foundIndexPath 
                                                    animated: YES
                                              scrollPosition: UITableViewScrollPositionMiddle ];
            //                                  scrollPosition: UITableViewScrollPositionNone];

                    } else {
                        [self.tableView selectRowAtIndexPath: foundIndexPath 
                                                    animated: YES
                                              scrollPosition: UITableViewScrollPositionNone ];
                    }


//                    [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
//                                                                      animated: YES];

                    if (gbl_scrollToCorrectRow == 1) {
                        // NSInteger gbl_scrollToCorrectRow;  // flag to set every time before calling [self putHighlightOnCorrectRow ] in HOME
                        // (do not want to scroll when hitting yellow/Edit and brown/Done)
                        [self.tableView scrollToNearestSelectedRowAtScrollPosition: UITableViewScrollPositionMiddle
                                                                          animated: YES];
                    }




                });

            } while (FALSE); // END highlight lastEntity row in tableview

        }

} //  putHighlightOnCorrectRow 

@end


