---
title: Polars
date: 2026-04-06 13:43:42
updated: 2026-04-06 13:43:42
categories:
  - 语言
  - Python
  - 框架
tags: python
---

Polars 是一个用于处理结构化数据的极速 DataFrame 库。其核心用 Rust 编写，并提供 Python、R 和 NodeJS 接口。

## 主要特性

- **快速**：完全用 Rust 从头编写，设计贴近底层机器，无外部依赖。
- **I/O (输入/输出)**：对所有常见数据存储层提供一流支持：本地、云存储和数据库。
- **直观的 API**：以您预期的方式编写查询。Polars 会利用其查询优化器在内部确定最有效的执行方式。<!-- more -->
- **核外处理**：流式 API 允许您处理结果，而无需将所有数据同时加载到内存中。
- **并行**：通过在可用 CPU 核心之间分配工作负载，充分利用您机器的性能，无需额外配置。
- **向量化查询引擎**
- **GPU 支持**：可选地在 NVIDIA GPU 上运行查询，以在内存工作负载中实现最大性能。
- **[Apache Arrow 支持](https://arrow.apache.ac.cn/)**：Polars 可以消费和生成 Arrow 数据，通常进行零拷贝操作。请注意，Polars 不是基于 Pyarrow/Arrow 实现构建的。相反，Polars 有自己的计算和缓冲区实现。

## 读取与写入

Polars 支持常见文件格式（例如 CSV、JSON、Parquet）、云存储（S3、Azure Blob、BigQuery）和数据库（例如 PostgreSQL、MySQL）的读写。下面，我们将创建一个小型数据框，并展示如何将其写入磁盘并读回。

```py
import polars as pl
import datetime as dt

df = pl.DataFrame(
    {
        "name": ["Alice Archer", "Ben Brown", "Chloe Cooper", "Daniel Donovan"],
        "birthdate": [
            dt.date(1997, 1, 10),
            dt.date(1985, 2, 15),
            dt.date(1983, 3, 22),
            dt.date(1981, 4, 30),
        ],
        "weight": [57.9, 72.5, 53.6, 83.1],  # (kg)
        "height": [1.56, 1.77, 1.65, 1.75],  # (m)
    }
)

print(df)
```

```
shape: (4, 4)
┌────────────────┬────────────┬────────┬────────┐
│ name           ┆ birthdate  ┆ weight ┆ height │
│ ---            ┆ ---        ┆ ---    ┆ ---    │
│ str            ┆ date       ┆ f64    ┆ f64    │
╞════════════════╪════════════╪════════╪════════╡
│ Alice Archer   ┆ 1997-01-10 ┆ 57.9   ┆ 1.56   │
│ Ben Brown      ┆ 1985-02-15 ┆ 72.5   ┆ 1.77   │
│ Chloe Cooper   ┆ 1983-03-22 ┆ 53.6   ┆ 1.65   │
│ Daniel Donovan ┆ 1981-04-30 ┆ 83.1   ┆ 1.75   │
└────────────────┴────────────┴────────┴────────┘
```

在下面的示例中，我们将数据框写入名为 `output.csv` 的 CSV 文件。之后，我们使用 `read_csv` 将其读回，然后打印结果进行检查。

```py
df.write_csv("docs/assets/data/output.csv")
df_csv = pl.read_csv("docs/assets/data/output.csv", try_parse_dates=True)
print(df_csv)
```

## 笔记

需要安装 fastexcel 包。polars 读取 Excel 需要这个依赖：

pip install fastexcel

- - -

polars 的 write_excel() 依赖 xlsxwriter 库来处理 Excel 文件写入。安装后即可正常运行。

pip install xlsxwriter

## 参考

[Polars 用户指南](https://docs.polars.org.cn/)
