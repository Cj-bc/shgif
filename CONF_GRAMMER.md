# grammer for `*.shgif` file

the `*.shgif` file define how the srcs will be rendered.
There's only few grammers for this.

## 1. main functions

  * `sleep <int sec> -- sleep for <sec> seconds. `sleep` command is called inside
  * `<int x> <int y> <string file_name> -- display the <file_name> at (<x>, <y>). `src/` is not needed to be written.
  * Other lines are ignored for now. In the future, *comment* will be `# <comment>`, so if you want to comment something,
    It's better to start with `#`
