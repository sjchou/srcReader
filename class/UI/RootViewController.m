//
//  RootViewController.m
//  srcReader
//
//  Created by victor chou on 12-3-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize atricleTitle,path;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithPath:(NSString *)_path title:(NSString *)_title1;
{
    self=[super init];
    self.path=_path;
    self.title=_title1;
    return self;
}
- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    [super loadView];


    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    path = [[NSBundle mainBundle] pathForResource:path ofType:@"txt"];
    NSMutableString *content=[[NSMutableString alloc] initWithCapacity:1];
    NSInputStream *stream=[[NSInputStream alloc] initWithFileAtPath:path];
    [stream open];
    // read and dump to NSTextView
    NSInteger maxLength = 128;
    uint8_t readBuffer [maxLength];//typedef unsigned char ：uint8_t;
    BOOL endOfStreamReached = NO;
    // NOTE: this tight loop will block until stream ends
    while (! endOfStreamReached) {
        NSInteger bytesRead = [stream read: readBuffer maxLength:maxLength];
        if (bytesRead == 0) {
            endOfStreamReached = YES;
        } else if (bytesRead == -1) {
            // TODO - should have an error dialog
            endOfStreamReached = YES; 
        } else {
            NSString *buffer=[[NSString alloc] initWithBytesNoCopy:readBuffer length:bytesRead encoding:NSUTF8StringEncoding freeWhenDone:NO];
            [content appendString:(buffer == nil ? @"" : buffer)];
            [buffer release];
        }
    } // while ! endOfStreamReached
    [stream close];
    [stream release];
    
    arrayText=[[NSMutableArray alloc] initWithCapacity:1];
    
    NSMutableArray *arrayStrings=[[content componentsSeparatedByString:@"\n"] mutableCopy];
    for (int i=0; i<[arrayStrings count]; i++) {
        
        if ([[arrayStrings objectAtIndex:i] rangeOfString:@"-->"].length>0) {
            if (i+3<[arrayStrings count]&& [[arrayStrings objectAtIndex:i+3]length]<2) {
                [arrayText addObject:[arrayStrings objectAtIndex:i+2]];
                [arrayText addObject:[arrayStrings objectAtIndex:i+1]];
            }
        }
    }
    
    
    for (int i=0; i<[arrayText count]; i++) {
        NSLog(@"%@",[arrayText objectAtIndex:i]);
    }
    NSLog(@"%d",[arrayText count]);
    [arrayStrings release];
    
    
    
    
    
    tableViewList=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    tableViewList.separatorColor=[UIColor clearColor];
    tableViewList.delegate=self;
    tableViewList.dataSource=self;
    [self.view addSubview:tableViewList];
    [tableViewList release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayText count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lable=[[[UILabel alloc] init] autorelease];
    lable.text=[arrayText objectAtIndex:indexPath.row];
    lable.numberOfLines=0;
    lable.frame=CGRectMake(0, 0, 320, 200);
    [lable sizeToFit];
    return lable.frame.size.height+10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *lableContent;
    static NSString *CellIdentifier = @"CellList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        lableContent=[[[UILabel alloc] init] autorelease];
        lableContent.tag=909;
        [cell.contentView addSubview:lableContent];
    }
    else {
        lableContent=(UILabel *)[cell.contentView viewWithTag:909];
    }
    
    
    lableContent.text=[arrayText objectAtIndex:indexPath.row];
    lableContent.numberOfLines=0;
    lableContent.frame=CGRectMake(0, 0, 320, 200);
    [lableContent sizeToFit];


    if (indexPath.row%2==1) {
        cell.hidden=YES;
    }
    
    
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint midPoint=scrollView.contentOffset;
    for (int i=0; i<230; i+=30) {
        NSIndexPath *indexPath=[tableViewList indexPathForRowAtPoint:CGPointMake(0, midPoint.y+i)];
        if (indexPath.row%2==1) {
            [tableViewList cellForRowAtIndexPath:indexPath].hidden=NO;
        }
            
    }
    for (int i=230; i<460; i+=30) {
        NSIndexPath *indexPath=[tableViewList indexPathForRowAtPoint:CGPointMake(0, midPoint.y+i)];
        if (indexPath.row%2==1) {
            [tableViewList cellForRowAtIndexPath:indexPath].hidden=YES;
        }
        
    }
    
    
}

-(void)dealloc
{
    [super dealloc];
    [arrayText release];
}


@end
