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
    recipeNames = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    prepTimes = [NSMutableArray arrayWithObjects:@"10 min", @"20min", @"30min", @"40min", @"50min", @"60min", @"70min", @"80min", @"90min", @"100min", @"110min", @"120min", @"130min", @"140min", @"150min", @"160min", nil];
    
    recipeImages = [NSMutableArray arrayWithObjects:@"egg_benedict.jpg", @"mushroom_risotto.jpg", @"full_breakfast.jpg", @"hamburger.jpg", @"ham_and_egg_sandwich.jpg", @"creme_brelee.jpg", @"white_chocolate_donut.jpg", @"starbucks_coffee.jpg", @"vegetable_curry.jpg", @"instant_noodle_with_egg.jpg", @"noodle_with_bbq_pork.jpg", @"japanese_noodle_with_pork.jpg", @"green_tea.jpg", @"thai_shrimp_cake.jpg", @"angry_birds_cake.jpg", @"ham_and_cheese_panini.jpg", nil];
    
    
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
    [tableView reloadData];
}



@end
