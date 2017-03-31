//
//  MAMB09_selPersonViewController.m
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
// selects a person or group

#import "MAMB09_selPersonViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals


@implementation MAMB09_selPersonViewController

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
    fopen_fpdb_for_debug();
    NSLog(@"in Select Person   viewDidLoad!");
    
    [super viewDidLoad];

   
    NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    //
    // Note:   MAMB09_selPersonViewController is only ever entered   only ever called   from the home screen, person Entity
    //      1. to select a Person for this report:
    //             @"hompco|Compatibility Paired with ...",
    //      2. to select a Group for this report:
    //             @"hompbm|My Best Match in Group ...",
    //     


    // set the Nav Bar Title  according to where we came from
    //
    do {
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];



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
        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) {   // came from "Compatibility Paired With ..."
            myNavBar2lineTitle = [NSString stringWithFormat:  @"%@\nSelect Second Person", gbl_lastSelectedPerson ];
        }
//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"])    // came from "My Best Match in Group ..."
        else {
//            myNavBar2lineTitle = [NSString stringWithFormat: @"%@\nSelect Group",  gbl_lastSelectedPerson ];
            myNavBar2lineTitle = [NSString stringWithFormat: @"%@\nSelect Group for Best Match",  gbl_lastSelectedPerson ];
//            myNavBar2lineTitle = [NSString stringWithFormat: @"%@\nFind Best Match in Group ...",  gbl_lastSelectedPerson ];
//            myNavBar2lineTitle = [NSString stringWithFormat: @"%@\nSelect Best Match Group",  gbl_lastSelectedPerson ];

        }

        myNavBarLabel.numberOfLines = 2;
    //        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 16.0];
        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 14.0];
        myNavBarLabel.textColor     = [UIColor blackColor];
        myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
        myNavBarLabel.text          = myNavBar2lineTitle;
        myNavBarLabel.adjustsFontSizeToFitWidth = YES;
        [myNavBarLabel sizeToFit];


        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) {   // came from "Compatibility Paired With ..."

//            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== 
//                [[self navigationItem] setTitle: @"Second Person"];
//            });


            // TWO-LINE NAV BAR TITLE
            //
            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
                self.navigationItem.titleView           = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
        //      self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
                self.navigationItem.rightBarButtonItem =  mySpacerForTitle;
            });


        }
//        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"])    // came from "My Best Match in Group ..."
        else {

            dispatch_async(dispatch_get_main_queue(), ^{                                // <=== 

//                [[self navigationItem] setTitle: myTitleGrponeSelGroup ];  // has to go first (stutter)
                self.navigationItem.titleView           = myNavBarLabel; // mySel2ndPer_Label.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL

                self.navigationItem.rightBarButtonItem =  mySpacerNavItem;
//                self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: myFlexibleSpace ];
//                self.navigationItem.leftBarButtonItems  = [self.navigationItem.leftBarButtonItems arrayByAddingObject: myFlexibleSpace ];
//                self.navigationItem.rightBarButtonItem =  mySpacerForTitle;
                [self.navigationController.navigationBar setTranslucent:NO];

//              self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
//        self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerNavItem];

            });
        }
    } while (FALSE);


 
    NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
    NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
    NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
    
    // ---------------------------------------------------------------------------------------- 
    // ---------------------------------------------------------------------------------------- 
    // populate arrayPersonsToPickFrom
    //
    // if we came here from hompco, the domain is all persons except current person
    // if we came here from hompbm,  the domain is all persons in the group
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"])
    {   
        
        [_PSVs_for_person_picklist removeAllObjects];
        _PSVs_for_person_picklist   = [[NSMutableArray alloc] init];
        
        [gbl_arrayPersonsToPickFrom removeAllObjects];
        gbl_arrayPersonsToPickFrom = [[NSMutableArray alloc] init];

        for (id myPerPSV in gbl_arrayPer) {

            // skip example record  in production  IF  gbl_show_example_data ==  NO  
            if (   [gbl_ExampleData_show isEqualToString: @"no"] 
                && [myPerPSV hasPrefix: @"~"]                      )
            {  // skip example record
                continue;     
            }


            NSArray *psvArray;
            NSString *person1, *person2;
            
            psvArray = [myPerPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
            person1  = psvArray[0];

            psvArray = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @"|"] ];
            person2  = psvArray[0];
            if ([person1 isEqualToString: person2]) {            // do not show person himself
                continue;
            }
            if (   [person1 hasPrefix: @"~"]
                && [gbl_ExampleData_show isEqualToString: @"no"] ) 
            {            // do not show example data if turned off
                continue;
            }

            [gbl_arrayPersonsToPickFrom addObject: person1 ];                        //  Person name for pick
            [_PSVs_for_person_picklist addObject: myPerPSV ]; //  Person PSV  for ViewHTML
            
            // NSLog(@"gbl_arrayPersonsToPickFrom=%@",gbl_arrayPersonsToPickFrom);
        }
        //NSLog(@"gbl_arrayPersonsToPickFrom.count=%lu",(unsigned long)gbl_arrayPersonsToPickFrom.count);
        //NSLog(@"_PSVs_for_person_picklist=%@",_PSVs_for_person_picklist);
    }
    else
    {    //    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]) 
        [_PSVs_for_group_picklist removeAllObjects];
        _PSVs_for_group_picklist   = [[NSMutableArray alloc] init];
        
        [gbl_arrayGroupsToPickFrom removeAllObjects];
        gbl_arrayGroupsToPickFrom = [[NSMutableArray alloc] init];

        for (id myGrpPSV in gbl_arrayGrp) {

            // skip example record  in production  IF  gbl_show_example_data ==  NO  
            if (   [gbl_ExampleData_show isEqualToString: @"no"] 
                && [myGrpPSV hasPrefix: @"~"]                      )
            {  // skip example record
                continue;     
            }


            NSArray *psvArray;
            psvArray = [myGrpPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
            NSString *myGroup = psvArray[0];

            if (   [myGroup hasPrefix: @"~"]
                && [gbl_ExampleData_show isEqualToString: @"no"] )
            {            // do not show example data if turned off
                continue;
            }

            [gbl_arrayGroupsToPickFrom addObject: myGroup ]; //  Group name for pick
            [_PSVs_for_group_picklist addObject: myGrpPSV ]; //  Group PSV  for ViewHTML
            
//             NSLog(@"gbl_arrayGroupsToPickFrom=%@",gbl_arrayGroupsToPickFrom);
        }
        NSLog(@"gbl_arrayGroupsToPickFrom.count=%lu",(unsigned long)gbl_arrayGroupsToPickFrom.count);
        NSLog(@"_PSVs_for_group_picklist=%@",_PSVs_for_group_picklist);
    }
    // ---------------------------------------------------------------------------------------- 



  NSLog(@" // set up sectionindex  or not");
    [self sectionIndexTitlesForTableView: self.tableView ];  // set up sectionindex  or not


} /* viewDidLoad */


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
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) {   
        return 1;
    }
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]) {   
    else {
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//tn();
//  NSLog(@" in numberOfRowsInSection!  in selperson/group");
//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );
//  NSLog(@"gbl_currentMenuPrefixFromHome=%@",gbl_currentMenuPrefixFromHome);
//  NSLog(@"gbl_currentMenuPrefixFromMatchRpt=%@",gbl_currentMenuPrefixFromMatchRpt);
//
//  NSLog(@"gbl_lastSelPersonWasA =%@",gbl_lastSelPersonWasA );
//tn();

//
////        || [gbl_lastSelPersonWasA         isEqualToString: @"person"]
////    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]
//    if ([gbl_currentMenuPlusReportCode hasSuffix: @"co"]) {  //   @"Compatibility Potential"
//
////kin(gbl_arrayPersonsToPickFrom.count);
//        return gbl_arrayPersonsToPickFrom.count;
//    }
//
////        || [gbl_lastSelPersonWasA         isEqualToString: @"group" ]
////    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]
//    if ([gbl_currentMenuPlusReportCode hasSuffix: @"bm"]) {  //   grpall or grpone (hompbm,pbm2bm, homgbm,gbm1bm,gbm2bm)
//
////kin(gbl_arrayGroupsToPickFrom.count);
//        return gbl_arrayGroupsToPickFrom.count;
//    }
////trn("oioioioi");
//


    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) return gbl_arrayPersonsToPickFrom.count;
    else                                                               return gbl_arrayGroupsToPickFrom.count;

    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"in sel Person  cellForRow!");
//  NSLog(@"indexPath.row=%ld",(long)indexPath.row);
//  NSLog(@"gbl_currentMenuPlusReportCode =%@",gbl_currentMenuPlusReportCode );

    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelPersonCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //   cell.selectedBackgroundView =  gbl_myCellBgView ;  // get my own background color for selected rows (see MAMB09AppDelegate.m)

    //NSLog(@"cwll=%@",cell);

    // Configure the cell...


        // UILabel for the disclosure indicator, ">",  for tappable cells
        //
            NSAttributedString *myNewCellAttributedText3 = [
                [NSAttributedString alloc] initWithString: @">"  
                                               attributes: @{
                        NSFontAttributeName :  [UIFont fontWithName: @"MarkerFelt-Thin" size:  24.0] ,  
//                        NSForegroundColorAttributeName: gbl_colorDIfor_home   
                        NSForegroundColorAttributeName: [UIColor grayColor]   
                    }
            ];
            UILabel *myDisclosureIndicatorLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 12.0f, 32.0f)];
            myDisclosureIndicatorLabel.attributedText  = myNewCellAttributedText3;
//            myDisclosureIndicatorLabel.backgroundColor = gbl_colorReportsBG; 
            myDisclosureIndicatorLabel.backgroundColor = gbl_colorHomeBG; 
        //
        // end of  UILabel for the disclosure indicator, ">",  for tappable cells


    
    UIFont *myNewFont =  [UIFont boldSystemFontOfSize: 17.0];

    dispatch_async(dispatch_get_main_queue(), ^(void){

        // PROBLEM  name slides left off screen when you hit red round delete "-" button
        //          and delete button slides from right into screen
        //
        cell.indentationWidth = 12.0; // these 2 keep the name on screen when hit red round delete and delete button slides from right
        cell.indentationLevel =  3;   // these 2 keep the name on screen when hit red round delete and delete button slides from right

        if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) {
            cell.textLabel.text = [gbl_arrayPersonsToPickFrom   objectAtIndex:indexPath.row];
            //        cell.textLabel.font = [UIFont systemFontOfSize: 16.0];
            cell.textLabel.font = myNewFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;

            cell.accessoryView  = myDisclosureIndicatorLabel;
            cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        }
        //    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]) {   
        else {
            cell.textLabel.text = [gbl_arrayGroupsToPickFrom   objectAtIndex:indexPath.row];
            // cell.textLabel.font = [UIFont systemFontOfSize: 16.0];
            cell.textLabel.font = myNewFont;
            cell.textLabel.adjustsFontSizeToFitWidth = YES;

            cell.accessoryView  = myDisclosureIndicatorLabel;
            cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        }
    });

    return cell;
} // cellForRowAtIndexPath


// color cell bg
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];
//    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    [self.tableView setBackgroundColor: gbl_colorHomeBG];

    cell.backgroundColor = [UIColor clearColor];
}

// how to set the tableview cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  // -------------------------
{
//  NSLog(@"in heightForRowAtIndexPath 1");

  return 44.0; // matches report height

}



//  from home code
// these 5 methods  handle light grey highlight correctly
// when returning from report viewer
//
// viewDidAppear
// willDeselectRowAtIndexPath
// viewWillAppear (?)
// willSelectRowAtIndexPath
// didSelectRowAtIndexPath
//

-(void) viewWillAppear:(BOOL)animated {
    //NSLog(@"in viewWillAppear!");



  NSLog(@"selPerson   in viewwill");
    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        if ([gbl_lastSelectionType isEqualToString:@"group"]) {
            self.tableView.separatorColor    = gbl_colorSepara_grp;
        } else if ([gbl_lastSelectionType isEqualToString:@"person"]){
            self.tableView.separatorColor    = gbl_colorSepara_per;
        }
    });


    [self.tableView reloadData];  // moved reloaddata from viewdidappear (flashing highlight on selected row)


// had to move this block to viewDidAppear (maybe because viewDidAppear   has new reloaddata)
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//    NSIndexPath *highlightIdxPath;
//    NSString *rememberedLastPerson;
//    NSString *rememberedLastGroup;
//
//    
//    // get the indexpath of current row
//    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//
//    if(myIdxPath) {
//        [self.tableView selectRowAtIndexPath:myIdxPath animated:YES scrollPosition:UITableViewScrollPositionNone]; // puts highlight on this row (?)
//    }
//
//
//    // if there is a remembered selection, highlight its row
//    //
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) {   
//        rememberedLastPerson = [myappDelegate grabLastSelectionValueForEntity: (NSString *) @"person"
//                                                                   havingName: (NSString *) gbl_fromHomeCurrentEntityName 
//                                                         fromRememberCategory: (NSString *) @"person"  ];
//
//        NSLog(@"rememberedLastPerson =%@",rememberedLastPerson );
//        if (rememberedLastPerson  &&  rememberedLastPerson.length != 0 ) {
//nbn(100);
//            // go thru tableview rows to get indexPath for rememberedLastPerson 
//            //
//            highlightIdxPath = [myappDelegate  indexpathForTableView: (UITableView *) self.tableView
//                                                      havingCellText: (NSString *)    rememberedLastPerson ];
//            if (highlightIdxPath) {
//nbn(101);
//tn();trn("hightlight ON");
//                [self.tableView selectRowAtIndexPath: highlightIdxPath
//                                            animated: YES
//                                      scrollPosition: UITableViewScrollPositionNone ]; // puts highlight on this row (?)
//            }
//        }
//    }
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]) {   
//
//        rememberedLastGroup = [myappDelegate grabLastSelectionValueForEntity: (NSString *) @"person"
//                                                                   havingName: (NSString *) gbl_fromHomeCurrentEntityName 
//                                                         fromRememberCategory: (NSString *) @"group"  ];
//
//        NSLog(@"rememberedLastGroup =%@",rememberedLastGroup );
//        if (rememberedLastGroup  &&  rememberedLastGroup.length != 0 ) {
//nbn(110);
//            // go thru tableview rows to get indexPath for rememberedLastGroup 
//            //
//            highlightIdxPath = [myappDelegate  indexpathForTableView: (UITableView *) self.tableView
//                                                      havingCellText: (NSString *)    rememberedLastGroup ];
//            if (highlightIdxPath) {
//nbn(111);
//tn();trn("hightlight ON");
//                [self.tableView selectRowAtIndexPath: highlightIdxPath
//                                            animated: YES
//                                      scrollPosition: UITableViewScrollPositionNone ]; // puts highlight on this row (?)
//            }
//        }
//    }
//
// had to move this block to viewDidAppear (maybe because viewDidAppear   has new reloaddata)

} // viewWillAppear


// 
// A good way to update a table view when starting up or returning from another view
// is to add code like this to viewDidAppear:
//- (void)viewDidAppear:(BOOL)animated {
// NSLog(@"rootViewController: viewDidAppear");
// [super viewDidAppear:animated];
// [self.view reloadData]; // self.view is the table view if self is its controller
//}
//

- (void)viewDidAppear:(BOOL)animated
{
//  NSLog(@" in viewDidAppear!  in selperson/group");
    // [super viewDidAppear];

    [super viewDidAppear:animated];
    // [self.view reloadData]; // self.view is the table view if self is its controller

    gbl_disclosureSetAlready = NO;

// comment out like in  sel rpt
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


   //  here we are ignoring interaction events from the previous segue 


    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
    NSIndexPath *highlightIdxPath;
    NSString *rememberedLastPerson;
    NSString *rememberedLastGroup;

    
    // get the indexpath of current row
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
//tn();tr("indexPathForSelectedRow.row viewdidappear in SelPerson");   NSLog(@"myIdxPath.row=%ld",myIdxPath.row);

    if(myIdxPath) {
        [self.tableView selectRowAtIndexPath: myIdxPath
                                    animated: YES
                              scrollPosition: UITableViewScrollPositionNone ]; // puts highlight on this row (?)
    } else {
//tn();tr("gbl_IdxPathSaved_SelPerson.row viewdidappear in SelPerson"); NSLog(@"gbl_IdxPathSaved_SelPerson.row=%ld",gbl_IdxPathSaved_SelPerson.row);
        if(gbl_IdxPathSaved_SelPerson) {
           [self.tableView selectRowAtIndexPath: gbl_IdxPathSaved_SelPerson
                                       animated: YES
                                 scrollPosition: UITableViewScrollPositionNone ]; // puts highlight on this row (?)
           gbl_IdxPathSaved_SelPerson = nil;
        }
    }


    // if there is a remembered selection, highlight its row
    //
    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) {   
        rememberedLastPerson = [myappDelegate grabLastSelectionValueForEntity: (NSString *) @"person"
                                                                   havingName: (NSString *) gbl_fromHomeCurrentEntityName 
                                                         fromRememberCategory: (NSString *) @"person"  ];

        NSLog(@"rememberedLastPerson =%@",rememberedLastPerson );
        if (rememberedLastPerson  &&  rememberedLastPerson.length != 0 ) {
//nbn(100);
            // go thru tableview rows to get indexPath for rememberedLastPerson 
            //
            highlightIdxPath = [myappDelegate  indexpathForTableView: (UITableView *) self.tableView
                                                      havingCellText: (NSString *)    rememberedLastPerson ];
            if (highlightIdxPath) {
//nbn(101);
//tn();trn("hightlight ON");
                [self.tableView selectRowAtIndexPath: highlightIdxPath
                                            animated: YES
                                      scrollPosition: UITableViewScrollPositionNone ]; // puts highlight on this row (?)
            }
        }
    }
//    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"])    
    else  {
        rememberedLastGroup = [myappDelegate grabLastSelectionValueForEntity: (NSString *) @"person"
                                                                   havingName: (NSString *) gbl_fromHomeCurrentEntityName 
                                                         fromRememberCategory: (NSString *) @"group"  ];

        NSLog(@"rememberedLastGroup =%@",rememberedLastGroup );
        if (rememberedLastGroup  &&  rememberedLastGroup.length != 0 ) {
//nbn(110);
            // go thru tableview rows to get indexPath for rememberedLastGroup 
            //
            highlightIdxPath = [myappDelegate  indexpathForTableView: (UITableView *) self.tableView
                                                      havingCellText: (NSString *)    rememberedLastGroup ];
            if (highlightIdxPath) {
//nbn(111);
//tn();trn("hightlight ON");
                [self.tableView selectRowAtIndexPath: highlightIdxPath
                                            animated: YES
                                      scrollPosition: UITableViewScrollPositionNone ]; // puts highlight on this row (?)
            }
        }
    }

    [myappDelegate mamb_endIgnoringInteractionEvents_after: 0.0 ];    // after arg seconds

} //  viewDidAppear



// - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"in willDeselectRowAtIndexPath!");
    
    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.
    
    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);
    
    //    if ([_mambCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [gbl_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
    //    if ([_mambCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [gbl_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);
    //
    
    // here deselect "previously" selected row
    // and remove yellow highlight
//tn();trn("hightlight OFF");
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
    
//     NSLog(@"willSelectRowAtIndexPath! selPer");
    
    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // here deselect "previously" selected row
    // and remove yellow highlight
//tn();trn("hightlight OFF");
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
                                  animated: NO];
//     NSLog(@"END OF willSelectRowAtIndexPath! selPer");
    return(indexPath);
} // willSelectRowAtIndexPath



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
tn();    NSLog(@"in didSelectRowAtIndexPath!  in SelectPerson !!!!!!!!!!!!");
    
  NSLog(@"gbl_currentMenuPlusReportCode=%@", gbl_currentMenuPlusReportCode);
    // this is the "currently" selected row now
    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    gbl_IdxPathSaved_SelPerson = currentlyselectedIndexPath ;  // for highlight previous choice when come back to SelPerson
  NSLog(@"SAVED HERE  gbl_IdxPathSaved_SelPerson.row=%ld",(long)gbl_IdxPathSaved_SelPerson.row);


    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
//tn();trn("hightlight ON");
    [self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: currentlyselectedIndexPath.row
                                                      animated: NO];
    // animated:YES
    
    // GOTO  the Correct View for Input Params
    // or, directly to ViewHTML to see the Selected Report
    //
    
    // Because background threads are not prioritized and will wait a very long time
    // before you see results, unlike the mainthread, which is high priority for the system.
    //
    // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
    //
    
    UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
    // now you can use cell.textLabel.text


    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"]) {   
        // gbl_lastSelectedPerson = currcell.textLabel.text;
        gbl_lastSelectedSecondPerson = currcell.textLabel.text;  // not used (20150405)
//        gbl_lastSelPersonWasA        = @"person";

        // save selection
        //
        gbl_fromSelSecondPersonPSV = _PSVs_for_person_picklist[currentlyselectedIndexPath.row];
        //correct   NSLog(@"gbl_fromSelSecondPersonPSV =%@",gbl_fromSelSecondPersonPSV );

        // grab selected name to save
        NSArray *psvArray = [gbl_fromSelSecondPersonPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        NSString *selectedPersonName  = psvArray[0];

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m


        [myappDelegate mamb_beginIgnoringInteractionEvents ];


        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"person"
                                       usingValue: (NSString *) selectedPersonName
        ];

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//            [self performSegueWithIdentifier:@"seguePerSelToViewHTML" sender:self];
            [self performSegueWithIdentifier:@"segueGrpSelToViewTBLRPT1" sender:self];
        });
    }

    //    if (   [gbl_currentMenuPlusReportCode isEqualToString: @"hompbm"]
    //        || [gbl_currentMenuPlusReportCode isEqualToString: @"pbm2bm"]
    //    )    
    else {

        gbl_lastSelectedGroup = currcell.textLabel.text;
  NSLog(@"gbl_lastSelectedGroup                 =[%@]",gbl_lastSelectedGroup );
  NSLog(@"gbl_nameOfGrpHavingAllPeopleIhaveAdded=[%@]",gbl_nameOfGrpHavingAllPeopleIhaveAdded);


        // search in  gbl_arrayMem  for   currcell.textLabel.text
        // count how many members
        // if not at least 2 members,  alert and return
        //
  NSLog(@"currcell.textLabel.text =[%@]",currcell.textLabel.text );

        NSInteger member_cnt;
        NSString *prefixStr = [NSString stringWithFormat: @"%@|", currcell.textLabel.text ];

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
                currcell.textLabel.text, (long)member_cnt
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

            // cannot save because of missing information > stay in this screen
            //
            [self presentViewController: myAlert  animated: YES  completion: nil   ]; // cannot save because of missing information

            return;  // cannot save because of missing information > stay in this screen


        }
   

        // save selection
        //
        gbl_fromSelGroupPSV   = _PSVs_for_group_picklist[currentlyselectedIndexPath.row];
        gbl_lastSelectedGroup = [gbl_fromSelGroupPSV componentsSeparatedByString:@"|"][0]; // get field #1 (name) (zero-based)

        // grab selected name to save
        NSArray *psvArray = [gbl_fromSelGroupPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        NSString *selectedGroupName  = psvArray[0];

        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m

        [myappDelegate mamb_beginIgnoringInteractionEvents ];

        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"group"
                                       usingValue: (NSString *) selectedGroupName
        ];

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
            [self performSegueWithIdentifier:@"segueGrpSelToViewTBLRPT1" sender:self];
        });

    }

//     NSLog(@"END OF  in didSelectRowAtIndexPath!  in SelectPerson ");

    
} // didSelectRowAtIndexPath


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


    //    if ([gbl_ExampleData_show isEqualToString: @"yes"])
    //    {
    //       myCountOfRows = gbl_arrayPer.count;
    //    } else {
    //       // Here we do not want to show example data.
    //       // Because example data names start with "~", they sort last,
    //       // so we can just reduce the number of rows to exclude example data from showing on the screen.
    //       myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;
    //    }

    // myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;  //  never show ~ example data to pick as members

    // myCountOfRows =  [gbl_arrayNewMembersToPickFrom count ];         //  Person name for picking as members

    // gbl_arrayNewMembersToPickFrom  is not created yet so 
    // do calculation
    //
    //   MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for gbl methods in appDelegate.m



    if ([gbl_currentMenuPlusReportCode isEqualToString: @"hompco"])
    {   
        myCountOfRows = gbl_arrayPersonsToPickFrom.count;
    } else {
        myCountOfRows = gbl_arrayGroupsToPickFrom.count;
    }   



//tn();
//  NSLog(@"gbl_arrayPer.count           =[%ld]",(long) gbl_arrayPer.count );
//  NSLog(@"gbl_ExampleData_count_per    =[%ld]",(long) gbl_ExampleData_count_per );
//  NSLog(@"gbl_numMembersInCurrentGroup =[%ld]",(long) gbl_numMembersInCurrentGroup );
//  NSLog(@"myCountOfRows                =[%ld]",(long) myCountOfRows          );

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
  NSLog(@"title=[%@]",title);
  NSLog(@"atIndex=[%ld]",(long)index);



    // find first group starting with title letter (guaranteed to be there, see sectionIndexTitlesForTableView )
    NSInteger newRow;  newRow = 0;
    NSIndexPath *newIndexPath;
    NSInteger myCountOfRows;
    myCountOfRows = 0;

    //        if ([gbl_ExampleData_show isEqualToString: @"yes"] ) 
    //        {
    //           myCountOfRows = gbl_arrayPer.count;
    //        } else {
    //           // Here we do not want to show example data.
    //           // Because example data names start with "~", they sort last,
    //           // so we can just reduce the number of rows to exclude example data from showing on the screen.
    //           myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;
    //        }
    //

    // myCountOfRows = gbl_arrayPer.count - gbl_ExampleData_count_per ;  //  never show ~ example data to pick as members
    myCountOfRows =  [gbl_arrayPersonsToPickFrom count ];         //  Person name for picking as members

    if (     [title isEqualToString:@"TOP"]) newRow = 0;
    else if ([title isEqualToString:@"END"]) newRow = myCountOfRows - 1;
    else                                     newRow = ((double) (index + 1) / (double) gbl_numSectionIndexTitles ) * (double)myCountOfRows ;

    if (newRow == myCountOfRows)  newRow = newRow - 1;

  NSLog(@"gbl_numSectionIndexTitles =[%ld]",(long)gbl_numSectionIndexTitles );
  NSLog(@"newRow                    =[%ld]", (long)newRow);
  NSLog(@"myCountOfRows             =[%ld]", (long)myCountOfRows   );


    newIndexPath = [NSIndexPath indexPathForRow: newRow inSection: 0];
    [tableView scrollToRowAtIndexPath: newIndexPath atScrollPosition: UITableViewScrollPositionMiddle animated: NO];

    return index;

} // sectionForSectionIndexTitle


// end of SECTION INDEX VIEW
//--------------------------------------------------------------------------------------------


@end

