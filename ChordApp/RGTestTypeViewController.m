//
//  RGTestTypeViewController.m
//  ChordApp
//
//  Created by Zero on 13-3-18.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGTestTypeViewController.h"
#import "RGHelper.h"

#import "RGConstants.h"

@interface RGTestTypeViewController () {
    
}

- (void)checkTheCellAtIndexPath:(NSIndexPath*)indexPath;
- (NSIndexPath*)indexPathOfCurrentCategory;

@end

@implementation RGTestTypeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Load all category.
    // I love refactoring.
    NSDictionary *dataDict = [RGHelper plistDictByFileName:@"chords_data"];
    self.categoryArray = [RGHelper localizedArrayFromKeysArray:[dataDict objectForKey:@"questCategorys"]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    // Refactoring is awesome!
    [self checkTheCellAtIndexPath:[self indexPathOfCurrentCategory]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self categoryArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.categoryArray objectAtIndex:[indexPath row]];;
    
    return cell;
}
 
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Set.
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [RGHelper setUserDefaultsObject:[NSNumber numberWithInteger:indexPath.row] byKey:kSettingQuestCategory];
    [self.configDelegate setupQuestTypeByKey:indexPath.row];
    // Pop.
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private

- (void)checkTheCellAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *checkCell = [self.tableView cellForRowAtIndexPath:indexPath];
    checkCell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (NSIndexPath *)indexPathOfCurrentCategory {
    NSIndexPath *indexPath =  [NSIndexPath indexPathForRow:self.questType inSection:0];
    return indexPath;
}

@end
