import router from '@ohos.router';
import picker from '@ohos.file.picker';
async function picker_file(): Promise<string | null> {
  try {
    let documentSelectOptions = new picker.DocumentSelectOptions();
    let documentPicker = new picker.DocumentViewPicker();
    const documentSelectResult = await documentPicker.select(documentSelectOptions);

    if (!documentSelectResult || documentSelectResult.length === 0) {
      console.log('No file selected.');
      return null;
    }

    let filePath = documentSelectResult[0];
    if (!isExcelFile(filePath)) {
      console.log('Selected file is not an Excel file.');
      return null;
    }

    return filePath;
  } catch (err) {
    console.error('Error picking file:', err);
    return null;
  }
}
// 检查文件类型是否是 Excel
function isExcelFile(filePath: string): boolean {
  return filePath.endsWith('.xlsx') || filePath.endsWith('.xls');
}



@Entry
@Component
struct Page {
  @State money: number = 0.0;
  @State frequency: number = 0.0;
  @State message: string = '分析-上传'
  build() {
      Column() {
        Row(){
          Text('< 返回')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .onClick(()=>{
            router.back()
          })
          .margin({
            top:'40vp',
            left:'10vp'
          })
        }.justifyContent(FlexAlign.Start)
        .width('100%')
        Column(){
          Button('上传文件')
            .fontColor(Color.Black)
            .type(ButtonType.Normal)
            .width('150')
            .height('40')
            .borderRadius(5)
            .backgroundColor(Color.White)
            .borderWidth(1)
            .borderColor(Color.Black)
            .onClick(async () => {
              try {
                const filePath = await picker_file();
                if (filePath) {
                  router.pushUrl({
                    url: 'pages/Page_13',
                    params: { id: 1 }
                  }, router.RouterMode.Single, err => {
                    if (err) {
                      console.error('路由失败:', err);
                    }
                  });
                }
              } catch (err) {
                console.error('选择文件出错：', err);
              }
            })
          Text('请上传xls/xlsx文件，大小在60M以内')
            .fontColor(Color.Gray)
            .fontSize(15)
            .margin({top:30})
        }.margin({top:220})
        Column(){
          Text('评判标准-自定义')
            .fontSize(25)
            .fontColor(Color.Black)
          Text('留空则为系统默认标准')
            .fontSize(15)
            .fontColor(Color.Gray)
        }.margin({top:100})
        Row(){
          Text('评价缴费金额标准')
            .fontSize(18)
            .fontColor(Color.Black)
            .margin({right:10})
          TextInput({placeholder:'默认'})
            .type(InputType.Number)
            .borderWidth(1)
            .width(150)
            .onChange( value =>{
              this.money = parseFloat(value)
            })
        }.margin({top:10})
        Row(){
          Text('评价缴费次数标准')
            .fontSize(18)
            .fontColor(Color.Black)
            .margin({right:10})
          TextInput({placeholder:'默认'})
            .type(InputType.Number)
            .borderWidth(1)
            .width(150)
            .onChange( value =>{
              this.frequency = parseFloat(value)
            })
        }.margin({top:20})

      }
      .width('100%')
      .height('100%')
  }
}