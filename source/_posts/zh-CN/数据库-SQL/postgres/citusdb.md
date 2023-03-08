Citus概念
Citus 是 PostgreSQL 的扩展（not a fork），采用 shared nothing 架构，节点之间无共享数据，由协调器节点和Work节点构成一个数据库集群。
相比单机 PostgreSQL，Citus可以使用更多的 CPU 核心，更多的内存数量，保存更多的数据。
通过向集群添加节点，可以轻松的扩展数据库。
Citus 支持新版本 PostgreSQL 的特性，并保持与现有工具的兼容 Citus 使用分片和复制在多台机器上横向扩展 PostgreSQL。它的查询引擎将在这些服务器上执行 SQL 进行并行化查询，以便在大型数据集上实现实时（不到一秒）的响应。

如何获得 Citus

* Citus 社区版
* Citus 商业版
* Cloud [AWS，citus cloud]

通过 docker 进行安装

```sh
# start the image
docker run -d --name citus -p 5432:5432 -e POSTGRES_PASSWORD=mypass citusdata/citus:11.2

# verify it's running, and that Citus is installed:
psql -U postgres -h localhost -d postgres -c "SELECT * FROM citus_version();"
```

安装 pgdg 存储库和 Citus 扩展:

ubuntu 或 Debian 系统

```sh
# Add Citus repository for package manager
curl https://install.citusdata.com/community/deb.sh | sudo bash
# install the server and initialize db
sudo apt-get -y install postgresql-15-citus-11.2

# 如果是多节点
sudo pg_conftool 15 main set shared_preload_libraries citus
```

Fedora、 CentOS 或 Red Hat 系统

```sh
curl https://install.citusdata.com/community/rpm.sh | sudo bash
sudo yum install -y citus112_15
# 如果是多节点
sudo service postgresql-15 initdb || sudo /usr/pgsql-15/bin/postgresql-15-setup initdb
echo "shared_preload_libraries = 'citus'" | sudo tee -a /var/lib/pgsql/15/data/postgresql.conf
```

## 参考

Citus Data | Distributed Postgres. At any scale.
<https://www.citusdata.com/>

citusdata/citus: Distributed PostgreSQL as an extension
<https://github.com/citusdata/citus>
