---
title: Google Shell 风格规范
date: 2021-12-24 21:29:26
updated: 2022-11-05 10:46:00
categories: 文档规约
---

## 背景[](https://google.github.io/styleguide/shellguide.html#background)

### 使用哪种 Shell[](https://google.github.io/styleguide/shellguide.html#which-shell-to-use)

Bash 是唯一允许可执行程序使用的 shell / 脚本语言。

可执行文件必须以 `#!/bin/bash` 开头和最少数量的标志。 使用 `set` 设置 shell 选项，以便将脚本调用为 bash 脚本名称不会破坏其功能。

将所有可执行 shell 脚本限制为 bash 可以为我们提供一个安装在所有计算机上的一致的 shell 语言。

唯一的例外是，无论你在编写什么代码，你都不得不这样做。 这方面的一个例子是 Solaris SVR4包，它要求任何脚本都使用普通的 Bourne shell。

### When to use Shell[](https://google.github.io/styleguide/shellguide.html#when-to-use-shell)

Shell 应该只用于小型实用程序或简单的包装器脚本。

<!-- more -->

虽然 shell 脚本不是一种开发语言，但它用于编写贯穿 Google 的各种实用脚本。 这个样式指南更多的是对其使用的认可，而不是建议将其用于广泛的部署。

Some guidelines:

* 如果你主要是调用一些其它的实用程序，和正在做一些相对较少的数据处理，那么shell是该任务可以接受的选择
* 如果你在乎性能，那么使用其它开发语言而不是shell
* If you are writing a script that is more than 100 lines long, or that uses non-straightforward control flow logic, you should rewrite it in a more structured language *now*. Bear in mind that scripts grow. Rewrite your script early to avoid a more time-consuming rewrite at a later date.
* When assessing the complexity of your code (e.g. to decide whether to switch languages) consider whether the code is easily maintainable by people other than its author.

## Shell Files and Interpreter Invocation[](https://google.github.io/styleguide/shellguide.html#shell-files-and-interpreter-invocation)

### 文件拓展[](https://google.github.io/styleguide/shellguide.html#file-extensions)

【可执行文件不应该有文件名扩展(强烈推荐)，或者只用.sh作为扩展。库就必须要用.sh扩展，而且要把它设置成不可以执行文件。】

在执行程序时，不需要知道程序是用什么语言编写的，shell 不需要扩展，因此我们不希望为可执行程序使用扩展。

However, for libraries it’s important to know what language it is and sometimes there’s a need to have similar libraries in different languages. This allows library files with identical purposes but different languages to be identically named except for the language-specific suffix.

### SUID/SGID[](https://google.github.io/styleguide/shellguide.html#suidsgid)

【SUID和SGID 在Shell脚本中禁用。】

There are too many security issues with shell that make it nearly impossible to secure sufficiently to allow SUID/SGID. While bash does make it difficult to run SUID, it’s still possible on some platforms which is why we’re being explicit about banning it.

如果需要，可以使用 sudo 提供高级访问。

## 环境[](https://google.github.io/styleguide/shellguide.html#environment)

### STDOUT vs STDERR[](https://google.github.io/styleguide/shellguide.html#stdout-vs-stderr)

所有的错误消息都应该发送到 `STDERR`.

这使得将正常状态与实际问题区分开来更加容易。

建议使用一个函数打印出错误消息以及其他状态信息。

```shell
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

if ! do_something; then
  err "Unable to do_something"
  exit 1
fi

```

## 注释[](https://google.github.io/styleguide/shellguide.html#comments)

### 文件头[](https://google.github.io/styleguide/shellguide.html#file-header)

以每个文件的内容描述开始。

每个文件必须有一个顶级注释，包括其内容的简要概述。 版权声明和作者信息是可选的。

Example:

```sh
#!/bin/bash
#
# Perform hot backups of Oracle databases.
```

### Function Comments[](https://google.github.io/styleguide/shellguide.html#function-comments)

任何不是显而易见和简短的函数都必须被注释。 库中的任何函数都必须注释，而不管其长度或复杂性如何。

其他人应该可以通过阅读注释(如果提供自助功能的话)而不用阅读代码来学习如何使用您的程序或使用您的库中的函数。

所有函数注释都应该使用以下方法描述预期的 API 行为:

*   函数的描述信息
*   Globals: 使用的和修改的全局变量
*   Arguments: 参数信息
*   Outputs: 输出到 STDOUT 或 STDERR
*   Returns: 返回值而不是最后一条命令的退出状态码

Example:

```sh
#######################################
# Cleanup files from the backup directory.
# Globals:
#   BACKUP_DIR
#   ORACLE_SID
# Arguments:
#   None
#######################################
function cleanup() {
  …
}

#######################################
# Get configuration directory.
# Globals:
#   SOMEDIR
# Arguments:
#   None
# Outputs:
#   Writes location to stdout
#######################################
function get_dir() {
  echo "${SOMEDIR}"
}

#######################################
# Delete a file in a sophisticated manner.
# Arguments:
#   File to delete, a path.
# Returns:
#   0 if thing was deleted, non-zero on error.
#######################################
function del_thing() {
  rm "$1"
}
```

### Implementation 注释[](https://google.github.io/styleguide/shellguide.html#implementation-comments)

注释代码中棘手的、不明显的、有趣的或重要的部分。

这遵循了一般的 Google 编码注释实践。 不要注释所有事情。 如果有一个复杂的算法，或者你正在做一些不寻常的事情，在里面加一个简短的评论。

### TODO 注释[](https://google.github.io/styleguide/shellguide.html#todo-comments)

对于临时的、短期的解决方案或足够好但不完美的代码，使用 TODO 注释。

This matches the convention in the [C++ Guide](https://google.github.io/styleguide/cppguide.html#TODO_Comments).

`TODO`s should include the string `TODO` in all caps, followed by the name, e-mail address, or other identifier of the person with the best context about the problem referenced by the `TODO`. The main purpose is to have a consistent `TODO` that can be searched to find out how to get more details upon request. A `TODO` is not a commitment that the person referenced will fix the problem. Thus when you create a `TODO` , it is almost always your name that is given.

Examples:

```sh
# TODO(mrmonkey): Handle the unlikely edge cases (bug ####)
```

## 格式化[](https://google.github.io/styleguide/shellguide.html#formatting)

虽然你应该修改已有的文件来遵循下面风格，但是任何新编写的代码下面的风格是所必须的．

### 缩进[](https://google.github.io/styleguide/shellguide.html#indentation)

按照２个空格来缩进，不使用tab来缩进．

在两个语句块中使用空白行，来提高可读性，缩进是两个空格，无论你做什么，不要使用制表符，对于现有的文件，保留现有使用的缩进．

### Line Length and Long Strings[](https://google.github.io/styleguide/shellguide.html#line-length-and-long-strings)

一行的长度最大是80个字符．

如果你必须要写一个长于80个字符的字符串，那么你应该使用EOF或者嵌入一个新行，如果有一个文字字符串长度超过了80个字符，并且不能合理的分割文字字符串，但是强烈推荐你找到一种办法让它更短一点．

```sh
# DO use 'here document's
cat <<END
I am an exceptionally long
string.
END

# Embedded newlines are ok too
long_string="I am an exceptionally
long string."
```

### 多个管道[](https://google.github.io/styleguide/shellguide.html#pipelines)

如果管道不能适应一行一个那么应该分割成每行一个．

如果管道都适合在一行，那么就使用一行即可．

如果不是，那么应该分割在每行一个管道，新的一行应该缩进２个空格，这条规则适用于那些通过使用”|”或者是一个逻辑运算符”||”和”&&”等组合起来的链式命令．

```
# All fits on one line
command1 | command2

# Long commands
command1 \
  | command2 \
  | command3 \
  | command4

```

### 循环[](https://google.github.io/styleguide/shellguide.html#loops)

让`; do`和`; then`和`while` `for` 以及`if`在同一行

Shell 中的循环稍有不同，但我们在声明函数时遵循与大括号相同的原则。 也就是: ; then 和; do 应该与 if / for / while 在同一行上。 Else 应该在自己的行上，结束语句应该在自己的行上与开始语句垂直对齐。

例子:

```
# If inside a function, consider declaring the loop variable as
# a local to avoid it leaking into the global environment:
# local dir
for dir in "${dirs_to_cleanup[@]}"; do
  if [[ -d "${dir}/${ORACLE_SID}" ]]; then
    log_date "Cleaning up old files in ${dir}/${ORACLE_SID}"
    rm "${dir}/${ORACLE_SID}/"*
    if (( $? != 0 )); then
      error_message
    fi
  else
    mkdir -p "${dir}/${ORACLE_SID}"
    if (( $? != 0 )); then
      error_message
    fi
  fi
done

```

### Case语句[](https://google.github.io/styleguide/shellguide.html#case-statement)

*   通过2个空格来缩进
*   A one-line alternative needs a space after the close parenthesis of the pattern and before the `;;`.
*   Long or multi-command alternatives should be split over multiple lines with the pattern, actions, and `;;` on separate lines.

The matching expressions are indented one level from the `case` and `esac`. Multiline actions are indented another level. In general, there is no need to quote match expressions. Pattern expressions should not be preceded by an open parenthesis. Avoid the `;&` and `;;&`notations.

```sh
case "${expression}" in
  a)
    variable="…"
    some_command "${variable}" "${other_expr}" …
    ;;
  absolute)
    actions="relative"
    another_command "${actions}" "${other_expr}" …
    ;;
  *)
    error "Unexpected expression '${expression}'"
    ;;
esac
```

Simple commands may be put on the same line as the pattern *and* `;;` as long as the expression remains readable. This is often appropriate for single-letter option processing. When the actions don’t fit on a single line, put the pattern on a line on its own, then the actions, then `;;` also on a line of its own. When on the same line as the actions, use a space after the close parenthesis of the pattern and another before the `;;`.

```
verbose='false'
aflag=''
bflag=''
files=''
while getopts 'abf:v' flag; do
  case "${flag}" in
    a) aflag='true' ;;
    b) bflag='true' ;;
    f) files="${OPTARG}" ;;
    v) verbose='true' ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

```

### 变量表达式[](https://google.github.io/styleguide/shellguide.html#variable-expansion)

In order of precedence: Stay consistent with what you find; quote your variables; prefer `"${var}"` over `"$var"`.

These are strongly recommended guidelines but not mandatory regulation. Nonetheless, the fact that it’s a recommendation and not mandatory doesn’t mean it should be taken lightly or downplayed.

这些约定按照下面的优先顺序列出:

*   保留你发现的现有代码的一致性的地方
*   将你的变量引起来，请看”引用”这个章节
*   3. 不要对单个字符的shell特殊变量或者是位置参数使用括号引用，除非强烈需求或者是为了避免深层次的困惑，优先使用括号引用其它任何变量

优先使用大括号划分所有其他变量。

```sh
# Section of *recommended* cases.

# Preferred style for 'special' variables:
echo "Positional: $1" "$5" "$3"
echo "Specials: !=$!, -=$-, _=$_. ?=$?, #=$# *=$* @=$@ \$=$$ …"

# Braces necessary:
echo "many parameters: ${10}"

# Braces avoiding confusion:
# Output is "a0b0c0"
set -- a b c
echo "${1}0${2}0${3}0"

# Preferred style for other variables:
echo "PATH=${PATH}, PWD=${PWD}, mine=${some_var}"
while read -r f; do
  echo "file=${f}"
done < <(find /tmp)
```

```sh
# Section of *discouraged* cases

# Unquoted vars, unbraced vars, brace-delimited single letter
# shell specials.
echo a=$avar "b=$bvar" "PID=${$}" "${1}"

# Confusing use: this is expanded as "${1}0${2}0${3}0",
# not "${10}${20}${30}
set -- a b c
echo "$10$20$30"
```

NOTE: Using braces in `${var}` is *not* a form of quoting. “Double quotes” must be used *as well*.

### 引用[](https://google.github.io/styleguide/shellguide.html#quoting)

*   Always quote strings containing variables, command substitutions, spaces or shell meta characters, unless careful unquoted expansion is required or it’s a shell-internal integer (see next point).
*   Use arrays for safe quoting of lists of elements, especially command-line flags. See [Arrays](https://google.github.io/styleguide/shellguide.html#arrays) below.
*   Optionally quote shell-internal, readonly special variables that are defined to be integers: `$?`, `$#`, `$$`, `$!` (man bash). Prefer quoting of “named” internal integer variables, e.g. PPID etc for consistency.
*   Prefer quoting strings that are “words” (as opposed to command options or path names).
*   Never quote *literal* integers.
*   Be aware of the quoting rules for pattern matches in `[[ … ]]`. See the [Test, `[ … ]`, and `[[ … ]]`](https://google.github.io/styleguide/shellguide.html#tests) section below.
*   Use `"$@"` unless you have a specific reason to use `$*`, such as simply appending the arguments to a string in a message or log.

```
# 'Single' quotes indicate that no substitution is desired.
# "Double" quotes indicate that substitution is required/tolerated.

# Simple examples

# "quote command substitutions"
# Note that quotes nested inside "$()" don't need escaping.
flag="$(some_command and its args "$@" 'quoted separately')"

# "quote variables"
echo "${flag}"

# Use arrays with quoted expansion for lists.
declare -a FLAGS
FLAGS=( --foo --bar='baz' )
readonly FLAGS
mybinary "${FLAGS[@]}"

# It's ok to not quote internal integer variables.
if (( $# > 3 )); then
  echo "ppid=${PPID}"
fi

# "never quote literal integers"
value=32
# "quote command substitutions", even when you expect integers
number="$(generate_number)"

# "prefer quoting words", not compulsory
readonly USE_INTEGER='true'

# "quote shell meta characters"
echo 'Hello stranger, and well met. Earn lots of $$$'
echo "Process $$: Done making \$\$\$."

# "command options or path names"
# ($1 is assumed to contain a value here)
grep -li Hugo /dev/null "$1"

# Less simple examples
# "quote variables, unless proven false": ccs might be empty
git send-email --to "${reviewers}" ${ccs:+"--cc" "${ccs}"}

# Positional parameter precautions: $1 might be unset
# Single quotes leave regex as-is.
grep -cP '([Ss]pecial|\|?characters*)$' ${1:+"$1"}

# For passing on arguments,
# "$@" is right almost every time, and
# $* is wrong almost every time:
#
# * $* and $@ will split on spaces, clobbering up arguments
#   that contain spaces and dropping empty strings;
# * "$@" will retain arguments as-is, so no args
#   provided will result in no args being passed on;
#   This is in most cases what you want to use for passing
#   on arguments.
# * "$*" expands to one argument, with all args joined
#   by (usually) spaces,
#   so no args provided will result in one empty string
#   being passed on.
# (Consult `man bash` for the nit-grits ;-)

(set -- 1 "2 two" "3 three tres"; echo $#; set -- "$*"; echo "$#, $@")
(set -- 1 "2 two" "3 three tres"; echo $#; set -- "$@"; echo "$#, $@")
```

## 特性和bug[](https://google.github.io/styleguide/shellguide.html#features-and-bugs)

### ShellCheck[](https://google.github.io/styleguide/shellguide.html#shellcheck)

The [ShellCheck project](https://www.shellcheck.net/) identifies common bugs and warnings for your shell scripts. It is recommended for all scripts, large or small.

### Command Substitution[](https://google.github.io/styleguide/shellguide.html#command-substitution)

Use `$(command)` instead of backticks.

Nested backticks require escaping the inner ones with `\ `. The `$(command)` format doesn’t change when nested and is easier to read.

Example:

```sh
# This is preferred:
var="$(command "$(command1)")"
```

```sh
# This is not:
var="`command \`command1\``"
```

### Test, `[ … ]`, and `[[ … ]]`[](https://google.github.io/styleguide/shellguide.html#test----and---)

`[[ … ]]` is preferred over `[ … ]`, `test` and `/usr/bin/[`.

`[[ … ]]` reduces errors as no pathname expansion or word splitting takes place between `[[` and `]]`. In addition, `[[ … ]]` allows for regular expression matching, while `[ … ]` does not.

```
# This ensures the string on the left is made up of characters in
# the alnum character class followed by the string name.
# Note that the RHS should not be quoted here.
if [[ "filename" =~ ^[[:alnum:]]+name ]]; then
  echo "Match"
fi

# This matches the exact pattern "f*" (Does not match in this case)
if [[ "filename" == "f*" ]]; then
  echo "Match"
fi

```

```
# This gives a "too many arguments" error as f* is expanded to the
# contents of the current directory
if [ "filename" == f* ]; then
  echo "Match"
fi

```

For the gory details, see E14 at http://tiswww.case.edu/php/chet/bash/FAQ

### Testing Strings[](https://google.github.io/styleguide/shellguide.html#testing-strings)

Use quotes rather than filler characters where possible.

Bash is smart enough to deal with an empty string in a test. So, given that the code is much easier to read, use tests for empty/non-empty strings or empty strings rather than filler characters.

```
# Do this:
if [[ "${my_var}" == "some_string" ]]; then
  do_something
fi

# -z (string length is zero) and -n (string length is not zero) are
# preferred over testing for an empty string
if [[ -z "${my_var}" ]]; then
  do_something
fi

# This is OK (ensure quotes on the empty side), but not preferred:
if [[ "${my_var}" == "" ]]; then
  do_something
fi

```

```
# Not this:
if [[ "${my_var}X" == "some_stringX" ]]; then
  do_something
fi

```

To avoid confusion about what you’re testing for, explicitly use `-z` or `-n`.

```
# Use this
if [[ -n "${my_var}" ]]; then
  do_something
fi

```

```
# Instead of this
if [[ "${my_var}" ]]; then
  do_something
fi

```

For clarity, use `==` for equality rather than `=` even though both work. The former encourages the use of `[[` and the latter can be confused with an assignment. However, be careful when using `<` and `>` in `[[ … ]]` which performs a lexicographical comparison. Use `(( … ))` or `-lt` and `-gt` for numerical comparison.

```sh
# Use this
if [[ "${my_var}" == "val" ]]; then
  do_something
fi

if (( my_var > 3 )); then
  do_something
fi

if [[ "${my_var}" -gt 3 ]]; then
  do_something
fi
```

```sh
# Instead of this
if [[ "${my_var}" = "val" ]]; then
  do_something
fi

# Probably unintended lexicographical comparison.
if [[ "${my_var}" > 3 ]]; then
  # True for 4, false for 22.
  do_something
fi
```

### Wildcard Expansion of Filenames[](https://google.github.io/styleguide/shellguide.html#wildcard-expansion-of-filenames)

Use an explicit path when doing wildcard expansion of filenames.

As filenames can begin with a `-`, it’s a lot safer to expand wildcards with `./*` instead of `*`.

```
# Here's the contents of the directory:
# -f  -r  somedir  somefile

# Incorrectly deletes almost everything in the directory by force
psa@bilby$ rm -v *
removed directory: `somedir'
removed `somefile'

```

```
# As opposed to:
psa@bilby$ rm -v ./*
removed `./-f'
removed `./-r'
rm: cannot remove `./somedir': Is a directory
removed `./somefile'

```

### Eval[](https://google.github.io/styleguide/shellguide.html#eval)

`eval` should be avoided.

Eval munges the input when used for assignment to variables and can set variables without making it possible to check what those variables were.

```
# What does this set?
# Did it succeed? In part or whole?
eval $(set_my_variables)

# What happens if one of the returned values has a space in it?
variable="$(eval some_function)"

```

### Arrays[](https://google.github.io/styleguide/shellguide.html#arrays)

Bash arrays should be used to store lists of elements, to avoid quoting complications. This particularly applies to argument lists. Arrays should not be used to facilitate more complex data structures (see [When to use Shell](https://google.github.io/styleguide/shellguide.html#when-to-use-shell) above).

Arrays store an ordered collection of strings, and can be safely expanded into individual elements for a command or loop.

Using a single string for multiple command arguments should be avoided, as it inevitably leads to authors using `eval` or trying to nest quotes inside the string, which does not give reliable or readable results and leads to needless complexity.

```
# An array is assigned using parentheses, and can be appended to
# with +=( … ).
declare -a flags
flags=(--foo --bar='baz')
flags+=(--greeting="Hello ${name}")
mybinary "${flags[@]}"

```

```
# Don’t use strings for sequences.
flags='--foo --bar=baz'
flags+=' --greeting="Hello world"'  # This won’t work as intended.
mybinary ${flags}

```

```
# Command expansions return single strings, not arrays. Avoid
# unquoted expansion in array assignments because it won’t
# work correctly if the command output contains special
# characters.
declare -a files=($(ls /directory))
mybinary $(get_arguments)

```

#### Arrays Pros[](https://google.github.io/styleguide/shellguide.html#arrays-pros)

*   Using Arrays allows lists of things without confusing quoting semantics. Conversely, not using arrays leads to misguided attempts to nest quoting inside a string.
*   Arrays make it possible to safely store sequences/lists of arbitrary strings, including strings containing whitespace.

#### Arrays Cons[](https://google.github.io/styleguide/shellguide.html#arrays-cons)

Using arrays can risk a script’s complexity growing.

#### Arrays Decision[](https://google.github.io/styleguide/shellguide.html#arrays-decision)

Arrays should be used to safely create and pass around lists. In particular, when building a set of command arguments, use arrays to avoid confusing quoting issues. Use quoted expansion – `"${array[@]}"` – to access arrays. However, if more advanced data manipulation is required, shell scripting should be avoided altogether; see [above](https://google.github.io/styleguide/shellguide.html#when-to-use-shell).

### Pipes to While[](https://google.github.io/styleguide/shellguide.html#pipes-to-while)

Use process substitution or the `readarray` builtin (bash4+) in preference to piping to `while`. Pipes create a subshell, so any variables modified within a pipeline do not propagate to the parent shell.

The implicit subshell in a pipe to `while` can introduce subtle bugs that are hard to track down.

```
last_line='NULL'
your_command | while read -r line; do
  if [[ -n "${line}" ]]; then
    last_line="${line}"
  fi
done

# This will always output 'NULL'!
echo "${last_line}"

```

Using process substitution also creates a subshell. However, it allows redirecting from a subshell to a `while` without putting the `while`(or any other command) in a subshell.

```
last_line='NULL'
while read line; do
  if [[ -n "${line}" ]]; then
    last_line="${line}"
  fi
done < <(your_command)

# This will output the last non-empty line from your_command
echo "${last_line}"

```

Alternatively, use the `readarray` builtin to read the file into an array, then loop over the array’s contents. Notice that (for the same reason as above) you need to use a process substitution with `readarray` rather than a pipe, but with the advantage that the input generation for the loop is located before it, rather than after.

```
last_line='NULL'
readarray -t lines < <(your_command)
for line in "${lines[@]}"; do
  if [[ -n "${line}" ]]; then
    last_line="${line}"
  fi
done
echo "${last_line}"

```

> Note: Be cautious using a for-loop to iterate over output, as in `for var in $(...)`, as the output is split by whitespace, not by line. Sometimes you will know this is safe because the output can’t contain any unexpected whitespace, but where this isn’t obvious or doesn’t improve readability (such as a long command inside `$(...)`), a `while read` loop or `readarray` is often safer and clearer.

### Arithmetic[](https://google.github.io/styleguide/shellguide.html#arithmetic)

Always use `(( … ))` or `$(( … ))` rather than `let` or `$[ … ]` or `expr`.

Never use the `$[ … ]` syntax, the `expr` command, or the `let` built-in.

`<` and `>` don’t perform numerical comparison inside `[[ … ]]` expressions (they perform lexicographical comparisons instead; see [Testing Strings](https://google.github.io/styleguide/shellguide.html#testing-strings)). For preference, don’t use `[[ … ]]` *at all* for numeric comparisons, use `(( … ))` instead.

It is recommended to avoid using `(( … ))` as a standalone statement, and otherwise be wary of its expression evaluating to zero

*   particularly with `set -e` enabled. For example, `set -e; i=0; (( i++ ))` will cause the shell to exit.

```
# Simple calculation used as text - note the use of $(( … )) within
# a string.
echo "$(( 2 + 2 )) is 4!?"

# When performing arithmetic comparisons for testing
if (( a < b )); then
  …
fi

# Some calculation assigned to a variable.
(( i = 10 * j + 400 ))

```

```
# This form is non-portable and deprecated
i=$[2 * 10]

# Despite appearances, 'let' isn't one of the declarative keywords,
# so unquoted assignments are subject to globbing wordsplitting.
# For the sake of simplicity, avoid 'let' and use (( … ))
let i="2 + 2"

# The expr utility is an external program and not a shell builtin.
i=$( expr 4 + 4 )

# Quoting can be error prone when using expr too.
i=$( expr 4 '*' 4 )

```

Stylistic considerations aside, the shell’s built-in arithmetic is many times faster than `expr`.

When using variables, the `${var}` (and `$var`) forms are not required within `$(( … ))`. The shell knows to look up `var` for you, and omitting the `${…}` leads to cleaner code. This is slightly contrary to the previous rule about always using braces, so this is a recommendation only.

```
# N.B.: Remember to declare your variables as integers when
# possible, and to prefer local variables over globals.
local -i hundred=$(( 10 * 10 ))
declare -i five=$(( 10 / 2 ))

# Increment the variable "i" by three.
# Note that:
#  - We do not write ${i} or $i.
#  - We put a space after the (( and before the )).
(( i += 3 ))

# To decrement the variable "i" by five:
(( i -= 5 ))

# Do some complicated computations.
# Note that normal arithmetic operator precedence is observed.
hr=2
min=5
sec=30
echo $(( hr * 3600 + min * 60 + sec )) # prints 7530 as expected

```

## Naming Conventions[](https://google.github.io/styleguide/shellguide.html#naming-conventions)

### Function Names[](https://google.github.io/styleguide/shellguide.html#function-names)

Lower-case, with underscores to separate words. Separate libraries with `::`. Parentheses are required after the function name. The keyword `function` is optional, but must be used consistently throughout a project.

If you’re writing single functions, use lowercase and separate words with underscore. If you’re writing a package, separate package names with `::`. Braces must be on the same line as the function name (as with other languages at Google) and no space between the function name and the parenthesis.

```
# Single function
my_func() {
  …
}

# Part of a package
mypackage::my_func() {
  …
}

```

The `function` keyword is extraneous when “()” is present after the function name, but enhances quick identification of functions.

### Variable Names[](https://google.github.io/styleguide/shellguide.html#variable-names)

As for function names.

Variables names for loops should be similarly named for any variable you’re looping through.

```
for zone in "${zones[@]}"; do
  something_with "${zone}"
done

```

### Constants and Environment Variable Names[](https://google.github.io/styleguide/shellguide.html#constants-and-environment-variable-names)

All caps, separated with underscores, declared at the top of the file.

Constants and anything exported to the environment should be capitalized.

```
# Constant
readonly PATH_TO_FILES='/some/path'

# Both constant and environment
declare -xr ORACLE_SID='PROD'

```

Some things become constant at their first setting (for example, via getopts). Thus, it’s OK to set a constant in getopts or based on a condition, but it should be made readonly immediately afterwards. For the sake of clarity `readonly` or `export` is recommended instead of the equivalent `declare` commands.

```
VERBOSE='false'
while getopts 'v' flag; do
  case "${flag}" in
    v) VERBOSE='true' ;;
  esac
done
readonly VERBOSE

```

### Source Filenames[](https://google.github.io/styleguide/shellguide.html#source-filenames)

Lowercase, with underscores to separate words if desired.

This is for consistency with other code styles in Google: `maketemplate` or `make_template` but not `make-template`.

### Read-only Variables[](https://google.github.io/styleguide/shellguide.html#read-only-variables)

Use `readonly` or `declare -r` to ensure they’re read only.

As globals are widely used in shell, it’s important to catch errors when working with them. When you declare a variable that is meant to be read-only, make this explicit.

```
zip_version="$(dpkg --status zip | grep Version: | cut -d ' ' -f 2)"
if [[ -z "${zip_version}" ]]; then
  error_message
else
  readonly zip_version
fi

```

### Use Local Variables[](https://google.github.io/styleguide/shellguide.html#use-local-variables)

Declare function-specific variables with `local`. Declaration and assignment should be on different lines.

Ensure that local variables are only seen inside a function and its children by using `local` when declaring them. This avoids polluting the global name space and inadvertently setting variables that may have significance outside the function.

Declaration and assignment must be separate statements when the assignment value is provided by a command substitution; as the`local` builtin does not propagate the exit code from the command substitution.

```
my_func2() {
  local name="$1"

  # Separate lines for declaration and assignment:
  local my_var
  my_var="$(my_func)"
  (( $? == 0 )) || return

  …
}

```

```
my_func2() {
  # DO NOT do this:
  # $? will always be zero, as it contains the exit code of 'local', not my_func
  local my_var="$(my_func)"
  (( $? == 0 )) || return

  …
}

```

### Function Location[](https://google.github.io/styleguide/shellguide.html#function-location)

Put all functions together in the file just below constants. Don’t hide executable code between functions. Doing so makes the code difficult to follow and results in nasty surprises when debugging.

If you’ve got functions, put them all together near the top of the file. Only includes, `set` statements and setting constants may be done before declaring functions.

### main[](https://google.github.io/styleguide/shellguide.html#main)

A function called `main` is required for scripts long enough to contain at least one other function.

In order to easily find the start of the program, put the main program in a function called `main` as the bottom most function. This provides consistency with the rest of the code base as well as allowing you to define more variables as `local` (which can’t be done if the main code is not a function). The last non-comment line in the file should be a call to `main`:

```
main "$@"

```

Obviously, for short scripts where it’s just a linear flow, `main` is overkill and so is not required.

## 命令调用[](https://google.github.io/styleguide/shellguide.html#calling-commands)

### 检查返回值[](https://google.github.io/styleguide/shellguide.html#checking-return-values)

总是应该检查返回值，给出返回值相关的信息．

对于一个未使用管道的命令，可以使用$?或者直接指向if语句来检查其返回值.

例子:

```
if ! mv "${file_list[@]}" "${dest_dir}/"; then
  echo "Unable to move ${file_list[*]} to ${dest_dir}" >&2
  exit 1
fi

# Or
mv "${file_list[@]}" "${dest_dir}/"
if (( $? != 0 )); then
  echo "Unable to move ${file_list[*]} to ${dest_dir}" >&2
  exit 1
fi

```

Bash also has the `PIPESTATUS` variable that allows checking of the return code from all parts of a pipe. If it’s only necessary to check success or failure of the whole pipe, then the following is acceptable:

```
tar -cf - ./* | ( cd "${dir}" && tar -xf - )
if (( PIPESTATUS[0] != 0 || PIPESTATUS[1] != 0 )); then
  echo "Unable to tar files to ${dir}" >&2
fi

```

However, as `PIPESTATUS` will be overwritten as soon as you do any other command, if you need to act differently on errors based on where it happened in the pipe, you’ll need to assign `PIPESTATUS` to another variable immediately after running the command (don’t forget that `[` is a command and will wipe out `PIPESTATUS`).

```
tar -cf - ./* | ( cd "${DIR}" && tar -xf - )
return_codes=( "${PIPESTATUS[@]}" )
if (( return_codes[0] != 0 )); then
  do_something
fi
if (( return_codes[1] != 0 )); then
  do_something_else
fi

```

### 内置命令 vs 外部命令[](https://google.github.io/styleguide/shellguide.html#builtin-commands-vs-external-commands)

调用 shell 内置命令和调用一个单独的进程在两者这件做出选择，选择调用内置命令．

我更喜欢使用内置命令，例如函数参数扩展 (bash(1)),它更加健壮和更可一致性．(尤其和像sed想比较而言)

例子:

```
# Prefer this:
addition=$(( ${X} + ${Y} ))
substitution="${string/#foo/bar}"
```

```
# Instead of this:
addition="$(expr ${X} + ${Y})"
substitution="$(echo "${string}" | sed -e 's/^foo/bar/')"
```

## 总结[](https://google.github.io/styleguide/shellguide.html#conclusion)

运用常识，保持始终如一。

请花几分钟阅读下google code style [C++ Guide](https://google.github.io/styleguide/cppguide.html#Parting_Words) 的Parting words章节. .

修订版 2.02

## 参考

中文翻译基于 https://google.github.io/styleguide/shellguide.html

https://yq.aliyun.com/articles/55699

https://www.cnblogs.com/zhouhappy88/p/7529961.html
