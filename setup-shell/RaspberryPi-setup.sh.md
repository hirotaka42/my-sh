#RaspberryPi Setup Shell Script

##Installation

` sh -c "$(curl -fsSL https://raw.githubusercontent.com/hirotaka42/my-sh/main/setup-shell/RaspberryPi-setup.sh)"`

##Overview

RaspberryPiの初期設定をシェルスクリプトにまとめました

Desktop版を選択すると以下がダウンロードされます.
CLI版との違いはこれだけです.

- vscode
- fcitx-mozc(日本語入力)


質問は以下の3つ

- RaspberryPi Desktop版の設定を実行しますか? (y/N)
    - Yを選択すると `Desktop版`の設定になります. 
    - Nを選択すると `CLI版`の設定になります. 
- ネットワーク設定を実行しますか? (y/N)
    - Yを選択すると スクリプト内に記述してあるIP,DNS,ルータ,ホストネームが設定されます
- プロンプトの設定をしますか? (y/N)
    - Yを選択すると `zsh`,`starship`,`NerdFonts`が設定されます