# my-sh

セットアップ用のシェルスクリプト

# 概要
RaspberryPiOSの初期セットアップをシェルスクリプトに落とし込みワンライナーとして実行できます.


# ディレクトリ説明


- my-sh/config/fcitx/
  - RaspberryPiOS用のキーボード設定ファイル(US用の日本語切り替え)
- my-sh/dotfiles/
  - starship.toml (プロント設定ファイル)
  - zshrc (.zshrc zsh設定ファイル)
- my-sh/setup-shell/
  - RaspberryPi-setup.sh (RaspberryPiOS向け設定シェルスクリプト本体)
  - install.sh (実行ファイル)
  
# Description

```bash:
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hirotaka42/my-sh/main/setup-shell/install.sh)"
```

RaspberryPiの初期設定をシェルスクリプトにまとめました
Desktop版とCLI版を選択でき,Desktop版では以下も設定されます. 

- vscode
- fcitx-mozc(日本語入力)

質問は以下の3つ

- RaspberryPi Desktop版の設定を実行しますか? (y/N)
  - Yを選択すると Desktop版の設定になります.
  - Nを選択すると CLI版の設定になります.
- ネットワーク設定を実行しますか? (y/N)
  - Yを選択すると スクリプト内に記述してあるIP,DNS,ルータ,ホストネームが設定されます
- プロンプトの設定をしますか? (y/N)
  - Yを選択すると zsh,starship,NerdFontsが設定されます
