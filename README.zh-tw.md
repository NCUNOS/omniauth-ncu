
# Omniauth::NCU
> [English](README.md) | 繁體中文

此為社群版本之可用於[中央大學](http://www.ncu.edu.tw)認證之 OmniAuth strategy。 使用前你可能需要先前往[中央大學 OAuth 應用服務管理](https://api.cc.ncu.edu.tw/manage/developer/client/list)申請 Client ID 以及 Client Secret。

## 基礎用法

```
use OmniAuth::Builder do
  provider :ncu, ENV['NCU_CLIENT_ID'], ENV['NCU_CLIENT_SECRET']
end
```

## Scope

NCU OAuth API 提供你設定 scopes 來取得不同資料的存取權限：

```
use OmniAuth::Builder do
  provider :ncu, ENV['NCU_CLIENT_ID'], ENV['NCU_CLIENT_SECRET'], scope: "user.info.basic.read,course.schedule.read"
end
```

更多資訊請上 [Scopes](https://github.com/NCU-CC/API-Documentation/blob/master/oauth-service/scope.md)。

## 授權條款

以 MIT License 釋出。

> Copyright (c) 2015- Community of Networking and Open Source
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

