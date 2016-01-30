//
//  MAMB09_selectReportsTableViewController.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

//#import "MAMB09_homeTableViewController.h"
#import "MAMB09_selectReportsTableViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals


@interface MAMB09_selectReportsTableViewController ()
{

}
@end


@implementation MAMB09_selectReportsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    fopen_fpdb_for_debug();
tn(); NSLog(@"in sel Reports viewDidLoad!");

    
    // When I am navigating back & forth, i see a dark shadow
    // on the right side of navigation bar at top.
    // It feels rough and distracting. How can I get rid of it?
    //
    self.navigationController.navigationBar.translucent = NO;
    //
    // http://stackoverflow.com/questions/22413193/dark-shadow-on-navigation-bar-during-segue-transition-after-upgrading-to-xcode-5


    // http://stackoverflow.com/questions/18912638/custom-image-for-uinavigation-back-button-in-ios-7
    UIImage *backBtn = [UIImage imageNamed:@"iconRightArrowBlue_66"];
    backBtn = [backBtn imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.backBarButtonItem.title=@"";
    self.navigationController.navigationBar.backIndicatorImage = backBtn;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // put name of grp or per as title
    //
    // NSArray *arrSpecs = [self.fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet:
    //                   [NSCharacterSet characterSetWithCharactersInString:@"|"]];
    NSArray *arrSpecs = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@"|"]];


    UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    myInvisibleButton.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *mySpacerNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];  // 3rd arg is horizontal length
    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];


    UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];
nbn(44);
    myNavBarLabel.textColor     = [UIColor blackColor];
    myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
    myNavBarLabel.text          = [NSString stringWithFormat:@"%@", arrSpecs[0] ];
    myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 17.0];
    myNavBarLabel.adjustsFontSizeToFitWidth = YES;
    [myNavBarLabel sizeToFit];
    
    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//        [[self navigationItem] setTitle: arrSpecs[0]];
        self.navigationItem.titleView = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
        self.navigationItem.rightBarButtonItem =  mySpacerForTitle;
    });
    
    // NSLog(@"fromHomeCurrentEntity=%@",self.fromHomeCurrentEntity);                  // like "group" or "person"
//    NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
//    NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
//    NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);

} /* viewDidLoad */



- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.2 ];    // after arg seconds
                                                    
NSLog(@"in viewDidAppear()");
} // end of viewDidAppear



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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowcount;
    rowcount = 0;

    // Return the number of rows in the section.
    // return 0;
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {
//        return 7;
        return 8;
    }
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"])  {
//        return 11;
        return 12;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
//  NSLog(@"in heightForRowAtIndexPath  INFO ");
//    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] ){   // my best match (grpone)
    if ([gbl_currentMenuPrefixFromHome isEqualToString: @"homp"] ) {   // home menu, person was selected
//        if (indexPath.row == 0) return    16.0;  // spacer
        if (indexPath.row == 0) return    22.0;  // spacer
        if (indexPath.row == 4) return    22.0;  // spacer
        if (indexPath.row == 6) return    22.0;  // spacer
//        if (indexPath.row == 5) return    48.0;  // 2-row  grpone desc
        if (indexPath.row == 5) return    66.0;  // 2-row  grpone desc
        return 44.0;  //default
    }
    if ([gbl_currentMenuPrefixFromHome isEqualToString: @"homg"] ) {   // home menu, group was selected
        if (indexPath.row == 0) return    22.0;  // spacer
        if (indexPath.row == 2) return    22.0;  // spacer
        if (indexPath.row == 8) return    22.0;  // spacer
        return 44.0;  //default
    }
//    return 32.0;
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"in selREP cellForRowAtIndexPath!");

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelReportsCellIDentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...

//    UIFont *myNewFont = [UIFont systemFontOfSize: 16.0];
//    cell.textLabel.font            = [UIFont boldSystemFontOfSize: 17.0];
    UIFont *myNewFont =  [UIFont boldSystemFontOfSize: 17.0];


    //   cell.selectedBackgroundView =  gbl_myCellBgView ;  // get my own background color for selected rows (see MAMB09AppDelegate.m)

    NSString *myNewCellText;
    NSInteger thisCellIsActive;
    myNewCellText    = @" ";
    thisCellIsActive = 0;

    UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    myInvisibleButton.backgroundColor = [UIColor clearColor];

    NSString *myPrefix;  // for 3-char code in rptsel array PSV field # 1
    myPrefix = gbl_currentMenuPrefixFromHome;  // this is "homp" or "homg"   <<----------------

    //NSLog(@"    myPrefix=%@",myPrefix);

    // match the tableview index we are on 
    // to the same index in gbl_mambReports  (but for the correct prefix  p,g,2)
    int myIdxInto_gbl_mambReports = (int) indexPath.row;

    // goto gbl_mambReports  and  grab menu cell text
    // consider  elements who have correct prefix    like "p" for person reports
    // get str with index of  myIdxInto_gbl_mambReports into those
    // grab field #2 of that PSV (will be report table text)
    //
    int idx = -1;
    for (NSString *perRptPSV in gbl_mambReports) {

        if ( ! [perRptPSV hasPrefix: myPrefix]) continue;

        idx = idx + 1;
        if (idx == myIdxInto_gbl_mambReports) {
            NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
            NSArray *myRptSelarr         = [perRptPSV componentsSeparatedByCharactersInSet: mySeparators];
            myNewCellText                = myRptSelarr[1];  // field # 2  in like,  @"pcy|Calendar Year ...",
            thisCellIsActive = 1;
        }
    }
//tn();kin(myIdxInto_gbl_mambReports);
//  NSLog(@"myNewCellText                =%@",myNewCellText                );

    // override if spacer cell
    //
    if (  [myPrefix isEqualToString: @"homp"] )   // my best match (grpone)
    { 
        if (indexPath.row == 0      // spacer
        ||  indexPath.row == 4      // spacer
        ||  indexPath.row == 6      // spacer
        ) {
            thisCellIsActive = 0;
            myNewCellText    = @" ";
        }
    } 
    if (  [myPrefix isEqualToString: @"homg"] )   // my best match (grpone)
    { 
//        if (indexPath.row == 1      // spacer
//        ||  indexPath.row == 7)     // spacer
        if (indexPath.row == 0      // spacer
        ||  indexPath.row == 2      // spacer
        ||  indexPath.row == 8      // spacer
        ) {
            thisCellIsActive = 0;
            myNewCellText    = @" ";
        }
    } 


    if (thisCellIsActive == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{        
            cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
            cell.textLabel.font                      = myNewFont ;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.userInteractionEnabled              = NO;                           // no selection highlighting
            cell.accessoryView                       = myInvisibleButton;            // no right arrow on benchmark label
            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

            cell.textLabel.numberOfLines             = 1; 
            cell.textLabel.textColor                 = [UIColor blackColor];
//            cell.textLabel.font                      = myFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;

            // PROBLEM  name slides left off screen when you hit red round delete "-" button
            //          and delete button slides from right into screen
            //
            cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
            cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
        });
    }

    if (thisCellIsActive == 1) {


        // UILabel for the disclosure indicator, ">",  for tappable cells
        //
            NSString *myDisclosureIndicatorBGcolorName; 
            NSString *myDisclosureIndicatorText; 
            UIColor  *colorOfGroupReportArrow; 
            UIFont   *myDisclosureIndicatorFont; 

            myDisclosureIndicatorText = @">"; 

    //                myDisclosureIndicatorBGcolorName = gbl_array_cellBGcolorName[indexPath.row];   // array set in  viewDidLoad
    //        NSLog(@"myDisclosureIndicatorBGcolorName =%@",myDisclosureIndicatorBGcolorName );

//            if ( [myDisclosureIndicatorBGcolorName isEqualToString: @"cRe2"] ) {
//                colorOfGroupReportArrow   = [UIColor blackColor];                 // deepest red is pretty  dark
//                myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 16.0f]; // make not bold
//            } else {
//                colorOfGroupReportArrow   = [UIColor  grayColor];
//                myDisclosureIndicatorFont = [UIFont boldSystemFontOfSize: 16.0f];
//            }
//
//            colorOfGroupReportArrow   = [UIColor blackColor];                 // blue background
//            myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 16.0f]; // make not bold
            colorOfGroupReportArrow   = [UIColor lightGrayColor];                 // blue background
            myDisclosureIndicatorFont = [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0]; // good


            NSAttributedString *myNewCellAttributedText3 = [
                [NSAttributedString alloc] initWithString: myDisclosureIndicatorText  // i.e.   @">"
                                               attributes: @{            NSFontAttributeName : myDisclosureIndicatorFont,
                                                               NSForegroundColorAttributeName: colorOfGroupReportArrow                }
            ];
    //                                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize: 16.0f],

            UILabel *myDisclosureIndicatorLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
            myDisclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
            myDisclosureIndicatorLabel.backgroundColor = gbl_colorReportsBG; 


        //
        // end of  UILabel for the disclosure indicator, ">",  for tappable cells


        if (   indexPath.row == 5     // 2 lines. old "My Best Match in Group" before 2 line version below with person name
            && [myPrefix isEqualToString: @"homp"]    // my best match (grpone)
        ) {
            myNewCellText = [NSString stringWithFormat:  @"Best Match for\n %@ in Group ...", gbl_lastSelectedPerson ]; 

            dispatch_async(dispatch_get_main_queue(), ^{            // <  active
                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
                cell.textLabel.font                      = myNewFont ;
                cell.textLabel.adjustsFontSizeToFitWidth = YES;
                cell.userInteractionEnabled              = YES;                  
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.textLabel.numberOfLines             = 2; 
                cell.textLabel.textColor                 = [UIColor blackColor];
                cell.textLabel.adjustsFontSizeToFitWidth = YES;

                // PROBLEM  name slides left off screen when you hit red round delete "-" button
                //          and delete button slides from right into screen
                //
                cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
                cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right

                cell.accessoryView                       = myDisclosureIndicatorLabel;
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
            });
            return cell;  // row 4, homp
        }

        dispatch_async(dispatch_get_main_queue(), ^{            // <  active
            cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
            cell.textLabel.font                      = myNewFont ;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
            cell.userInteractionEnabled              = YES;                  
//            cell.accessoryView                       = myDisclosureIndicatorLabel;
            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

            cell.textLabel.numberOfLines             = 1; 
            cell.textLabel.textColor                 = [UIColor blackColor];
//            cell.textLabel.font                      = myFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;

            // PROBLEM  name slides left off screen when you hit red round delete "-" button
            //          and delete button slides from right into screen
            //
            cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
            cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right

            cell.accessoryView                       = myDisclosureIndicatorLabel;
            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
        });
    }

    return cell;
} // cellForRowAtIndexPath


// color cell bg
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    cell.backgroundColor = [UIColor clearColor];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in SELREPORTS prepareForSegue!");

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // get the indexpath of current row

    // this is the "currently" selected row now
    //
    //NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    //   UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
    // now you can use cell.textLabel.text

    // segueRptSelToViewHTML
    //
    if ([segue.identifier isEqualToString:@"segueRptSelToViewHTML"]) {
        
        //MAMB09_viewHTMLViewController *myDestViewController = segue.destinationViewController;
        // now globals
        // pass forward this data to ViewHTML
        //myDestViewController.fromHomeCurrentSelectionType = self.fromHomeCurrentSelectionType; // "group" or "person" or "pair"
        //myDestViewController.fromHomeCurrentEntity        = self.fromHomeCurrentEntity; // "group" or "person"
        
        // now in gbl_fromHomeCurrentSelectionPSV
        // myDestViewController.fromHomeCurrentSelectionPSV     = self.fromHomeCurrentSelectionPSV; //  PSV for "group" or "person"
        
        // this is the "currently" selected row now
        //NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];

        //myDestViewController.fromSelRptRowNumber = currentlyselectedIndexPath.row; // "group" or "person" or "pair"
        // gbl_fromSelRptRowNumber =currentlyselectedIndexPath.row; // "group" or "person" or "pair"
        
        //UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
        // now you can use cell.textLabel.text
 
//        gbl_fromSelRptRowString = currcell.textLabel.text;

        
    } // segueRptSelToViewHTML

    if ([segue.identifier isEqualToString:@"segueRptSelToSelDate3"]) {
        //MAMB09_viewHTMLViewController *myDestViewController = segue.destinationViewController;
        
        // pass forward this data to ViewHTML
        //myDestViewController.fromHomeCurrentSelectionType = self.fromHomeCurrentSelectionType; // "group" or "person" or "pair"
        //myDestViewController.fromHomeCurrentEntity        = self.fromHomeCurrentEntity; // "group" or "person"
        
        // now in gbl_fromHomeCurrentSelectionPSV
        //myDestViewController.fromHomeCurrentSelectionPSV     = self.fromHomeCurrentSelectionPSV; //  CSV for "group" or "person"
        
//        gbl_fromSelRptRowString = currcell.textLabel.text;
//        NSLog(@" in selReports seg to seldate3  SET   gbl_fromSelRptRowString=%@",gbl_fromSelRptRowString);

        //myDestViewController.selectedYear = self.selectedYear;  // user-selected yr for Calendar Year report
    } // segueRptSelToSelYear
    
    if ([segue.identifier isEqualToString:@"segueRptSelToSelPerson"]) {
//        gbl_fromSelRptRowString = currcell.textLabel.text;
//        NSLog(@"gbl_fromSelRptRowString=%@",gbl_fromSelRptRowString);

    } // segueRptSelToSelPerson

    if ([segue.identifier isEqualToString:@"segueRptSelToSelYear"]) {
//        gbl_fromSelRptRowString = currcell.textLabel.text;
//        NSLog(@"in segue segueRptSelToSelYear  gbl_fromSelRptRowString=%@",gbl_fromSelRptRowString);

    } // segueRptSelToSelYear
    

} /* prepareForSegue */


    //<.>  from home code
    // these 5 methods  handlelight grey highlight correctly
    // when returning from report viewer
    //
    // viewWillAppear   first  (after viewdidload)
    // viewDidAppear    then this
    // willDeselectRowAtIndexPath
    // willSelectRowAtIndexPath
    // didSelectRowAtIndexPath
    //
-(void) viewWillAppear:(BOOL)animated {
    NSLog(@"in viewWillAppear  in rpt sel!");

    NSString *myLastReportCodeSelected;

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m


    // Now  highlight the  remembered last report selection  for the current  person

    // get last report  3-char code
    myLastReportCodeSelected =  [myappDelegate grabLastSelectionValueForEntity: (NSString *) gbl_fromHomeCurrentEntity     //  personOrGroup
                                                                    havingName: (NSString *) gbl_fromHomeCurrentEntityName
                                                          fromRememberCategory: (NSString *) @"rptsel"  ]; 

    NSLog(@"myLastReportCodeSelected =%@",myLastReportCodeSelected );
nbn(71);
    if (myLastReportCodeSelected  &&  myLastReportCodeSelected.length != 0) {
nbn(72);
        // find the last report  3-char code   in   gbl_mambReports
        //    (the index of that  equals  the index of the row in tableview to highlight)
        BOOL foundRptArrEltWithCode;
        foundRptArrEltWithCode = NO;
        int foundIdx = -1;
        for (NSString *perRptPSV in gbl_mambReports) {
            foundIdx = foundIdx + 1;
            if ( ! [perRptPSV hasPrefix: myLastReportCodeSelected]) continue;
           
            foundRptArrEltWithCode = YES;
            break;
        }
//  NSLog(@"foundRptArrEltWithCode =%d",foundRptArrEltWithCode );
//tn();kin(foundIdx);

        //
        // adjust foundidx   because of setup of gbl_mambReports   in MAMB09AppDelegate.m  -
        // see  gbl_mambReports = // all reports in all report selection menus, "homp*" "homg*" "gbm*" or "pbm*" 
        //
        int myOffsetRptCodeTbl;
        myOffsetRptCodeTbl = 0;
        if ([myLastReportCodeSelected hasPrefix: @"homp"]) myOffsetRptCodeTbl =  0; //  see gbl_mambReports in MAMB09AppDelegate.m 
        if ([myLastReportCodeSelected hasPrefix: @"homg"]) myOffsetRptCodeTbl =  8;
        if ([myLastReportCodeSelected hasPrefix: @"gbm" ]) myOffsetRptCodeTbl = 19;
        if ([myLastReportCodeSelected hasPrefix: @"pbm" ]) myOffsetRptCodeTbl = 27;
        foundIdx = foundIdx - myOffsetRptCodeTbl ;   //  MAGIC HERE mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm !
tn();kin(foundIdx);

        if (foundRptArrEltWithCode == YES) {
nbn(73);

            // use found foundIdx to get  found  indexPath
            NSIndexPath *foundIndexPath = [NSIndexPath indexPathForRow: foundIdx   inSection: 0];

  NSLog(@"foundIndexPath=%@",foundIndexPath);

//      // for test
//      //how can I get the text of the cell here?    
//      UITableViewCell *testcell = [self.tableView cellForRowAtIndexPath: foundIndexPath];
//      NSLog(@" testcell.textLabel.text=[%@]", testcell.textLabel.text);
//


            if (foundIndexPath) {
nbn(74);
                [self.tableView selectRowAtIndexPath: foundIndexPath  // puts highlight on remembered row
                                            animated: YES
                                      scrollPosition: UITableViewScrollPositionNone];
nbn(75);
            }
nbn(76);
        }
nbn(77);
    } // myLastReportCodeSelected exists
nbn(78);

} // viewWillAppear

// - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"in willDeselectRowAtIndexPath!");
    
    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.
    // 
    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);
    
//    if ([_mambCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [gbl_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
//    if ([_mambCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [gbl_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);
//    
    
    // here we are deselecting "previously" selected row
    // and removing light grey highlight
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
                                  animated: NO];
    //animated: YES];
    return previouslyselectedIndexPath;
} // willDeselectRowAtIndexPath


// willSelectRowAtIndexPath message is sent to the UITableView Delegate
// after the user lifts their finger from a touch of a particular row
// and before didSelectRowAtIndexPath.
//
// willSelectRowAtIndexPath allows you to either confirm that the particular row can be selected,
// by returning the indexPath, or select a different row by providing an alternate indexPath.
//
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath: (NSIndexPath*)indexPath {
    
    // NSLog(@"willSelectRowAtIndexPath!");

    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // here deselect "previously" selected row
    // and remove yellow highlight
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
                                  animated: NO];
    return(indexPath);
} // willSelectRowAtIndexPath



// GOTO  the Correct View for Input Params
// or, directly to ViewHTML to see the Selected Report
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
//tn();trn("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
//    NSLog(@"in didSelectRowAtIndexPath! in sel rpt");
//    NSLog(@"indexpath.row=%ld",(long)indexPath.row);

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m


    // this is the "currently" selected row now
    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    

    
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    [self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: currentlyselectedIndexPath.row
                                                      animated: NO];
    // animated:YES
    //  animated: YES];
    
    // now unused   20150223
    //UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
    // NSLog(@"currcell=%@",currcell);

    // not used anymore 2015023 
    // now you can use cell.textLabel.text
    //    NSString *stringForCurrentlySelectedRow = currcell.textLabel.text;
    // NSLog(@"currcell.textLabel.text=%@",currcell.textLabel.text);



    // populate  gbl_currentMenuPlusReportCode 
    //
    // get the menu code + report code from gbl_mambReports   (like "hompbm")
    do {
//        NSString *myPrefix = gbl_currentMenuCode;  // like "homp"
        NSString *myPrefix = gbl_currentMenuPrefixFromHome;  // like "homp"

        // match the tableview index we are on 
        // to the same index in gbl_mambReports  (but for the correct prefix)
        int myIdxInto_gbl_mambReports = (int) indexPath.row;


        // goto gbl_mambReports 
        // consider  elements who have correct prefix    like "p" for person reports
        // get str with index of  myIdxInto_gbl_mambReports into those
        // grab field #2 of that PSV (will be report table text)
        //
        int idx = -1;
        for (NSString *rptPSV in gbl_mambReports) {

            if ( ! [rptPSV hasPrefix: myPrefix]) continue;

            idx = idx + 1;
            if (idx == myIdxInto_gbl_mambReports) {
                NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
                NSArray *myRptSelarr         = [rptPSV componentsSeparatedByCharactersInSet: mySeparators];
                gbl_currentMenuPlusReportCode = myRptSelarr[0];  // field # 1  in like,  @"hompcy|Calendar Year ...",
            }
        }
    } while (FALSE); // get the menu code + report code from gbl_mambReports   (like "hompbm")

tn();trn("selRPT after ");   NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode ); tn();



    [myappDelegate mamb_beginIgnoringInteractionEvents ];

   

    //if ([stringForCurrentlySelectedRow hasPrefix: @"Calendar Year"] ) 
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompcy"] ) {
NSLog(@"in dispatch  for SELECT YEAR  !");
        
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];

        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //
        nbn(331);
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelYear" sender:self];
        });
        nbn(332);
        
        // no improvement in 2 sec
        //        if (NSThread.isMainThread == YES){
        //            nksn("are in Mainthread    main main main main !!!!!!!!!!");
        //            [self performSegueWithIdentifier:@"segueRptSelToSelYear" sender:self];
        //        } else {
        //            nksn("dispatching to main thread   !!!!!!!!! ");
        //
        //            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        //                [self performSegueWithIdentifier:@"segueRptSelToSelYear" sender:self];
        //            });
        //        }
        
        
// NSLog(@"34!");
        // ntrn("=========================================");
    } // Calendar Year

//  NSLog(@"in sel rpt gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
//  NSLog(@"=%@",);
//  NSLog(@"=%@",);
//  NSLog(@"=%@",);
//  NSLog(@"=%@",);
//

    //if ([stringForCurrentlySelectedRow hasPrefix: @"Personality"] ) 
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homppe"] ) {

        //[self performSegueWithIdentifier:@"segueRptSelToViewHTML"         sender:self];
        
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];

        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToViewHTML" sender:self];
            [self performSegueWithIdentifier:@"segueRptSelToViewTBLRPT1" sender:self];  // is  now table rpt
        });
    }


    //if ([stringForCurrentlySelectedRow hasPrefix: @"Compatibility Paired"] ) 
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"] ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];

        dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self]; //  SELECT A PERSON
        });
    }

    //if ([stringForCurrentlySelectedRow hasPrefix: @"My Best Match"] ) 
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] ) {

//        gbl_currentMenuCode = @"pbm";
        gbl_currentMenuPrefixFromMatchRpt = @"pbm";

        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];
        dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self]; //  for SELECT A GROUP
        });

    }

    //if ([stringForCurrentlySelectedRow hasPrefix: @"What Color is Today"] ) 
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompwc"] ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelDate3" sender:self];
        });

    }
    
//
//// moved to home sel group
//    // check for group report,  BUT  group  does not have at least  2  members
//    //   then, alert and return
//    //
//    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"]   // best match
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // "Most Assertive ..."
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // "Most Emotional ..."
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // "Most Restless ..."
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // "Most Passionate ..."
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // "Most Down-to-earth"
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgby"]   // best year
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"]   // best day
//    ) {
//
//
//        // search in  gbl_arrayMem  for   gbl_lastSelectedGroup
//        // count how many members
//        // if not at least 2 members,  alert and return
//        //
//  NSLog(@"gbl_lastSelectedGroup =[%@]",gbl_lastSelectedGroup );
//
//        NSInteger member_cnt;
//        NSString *prefixStr = [NSString stringWithFormat: @"%@|", gbl_lastSelectedGroup ];
//
//        member_cnt = 0;
//        for (NSString *element in gbl_arrayMem) {
//            if ([element hasPrefix: prefixStr]) {
//                member_cnt = member_cnt + 1;
//            }
//        }
//
//  NSLog(@"prefixStr  =[%@]",prefixStr );
//  NSLog(@"member_cnt =[%ld]",(long) member_cnt );
//
//        if (member_cnt  <  2) {
//
//            // here info is missing
//            NSString *missingMsg;
//            
//            if (member_cnt == 0) missingMsg = [ NSString stringWithFormat:
//                @"A group report needs\nat least 2 members.\n\nGroup \"%@\" has %ld members.",
//                gbl_lastSelectedGroup, member_cnt
//            ];
////            UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Need more Group Members"
//            UIAlertController* myAlert = [UIAlertController alertControllerWithTitle: @"Not enough Group Members"
//                                                                             message: missingMsg
//                                                                      preferredStyle: UIAlertControllerStyleAlert  ];
//             
//            UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
//                                                                style: UIAlertActionStyleDefault
//                                                              handler: ^(UIAlertAction * action) {
//                    NSLog(@"Ok button pressed");
//                }
//            ];
//             
//            [myAlert addAction:  okButton];
//
//            // cannot save because of missing information > stay in this screen
//            //
//            [self presentViewController: myAlert  animated: YES  completion: nil   ]; // cannot save because of missing information
//
//            return;  // cannot save because of missing information > stay in this screen
//
//
//        }
//    }
//
//
    
    //if ([stringForCurrentlySelectedRow hasPrefix: @"Best Match"] ) 
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] ) {
        
        gbl_currentMenuPrefixFromMatchRpt = @"gbm";
        
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToViewTBLRPT1" sender:self];
        });


    }


    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"homgma"]   // "Most Assertive ..."
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgme"]   // "Most Emotional ..."
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"]   // "Most Restless ..."
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"]   // "Most Passionate ..."
        || [gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"]   // "Most Down-to-earth"
    ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToViewTBLRPT1" sender:self];
        });

    }
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgme"] ) {  // "Most Emotional ..."
//        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
//                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
//                         updatingRememberCategory: (NSString *) @"rptsel"
//                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
//        ];
//
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
////        });
////
//    }
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmr"] ) {  // "Most Restless ..."
//        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
//                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
//                         updatingRememberCategory: (NSString *) @"rptsel"
//                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
//        ];
//
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
////        });
////
//    }
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmp"] ) {  // "Most Passionate ..."
//        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
//                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
//                         updatingRememberCategory: (NSString *) @"rptsel"
//                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
//        ];
//
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
////            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
////        });
////
//    }
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmd"] ) {  // "Most Down-to-earth"
//        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
//                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
//                         updatingRememberCategory: (NSString *) @"rptsel"
//                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
//        ];
//


//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//
//    }
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgmu"] ) {  // "Most Ups and Downs ..."
//        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
//                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
//                         updatingRememberCategory: (NSString *) @"rptsel"
//                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
//        ];
//
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
////            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
////        });
////
//    }



    //if ([stringForCurrentlySelectedRow hasPrefix: @"Best Year"] ) 
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgby"] ) {  

        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelYear" sender:self];
        });

    }
    //if ([stringForCurrentlySelectedRow hasPrefix: @"Best Day"] ) 
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbd"] ) {  
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
        ];
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelDate3" sender:self];
        });
    }
   


    // below are report for pairs of people (picked from a group report having pairs)
    // **********   NO REMEMBERING WHICH REPORT WAS SELECTED  for pairs ********************


//    if ([stringForCurrentlySelectedRow hasSuffix: @"Compatibility Potential"] ) {
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
////            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
////        });
//    }
//    if ([stringForCurrentlySelectedRow hasSuffix: @" Best Match"] ) {
////        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
////            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
////        });
////
//    }
//

} // didSelectRowAtIndexPath


@end

//It looks like you'd like the picker to rest at the bottom of the view controller's main view (it's parent, I assume) and be as wide as the view. Try this in viewDidLoad:
//
// CGRect viewFrame = self.view.frame;
// CGRect pickerHeight = self.picker.frame.size.height;  // assume you have an outlet called picker
// CGRect pickerFrame = CGRectMake(0.0, viewFrame.size.height-pickerHeight, viewFrame.size.width, pickerHeight);
// self.picker.frame = pickerFrame;
//


//
//- (void)viewDidAppear:(BOOL)animated
//{
//    NSLog(@"in viewDidAppear  in rpt sel!");
//    //[super viewDidAppear];
//
//
//// for test
//
////
////    // set cell to whatever you want to be selected first
////    // yellow highlight that cell
////    //
////    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
////    if (indexPath) {
////        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
////        //        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
////        // [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionNone];
////    }
//}
//
