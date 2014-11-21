//
//  MAMB09_viewHTMLViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2014-11-19.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import "MAMB09_viewHTMLViewController.h"

@interface MAMB09_viewHTMLViewController ()

@end

@implementation MAMB09_viewHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"in viewHTML viewDidLoad!");

    NSLog(@"fromHomeCurrentSelection=%@",self.fromHomeCurrentSelection);            // CSV  for per or grp or pair of people
    NSLog(@"fromHomeCurrentSelectionType=%@",self.fromHomeCurrentSelectionType);    // like "group" or "person" or "pair"
    NSLog(@"fromHomeCurrentEntity=%@",self.fromHomeCurrentEntity);                  // like "group" or "person"
    
    NSLog(@"fromSelRptRowNumber=%ld",self.fromSelRptRowNumber);
    NSLog(@"fromSelRptRowString=%@",self.fromSelRptRowString);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // segueRptSelToViewHTML
}


@end
