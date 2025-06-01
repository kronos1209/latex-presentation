# LaTeX + プレゼンテーション

# 概要

LaTeX を利用してプレゼンテーション用の pdf を作成する方法をまとめる

# 環境

ここでは以下のような環境で LaTeX + プレゼンテーション用の pdf を作成することを想定する

- WSL on Windows 
  -  Ubuntu24.04
- VSCode + LaTeX Workshop

# 手順

## LaTeX のインストール

以下コマンドでインストールする

> 以下のコマンドだと不要なパッケージのインストールされるため日本語に必要なパッケージのみをインストールできるように調整したい

```bash
# 必要なもののインストール
# 一段目は日本語対応の LuaLaTex のインストール
# 二段名はユーティリティのインストール
sudo apt install \
    texlive-lang-japanese texlive-latex-extra texlive-luatex \
    latexmk texlive-extra-utils
```

## .latexmkrc でどのようにコンパイルするか設定

以下のような設定を行う `.latexmkrc` を作成

- lualatex を利用して .tex をコンパイルする
- out ディレクトリに出力ファイルを生成する

```latexmk
$latex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';
$out_dir = 'out';
```

## VSCode の設定

インストールしていない場合は以下拡張機能をインストールする

- LaTeX Workshop

拡張機能をインストールしたら LaTeX Workshop の設定を行う


```jsonc
{
    // レシピ定義
    "latex-workshop.latex.recipes": [
        {
            "name": "latexmk(lualatex)",
            "tools": [
                "latexmk-lualatex"
            ]
        }
    ],
    // タスク定義
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk-lualatex",
            "command": "latexmk",
            // "args": [
            //     "-interaction=nonstopmode",
            //     "-synctex=1",
            //     "%DOC%"
            // ]
        }
    ],
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.latex.autoBuild.run": "onSave", // 保存時にコンパイルする
    "latex-workshop.formatting.latex": "latexindent",   // フォーマッターの設定
    "latex-workshop.latex.outDir": "%DIR%/out"  // 出力ファイルがどこにあるかを指定する。これがないとプレビューがうまく表示されない
}
```

## (optional) Rust のコードのハイライトを設定を行う

`listings` パッケージはコードブロックを記述するためのパッケージだが、
デフォルトだと Rust のハイライトに対応していない.

そのため、ハイライト設定を自分で作成する必要がある。
ベースは [listings-rust](https://github.com/denki/listings-rust) のスタイルを利用しているが、
少し期待したものと違っていたため以下設定を追加している

```
% Markdown での Rust のハイライトのようなスタイルを設定する
% ==================================================
% highlight settings for Rust code like Markdown
\usepackage{xcolor}
\definecolor{keywordcolor}{RGB}{0,0,192}     % keywords: 青
\definecolor{typecolor}{RGB}{0,128,0}        % types: 緑
\definecolor{macrocolor}{RGB}{128,0,128}     % macros: 紫
\definecolor{stringcolor}{RGB}{163,21,21}    % 文字列: 赤系
\definecolor{commentcolor}{RGB}{106,153,85}  % コメント: 緑系（VSCode風）
\definecolor{bgcolor}{RGB}{245,245,245}      % 背景色: 明るいグレー

\lstdefinestyle{mdRust}{
    language=Rust,
    basicstyle=\ttfamily\footnotesize,
    keywordstyle=\color{keywordcolor}\bfseries,
    keywordstyle=[2]\color{typecolor},
    keywordstyle=[3]\color{typecolor},
    keywordstyle=[4]\color{typecolor},
    keywordstyle=[5]\color{macrocolor},
    stringstyle=\color{stringcolor},
    commentstyle=\color{commentcolor}\itshape,
    backgroundcolor=\color{bgcolor},
    breaklines=true,
    frame=single,
    showstringspaces=false,
    columns=fullflexible,
    numbers=left,
    numberstyle=\tiny\color{gray},
    numbersep=5pt,
    xleftmargin=15pt
}
```

設定手順としては 

1. /home/{USER}/texmf/tex/latex/listings-rust というディレクトリを作成する
2. listtings-rust ディレクトリ内に listings-rust.sty を作成
   1. 内容は [listings-rust](https://github.com/denki/listings-rust) の .sty と上で追加した設定を記述する
3. listings-rust ディレクトリ内で `mktexlsr .` を実行する
   1. これにより LaTeX が追加したパッケージを認識できるようになる
4. .tex ファイル内で `\usepackage{listings,listings-rust}` 

# よくあるシチュエーション

## 警告：Overfull \vbox or \hbox

確保している領域を超えてしまっていおり、もしかしたら正常に表示されていない可能性がある

- コードブロックなどが途中までしか表示されていない

## コードブロックを入れたい

`\begin{frane}` に [fragile] オプションをつける。
fragile オプションをつけることでこのスライド内では入力したテキスト通りに LaTex が出力してくれるようになる。

これをつけないとコードブロック内で特殊文字 ('[','{' など)を利用した場合にうまくビルドが通らない