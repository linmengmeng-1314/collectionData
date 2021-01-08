这里是修改后的 artDialog.js  

源码下面是封装的公共函数。

```js
/**
 * 简单的弹窗信息，只需传入弹窗主题内容
 *  content: 弹窗内容信息，不能为空，否则抛出异常
 */
function alertInfo(content) {
    alertFullInfo('', content);
}

/**
 * 完整的弹窗信息
 *  title：弹窗标题，为空则显示：提示信息
 *  content: 弹窗内容信息 为空则抛出异常
 */
function alertFullInfo(title, content) {
    if (title == null || title == ''){
        title = "提示信息";
    }
    if (content == null || content == ''){
        jadlsoftWarming("alertInfo", "The parameter 'content' is not empty!");
        return;
    }
    var d = dialog({
        title: title,
        content: content
    });
    d.showModal();
}

/**
 *  询问弹窗
 * @param content   弹窗内容
 * @param successCallBack   确定按钮回调函数
 */
function alertConfirm(content, successCallBack) {
    alertFullConfirm('', content, successCallBack, '');
}

/**
 *  询问弹窗
 * @param content   弹窗内容
 * @param successCallBack   确定按钮回调函数
 * @param cancelCallBack    取消按钮回调函数
 */
function alertConfirm(content, successCallBack, cancelCallBack) {
    alertFullConfirm('', content, successCallBack, cancelCallBack);
}

/**
 * 询问弹窗
 * @param title 弹窗标题
 * @param content   弹窗内容
 * @param successCallBack   确定按钮回调函数
 * @param cancelCallBack    取消按钮回调函数
 */
function alertFullConfirm(title, content, successCallBack, cancelCallBack) {
    if (title == null || title == ''){
        title = "提示信息";
    }

    if (content == null || content == ''){
        jadlsoftWarming("alertInfo", "The parameter 'content' is not empty!");
        return;
    }

    if(typeof successCallBack != 'function') {
        jadlsoftWarming("alertConfirm", "The parameter 'successCallBack' can not be null and should be a function!");
        return;
    }

    if(typeof cancelCallBack != 'function') {
        cancelCallBack = function(){
            //do something
        };
    }

    var d = dialog({
        title: title,
        content: content,
        okValue: '确定',
        ok: function () {
            successCallBack();
        },
        cancelValue: '取消',
        cancel: function () {
            cancelCallBack();
        }
    });
    d.showModal();
}

/**
 * 提醒弹窗
 * @param content   弹窗内容
 */
function alertSuccess(content){
    alertFullSuccess("", content, '');
}

/**
 * 提醒弹窗
 * @param content   弹窗内容
 * @param callback  确认
 */
function alertSuccess(content, callback){
    alertFullSuccess("", content, callback);
}

/**
 * 带标题的提醒弹窗
 * @param title
 * @param content
 * @param callback
 */
function alertFullSuccess(title, content, callback){
    if (title == null || title == ''){
        title = "提示信息";
    }

    if (content == null || content == ''){
        jadlsoftWarming("alertInfo", "The parameter 'content' is not empty!");
        return;
    }

    if(typeof callback != 'function') {
        callback = function(){
            //do something
        };
    }

    dialog({
        title: title,
        content: content,
        okValue: '确定',
        ok: callback,
        cancel: false
    }).showModal();
}

/**
 * 定时关闭的弹窗  默认两秒后关闭弹窗
 * @param content 弹窗内容
 * @param callback  回调函数
 */
function alertSuccessAutoClose(content, callback){
    alertSuccessAutoClose(content, callback, 2000);
}

/**
 * 定时关闭的弹窗  默认两秒后关闭弹窗
 * @param content 弹窗内容
 * @param callback  回调函数
 * @param timeout   延迟关闭时间(ms)
 */
function alertSuccessAutoClose(content, callback, timeout){
    if(typeof callback != 'function') {
        callback = function(){
            //do something
        };
    }

    if (timeout == null){
        timeout = 2000;
    }

    var d = dialog({
        content: content,
        onremove: function () {
            callback();
        }
    });
    d.showModal();

    setTimeout(function(){
        d.close().remove();
    },timeout);
}

```