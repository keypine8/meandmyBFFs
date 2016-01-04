//
//  MAMB09_selNewMembersTableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2016-01-04.
//  Copyright © 2016 Richard Koskela. All rights reserved.
//

#import "MAMB09_selNewMembersTableViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

@interface MAMB09_selNewMembersTableViewController ()

@end

@implementation MAMB09_selNewMembersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
tn();
    NSLog(@"in SELECT New MEMBEFRS   viewDidLoad!");

//    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    [self.tableView setBackgroundColor: gbl_colorEditingBG ];


    // get array to populate tableview with

    [gbl_arrayNewMembersToPickFrom removeAllObjects];
    gbl_arrayNewMembersToPickFrom = [[NSMutableArray alloc] init];

    // make array of group member names to check against
    //
    NSMutableArray *grpmemNameArray;
    grpmemNameArray = [[NSMutableArray alloc]init];

  NSLog(@"gbl_lastSelectedGroup =[%@]",gbl_lastSelectedGroup );
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
//  NSLog(@"currGroup  =[%@]",currGroup  );
//  NSLog(@"currMember =[%@]",currMember );

        if ([currGroup isEqualToString: gbl_lastSelectedGroup ] )
        {
            [grpmemNameArray addObject: currMember ];                        //  Person name for pick
//  NSLog(@"grpmemNameArray =[%@]",grpmemNameArray );
        }
    } // for each groupmember
//  NSLog(@"grpmemNameArray =[%@]",grpmemNameArray );


    // INCLUDE ONLY  non members of gbl_lastSelectedGroup
    //
    for (id myNewMemberRec in gbl_arrayPer) {

// skip example record  TODO in production
//            if (gbl_show_example_data ==  NO  &&
//                [mymyMemberRecPSV hasPrefix: @"~"]) {  // skip example record
//                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
//            }
//

        NSArray *psvArray;
        NSString *currMember;
        
        psvArray = [myNewMemberRec componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
        currMember = psvArray[0];


        if ( [grpmemNameArray containsObject: currMember] ) continue;
       
        [gbl_arrayNewMembersToPickFrom addObject: currMember ];                        //  Person name for pick
    } // for each groupmember

 NSLog(@"gbl_arrayNewMembersToPickFrom=%@",gbl_arrayNewMembersToPickFrom);
 NSLog(@"gbl_arrayNewMembersToPickFrom.count=%lu",(unsigned long)gbl_arrayNewMembersToPickFrom.count);

} //   viewDidLoad 


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
    return gbl_arrayNewMembersToPickFrom.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelPersonCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    

    UIFont *myNewFont =  [UIFont boldSystemFontOfSize: 17.0];

    cell.textLabel.text = [gbl_arrayNewMembersToPickFrom   objectAtIndex:indexPath.row];
    //        cell.textLabel.font = [UIFont systemFontOfSize: 16.0];
    cell.textLabel.font = myNewFont;
    
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
