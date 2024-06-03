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
struct Page_19 {
  @State message: string = '任务5 上传'
  onLoadComplete() {
    // 跳转到另一个页面
    router.pushUrl({
      url: 'pages/userTabs'
    }, router.RouterMode.Single,
      err => {
        if (err) {
          console.log('路由失败');
        }
      }
    )
  }
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
      }
      .width('100%')
      Column(){
        Button('上传文件')
          .fontColor(Color.Black)
          .type(ButtonType.Normal)
          .width('125')
          .height('30')
          .borderRadius(10)
          .backgroundColor(Color.White)
          .borderWidth(1)
          .borderColor(Color.Black)
          .onClick(async () => {
            try {
              const filePath = await picker_file();
              if (filePath) {
                this.onLoadComplete()
              }
            } catch (err) {
              console.error('选择文件出错：', err);
            }
          })
        Text('请上传xls/xlsx文件，大小在60M以内')
          .fontColor(Color.Gray)
          .fontSize(15)
          .margin({top:30})
      }.margin({top:300})
    }
    .height('100%')
  }
}