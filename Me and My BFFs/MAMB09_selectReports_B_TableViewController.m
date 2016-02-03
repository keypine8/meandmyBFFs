//
//  MAMB09_selectReports_B_TableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2015-04-13.
//  Copyright (c) 2015 Richard Koskela. All rights reserved.
//

#import "MAMB09_selectReports_B_TableViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

@interface MAMB09_selectReports_B_TableViewController ()

@end


@implementation MAMB09_selectReports_B_TableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    fopen_fpdb_for_debug();
    NSLog(@"in sel Reports   BBBBBB    viewDidLoad!");

tn(); NSLog(@"in SEL REPORTS BBBBB   viewDidLoad!");
  NSLog(@"gbl_PSVtappedPerson_fromGRP=%@",gbl_PSVtappedPerson_fromGRP);      // any of the above 14 RPTs
  NSLog(@"gbl_PSVtappedPersonA_inPair=%@",gbl_PSVtappedPersonA_inPair);      // hompbm,homgbm,pbmco,gbmco
  NSLog(@"gbl_PSVtappedPersonB_inPair=%@",gbl_PSVtappedPersonB_inPair);      // same
  NSLog(@"gbl_TBLRPTS1_PSV_personA=%@",gbl_TBLRPTS1_PSV_personA);            // of pair
  NSLog(@"gbl_TBLRPTS1_PSV_personB=%@",gbl_TBLRPTS1_PSV_personB);            // of pair
  NSLog(@"gbl_TBLRPTS1_PSV_personJust1=%@",gbl_TBLRPTS1_PSV_personJust1);    // for single person reports
  NSLog(@"gbl_TBLRPTS1_NAME_personA=%@",gbl_TBLRPTS1_NAME_personA);          // of pair
  NSLog(@"gbl_TBLRPTS1_NAME_personB=%@",gbl_TBLRPTS1_NAME_personB);          // of pair
  NSLog(@"gbl_TBLRPTS1_NAME_personJust1=%@",gbl_TBLRPTS1_NAME_personJust1);  // for single person reports
tn();

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;



//<.>
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
//
//            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
//                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//                [self.navigationController.navigationBar setTranslucent:NO];
//<.>
//


    // 2-line
    // TWO-LINE NAV BAR TITLE     WARNING  this is a HOUSE OF CARDS   beware changing a thing (landscape goes to right a bit !? )
    //
//        UIButton *myInvisibleButton             = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];

        myInvisibleButton.backgroundColor       = [UIColor clearColor];
        UIBarButtonItem *myInvisibleBtnNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];

//
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//       UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];  // 3rd arg is horizontal length
//        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];


//        UILabel *mySelRptB_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];
//        UILabel *mySelRptB_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024.0, 44.0)];
        UILabel *mySelRptB_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 2048.0, 44.0)];
        mySelRptB_Label.numberOfLines = 2;
        mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 14.0];
        mySelRptB_Label.textColor     = [UIColor blackColor];
        mySelRptB_Label.textAlignment = NSTextAlignmentCenter; 
        mySelRptB_Label.text          = [NSString stringWithFormat:  @"%@\nand %@", 
                                         gbl_selectedCellPersonAname, gbl_selectedCellPersonBname ];
        mySelRptB_Label.adjustsFontSizeToFitWidth = YES;
        [mySelRptB_Label sizeToFit];


//       [mySelRptB_Label sizeToFit];  // invisible button alone WORKS (with sizeToFit)

//         mySelRptB_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL  (works great)

//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 66, 44)];  // 3rd arg is horizontal length
//        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView: spaceView];

    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  

//        self.navigationItem.titleView          = mySelRptB_Label;


//        self.navigationItem.rightBarButtonItem = myInvisibleBtnNavItem ;  // invisible button alone WORKS (with sizeToFit)
//
//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myInvisibleBtnNavItem];

//        self.navigationItem.rightBarButtonItem  = myInvisibleBtnNavItem;
//        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];

//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: shareButton];
//            self.navigationItem.titleView           = mySelRptB_Label; // mySelRptB_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];

        self.navigationItem.titleView          = mySelRptB_Label;

//        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myInvisibleBtnNavItem ];
//        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
        self.navigationItem.rightBarButtonItem  = myInvisibleBtnNavItem;
//        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myInvisibleBtnNavItem ];
 

        [self.navigationController.navigationBar setTranslucent:NO];


        //        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        //        myInvisibleButton.backgroundColor = [UIColor clearColor];
        //        UIBarButtonItem *mySpacerNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];
        //        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerNavItem];
    });



  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
    // NSLog(@"fromHomeCurrentEntity=%@",self.fromHomeCurrentEntity);                  // like "group" or "person"
    NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
    NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
    NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
  NSLog(@"gbl_selectedCellPersonAname=%@",gbl_selectedCellPersonAname);
  NSLog(@"gbl_selectedCellPersonBname=%@",gbl_selectedCellPersonBname);



    // for grabbing correct menu choices from gbl_mambReports 
    //
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] ) {
        gbl_currentMenuPrefixFromMatchRpt = @"pbm";   //    gbl_mambReports = // all reports in all report selection menus, "homp*" "homg*" "gbm*" or "pbm*" 
    }
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] ) {
        gbl_currentMenuPrefixFromMatchRpt = @"gbm";   //    gbl_mambReports = // all reports in all report selection menus, "homp*" "homg*" "gbm*" or "pbm*" 
    }


} // end of viewdidload


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
    //return 0;
    return 1;
}

// ===============================================================================================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSLog(@"in numberOfRowsInSection! in sel rpt B!");
  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
  NSLog(@"gbl_currentMenuPrefixFromMatchRpt=%@",gbl_currentMenuPrefixFromMatchRpt);

    // Return the number of rows in the section.

//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] ) {
    if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"] ) {
//        return 6; 
        return 8; 
    }
    if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"] ) {
        return 9; 
    }
    return 1;
}

// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
//  NSLog(@"in heightForRowAtIndexPath  INFO ");
//    if (  [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] ){   // my best match (grpone)
    if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"] ) {   // my best match (grpone)
        if (indexPath.row == 0) return    16.0;  // spacer small
        if (indexPath.row == 1) return    44.0;  // compatibility potential report
//        if (indexPath.row == 2) return    16.0;  // spacer row
        if (indexPath.row == 2) return    22.0;  // spacer row
        if (indexPath.row == 3) return    44.0;  // per 1
        if (indexPath.row == 4) return    44.0;  // per 2
//        if (indexPath.row == 5) return    16.0;  // spacer row
        if (indexPath.row == 5) return    22.0;  // spacer row
//        if (indexPath.row == 6) return    48.0;  // 2-row  grpone desc best match for perB
        if (indexPath.row == 6) return    44.0;  // 1-row  grpone desc best match for perB
        if (indexPath.row == 7) return    44.0;  // empty rows at bottom of tableview
        return 44.0;  //default
    }
    if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"] ) {   // my best match (grpall)
        if (indexPath.row == 0) return    16.0;  // spacer small
        if (indexPath.row == 1) return    44.0;  // compatibility potential report
//        if (indexPath.row == 2) return    16.0;  // spacer row
        if (indexPath.row == 2) return    22.0;  // spacer row
        if (indexPath.row == 3) return    44.0;  // per for A
        if (indexPath.row == 4) return    44.0;  // per for B
//        if (indexPath.row == 5) return    16.0;  // spacer row
        if (indexPath.row == 5) return    22.0;  // spacer row
//        if (indexPath.row == 6) return    48.0;  // 2-row  grpone desc best match for perA
        if (indexPath.row == 6) return    44.0;  // 1-row  grpone desc best match for perA
//        if (indexPath.row == 7) return    48.0;  // 2-row  grpone desc best match for perB
        if (indexPath.row == 7) return    44.0;  // 1-row  grpone desc best match for perB
        if (indexPath.row == 8) return    44.0;  // empty rows at bottom of tableview
        return 44.0;  //default
    }
//<.>
    return 44.0;
}
// ===============================================================================================================

// ===============================================================================================================
    //    // REPORTS from homgbm  "Best Match" report
    //        @"gbmco|Compatibility Potential",       // from homgbm > tap on a pair  - display gbm*
    //        @"gbm|",            
    //        @"gbm1pe|<per1> Personality",
    //        @"gbm2pe|<per2> Personality",
    //        @"gbm|",
    //        @"gbm1bm|<per1>'s Best Match",                 // in gbm1bm, tap Pair> direct pco for pre-selected pair
    //        @"gbm2bm|<per2>'s Best Match",                 // in gbm2bm, tap Pair> direct pco for pre-selected pair
    //
    //    // REPORTS from hompbm  "My Best Match in Group ..." report
    //        @"pbmco|Compatibility Potential",       // from hompbm > tap on a pair  - display pbm*
    //        @"pbm|",            
    //        @"pbm1pe|<per1> Personality",
    //        @"pbm2pe|<per2> Personality",
    //        @"pbm|",            
    //        @"pbm2bm|<per2>'s Best Match",                 // in 21bm, tap Pair> direct pco for pre-selected pair
    //
// ===============================================================================================================


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
//    NSLog(@"in selREP   BBBBB   cellForRowAtIndexPath!");

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelReports_B_CellIDentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {      // if there are no cells to be reused, create a new cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //  cell.selectedBackgroundView =  gbl_myCellBgView ;  // get my own background color for selected rows (see MAMB09AppDelegate.m)

    // Configure the cell...


    //    UIFont *myNewFont = [UIFont systemFontOfSize: 16.0];
    UIFont *myNewFont =  [UIFont boldSystemFontOfSize: 17.0];

    // for sel rpt B, hard code all cells (pattern above)  - too much customization (each cell but one)

    UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    myInvisibleButton.backgroundColor = [UIColor clearColor];

    NSString *myNewCellText;
    NSInteger thisCellIsActive;
    myNewCellText    = @" ";
    thisCellIsActive = 0;



//
//        // UILabel for the disclosure indicator, ">",  for tappable cells
//        //
//            NSString *myDisclosureIndicatorBGcolorName; 
//            NSString *myDisclosureIndicatorText; 
//            UIColor  *colorOfGroupReportArrow; 
//            UIFont   *myDisclosureIndicatorFont; 
//
//            myDisclosureIndicatorText = @">"; 
////            colorOfGroupReportArrow   = [UIColor blackColor];                 // blue background
////            myDisclosureIndicatorFont = [UIFont     systemFontOfSize: 16.0f]; // make not bold
//            colorOfGroupReportArrow   = [UIColor lightGrayColor];                 // blue background
//            myDisclosureIndicatorFont = [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0]; // good
//
//            NSAttributedString *myNewCellAttributedText3 = [
//                [NSAttributedString alloc] initWithString: myDisclosureIndicatorText  // i.e.   @">"
//                                               attributes: @{            NSFontAttributeName : myDisclosureIndicatorFont,
//                                                               NSForegroundColorAttributeName: colorOfGroupReportArrow                }
//            ];
//
//            lcl_disclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
//            lcl_disclosureIndicatorLabel.backgroundColor = gbl_colorReportsBG; 
//        //
//        // end of  UILabel for the disclosure indicator, ">",  for tappable cells
//


        // UILabel for the disclosure indicator, ">",  for tappable cells
        //
            NSAttributedString *myNewCellAttributedText3 = [
                [NSAttributedString alloc] initWithString: @">"  
                                               attributes: @{
                        NSFontAttributeName :  [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0] ,  
//                        NSForegroundColorAttributeName: [UIColor grayColor ]  
//                        NSForegroundColorAttributeName: [UIColor darkGrayColor ]  
                        NSForegroundColorAttributeName: gbl_colorDIfor_home   
                    }
            ];

            UILabel *myDisclosureIndicatorLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
            myDisclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
            myDisclosureIndicatorLabel.backgroundColor = gbl_colorReportsBG; 

        // end of  UILabel for the disclosure indicator, ">",  for tappable cells




//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"homgbm"] ) {
    if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"gbm"] ) {
        if (indexPath.row == 0) {   // spacer
            thisCellIsActive = 0;
            myNewCellText = @" ";
        }
        if (indexPath.row == 1) {  
            thisCellIsActive = 1;
            myNewCellText = @"Compatibility Potential";
        }
        if (indexPath.row == 2) {   // spacer
            thisCellIsActive = 0;
            myNewCellText = @" ";
        }
        if (indexPath.row == 3) {  
            thisCellIsActive = 1;
            myNewCellText = [NSString stringWithFormat:  @"Personality   %@",  gbl_selectedCellPersonAname];
        }
        if (indexPath.row == 4) {  
            thisCellIsActive = 1;
            myNewCellText = [NSString stringWithFormat:  @"Personality   %@",  gbl_selectedCellPersonBname];
        }
        if (indexPath.row == 5) {   // spacer
            thisCellIsActive = 0;
            myNewCellText = @" ";
        }
//        if (indexPath.row == 6) {   // 2 lines
//            thisCellIsActive = 1;
//            myNewCellText = [NSString stringWithFormat:  @"Best Match for %@\nin Group %@",
//                             gbl_selectedCellPersonAname, gbl_lastSelectedGroup ];
//
//            dispatch_async(dispatch_get_main_queue(), ^{            // <  active
//                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
//                cell.userInteractionEnabled              = YES;                  
//                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
//
//                cell.textLabel.numberOfLines             = 2; 
//                cell.textLabel.textColor                 = [UIColor blackColor];
//                cell.textLabel.adjustsFontSizeToFitWidth = YES;
//            });
//            return cell;
//        }
//
        if (indexPath.row == 6) {   // 1 line
            thisCellIsActive = 1;
            myNewCellText = [NSString stringWithFormat:  @"Best Match for %@", gbl_selectedCellPersonAname];

            dispatch_async(dispatch_get_main_queue(), ^{            // <  active
                cell.textLabel.font                      = myNewFont ;
                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
                cell.userInteractionEnabled              = YES;                  
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.textLabel.numberOfLines             = 1; 
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
                return cell;
        }
//        if (indexPath.row == 7) {   // 2 lines  
//            thisCellIsActive = 1;
//            myNewCellText = [NSString stringWithFormat:  @"Best Match for %@\nin Group %@",
//                             gbl_selectedCellPersonBname, gbl_lastSelectedGroup ];
//
//            dispatch_async(dispatch_get_main_queue(), ^{            // <  active
//                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
//                cell.userInteractionEnabled              = YES;                  
//                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
//
//                cell.textLabel.numberOfLines             = 2; 
//                cell.textLabel.textColor                 = [UIColor blackColor];
//                cell.textLabel.adjustsFontSizeToFitWidth = YES;
//            });
//            return cell;
//        }
//
        if (indexPath.row == 7) {   // 1 line
            thisCellIsActive = 1;
            myNewCellText = [NSString stringWithFormat:  @"Best Match for %@", gbl_selectedCellPersonBname];

            dispatch_async(dispatch_get_main_queue(), ^{            // <  active
                cell.textLabel.font                      = myNewFont ;
                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
                cell.userInteractionEnabled              = YES;                  
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.textLabel.numberOfLines             = 1; 
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
            return cell;
        }
            cell.textLabel.numberOfLines             = 1; 
        if (indexPath.row == 7) {   // spacer   this makes bottom cells be  cell.textLabel.numberOfLines = 1; instead of 2 (above)
            thisCellIsActive = 0;
            myNewCellText = @" ";
        }
    } // homgbm

//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] ) {
    if ([gbl_currentMenuPrefixFromMatchRpt isEqualToString: @"pbm"] ) {

        if (indexPath.row == 0) {   // spacer small
            thisCellIsActive = 0;
            myNewCellText = @" ";
        }
        if (indexPath.row == 1) {  
            thisCellIsActive = 1;
//            myNewCellText = [NSString stringWithFormat:  @"Compatibility Potential Report   "];
            myNewCellText = [NSString stringWithFormat:  @"Compatibility Potential "];
        }
        if (indexPath.row == 2) {   // spacer
            thisCellIsActive = 0;
            myNewCellText = @" ";
        }
        if (indexPath.row == 3) {  
            thisCellIsActive = 1;
            myNewCellText = [NSString stringWithFormat:  @"Personality   %@",  gbl_selectedCellPersonAname];
        }
        if (indexPath.row == 4) {  
            thisCellIsActive = 1;
            myNewCellText = [NSString stringWithFormat:  @"Personality   %@",  gbl_selectedCellPersonBname];
        }
        if (indexPath.row == 5) {   // spacer
            thisCellIsActive = 0;
            myNewCellText = @" ";
        }
//        if (indexPath.row == 6) {   // 2 lines
//            thisCellIsActive = 1;
//            myNewCellText = [NSString stringWithFormat:  @"Best Match for %@\nin Group %@",
//                             gbl_selectedCellPersonBname, gbl_lastSelectedGroup ];
//
//            dispatch_async(dispatch_get_main_queue(), ^{            // <  active
//                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
//                cell.userInteractionEnabled              = YES;                  
//                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
//
//                cell.textLabel.numberOfLines             = 2; 
//                cell.textLabel.textColor                 = [UIColor blackColor];
//                cell.textLabel.adjustsFontSizeToFitWidth = YES;
//            });
//            return cell;
//        }
//
        if (indexPath.row == 6) {   // 1 line
            thisCellIsActive = 1;
            myNewCellText = [NSString stringWithFormat:  @"Best Match for %@", gbl_selectedCellPersonBname];

            dispatch_async(dispatch_get_main_queue(), ^{            // <  active
                cell.textLabel.font                      = myNewFont ;
                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
                cell.userInteractionEnabled              = YES;                  
                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;

                cell.textLabel.numberOfLines             = 1; 
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
            return cell;
        }

//        if (indexPath.row == 7) {   // spacer small
//            thisCellIsActive = 0;
//            myNewCellText = @" ";
//        }
//
//        if (indexPath.row == 8) {   // 2 lines
//            thisCellIsActive = 1;
//            myNewCellText = [NSString stringWithFormat:  @"Best Match for %@\nin Group %@",
//                             gbl_selectedCellPersonBname, gbl_lastSelectedGroup ];
//
//            dispatch_async(dispatch_get_main_queue(), ^{            // <  active
//                cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
//                cell.userInteractionEnabled              = YES;                  
//                cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
//
//                cell.textLabel.numberOfLines             = 2; 
//                cell.textLabel.textColor                 = [UIColor blackColor];
//                cell.textLabel.adjustsFontSizeToFitWidth = YES;
//            });
//            return cell;
//        }
//
    } // homgbm


    if (thisCellIsActive == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{        
            cell.textLabel.font                      = myNewFont ;
            cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
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

//            cell.accessoryView                       = myDisclosureIndicatorLabel;
            cell.accessoryType                       = UITableViewCellAccessoryDisclosureIndicator;
        });
    }
    if (thisCellIsActive == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{            // <  active
            cell.textLabel.font                      = myNewFont ;
            cell.textLabel.text                      = myNewCellText;  // --------------------------------------------------
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
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
//// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSLog(@"in   prepareForSegue in selrpt B  NOTHING HAPPENS in here");
//
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//
//    // get the indexpath of current row
//
//    // this is the "currently" selected row now
//    //
//    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
//    UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
//    // now you can use cell.textLabel.text
//
//    // segueRptSelToViewHTML
//    //
//    if ([segue.identifier isEqualToString:@"segueSelReports_B_ToViewHTML2"]) {
//
//        gbl_fromSelRpt_B_RowString = currcell.textLabel.text;  // note, not used now
//    }
//
//    if ([segue.identifier isEqualToString:@"segueSelReports_B_ToTBLRPTS2"]) {
//
//        gbl_fromSelRpt_B_RowString = currcell.textLabel.text;
//    }
//  NSLog(@"end   prepareForSegue in selrpt B");
} /* prepareForSegue */
//


    //  from home code
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
     NSLog(@"in viewWillAppear  in rpt sel  BBBB!");

     [super viewWillAppear:animated]; 

     [self.navigationController.navigationBar.layer removeAllAnimations];  // stop the nav bar title stutter l to r


    // for B level reports - no remembering for B level reports EXCEPT for returning to this menu)

    // Now  highlight the  remembered last report selection 
    // UNLESS this is entering this menu from "below"
    // OK to highlight if returning to this menu from "above"
    //
  NSLog(@"gbl_selectedRownumSelRpt_B =[%ld]",(long)gbl_selectedRownumSelRpt_B );
    if (gbl_selectedRownumSelRpt_B == -1)  // FLAG to not highlight menu row on first entering selrpts_B
    {
        ;  // do not hightlight any row

    } else {

        if (self.isBeingPresented || self.isMovingToParentViewController) {   // "first time" entering from below
            ;  // do not hightlight any row

        } else {

//NSLog(@"gbl_selectedRownumSelRpt_B=%ld", (long)gbl_selectedRownumSelRpt_B); // get indexpath for saved rownum 
            NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow: gbl_selectedRownumSelRpt_B
                                                          inSection: 0 ];

            [self.tableView selectRowAtIndexPath: myIndexPath   // puts highlight on remembered row
                                        animated: YES
                                  scrollPosition: UITableViewScrollPositionNone];
        }
     } // highlight saved row

} // end of viewWillAppear


//How to check if a UIViewController is being dismissed/popped?
//  To know if your UIVIewController is being dismissed or popped,
//  you can ask your UIVIewController if it is being dismissed or being moved
//  from it’s parent UIVIewController. 
//
- (void)viewWillDisappear:(BOOL)animated {
     NSLog(@"in viewWillDisappear in rpt sel  BBBBB x !");

  [super viewWillDisappear:animated];

  if (self.isBeingDismissed || self.isMovingFromParentViewController) {
      // Handle the case of being dismissed or popped.
      //
      gbl_selectedRownumSelRpt_B = -1; // FLAG to not highlight menu row on first entering selrpts_B
  }
  NSLog(@"gbl_selectedRownumSelRpt_B=%ld", (long)gbl_selectedRownumSelRpt_B);
}



- (void)viewDidAppear:(BOOL)animated
{
     NSLog(@"in viewDidAppear  in rpt sel  BBBBB  !");
//    [super viewDidAppear];

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

    //
    //    // set cell to whatever you want to be selected first
    //    // yellow highlight that cell
    //    //
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //    if (indexPath) {
    //        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    //        //        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    //        // [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionNone];
    //    }
    //
//    tn(); NSLog(@"END of   viewDidAppear  in rpt sel  BBBBB  !");
}



- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"in willDeselectRowAtIndexPath!");
    
    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.
    // 
    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    NSLog(@"in didSelectRowAtIndexPath! in   sel rpt   BBBBB  !");
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access appDelegate.m global stuff
    
    // this is the "currently" selected row now
    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    NSLog(@"indexpath.row=%ld",(long)indexPath.row);

    
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    [self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: currentlyselectedIndexPath.row
                                                      animated: NO];
    // animated:YES
    //  animated: YES];
    
    // populate  gbl_currentMenuPlusReportCode 
    // get the menu code + report code from gbl_mambReports   (like "hompbm")
    do {
        NSString *myPrefix = gbl_currentMenuPrefixFromMatchRpt;  // like "homp"

  NSLog(@"gbl_currentMenuPrefixFromMatchRpt=%@", gbl_currentMenuPrefixFromMatchRpt);

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
tn(); NSLog(@"gbl_currentMenuPlusReportCode in rptsel BBB =%@",gbl_currentMenuPlusReportCode ); tn();


    // "Personality"  or  compatibility (just2)  or wc  or cy
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"pbmco" ]  // all reports HTML
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbmco" ]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1pe"]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2pe"]
    ) {

        // save PSV of person for whom a report was selected (A or B from pair)
        //
        do {
            //NSString *gbl_PSVtappedPerson_grpone;  // pbm1pe,pbm2pe,pbm2bm
            //NSString *gbl_PSVtappedPerson_grpall;  // gbm1pe,gbm2pe,gbm1bm,gbm2bm
            //NSString *gbl_PSVtappedPerson_grpmost; // gmappe,gmeppe,gmrppe,gmpppe,gmdppe
            //NSString *gbl_PSVtappedPerson_grpbest; // gbypcy,gbdpwc
            //NSString *gbl_PSVtappedPersonA_inPair; // pbmco,gbmco
            //NSString *gbl_PSVtappedPersonB_inPair; // pbmco,gbmco

            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]
                || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1pe"]
            ) {
                gbl_PSVtappedPerson_fromGRP = gbl_PSVtappedPersonA_inPair;
            }
            if (   [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]
                || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2pe"]
            ) {
                gbl_PSVtappedPerson_fromGRP = gbl_PSVtappedPersonB_inPair;
            }

        } while (false);  // save PSV of select person or persons


        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myappDelegate mamb_beginIgnoringInteractionEvents ];
   
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [self performSegueWithIdentifier: @"segueRptSel_B_ToViewHTML" sender:self];
            [self performSegueWithIdentifier:@"segueRptSelBToTBLRPT2" sender:self];   // is  now table rpt 
        });


    } // all reports HTML


    //  "My Best Match"
    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm" ]  // all reports group/tableview
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1bm" ]
        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2bm" ]
    ) {

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
        [myappDelegate mamb_beginIgnoringInteractionEvents ];
   
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [self performSegueWithIdentifier:@"segueRptSelBToTBLRPT2" sender:self];
        });


    }


    //    // **********   NO REMEMBERING WHICH REPORT WAS SELECTED  for a specific pair or person ********************
    //   ONLY REMEMBER the indexPath.row in this session   NOT names between sessions
    //
    gbl_selectedRownumSelRpt_B = indexPath.row;

    //        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
    //                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
    //                         updatingRememberCategory: (NSString *) @"rptsel"
    //                                       usingValue: (NSString *) gbl_currentMenuPlusReportCode
    //        ];
    //

} // didSelectRowAtIndexPath


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
//tn();
//  NSLog(@"in viewForHeaderInSection  in tblrpts 1");
//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
//  NSLog(@"gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
//  NSLog(@"gbl_currentMenuPrefixFromMatchRpt=%@",gbl_currentMenuPrefixFromMatchRpt);
//  NSLog(@"gbl_lastSelPersonWasA =%@",gbl_lastSelPersonWasA );
//  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//  NSLog(@"gbl_kingpinPersonName=%@",gbl_kingpinPersonName);
//  NSLog(@"gbl_lastSelectedGroup=%@",gbl_lastSelectedGroup);
//tn();
//


    UIView *myReturnView;

    if (section == 0) {
        UILabel *lblSection0 = [[UILabel alloc] init];


  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );

        lblSection0.numberOfLines   = 1;
        lblSection0.font            = [UIFont boldSystemFontOfSize: 14.0];
        lblSection0.text            = [NSString stringWithFormat: @"in Group   %@", gbl_lastSelectedGroup];
        lblSection0.backgroundColor = [UIColor whiteColor];

        [lblSection0 sizeToFit];

        // make same font bold
        //
        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
        UIFont *currentFont       = lblSection0.font;
        UIFont *currentFontBolded = [myappDelegate boldFontWithFont: (UIFont *) currentFont];
        lblSection0.font          = currentFontBolded;

        lblSection0.textAlignment = NSTextAlignmentCenter;
        myReturnView = lblSection0;
    }

    return myReturnView;

}  // end of  viewForHeaderInSection



// how to set the section header cell height
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  // --------------------------------
{
      return 24.0;
}  // ---------------------------------------------------------------------------------------------------------------------



@end

//
//    // below are reports for pairs of people (picked from a group report having pairs)
//    // **********   NO REMEMBERING WHICH REPORT WAS SELECTED  for pairs ********************
//
//
//    //if ([stringForCurrentlySelectedRow hasPrefix: @"Personality"] ) {
//    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"pbm1pe"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2pe"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm1pe"]
//        || [gbl_currentMenuPlusReportCode isEqualToString: @"gbm2pe"]
//       ) {
//
//        // Because background threads are not prioritized and will wait a very long time
//        // before you see results, unlike the mainthread, which is high priority for the system.
//        //
//        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
//        //
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [self performSegueWithIdentifier: @"segueRptSel_B_ToViewHTML" sender:self];
//        });
//    }
//
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"] ) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [self performSegueWithIdentifier: @"segueRptSelToSelPerson" sender:self];
//        });
//    }
//
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"] ) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [self performSegueWithIdentifier: @"segueRptSelToSelPerson" sender:self];
//        });
//    }
//



//    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//
//    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
//    UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];
//
//
//    //    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//    //        [[self navigationItem] setTitle: @"Select Report" ];
//    //    });
//    //
//
//    //label.backgroundColor = [UIColor clearColor];
//    //label.font = [UIFont boldSystemFontOfSize: 14.0f];
//    //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
//    //label.textAlignment = UITextAlignmentCenter;  deprecated to NSText...
//    //label.textColor = [UIColor whiteColor];
//
//
////    UILabel *mySelRptB_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
//    UILabel *mySelRptB_Label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 132)];  // 132=3*44
//    mySelRptB_Label.numberOfLines = 2;
//
////    mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 17.0f];
////    mySelRptB_Label.font          = [UIFont fontWithName:@"HelveticaNeueBold" size: 17.0];
////    mySelRptB_Label.font          = [UIFont fontWithName:@"HelveticaNeueBold" size: 10.0];
////    mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 10.0];
////    mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 14.0];
////    mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 12.0];
////    mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 13.0];
////    mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 12.0];
////    mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 16.0];
//    mySelRptB_Label.font          = [UIFont boldSystemFontOfSize: 16.0];
//
//    mySelRptB_Label.textColor     = [UIColor blackColor];
//    mySelRptB_Label.textAlignment = NSTextAlignmentCenter; 
////    mySelRptB_Label.text          = [NSString stringWithFormat:  @"%@\nand %@\nin G2oup %@", 
////    mySelRptB_Label.text          = [NSString stringWithFormat:  @"%@ and %@\nin G2oup %@", 
//    mySelRptB_Label.text          = [NSString stringWithFormat:  @"%@\nand %@", 
//                                     gbl_selectedCellPersonAname, gbl_selectedCellPersonBname ];
////                                     gbl_selectedCellPersonAname, gbl_selectedCellPersonBname, gbl_lastSelectedGroup ];
//
//
////    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//        self.navigationItem.rightBarButtonItem = mySpacerForTitle;
//        self.navigationItem.titleView = mySelRptB_Label;
//    });
//
//
