# PPTableView

模仿 WeChat 封装的 TableView，适用于有大量静态 Cell 的场景。

## TODO

- Fit iPad
- Badge Cell
- Web Image Cell
- Custom Cell
- ...

## Installation

### CocoaPods

1. Add `pod 'PPTableView', :git=> 'https://github.com/DSKcpp/PPTableView.git'` to `Podfile`

2. Run `pod install`

3. # import "PPTableView.h"

## Use

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableViewInfo = [[PPTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:[_tableViewInfo getTableView]];
  
	PPTableViewCellInfo *normalCellInfo = [PPTableViewCellInfo normalCellForSel:@selector(test) target:self title:@"NormalCell" rightValue:@"rightText" imageName:@"icon" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
      PPTableViewSectionInfo *sectionInfo = [PPTableViewSectionInfo sectionInfoDefault];
  [sectionInfo addCell:normalCellInfo];
  [_tableViewInfo addSection:sectionInfo];
}
```



See `PPAlertController.xcodeproj`

## Requirements

This project requires `iOS6.0+`.

## License

MIT

