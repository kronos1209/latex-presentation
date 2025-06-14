$latex = 'lualatex -shell-escape -interaction=nonstopmode -synctex=1 -file-line-error %O %S';
$out_dir = '/workspace/out';
$makeindex = 'mendex $O -U -o %D %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'bibtexu %O %B';
$pdf_mode = 4;
$lualatex = 'lualatex %O -shell-escape -file-line-error -synctex=1 -interaction=nonstopmode %S';
$max_repeat = 5;
$pdf_previewer = 'start evince';

# 環境変数のセット
$ENV{'TEXINPUTS'} = '/workspace/style//:';