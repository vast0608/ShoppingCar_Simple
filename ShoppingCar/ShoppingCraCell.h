//
//  ShoppingCraCell.h
//  ShoppingCar
//
//  Created by 上海烨历网络科技有限公司 on 2017/6/14.
//  Copyright © 2017年 上海烨历网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCarModel.h"
#import "PPNumberButton.h"//加号减号按钮
@interface ShoppingCraCell : UITableViewCell
@property (nonatomic,strong) UIButton * selectBtn;//选择按钮
@property (nonatomic,strong) UIImageView * productImageView;//商品图片
@property (nonatomic,strong) UILabel * productNameLab;//商品名字
@property (nonatomic,strong) UILabel * productPriceLab;//商品价格
@property (nonatomic,strong) PPNumberButton *numberButton;//加号减号按钮

@property (nonatomic,strong) UIButton * deleteBtn;//删除按钮

@property (nonatomic,strong) ShoppingCarModel * model;

@end
