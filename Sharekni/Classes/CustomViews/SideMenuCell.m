//
//  SideMenuCell.m
//  sharekni
//
//  Created by Ahmed Askar on 11/17/15.
//
//

#import "SideMenuCell.h"

@implementation SideMenuCell

- (void)awakeFromNib {
    // Initialization code
    self.cellTitle.textAlignment = NSTextAlignmentNatural ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
