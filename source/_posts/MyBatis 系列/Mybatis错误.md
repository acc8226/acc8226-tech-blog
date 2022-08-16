"nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named 'paymentTypeCode' in 'class java.lang.String'"

xml中 或者在 类方法上写的sql语句有问题

### SpringBoot整合Mybatis报错:Consider defining a bean of type 'xx.xx.xx' in your configur

Consider defining a bean of type 'com.poly.ncl.chargepaychange.mapper.ChargePayChangeMapper' in your configuration.

这是由于 springBoot 启动时，没有扫描到com.alibaba.dao.EntFileDao ，而在 com.alibaba.serviceImpl.EntFileServiceImpl 中又使用了 @autowired private EnfileDao entFileDao 进行装配，所以会发现错误，说没有定义。此时需要在 springBoot 的启动类上，加个注解：@MapperScan("持久层路径")，这样就会扫描到com.alibaba.dao.EntFileDao了。

原文：<https://blog.csdn.net/weixin_39800144/article/details/79176373>
