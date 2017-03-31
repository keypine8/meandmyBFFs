//
//  MAMB09_deleteMembersTableViewController.m
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

#import "MAMB09_deleteMembersTableViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

@interface MAMB09_deleteMembersTableViewController ()

@end

@implementation MAMB09_deleteMembersTableViewController
//@implementation MAMB09_selNewMembersTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
tn();
    NSLog(@"in DELEtE MEMBEFRS   viewDidLoad!");


    // put selected names to delete into array  gbl_selectedMembers_toDel  
    //
    [gbl_selectedMembers_toDel  removeAllObjects];
     gbl_selectedMembers_toDel  = [[NSMutableArray alloc] init];
        


    [self.tableView setEditing:YES animated:YES];

    self.tableView.allowsMultipleSelectionDuringEditing = YES;

//    [[UITableViewCell appearance] setTintColor:[UIColor greenColor]];  // set color of selected row circle+checkmark background
//    [[UITableViewCell appearance] setTintColor:[UIColor blueColor]];  // set color of selected row circle+checkmark background
//    [[UITableView appearance] setTintColor:[UIColor blackColor]];


//    [self.tableView setBackgroundColor: gbl_colorReportsBG];
//    [self.tableView setBackgroundColor: gbl_colorEditingBG ];
//    [self.tableView setBackgroundColor: gbl_color_cGre ];
//    [self.tableView setBackgroundColor: gbl_colorforAddMembers ];
    [self.tableView setBackgroundColor: gbl_colorforDelMembers ];


//        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave
        UIBarButtonItem *navSaveButton   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                                         target: self
                                                                                         action: @selector(pressedSaveDone:)];
//        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        UIBarButtonItem *navCancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                                                         target: self
                                                                                         action: @selector(pressedCancel:)];
//        // put info button on Nav Bar
//        UIButton *myInfoButton     =  [UIButton buttonWithType: UIButtonTypeInfoDark] ;
//        [myInfoButton addTarget: self action: @selector(pressedInfoButton:) forControlEvents:UIControlEventTouchUpInside];
//
//        UIBarButtonItem *navToInfoButton = [[UIBarButtonItem alloc] initWithCustomView: myInfoButton ];
//


  NSLog(@"navSaveButton=[%@]",navSaveButton);

    // set the Nav Bar Title  according to where we came from
    //
    do {
//        UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
//                                                                                         target: self
//                                                                                         action: nil];

        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        myInvisibleButton.backgroundColor = [UIColor clearColor];
//        UIBarButtonItem *mySpacerNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];

        // setup for TWO-LINE NAV BAR TITLE

        //    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];  // 3rd arg is horizontal length
//        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

        UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

        NSString *myNavBar2lineTitle;
//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete Members\n from Group %@", gbl_lastSelectedGroup ];
//      myNavBar2lineTitle = [NSString stringWithFormat:  @"Select Members to DELETE\n from Group %@", gbl_lastSelectedGroup ];
//      myNavBar2lineTitle = [NSString stringWithFormat:  @"Select Deletable Members\n from Group %@", gbl_lastSelectedGroup ];
//       myNavBar2lineTitle = [NSString stringWithFormat:  @"Select one to Delete\n from Group %@", gbl_lastSelectedGroup ];

//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Select 8 0 2 4 6 8 0 2 4\n from Group %@", @"1 3 5 7 9 1 3 5"];
//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Select 8 0 2 4 6 8 0 2 4\n from %@", @"1 3 5 7 9 1 3 5"];
//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Select 8 0 2 4 67\n from %@", @"1 3 5 7 9 1 3 5"];
//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Select 8 0 2 4 67\n from %@", @"1 3 5 7 9 1 3 5"];
//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete Members from\nGroup %@",  @"1 3 5 7 9 1 3 5"];
//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete Members from\nGroup %@",@"Moon Base w2345"];

            if (   self.view.bounds.size.width >= 414.0        // 6+ and 6s+  and bigger
            ) {
                myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete People from\nGroup %@", gbl_lastSelectedGroup ];
//myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete Members from\nGroup %@",@"Moon Base w2345"];
            }
            else if (   self.view.bounds.size.width  < 414.0    // 6 and 6s
                     && self.view.bounds.size.width  > 320.0
            ) {
                myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete People from\nGroup %@", gbl_lastSelectedGroup ];
//myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete Members from\nGroup %@",@"Moon Base w2345"];
            }
            else if (   self.view.bounds.size.width <= 320.0   //  5s and 5 and 4s and smaller
            ) {
                myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete People from\n%@", gbl_lastSelectedGroup ];
//myNavBar2lineTitle = [NSString stringWithFormat:  @"Delete Members from\n%@",@"Moon Base w2345"];
            }

//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Select\n for %@", @"xx" ];

        myNavBarLabel.numberOfLines = 2;
    //        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 16.0];
        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 14.0];
        myNavBarLabel.textColor     = [UIColor blackColor];
        myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
        myNavBarLabel.text          = myNavBar2lineTitle;
        myNavBarLabel.adjustsFontSizeToFitWidth = YES;
        [myNavBarLabel sizeToFit];

//    =  [NSArray arrayWithObjects: 
//                gbl_nameButtonToClearKeyboard, gbl_flexibleSpace,
//                gbl_title_groupName          , gbl_flexibleSpace,
//                gbl_flexibleSpace            , nil ]; 
            //
//        [gbl_ToolbarForGroupName    setItems: gbl_buttonArrayForPersonName  animated: YES];


        // TWO-LINE NAV BAR TITLE
        //
        dispatch_async(dispatch_get_main_queue(), ^{   

            // Disable the swipe to make sure you get your chance to save  
            // self.navigationController?.interactivePopGestureRecognizer.enabled = false
            self.navigationController.interactivePopGestureRecognizer.enabled = false ;

            self.navigationItem.titleView           = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
    //      self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//            self.navigationItem.rightBarButtonItem =  mySpacerForTitle;

            self.navigationItem.leftBarButtonItem   = navCancelButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item

// self.navigationItem.RightBarButtonItem    = navSaveButton; 
//            self.navigationItem.RightBarButtonItem  = navToInfoButton;
//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: navSaveButton ];
//                gbl_flexibleSpace,

            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: 
//                navToInfoButton,
                navSaveButton,
                nil
            ]; 


//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myInfoButton  ];
//            self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: navSaveButton ];

//            self.navigationItem.rightBarButtonItems  =
//           [self.navigationItem.rightBarButtonItems  arrayByAddingObject: navSaveButton  ]; // add SAVE   BUTTON

//            // below works for when there is an info button  (from storyboard)
//            self.navigationItem.rightBarButtonItems  =
//                [self.navigationItem.rightBarButtonItems  arrayByAddingObject: navSaveButton  ]; // add SAVE   BUTTON

//            // below works for no info button
// self.navigationItem.RightBarButtonItem    = navSaveButton; // replace what's there with  CANCEL BUTTON   Notice no "s" on item


        });

    } while (FALSE);


    // get array to populate tableview with

    [gbl_arrayDeletableMembersToPickFrom  removeAllObjects];
     gbl_arrayDeletableMembersToPickFrom = [[NSMutableArray alloc] init];


    // INCLUDE ONLY      members of gbl_lastSelectedGroup
    //
    for (id myNewMemberRec in gbl_arrayMem) {

// skip example record  TODO in production
//            if (gbl_show_example_data ==  NO  &&
//                [mymyMemberRecPSV hasPrefix: @"~"]) {  // skip example record
//                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
//            }
//

        NSArray *psvArray;
        NSString *currGroup;
        NSString *currMember;
        
        psvArray = [myNewMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        currGroup  = psvArray[0];
        currMember = psvArray[1];


        if ([currGroup isEqualToString: gbl_lastSelectedGroup ] )
        {
            [gbl_arrayDeletableMembersToPickFrom  addObject: currMember ];    //  Person name for pick
        }
    } // for each groupmember

 NSLog(@"gbl_arrayDeletableMembersToPickFrom =%@",gbl_arrayDeletableMembersToPickFrom );
 NSLog(@"gbl_arrayDeletableMembersToPickFrom.count=%lu",(unsigned long)gbl_arrayDeletableMembersToPickFrom.count);


//    [self updateButtonsToMatchTableState]; // make our view consistent - Update the delete button's title based on how many items are selected.
    //    [self updateButtonsToMatchTableState]; // Update the delete button's title based on how many items are selected.



    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex  or not


} //   viewDidLoad 


- (void)viewDidAppear:(BOOL)animated
{
NSLog(@"in viewDidAppear()");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds
                                                    
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in didSelectRowAtIndexPath! in sel new mbr");
    UITableViewCell* cell   = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType      = UITableViewCellAccessoryCheckmark;
    NSString *tmpMemberName = cell.textLabel.text;
    [gbl_selectedMembers_toDel  addObject: tmpMemberName ];          //  Person name for pick

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"in didDeselectRowAtIndexPath! in sel new mbr");
    UITableViewCell* cell   = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType      = UITableViewCellAccessoryNone;
    NSString *tmpMemberName = cell.textLabel.text;
    [gbl_selectedMembers_toDel  removeObject: tmpMemberName ];          //  Person name for pick
}



- (IBAction)pressedSaveDone:(id)sender
{
  NSLog(@"in pressedSAVEDONE!!");
    // PROBLEM:  CANNOT TRUST  [self.tableView indexPathsForSelectedRows] when scrolling off screen
    // therefore,  use gbl_selectedMembers_toAdd  
    //
    //    for (id idxpath in [self.tableView indexPathsForSelectedRows] )
    //    {
    //        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: idxpath];
    //        [gbl_selectedMembers_toDel  addObject: cell.textLabel.text ];
    //    }


    if ([gbl_lastSelectedGroup hasPrefix: @"~" ]) 
    {
        UIAlertController* myAlert = [
            UIAlertController alertControllerWithTitle: @"An Example Group Cannot be Changed"
                                               message: @"You cannot delete members from an example group."
                                        preferredStyle: UIAlertControllerStyleAlert 
        ];
        UIAlertAction*  okButton = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {
            NSLog(@"Ok button pressed");
        } ];
        [myAlert addAction:  okButton];

        [self presentViewController: myAlert  animated: YES  completion: nil   ]; // cannot save because of missing information

        return;
    }



    // sort array  gbl_selectedMembers_toDel 
    if (gbl_selectedMembers_toDel)  { [gbl_selectedMembers_toDel  sortUsingSelector: @selector(caseInsensitiveCompare:)]; }

  NSLog(@"[self.tableView indexPathsForSelectedRows] =[%@]",[self.tableView indexPathsForSelectedRows] );
  NSLog(@"gbl_selectedMembers_toDel  =[%@]",gbl_selectedMembers_toDel);


    // DELETE the members here
    //
    if (gbl_selectedMembers_toDel.count == 0) return;
    
    // before write of array data to file, disallow/ignore user interaction events --------------------------------------------------------
    //

//    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] ==  NO) {  // suspend handling of touch-related events
//        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];     // typically call this before an animation or transitiion.
//NSLog(@"ARE  IGnoring events");
//    }
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];

    // delete each selected member from gbl_arrayMem 
    //     having group  = gbl_lastSelectedGroup
    //        and member = name in gbl_selectedMembers_toDel
    //
//    NSInteger arrayIndexToDelete;
    for (id del_me_name  in  gbl_selectedMembers_toDel)
    {

        // searchfor element in gbl_arrayMem
        // matching   group = gbl_lastSelectedGroup   and   member = del_me_indexPath.text
        // delete that element in gbl_arrayMem
        // 
        NSString *prefixStr;
        prefixStr = [NSString stringWithFormat: @"%@|%@|", gbl_lastSelectedGroup, del_me_name ];
        for (int i=0;  i < gbl_arrayMem.count;  i++) {

            if ( [gbl_arrayMem[i]  hasPrefix: prefixStr ] )
            {
                // delete this array element
                [gbl_arrayMem removeObjectAtIndex:  i ]; 
  NSLog(@"DELETED =[%@]",gbl_arrayMem[i]);
            }
        } // for each gbl_arrayMem

    } // for each member to delete


    // was sorted before anyway, but sort it for safety
    [myappDelegate mambSortOnFieldOneForPSVarrayWithDescription:  (NSString *) @"member"]; // sort array by name

    [myappDelegate mambWriteNSArrayWithDescription:               (NSString *) @"member"]; // write new array data to file
    //  [myappDelegate mambReadArrayFileWithDescription:              (NSString *) @"person"]; // read new data from file to array


//    // after write of array data to file, allow user interaction events again  ----------------------------------------------------------
//    //
//    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents] == YES) {  // re-enable handling of touch-related events
//        [[UIApplication sharedApplication] endIgnoringInteractionEvents];       // typically call this after an animation or transitiion.
//NSLog(@"STOP IGnoring events");
//    }

    gbl_justWroteMemberFile = 1;

    // go back to home and ask for  What Kind of Delete  there
    //
    dispatch_async(dispatch_get_main_queue(), ^{  
        [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
    });

} // pressedSaveDone



- (IBAction)pressedCancel:(id)sender     // this is the Cancel on left of Nav Bar
{
  NSLog(@"pressedCancel");
  NSLog(@" // actually do the BACK action ");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate];
    [myappDelegate mamb_beginIgnoringInteractionEvents ];

    dispatch_async(dispatch_get_main_queue(), ^{  
        [self.navigationController popViewControllerAnimated: YES]; // actually do the "Back" action
    });
} // pressedCancel



//- (IBAction)pressedInfoButton:(id)sender     // this is the Cancel on left of Nav Bar
//{
//  NSLog(@"pressedInfoButton");
//  NSLog(@" // go to info screen ");
//
//} // pressedInfoButton
//




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return gbl_arrayDeletableMembersToPickFrom.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelPersonToDeleteCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    

    UIFont *myNewFont =  [UIFont boldSystemFontOfSize: 17.0];

    dispatch_async(dispatch_get_main_queue(), ^(void){

//        cell.tintColor = [UIColor blackColor] ;
//        cell.accessory.tintColor = [UIColor blackColor] ;

        cell.textLabel.text = [gbl_arrayDeletableMembersToPickFrom  objectAtIndex:indexPath.row];

        //        cell.textLabel.font = [UIFont systemFontOfSize: 16.0];
        cell.textLabel.font = myNewFont;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
        // PROBLEM  name slides left off screen when you hit red round delete "-" button
        //          and delete button slides from right into screen
        //
        cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
        cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right
    });

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

    NSInteger myCountOfRows;
    myCountOfRows = 0;


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m
    [myappDelegate get_gbl_numMembersInCurrentGroup ];   // populates gbl_numMembersInCurrentGroup  using  gbl_lastSelectedGroup
    myCountOfRows = gbl_numMembersInCurrentGroup ;

    if (myCountOfRows <= gbl_numRowsToTriggerIndexBar)  return nil ;  // no sectionindex }



    NSArray *mySectionIndexTitles = [NSArray arrayWithObjects:  // 33 items  last index=32
//         @"A", @"B", @"C", @"D",  @"E", @"F", @"G", @"H", @"I", @"J",  @"K", @"L", @"M",
//         @"N", @"O", @"P",  @"Q", @"R", @"S", @"T", @"U", @"V",  @"W", @"X", @"Y", @"Z",   nil ];

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
            nil
    ];


    gbl_numSectionIndexTitles = mySectionIndexTitles.count;

    return mySectionIndexTitles;

} // end of sectionIndexTitlesForTableView



- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{

  NSLog(@"sectionForSectionIndexTitle!  in HOME");
//  NSLog(@"title=[%@]",title);
//  NSLog(@"atIndex=[%ld]",(long)index);



    // find first group starting with title letter (guaranteed to be there, see sectionIndexTitlesForTableView )
    NSInteger newRow;  newRow = 0;
    NSIndexPath *newIndexPath;
    NSInteger myCountOfRows;
    myCountOfRows = 0;

        if ([gbl_ExampleData_show isEqualToString: @"yes"] ) 
        {
           myCountOfRows = gbl_arrayPer.count;
        } else {
           // Here we do not want to show example data.
           // Because example data names start with "~", they sort last,
           // so we can just reduce the number of rows to exclude example data from showing on the screen.
           myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;
        }

    if (     [title isEqualToString:@"TOP"]) newRow = 0;
    else if ([title isEqualToString:@"END"]) newRow = myCountOfRows - 1;
    else                                     newRow = ((double) (index + 1) / (double) gbl_numSectionIndexTitles ) * (double)myCountOfRows ;

    if (newRow == myCountOfRows)  newRow = newRow - 1;

//  NSLog(@"gbl_numSectionIndexTitles =[%ld]",(long)gbl_numSectionIndexTitles );
//  NSLog(@"newRow                    =[%ld]", (long)newRow);
//  NSLog(@"myCountOfRows             =[%ld]", (long)myCountOfRows   );


    newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];
    [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];

    return index;

} // sectionForSectionIndexTitle


// end of SECTION INDEX VIEW
//--------------------------------------------------------------------------------------------




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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

  NSLog(@"in prepareForSegue  in SEL  NEW  MEMbers");

}

@end
  //  end of MAMB09_deleteMembersTableViewController.m

//        NSMutableArray  *member_fields;
//        NSString        *current_group;
//        NSString        *current_member;
//        NSInteger        idx_in_gblarrayMem;
//        idx_in_gblarrayMem = -1;
//        for (id member_record in gbl_arrayMem) 
//        {
//            idx_in_gblarrayMem = idx_in_gblarrayMem + 1;
//            member_fields  = [member_record  componentsSeparatedByString:@"|"];
//            current_group  = member_fields[0];
//            current_member = member_fields[1];
//            if (   [current_group  caseInsensitiveCompare: gbl_lastSelectedGroup ] == NSOrderedSame
//                && [current_member caseInsensitiveCompare: del_me_indexPath.text ] == NSOrderedSame  )
//            {
//            }
//        }
//
