import router from '@ohos.router';

class Item {
  name: string;
  image: ResourceStr;

  constructor(name: string, image: ResourceStr) {
    this.name = name;
    this.image = image;
  }
}

@Entry
@Component
struct Page_18 {
  @State message: string = '文档';
  @State private items: Array<Item> = [];
  @State mode: number = router.getParams()['mode']
  item_input() {
    const newItems: Array<Item> = [];
    if (this.mode === 1) {
      for (let i = 1; i <= 8; i++) {
        newItems.push(new Item(`居民用电分类${i}.xlsx`, $r('app.media.xlsx')));
      }
      this.items = newItems;
    }
    else if(this.mode === 2){
      for (let i = 1; i <= 4; i++) {
        newItems.push(new Item(`企业用电分析${i}.csv`, $r('app.media.xlsx')));
      }
      for (let i = 1; i <= 4; i++) {
        newItems.push(new Item(`企业用电分析${i}.xlsx`, $r('app.media.xlsx')));
      }
      this.items = newItems;
    }
    else{
      for (let i = 1; i <= 8; i++) {
        newItems.push(new Item(`集群分析${i}.csv`, $r('app.media.xlsx')));
      }
      this.items = newItems;
    }

  }

  build() {
    Column() {
      Row() {
        Text('< 返回')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.back();
          })
          .margin({
            top: '40vp',
            left: '10vp'
          });
      }
      .width('100%');

      Text('请选择已存储至库中的文件')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 30 });

      List({ space: 10 }) {
        ForEach(this.items, (item: Item) => {
          ListItem() {
            Row({ space: 10 }) {
              Image(item.image).width(100);
              Column() {
                Text(item.name)
                  .fontSize(18)
                  .fontColor('#444')
                  .fontWeight(FontWeight.Bold);
                Button('选择')
                  .width(150)
                  .fontSize(18)
                  .backgroundColor(Color.Gray)
                  .margin({ top: 20 })
                  .onClick(() => {
                    router.back();
                  });
              }
              .alignItems(HorizontalAlign.Start);
            }
            .width('100%')
            .padding({ left: 14, right: 14 })
            .backgroundColor('#fff')
            .borderRadius(8);
          }
          .width('100%');
        });
      }
      .height('80%')
      .margin({ top: 10 })
      .padding({ bottom: 10 })
    }
    .onAppear(() => {
      this.item_input();
    })
  }
}
