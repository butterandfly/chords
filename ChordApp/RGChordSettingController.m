//
//  RGChordSettingController.m
//  ChordApp
//
//  Created by Zero on 13-4-14.
//  Copyright (c) 2013年 Zero. All rights reserved.
//

#import "RGChordSettingController.h"
#import "RGDataCenter.h"
#import "RGConstants.h"

@interface RGChordSettingController () {
    NSMutableArray *_chordsArray;
}

@end

@implementation RGChordSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chordsArray = [[NSMutableArray alloc] init];
    
    // !Not working! Set up the nav button.
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
//    backButton.title = @"返回";
//    self.navigationItem.leftBarButtonItem = backButton;
//    [[self navigationItem].leftBarButtonItem setTitle:@"返回"];

    // * Set up the chords array.
    NSDictionary *allChordsDic = [[RGDataCenter sharedDataCenter] objectFromChordsDataByKey:kPlistAllChords];
    // Sort the array from "c" to "b".
    NSArray *musicKey = @[@"C", @"C#", @"D", @"Eb", @"E", @"F", @"F#", @"G", @"Ab", @"A", @"Bb", @"B"];
    for (NSString *key in musicKey) {
        for (NSString *chordName in [allChordsDic objectForKey:key]) {
            [_chordsArray addObject:chordName];
        }
    }

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
    return [_chordsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *chordName = _chordsArray[indexPath.row];
    cell.textLabel.text = chordName;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *desChord = [_chordsArray objectAtIndex:[indexPath row]];
    [[self chordsMediator] changeChordByTag:self.buttonTag srcChord:self.buttonText desChord:desChord];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
