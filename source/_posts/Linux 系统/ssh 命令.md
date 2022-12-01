## RSA，DSA，ECDSA，EdDSA 和 Ed25519 的区别

### 结论

ssh key 的类型有四种，分别是 dsa、rsa、 ecdsa、ed25519。

根据数学特性，这四种类型又可以分为两大类，dsa/rsa 是一类，ecdsa/ed25519 是一类，后者算法更先进。

1. dsa 因为安全问题，已不再使用了。
2. ecdsa 因为政治原因和技术原因，也不推荐使用。
3. rsa 是目前兼容性最好的，应用最广泛的 key 类型，在用ssh-keygen工具生成 key的时候，默认使用的也是这种类型。不过在生成 key 时，如果指定的 key size 太小的话，也是有安全问题的，推荐 key size 是 3072 或更大。
4. ed25519 是目前最安全、加解密速度最快的 key 类型，由于其数学特性，它的 key 的长度比 rsa 小很多，优先推荐使用。它目前唯一的问题就是兼容性，即在旧版本的 ssh 工具集中可能无法使用。不过据我目前测试，还没有发现此类问题。

## 什么是 OpenSSH

OpenSSH 是安全 Shell (SSH) 工具的开放源代码版本，Linux 及其他非 Windows 系统的管理员使用此类工具跨平台管理远程系统。 OpenSSH 在 2018 年秋季已添加至 Windows，并包含在 Windows 10 和 Windows Server 2019 中。

SSH 基于客户端-服务器体系结构，用户在其中工作的系统是客户端，所管理的远程系统是服务器。 OpenSSH 包含一系列组件和工具，用于提供一种安全且简单的远程系统管理方法，其中包括：

sshd.exe，它是远程所管理的系统上必须运行的 SSH 服务器组件
ssh.exe，它是在用户的本地系统上运行的 SSH 客户端组件
ssh-keygen.exe，为 SSH 生成、管理和转换身份验证密钥
ssh-agent.exe，存储用于公钥身份验证的私钥
ssh-add.exe，将私钥添加到服务器允许的列表中
ssh-keyscan.exe，帮助从许多主机收集公用 SSH 主机密钥
sftp.exe，这是提供安全文件传输协议的服务，通过 SSH 运行
scp.exe 是在 SSH 上运行的文件复制实用工具

**用户密钥生成**
若要使用基于密钥的身份验证，首先需要为客户端生成公钥/私钥对。 ssh-keygen.exe 用于生成密钥文件，并且可以指定算法 DSA、RSA、ECDSA 或 Ed25519。 如果未指定算法，则使用 RSA。 应使用强算法和密钥长度，例如此示例中的 Ed25519。

```sh
ssh-keygen -t ed25519
```

你可以按 Enter 来接受默认值，或指定要在其中生成密钥的路径和/或文件名。 此时，系统会提示你使用密码来加密你的私钥文件。 这可为空，但不建议这样做。 将密码与密钥文件一起使用来提供双因素身份验证。

现在，指定位置已有一个公共/专用 Ed25519 密钥对。 .pub 文件是公钥，没有扩展名的文件是私钥。

### 总结

优先选择 ed25519，否则选择 rsa

## 总结遇到的问题

### WSL 的时候 `sudo service ssh start` 启动不了 ssh

在尝试 `sudo ssh-keygen -A`，之后就没问题了。

### 之后我在使用 Putty 的时候，登录 linux 的时候，提示 no supported authentication methods available

可以尝试更改文件 /etc/ssh/sshd_config 中启用 `PasswordAuthentication yes`，然后再重启服务器即可

### Linux SSH 远程登录错误解决办法 WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED

**报错原因**:
当我们选择 yes 时，ssh 会把阿里云服务器的公钥(host key)都记录在 ~/.ssh/known_hosts。当下次访问相同服务器时，ssh 会核对 host key。如果 host key不同，ssh 会发出警告，避免你受到中间人攻击。

我这里之所以报错，是因为我重置了阿里云服务器，服务器 host key 发生了变化，所以再次登录时会报错。

**解决办法**:
`ssh-keygen -R YourAliyunServerIp` （YourAliyunServerIp 就是你阿里云服务器的公网ip）

它会更改我们上面说到的 known_hosts 文件，并生成一个 known_hosts.old 文件，known_hosts.old 文件其实就是known_hosts 未修改前的版本。

### likai@localhost: Permission denied (publickey)

登录目标机器，打开 /etc/ssh/sshd_config ，修改 PasswordAuthentication no 为：PasswordAuthentication yes。
