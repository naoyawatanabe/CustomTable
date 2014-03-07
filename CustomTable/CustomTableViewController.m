//
//  CustomTableViewController.m
//  CustomTable
//
//  Created by nao on 2014/02/28.
//  Copyright (c) 2014年 showandtell. All rights reserved.
//

#import "CustomTableViewController.h"
#import "CustomTableCell.h"

@interface CustomTableViewController ()
{
    NSMutableArray *recipeNames;
    NSMutableArray *prepTimes;
    NSMutableArray *recipeImages;
    BOOL recipeChecked[16];
}

@end

@implementation CustomTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipes" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    recipeNames = [dict objectForKey:@"Name"];
    recipeImages = [dict objectForKey:@"Image"];
    prepTimes = [dict objectForKey:@"PrepTime"];
    
    
    
    [self.tableView setContentInset:UIEdgeInsetsMake(20, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipeNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomTableCell";
    CustomTableCell *cell = (CustomTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.nameLabel.text = [recipeNames objectAtIndex:indexPath.row];
    cell.prepTimeLabel.text = [prepTimes objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
    if (recipeChecked[indexPath.row]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *checked = [[UIAlertView alloc] initWithTitle:@"" message:@"チェックしました！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    UIAlertView *unChecked = [[UIAlertView alloc] initWithTitle:@" " message:@"チェックを外しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
 

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (recipeChecked[indexPath.row]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        recipeChecked[indexPath.row] = NO;
        [unChecked show];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        recipeChecked[indexPath.row] = YES;
        [checked show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [recipeNames removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
}



@end
