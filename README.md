~/.bash_aliases
というファイルを作ればおのずと読み込まれるので、ここに以下の文を追加して使ってね

```
ALIASES_FILES=<このフォルダを指定>
source ${ALIASES_FILES}/setup_for_aws.bash
source ${ALIASES_FILES}/setup_for_builder.bash
```
