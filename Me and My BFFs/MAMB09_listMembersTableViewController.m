
//
//  MAMB09_listMembersTableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2016-01-04.
//  Copyright © 2016 Richard Koskela. All rights reserved.
//

#import "MAMB09_listMembersTableViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

@interface MAMB09_listMembersTableViewController ()

@end

@implementation MAMB09_listMembersTableViewController

CGFloat myCurrentScreenHeight;
CGFloat myCurrentNavbarHeight;
CGFloat myCurrentStatusbarHeight;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
tn();
    NSLog(@"in LIST MEMBEFRS   viewDidLoad!");

//    gbl_justLeftMemberAddorDelScreen  = 0;

//    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    [self.tableView setBackgroundColor: gbl_colorEditingBG ];

    // set up left arrow for "Back" button
    //
    // http://stackoverflow.com/questions/18912638/custom-image-for-uinavigation-back-button-in-ios-7
//    UIImage *backBtn = [UIImage imageNamed:@"iconPlusAddGreenBig_66"];
    UIImage *backBtn = [UIImage imageNamed:@"iconRightArrowBlue_66"]; // actually left arrow
    backBtn = [backBtn imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.backBarButtonItem.title=@"";
    self.navigationController.navigationBar.backIndicatorImage = backBtn;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backBtn;


    // set the Nav Bar Title  according to where we came from
    //
    do {
        // UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
        //                                                                               target: self
        //                                                                               action: nil];

        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        myInvisibleButton.backgroundColor = [UIColor clearColor];
        UIBarButtonItem *mySpacerNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];

        // setup for TWO-LINE NAV BAR TITLE

        //    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];  // 3rd arg is horizontal length
        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

        UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

        NSString *myNavBar2lineTitle;
        myNavBar2lineTitle = [NSString stringWithFormat:  @"Current Members of\n Group  %@", gbl_lastSelectedGroup ];

        myNavBarLabel.numberOfLines = 2;
    //        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 16.0];
        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 14.0];
        myNavBarLabel.textColor     = [UIColor blackColor];
        myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
        myNavBarLabel.text          = myNavBar2lineTitle;


        // TWO-LINE NAV BAR TITLE
        //
        dispatch_async(dispatch_get_main_queue(), ^{   
            self.navigationItem.titleView           = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
    //      self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
            self.navigationItem.rightBarButtonItem =  mySpacerForTitle;
        });

    } while (FALSE);



    // populate gbl_arrayMembersToDisplay
    //
    // INCLUDE ONLY   members of gbl_lastSelectedGroup
    //
tn();
  NSLog(@"doing  // populate gbl_arrayMembersToDisplay");
  NSLog(@"gbl_lastSelectedGroup =[%@]",gbl_lastSelectedGroup );

    [gbl_arrayMembersToDisplay removeAllObjects];
    gbl_arrayMembersToDisplay = [[NSMutableArray alloc] init];

    for (id myMemberRec in gbl_arrayMem) {

// skip example record  TODO in production
//            if (gbl_show_example_data ==  NO  &&
//                [mymyMemberRecPSV hasPrefix: @"~"]) {  // skip example record
//                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
//            }
//
  NSLog(@"myMemberRec =[%@]",myMemberRec );

        NSArray *psvArray;
        NSString *currGroup;
        NSString *currMember;
        
        psvArray = [myMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        currGroup  = psvArray[0];
        currMember = psvArray[1];
//  NSLog(@"currGroup  =[%@]",currGroup  );
//  NSLog(@"currMember =[%@]",currMember );

        if ([currGroup isEqualToString: gbl_lastSelectedGroup ] )
        {
//  NSLog(@"ADDED to gbl_arrayMembersToDisplay ");
            [gbl_arrayMembersToDisplay addObject: currMember ];                        //  Person name for pick
        }
    } // for each groupmember

 NSLog(@"gbl_arrayMembersToDisplay=%@",gbl_arrayMembersToDisplay);
 NSLog(@"gbl_arrayMembersToDisplay.count=%lu",(unsigned long)gbl_arrayMembersToDisplay.count);

} // viewDidLoad



- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
  NSLog(@"in viewWillAppear! in LIST MEMBERS ");


    // set up toolbar at bottom of screen
    // BUT ONLY if we got here for the first time "from below".
    //
    // If we are here returning from add member or del member,
    // we do not want to paint the toolbar again
    //
    if (self.isBeingPresented || self.isMovingToParentViewController) {   // "first time" entering from below
        // here we got to this screen from "below"
        //

        // use 2 buttons in a toolbar on bottom of screen to  add- green "+"  delete- red "-"
        //
        UIBarButtonItem *myPrompt = [[UIBarButtonItem alloc]initWithTitle: @"Members" 
                                                                    style: UIBarButtonItemStylePlain
                                                                   target: self
                                                                   action: nil
        ];

        [myPrompt setTitleTextAttributes: @{
    //                    NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:26.0],
    //                    NSFontAttributeName: [UIFont boldSystemFontOfSize: 17.0],
                        NSFontAttributeName: [UIFont boldSystemFontOfSize: 20.0],
    //         NSForegroundColorAttributeName: [UIColor greenColor]
             NSForegroundColorAttributeName: [UIColor blackColor]
           }
                                forState: UIControlStateNormal
        ];



        UIImage *myImageADD = [[UIImage imageNamed: @"iconPlusAddGreenBig_66.png"]
                            imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal
        ];
        UIImage *myImageDEL = [[UIImage imageNamed: @"iconMinusDelRedBig_66.png"]
                            imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal 
        ];


    //    UIBarButtonItem *memberADD = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"iconPlusAddGreenBig_66.png"]
        UIBarButtonItem *memberADD = [[UIBarButtonItem alloc] initWithImage: myImageADD
                                                                      style: UIBarButtonItemStylePlain
                                                                     target: self
                                                                     action: @selector(pressedGreenPlusAdd)
        ];
    //    UIBarButtonItem *memberDEL = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"iconMinusDelRedBig_66.png"]
        UIBarButtonItem *memberDEL = [[UIBarButtonItem alloc] initWithImage: myImageDEL
                                                                      style: UIBarButtonItemStylePlain
                                                                     target: self
                                                                     action: @selector(pressedRedMinusDel)
        ];

        
        UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                                         target: self
                                                                                         action: nil];
            // create a Toolbar

    //       UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
    //       UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    //        gbl_toolbarForwBack = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];

        float my_screen_height;
        float my_status_bar_height;
        float my_nav_bar_height;
        float my_toolbar_height;

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
        CGSize currentScreenWidthHeight = [myappDelegate currentScreenSize];
        my_screen_height       = currentScreenWidthHeight.height;
        myCurrentScreenHeight  = currentScreenWidthHeight.height;

        CGSize myStatusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
        my_status_bar_height   = MIN(myStatusBarSize.width, myStatusBarSize.height);
        myCurrentStatusbarHeight = MIN(myStatusBarSize.width, myStatusBarSize.height);


        my_nav_bar_height      =  self.navigationController.navigationBar.frame.size.height;
        myCurrentNavbarHeight  =  self.navigationController.navigationBar.frame.size.height;


    //  NSLog(@"cu33entScreenWidthHeight.width  =%f",currentScreenWidthHeight.width );
    //  NSLog(@"cu33entScreenWidthHeight.height =%f",currentScreenWidthHeight.height );
      NSLog(@"my_screen_height                  =%f",my_screen_height );
      NSLog(@"my_status_bar_height              =%f",my_status_bar_height   );
      NSLog(@"my_nav_bar_height                 =%f",my_nav_bar_height    );
        my_toolbar_height = 44.0;
      NSLog(@"my_toolbar_height                 =%f",my_toolbar_height );


        float y_value_of_toolbar; 
        //    y_value_of_toolbar  = currentScreenWidthHeight.height - 44.0;
        //    y_value_of_toolbar  = 400.0;
        //    y_value_of_toolbar  = 436.0;
        //    y_value_of_toolbar  = 480.0;
        //    y_value_of_toolbar  = 472.0;// too low
        //    y_value_of_toolbar  = 464.0; // very close
        //    y_value_of_toolbar  = 458.0; // too high
        //    y_value_of_toolbar  = 456.0; // too high
        //    y_value_of_toolbar  = 459.0; // too high
        //    y_value_of_toolbar  = 460.0; // very close   exact
        y_value_of_toolbar  = my_screen_height  - my_status_bar_height  - my_nav_bar_height - my_toolbar_height;
      NSLog(@"y_value_of_toolbar  =%f",y_value_of_toolbar  );


        gbl_toolbarMemberAddDel = [[UIToolbar alloc] initWithFrame:CGRectMake(
            0.0,
            y_value_of_toolbar, 
            currentScreenWidthHeight.width,
            44.0)];


    //
    //439://      gbl_myCellBgView =[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [cell frame].size.width -20, [cell frame].size.height)];
    //906:// CGRect pickerFrame = CGRectMake(0.0, viewFrame.size.height-pickerHeight, viewFrame.size.width, pickerHeight);
    //28:    self.outletWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //

            // make array of buttons for the Toolbar
            NSArray *myButtonArray =  [NSArray arrayWithObjects:
    //            myFlexibleSpace, myPrompt, myFlexibleSpace, memberADD, myFlexibleSpace, memberDEL, myFlexibleSpace, nil
    //            myFlexibleSpace, myFlexibleSpace, myPrompt, myFlexibleSpace, memberADD, myFlexibleSpace, memberDEL, myFlexibleSpace, myFlexibleSpace, nil
                myFlexibleSpace, myFlexibleSpace, myFlexibleSpace,
                myPrompt, myFlexibleSpace, memberADD, myFlexibleSpace, memberDEL,
                myFlexibleSpace, myFlexibleSpace, myFlexibleSpace, nil
            ]; 

            // put the array of buttons in the Toolbar
            [gbl_toolbarMemberAddDel setItems: myButtonArray   animated: NO];
    nbn(129);
                // set bottom toolbar bg color to white
                //
                gbl_toolbarMemberAddDel.translucent  = NO;
                gbl_toolbarMemberAddDel.barTintColor = [UIColor whiteColor];

            // put the Toolbar onto bottom of what color view
            dispatch_async(dispatch_get_main_queue(), ^(void){
    //             self.navigationController.toolbar.hidden = YES;
                [self.view addSubview: gbl_toolbarMemberAddDel ];

    //            [self.navigationController.view addSubview: gbl_toolbarForwBack ];  // this worked  but in info, it stayed  also allows too fast
    //             self.navigationController.toolbar.hidden = NO;
    //            [self.navigationController.toolbar setItems: myButtonArray ]; 
    //            self.navigationController.toolbar.items = myButtonArray; 
    //             self.navigationController.toolbar.hidden = NO

            });

            // set the y postion of this toolbar, so we can keep it on the bottom
            //
            gbl_listMemberToolbar_y = gbl_toolbarMemberAddDel.frame.origin.y ;
  NSLog(@"gbl_listMemberToolbar_y =[%f]",gbl_listMemberToolbar_y );
  
  } // end of set Member  Toolbar at bottom of screen

} // end of   viewWillAppear

// on the fly,  adjust the y value of the frame of the bottom toolbar
// so it is ALWAYS on the bottom
//
// http://stackoverflow.com/questions/13663230/ios-add-subview-with-a-fix-position-on-screen
//
// Replace 20 by how many points you want it to be from top of the table view.
// You still add self.fixedView as a subliew of self.view,
// this will just make sure it looks like it's in a fixed position above table view.
//
// - (void)scrollViewDidScroll:(UIScrollView *)scrollView
// {
//     CGRect fixedFrame = self.fixedView.frame;
//     fixedFrame.origin.y = 20 + scrollView.contentOffset.y;
//     self.fixedView.frame = fixedFrame;
// }
//
- (void)scrollViewDidScroll: (UIScrollView *)scrollView
{
    CGRect fixedFrame = gbl_toolbarMemberAddDel.frame;

//tn();
//  NSLog(@"myCurrentScreenHeight             =[%f]",myCurrentScreenHeight );
//  NSLog(@"myCurrentNavbarHeight             =[%f]",myCurrentNavbarHeight );
//  NSLog(@"my_status_bar_height              =[%f]",myCurrentStatusbarHeight );
//  NSLog(@"scrollView.contentOffset.y        =[%f]",scrollView.contentOffset.y );
//  NSLog(@"fixedFrame.origin.y               =[%f]",fixedFrame.origin.y );
//  NSLog(@"gbl_listMemberToolbar_y           =[%f]",gbl_listMemberToolbar_y );
//  NSLog(@"gbl_toolbarMemberAddDel.frame y   =[%f]",gbl_toolbarMemberAddDel.frame.origin.y  );
//

//    fixedFrame.origin.y =  628.0                  + scrollView.contentOffset.y ;
    fixedFrame.origin.y =  gbl_listMemberToolbar_y  + scrollView.contentOffset.y ;

//  NSLog(@"fixedFrame.origin.y  FINAL        =[%f]",fixedFrame.origin.y );

    gbl_toolbarMemberAddDel.frame = fixedFrame;
} // scrollViewDidScroll



//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if(section == 0) {
//        UIView *fakeFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44.0, 44.0)];  // 3rd arg is horizontal length
//        return fakeFooterView;
//    }
//    else return nil;
//} // viewForFooterInSection
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if(section == 0) return 44.0f;
//
//    return 44.0f;
//}
//



- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()  in list  members");

   
    if (gbl_justWroteMemberFile  == 1
    ) {
        gbl_justWroteMemberFile  = 0;
        
        // grab new array of members to display

        // INCLUDE ONLY   members of gbl_lastSelectedGroup
        //
        [gbl_arrayMembersToDisplay removeAllObjects];
        gbl_arrayMembersToDisplay = [[NSMutableArray alloc] init];

        for (id myMemberRec in gbl_arrayMem) {

// skip example record  TODO in production
//            if (gbl_show_example_data ==  NO  &&
//                [mymyMemberRecPSV hasPrefix: @"~"]) {  // skip example record
//                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
//            }
//

            NSArray *psvArray;
            NSString *currGroup;
            NSString *currMember;
            
            psvArray = [myMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
            currGroup  = psvArray[0];
            currMember = psvArray[1];

            if ([currGroup isEqualToString: gbl_lastSelectedGroup ] )
            {
                [gbl_arrayMembersToDisplay addObject: currMember ];                        //  Person name for pick
            }
        } // for each groupmember

  NSLog(@"reloading tableview");

        [self.tableView reloadData];
    }

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

} // viewDidAppear


- (IBAction)pressedGreenPlusAdd
{
  NSLog(@"in pressedGreenPlusAdd");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_beginIgnoringInteractionEvents ];

    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
        [self performSegueWithIdentifier:@"segueListMembersToSelNewMembers" sender:self]; //  
    });

} // (IBAction)pressedGreenPlusAdd


- (IBAction)pressedRedMinusDel
{
  NSLog(@"in pressedRedMinusDel");
//    [self.tableView setBackgroundColor: gbl_colorforDelMembers ];

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_beginIgnoringInteractionEvents ];

    dispatch_async(dispatch_get_main_queue(), ^{                                 // <===  
        [self performSegueWithIdentifier:@"segueListMembersToDeleteMembers" sender:self]; //  
    });


} // (IBAction)pressedRedMinusDel


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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return gbl_arrayMembersToDisplay.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
tn();
  NSLog(@"in cellForRowAtIndexPath");
//  NSLog(@"row=[%ld]",(long)indexPath.row);
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"ListPersonCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...


    UIFont *myNewFont =  [UIFont boldSystemFontOfSize: 17.0];

    dispatch_async(dispatch_get_main_queue(), ^(void){

        cell.textLabel.text = [gbl_arrayMembersToDisplay   objectAtIndex:indexPath.row];
        //        cell.textLabel.font = [UIFont systemFontOfSize: 16.0];
        cell.textLabel.font = myNewFont;

        // PROBLEM  name slides left off screen when you hit red round delete "-" button
        //          and delete button slides from right into screen
        //
        cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
        cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
    });

    
//  NSLog(@"cell.textLabel.text=[%@]",cell.textLabel.text);
    return cell;
}

// color cell bg
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];

    // UIColor *gbl_colorEditingBG_current;  // is now yellow or blue for add a record screen  (addChange view)
    cell.backgroundColor = [UIColor clearColor];
}

// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // -------------------------
{
//  NSLog(@"in heightForRowAtIndexPath 1");

  return 44.0; // matches report height
}


/*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
*/

/*
// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
*/

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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

  NSLog(@"in prepareForSegue  in LIST MEMbers");
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
