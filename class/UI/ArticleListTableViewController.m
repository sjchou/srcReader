//
//  ArticleListTableViewController.m
//  srcReader
//
//  Created by victor chou on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArticleListTableViewController.h"
#import "RootViewController.h"
@interface ArticleListTableViewController ()

@end

@implementation ArticleListTableViewController

-(void)dealloc
{
    [arrayOfAtricle release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    arrayOfAtricle=[[NSMutableArray alloc] initWithCapacity:1];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"Skins.US.S01E01",@"path", @"skin.S01E01",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"Skins.US.S01E02",@"path", @"skin.S01E02",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"Skins.US.S01E03",@"path", @"skin.S01E03",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"skins.us.s01e04",@"path", @"skin.S01E04",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"skins.us.s01e05",@"path", @"skin.S01E05",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"Skins.US.S01E06",@"path", @"skin.S01E06",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"skins.us.s01e07",@"path", @"skin.S01E07",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"skins.us.s01e08",@"path", @"skin.S01E08",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"Skins.US.S01E09",@"path", @"skin.S01E09",@"title",nil]];
    [arrayOfAtricle addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                               @"skins.us.s01e10",@"path", @"skin.S01E10",@"title",nil]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [arrayOfAtricle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    else {
        
    }
    
    NSDictionary *dic=[arrayOfAtricle objectAtIndex:indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"title"];
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[arrayOfAtricle objectAtIndex:indexPath.row];
    RootViewController *root=[[RootViewController alloc] initWithPath:[dic objectForKey:@"path"] title:[dic objectForKey:@"title"]];
    [self.navigationController pushViewController:root animated:YES];
    [root release];
}

@end
