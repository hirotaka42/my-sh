##概要
プロントをカスタマイズするシェルスクリプト

- install Zsh. & change the shell.
- install 'cross-shell Prompt starship'.
- Setting 'starship.toml'

##一括実行 Linux

```bash:一括実行
echo '-------------------------' && \
echo '0 ) install & change the shell ' && \
sudo apt install zsh -y && \
chsh -s /bin/zsh

echo '-------------------------' && \
echo '1 ) install starship' && \
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
eval "$(starship init zsh)" && \
echo '-------------------------' && \
echo '2 ) Setting starship.toml' && \
mkdir ~/.config && touch ~/.config/starship.toml && \
ln -fs "$HOME/Github/my-sh/dotfiles/starship.toml" "$HOME/.config/starship.toml" && \
echo '-------------------------' && \
echo '3 ) install NerdFonts' && \
mkdir -p ~/.local/share/fonts && \
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

##00. )  How to change bash to zsh

```
sudo apt install zsh -y 
```

シェルの変更のコマンドはchshコマンド(change shell)を用います。
```
chsh -s /bin/zsh
```
ここで、-sオプションを付けることでシェルを指定して変更できます。
これを入力後パスワードを聞かれるのでPCログイン時のパスワードを打って成功したのち、一旦ターミナルを切って再度立ち上げるとzshなっていることが確認できると思います。

##01. )  Starship のバイナリをインストール

[Startshipについて](https://starship.rs/ja-jp/guide/)

###最新版のインストール
ビルド済みのバイナリをインストール

```
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
```

Starship自体を更新するには、上記のスクリプトを再度実行してください。 最新のバージョンに置き換わり、設定ファイルには変更を加えません。

パッケージマネージャー経由でインストール
###Homebrew (https://brew.sh/)の場合：
```
brew install starship
``` 
    
###coop  (https://scoop.sh/)の場合：
```
scoop install starship
```

##02. ) 初期化のためのスクリプトをシェルの設定ファイルに追加

###Bash
`~/.bashrc `の最後に以下を追記してください
```
~/.bashrc
eval "$(starship init bash)"
```
 
###Fish
`~/.config/fish/config.fish `の最後に以下を追記してください

```
# ~/.config/fish/config.fish
starship init fish | source
```
    
###Zsh
`~/.zshrc `の最後に以下を追記してください
```
# ~/.zshrc
eval "$(starship init zsh)"
```

###PowerShell
`Microsoft.PowerShell_profile.ps1 `の最後に以下を追記してください。 PowerShell 上で $PROFILE 変数を問い合わせると、ファイルの場所を確認できます。 通常、パスは `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 `または -Nix 上では `~/.config/powershell/Microsoft.PowerShell_profile.ps1 `です。

```
Invoke-Expression (&starship init powershell)
```

###Setting

[手軽に導入できるStarshipでプロンプトをおしゃれにする](https://dev.classmethod.jp/articles/customize-prompt-with-starship/)

starship.tomlに設定値を記載し指定のディレクトリに配置することでカスタマイズすることができます。

```
mkdir ~/.config && touch ~/.config/starship.toml
```
実体ファイルをdotfilesに配置し~/.configにはシンボリックリンクを作っておきます。

```
ln -fs "$HOME/Github/my-sh/dotfiles/starship.toml" "$HOME/.config/starship.toml"
```

シンボリックリンクを解除するには`unlink`する
```
unlink $HOME/.config/starship.toml
```

##03. ) install NerdFonts

[NerdFonts](https://github.com/ryanoasis/nerd-fonts)
[NerdFonts - Linux](https://github.com/ryanoasis/nerd-fonts#linux)

```
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

