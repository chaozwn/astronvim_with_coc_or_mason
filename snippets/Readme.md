### https://github.com/rafamadriz/friendly-snippets/blob/main/package.json

### https://github.com/rafamadriz/friendly-snippets 
We have already been provided with a lot of configurations, which we can refer to when writing our own

# VSCode Snippets

## formatting

```json
"SnipetName" : {
    "prefix" : "sn"，
    "body" : [

    ],
    "description":"Snippet Description"
}
```

## 占位$

> \$1 代码段补全后光标的位置
> $0 代码段最后的位置

## 相关变量

- 文档
  - TM_SELECTED_TEXT 当前选定的文本或空字符串
  - TM_CURRENT_LINE 当前行内容
  - TM_CURRENT_WORD 光标下单词内容或空字符串
  - TM_LINE_INDEX 基于 0 索引的行号
  - TM_LINE_NUMBER 基于单索引的行号
  - TM_FILENAME 当前文件名
  - TM_FILENAME_BASE 当前文件名(无扩展名)
  - TM_DIRECTORY 当前文档的目录
  - TM_FILEPATH 当前文档绝对路径
  - CLIPBOARD 剪贴板的内容
  - WORKSPACE_NAME 当前工作空间名
- 日期
  - CURRENT_YEAR
  - CURRENT_YEAR_SHORT
  - CURRENT_MONTH_NAME
  - CURRENT_MONTH_NAME_SHORT
  - CURRENT_DATE
  - CURRENT_DAY_NAME
  - CURRENT_DAY_NAME_SHORT
  - CURRENT_HOUR
  - CURRENT_MINUTE
  - CURRENT_SECOND
- 注释
  - BLOCK_COMMENT_START
  - BLOCK_COMMENT_END
  - LINE_COMMENT
