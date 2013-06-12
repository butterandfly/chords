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
#import "RGAppUserDefaults.h"

@interface RGChordSettingController () {
    NSArray *_musicKey;
    NSDictionary *_chordsDict;
}

- (NSString*)chordByIndexPath:(NSIndexPath*)indexPath;

@end

@implementation RGChordSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _musicKey = @[@"C", @"C#", @"D", @"Eb", @"E", @"F", @"F#", @"G", @"Ab", @"A", @"Bb", @"B"];
    _chordsDict = [[RGDataCenter sharedDataCenter] objectFromChordsDataByKey:kPlistAllChords];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_musicKey count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *chords4CurrentKey = [_chordsDict objectForKey:[_musicKey objectAtIndex:section]];
    return [chords4CurrentKey count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_musicKey objectAtIndex:section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _musicKey;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    cell.textLabel.text = [self chordByIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *desChord = [self chordByIndexPath:indexPath];
    [[self chordsMediator] changeChordByTag:self.buttonTag srcChord:self.buttonText desChord:desChord];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Privated

- (NSString *)chordByIndexPath:(NSIndexPath *)indexPath {
    NSArray *chords4CurrentKey = [_chordsDict objectForKey:[_musicKey objectAtIndex:indexPath.section]];
    NSString *chordName = chords4CurrentKey[indexPath.row];
    return chordName;
}

@end
