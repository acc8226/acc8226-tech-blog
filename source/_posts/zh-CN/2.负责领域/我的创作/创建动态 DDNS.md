---
title: 创建动态 DDNS
date: 2025-08-09 16:41:12
updated: 2025-08-09 16:41:12
---

1\. 创建 Cloudflare 账户并获取 api 令牌

复制此令牌以访问 Cloudflare API。

2\. 创建 DNS 记录

3\. 构建请求

说明：ZONE_ID 填写你的 zone_identifier。
DNS_RECORD_ID 填写你的 dns 记录 id。一般可通过 `https://api.cloudflare.com/client/v4/zones/{zone_identifier}/dns_records` 查询得到。
<!-- more -->

```sh
curl https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID \
    -X PATCH \
    -H 'Content-Type: application/json' \
    -H "Authorization: $CLOUDFLARE_API_KEY" \
    -d '{
          "name": "example.com",
          "type": "A",
          "comment": "Domain verification record",
          "content": "198.51.100.4",
          "proxied": false
        }'
```

## 参考

[Cloudflare API | DNS › Records › Update DNS Record](https://developers.cloudflare.com/api/resources/dns/subresources/records/methods/edit/)
