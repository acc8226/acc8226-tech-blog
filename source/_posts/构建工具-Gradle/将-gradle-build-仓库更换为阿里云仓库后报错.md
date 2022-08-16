将 gradle.build 仓库更换为阿里云仓库后报错

Could not resolve all dependencies for configuration ':detachedConfiguration7'.

Using insecure protocols with repositories, without explicit opt-in, is unsupported. Switch Maven repository 'maven(http://maven.aliyun.com/nexus/content/groups/public/)' to redirect to a secure protocol (like HTTPS) or allow insecure protocols. See https://docs.gradle.org/7.0.2/dsl/org.gradle.api.artifacts.repositories.UrlArtifactRepository.html#org.gradle.api.artifacts.repositories.UrlArtifactRepository:allowInsecureProtocol for more details. 

修改方式有两种：

第一种：在仓库前添加关键字：

allowInsecureProtocol = true

```
    maven { 
        setAllowInsecureProtocol(true)
        url "https://repo.spring.io/release" 
    }
```

第二种：
将阿里云的连接 http 换成 https。

## 参考
