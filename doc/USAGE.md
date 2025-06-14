# Usage

# TODO

ドキュメントの拡充

# 概要

よく使うパッケージの使い方などをまとめる予定の場所

# beamer 

LaTeX でスライドを作成するために利用するパッケージ

使い方は以下リンクあたりを参考にする

https://www.overleaf.com/learn/latex/Beamer

# 利用例

```latex
% ドキュメントクラスとして beamer を指定する
% aspectratio はアスペクト比を指定することができるいオプションで、
\documentclass[aspectratio=169]{beamer}

\begin{document}

% 
\begin{frame}[options]
\frametitle{Slide Title}

Here is content parts

\end{frame}

\end{document}
```

# lstlisting

コードブロックを記述するためのパッケージです。

# tabular

表を記述するためのパッケージです。

# itemize

リストを記述するためのパッケージです。

# tikz-uml

tikz-uml は latex で uml 図を作成するために利用するパッケージです。
tikz-uml のスタイルファイルはデフォルトでは入っていなかったため、`/style/tikz-uml` 以下にスタイルファイルを配置しています。

.tex ファイルからは `/style/tikz-uml/tikz-uml` を usepackage で読み込んでください。

## 使い方

TODO: 下記ドキュメントからざっくりした使い方をまとめる

[tikz-uml の公式ドキュメント](https://perso.ensta-paris.fr/~kielbasi/tikzuml/var/files/doc/tikzumlmanual.pdf)