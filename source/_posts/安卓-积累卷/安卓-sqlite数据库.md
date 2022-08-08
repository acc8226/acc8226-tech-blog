---
title: 安卓-sqlite数据库
date: 2017.03.10 12:24:46
categories:
  - 安卓
  - 积累卷
tags:
- android
---

* 创建 Entry 的内部类, 该类实现 BaseColumns
* tableName 定义常量字符串
* 为 table 的每一项什么常量字符串

```java
package com.example.android.waitlist.data;

import android.provider.BaseColumns;

public class WaitlistContract {

    // COMPLETED (1) Create an inner class named WaitlistEntry class that implements the BaseColumns interface
    public static final class WaitlistEntry implements BaseColumns {
        // COMPLETED (2) Inside create a static final members for the table name and each of the db columns
        public static final String TABLE_NAME = "waitlist";
        public static final String COLUMN_GUEST_NAME = "guestName";
        public static final String COLUMN_PARTY_SIZE = "partySize";
        public static final String COLUMN_TIMESTAMP = "timestamp";
    }

}
```

### 创建数据库

``` java
package com.example.android.waitlist.data;


import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.example.android.waitlist.data.WaitlistContract.*;

// COMPLETED (1) extend the SQLiteOpenHelper class
public class WaitlistDbHelper extends SQLiteOpenHelper {

    // COMPLETED (2) Create a static final String called DATABASE_NAME and set it to "waitlist.db"
    // The database name
    private static final String DATABASE_NAME = "waitlist.db";

    // COMPLETED (3) Create a static final int called DATABASE_VERSION and set it to 1
    // If you change the database schema, you must increment the database version
    private static final int DATABASE_VERSION = 1;

    // COMPLETED (4) Create a Constructor that takes a context and calls the parent constructor
    // Constructor
    public WaitlistDbHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    // COMPLETED (5) Override the onCreate method
    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {

        // COMPLETED (6) Inside, create an String query called SQL_CREATE_WAITLIST_TABLE that will create the table
        // Create a table to hold waitlist data
        final String SQL_CREATE_WAITLIST_TABLE = "CREATE TABLE " + WaitlistEntry.TABLE_NAME + " (" +
                WaitlistEntry._ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
                WaitlistEntry.COLUMN_GUEST_NAME + " TEXT NOT NULL, " +
                WaitlistEntry.COLUMN_PARTY_SIZE + " INTEGER NOT NULL, " +
                WaitlistEntry.COLUMN_TIMESTAMP + " TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                "); ";

        // COMPLETED (7) Execute the query by calling execSQL on sqLiteDatabase and pass the string query SQL_CREATE_WAITLIST_TABLE
        sqLiteDatabase.execSQL(SQL_CREATE_WAITLIST_TABLE);
    }

    // COMPLETED (8) Override the onUpgrade method
    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {
        // For now simply drop the table and create a new one. This means if you change the
        // DATABASE_VERSION the table will be dropped.
        // In a production app, this method might be modified to ALTER the table
        // instead of dropping it, so that existing data is not deleted.
        // COMPLETED (9) Inside, execute a drop table query, and then call onCreate to re-create it
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS " + WaitlistEntry.TABLE_NAME);
        onCreate(sqLiteDatabase);
    }
}
```

### 更新数据库

1. 版本号增加
2. 修改 onCreate 中执行的 sql 语句, onUpgrade 按需求做适量更改。

### 检查表中某列是否存在

```java
     /**
     * 检查表中某列是否存在
     * @param db
     * @param tableName 表名
     * @param columnName 列名
     * @return
     */
     public static boolean checkColumnExists(SQLiteDatabase db, String tableName, String columnName) {
         boolean result = false ;
         Cursor cursor = null ;
         try{
             cursor = db.rawQuery( "select * from sqlite_master where name = ? and sql like ?"
                , new String[]{tableName , "%" + columnName + "%"} );
             result = null != cursor && cursor.moveToFirst() ;
         }catch (Exception e){
             e.printStackTrace();
         }finally{
             if(null != cursor && !cursor.isClosed()){
                 cursor.close() ;
             }
         }
         return result ;
     }
```

### 数据库的修复

比如手机程序对.db的不当操作造成.

```sh
$ sqlite3 backup.sqlite
sqlite> .output “_temp.tmp”
sqlite> .dump
sqlite> .quit
```

```sh
$ sqlite3 new.sqlite
sqlite> .read “_temp.tmp”
sqlite> .quit
```

就将错误的 backup.sqlite 修复为 new.sqlite 了。
