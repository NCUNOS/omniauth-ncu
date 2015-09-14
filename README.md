
# Omniauth::NCU
> English | [繁體中文](README.zh-tw.md)

This is the community version OmniAuth strategy for authenticating to [NCU](http://www.ncu.edu.tw) (National Central University, Taiwan). To use it, you'll need to sign up for an OAuth Client ID and Secret on the [NCU OAuth Applications Page](https://api.cc.ncu.edu.tw/manage/developer/client/list).

## Basic Usage

```
use OmniAuth::Builder do
  provider :ncu, ENV['NCU_CLIENT_ID'], ENV['NCU_CLIENT_SECRET']
end
```

## Scopes

NCU OAuth API lets you set scopes to provide granular access to different types of data:

```
use OmniAuth::Builder do
  provider :ncu, ENV['NCU_CLIENT_ID'], ENV['NCU_CLIENT_SECRET'], scope: %w(user.info.basic.read course.schedule.read)
end
```

More info on [Scopes](https://github.com/NCU-CC/API-Documentation/blob/master/oauth-service/scope.md).

## License

Under MIT License.

> Copyright (c) 2015- Community of Networking and Open Source
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

