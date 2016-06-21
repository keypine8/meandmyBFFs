//
//  MAMB09_confirmImportTableViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2016-05-24.
//  Copyright © 2016 Richard Koskela. All rights reserved.
//

#import "MAMB09_confirmImportTableViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals


// show the contents of import file  when import is ready,  (has been checked for corruption)
    //
    //         new screen (tableview)  blue choose export color

    //         - title      Names in this Import
    //   
    //           for groups   (3 lines below  are repeated as necessary)
    //         - GROUP swim team
    //           fred
    //           ethyl
    //           ...
    //           blank line
    //         - GROUP family
    //           Mary
    //           eva
    //         
    //           for people   
    //         - John Smith
    //           Mary
    //    
    //         - bottom action sheet 
    //            --------------
    //            Do this Import
    //            --------------
    //            Cancel Import
    //            --------------

    //     
    // if user confirms he want to do import,
    //     then do collision checking and name changes
    //         user can cancel out during any collision dialogue
    //     if there are no collisions
    //     OR all collisions were handled by user without her cancelling out
    //     then add all the groups and people
    //  when import done, confirm dialogue ?  with only OK button ???
    //     




    // UIAlertController EXAMPLE    WITH  NO  TEXTFIELD
    // 
    // // UIAlertController
    // // - (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField*textField))configurationHandler
    // // You can add a text field only if the preferredStyle property is set to UIAlertControllerStyleAlert. 
    // 
    // 
    // //  http://useyourloaf.com/blog/uialertcontroller-changes-in-ios-8/
    // 
    // UIAlertController *alertController = [UIAlertController
    //                               alertControllerWithTitle:alertTitle
    //                               message:alertMessage
    //                               preferredStyle:UIAlertControllerStyleAlert];
    // 
    // UIAlertAction *cancelAction = [UIAlertAction 
    //             actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
    //                       style:UIAlertActionStyleCancel
    //                     handler:^(UIAlertAction *action)
    //                     {
    //                       NSLog(@"Cancel action");
    //                     }];
    // 
    // UIAlertAction *okAction = [UIAlertAction 
    //             actionWithTitle:NSLocalizedString(@"OK", @"OK action")
    //                       style:UIAlertActionStyleDefault
    //                     handler:^(UIAlertAction *action)
    //                     {
    //                       NSLog(@"OK action");
    //                     }];
    // 
    // [alertController addAction:cancelAction];
    // [alertController addAction:okAction];
    // 
    // [self presentViewController:alertController animated:YES completion:nil];
    // 
    // 

    // UIAlertController EXAMPLE   WITH  TEXTFIELD
    // 
    // UIAlertController *alertController = [UIAlertController
    //                     alertControllerWithTitle:alertTitle
    //                                      message:alertMessage
    //                               preferredStyle:UIAlertControllerStyleAlert];
    // 
    // [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
    //  {
    //    textField.placeholder = NSLocalizedString(@"LoginPlaceholder", @"Login");
    //  }];
    // 
    // [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
    //  {
    //    textField.placeholder = NSLocalizedString(@"PasswordPlaceholder", @"Password");
    //    textField.secureTextEntry = YES;
    //  }];
    // 
    // // The values of the text field can be retrieved in the OK action handler:
    // 
    // UIAlertAction *okAction = [UIAlertAction
    //   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
    //   style:UIAlertActionStyleDefault
    //   handler:^(UIAlertAction *action)
    //   {
    //     UITextField *login = alertController.textFields.firstObject;
    //     UITextField *password = alertController.textFields.lastObject;
    //     ...
    //   }];
    // 
    // 
    // [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
    //  {
    //      textField.placeholder = NSLocalizedString(@"LoginPlaceholder", @"Login");
    //      [textField addTarget:self
    //                    action:@selector(alertTextFieldDidChange:)
    //          forControlEvents:UIControlEventEditingChanged];
    //  }];
    // 

    // 
    // // Dismissing Alert Controllers
    // //
    // // Typically the alert controller is dismissed automatically when the user selects an action.
    // // It can also be dismissed programmatically, if required, like any other view controller.
    // // One common reason can be to remove the alert or action sheet when the app moves to the background.
    // // Assuming we are listening for the UIApplicationDidEnterBackgroundNotification notification
    // // we can dismiss any presented view controller in the observer
    // // (see the example code for the setup of the observer in viewDidLoad):
    // //
    // - (void)didEnterBackground:(NSNotification *)notification
    // {
    //   [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    // }
    // 



@interface MAMB09_confirmImportTableViewController ()

@end


@implementation MAMB09_confirmImportTableViewController


// no selection at all,  just show members
- (BOOL)tableView:(UITableView *)tableView  shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;  // no selection at all,  just show members
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
tn();
    NSLog(@"in CONFIRM IMPORT   viewDidLoad!");

//    [self.tableView setBackgroundColor: gbl_colorSelShareEntityBG ];
    [self.tableView setBackgroundColor: [UIColor redColor] ];


    // set the Nav Bar Title  according to where we came from
    //
    do {
        // UIBarButtonItem *myFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
        //                                                                               target: self
        //                                                                               action: nil];

        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
//        UIButton *myInvisibleButton       = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        myInvisibleButton.backgroundColor = [UIColor clearColor];
//        UIBarButtonItem *mySpacerNavItem  = [[UIBarButtonItem alloc] initWithCustomView: myInvisibleButton];

        // setup for TWO-LINE NAV BAR TITLE

        //    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 44)];  // 3rd arg is horizontal length
//        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 44)];  // 3rd arg is horizontal length
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 44)];  // 3rd arg is horizontal length
        UIBarButtonItem *mySpacerForTitle = [[UIBarButtonItem alloc] initWithCustomView:spaceView];

        UILabel *myNavBarLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 480.0, 44.0)];

        NSString *myNavBar2lineTitle;
//        myNavBar2lineTitle = [NSString stringWithFormat:  @"Current Members of\n Group  %@", gbl_lastSelectedGroup ];
        myNavBar2lineTitle =  @"Names in this Import";


        myNavBarLabel.numberOfLines = 1;
    //        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 16.0];
        myNavBarLabel.font          = [UIFont boldSystemFontOfSize: 14.0];
        myNavBarLabel.textColor     = [UIColor blackColor];
        myNavBarLabel.textAlignment = NSTextAlignmentCenter; 
        myNavBarLabel.text          = myNavBar2lineTitle;
        myNavBarLabel.adjustsFontSizeToFitWidth = YES;
        [myNavBarLabel sizeToFit];


        // TWO-LINE NAV BAR TITLE
        //
        dispatch_async(dispatch_get_main_queue(), ^{   
            self.navigationItem.titleView           = myNavBarLabel; // myNavBarLabel.layer.borderWidth = 2.0f;  // TEST VISIBLE LABEL
    //      self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject: mySpacerForTitle];
            self.navigationItem.rightBarButtonItem =  mySpacerForTitle;
        });

    } while (FALSE);



    NSLog(@"end of  CONFIRM IMPORT   viewDidLoad!");
}  // end of ViewDidLoad   confirmImport



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
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
