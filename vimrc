" vundle 安装 git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
":PluginInstall
set nocompatible
filetype off
set runtimepath+=/home/dingjing/.vim/vim_runtime/
set rtp+=/home/dingjing/.vim/bundle/Vundle.vim/
hi clear
syntax off
syntax reset
syntax on
retab                                           " 以前的tab也用4空格代替
set nu
set expandtab                                   " 空格替换tab
set exrc
set secure
set cindent                                     " c 自动缩进
set ruler
set magic
set showmatch
set hlsearch
set cursorline                                  " 光标行
set cursorcolumn                                " 光标列
set autoread                                    " 自动检测外部更改
set autowrite
set autoindent
set noswapfile                                  " 禁止生成临时文件
set ignorecase
set tabstop=4	                                " 空格替换一个tab
set shiftwidth=4	                            " 自动缩进4
set softtabstop=4	                            " 自动缩进4
set laststatus=2
set encoding=utf-8                              " 编码设置
set langmenu=zn_CN.UTF-8                        " 语言设置
set helplang=cn                                 " 语言设置
set foldenable                                  " 允许折叠
set foldmethod=syntax                           " 按语法折叠
set foldcolumn=2                                " 折叠区域宽度
set backspace=indent,eol,start                  " 设置退格删除
set guifont=Courier_New:h9:cANSI
set clipboard+=unnamed                          " 共享粘贴板
set fileencoding=utf-8

" 按住 shift 再鼠标右键
if has('mouse')
set mouse-=a                                    " 使用鼠标
endif

let g:go_version_warning = 0                    " 去除版本信息警告

language message zh_CN.UTF-8

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'                   " vim 插件管理
Plugin 'vim-airline/vim-airline'                " 底栏信息
Plugin 'tpope/vim-markdown.git'                 " markdown 编辑器
Plugin 'scrooloose/syntastic'                   " 语法高亮与错误检查
Plugin 'terryma/vim-multiple-cursors'           " 多行编辑
Plugin 'tpope/vim-fugitive'                     " github 操作 :Git commit, :Git rebase -1, Git mergetool, Gdiffsplit
Plugin 'scrooloose/nerdtree'                    " 侧边栏文件
Plugin 'valloric/youcompleteme'                 " C/C++自动补全
Plugin 'ozelentok/denite-gtags'                 " gtags 代码跳转
Plugin 'szw/vim-tags'                           " 自动生成 ctag 文件
Plugin 'craigemery/vim-autotag'                 " 修改代码后自动更新 tag 标签文件
Plugin 'majutsushi/tagbar'                      " 自动显示 ctars 生成的标签
Plugin 'linux-environment/vim-gutentags'        " 自动更新 ctag

call vundle#end()

nnoremap <C-c> :call multiple_cursors#quit()<CR>
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
filetype plugin indent on

"""""""""""""""""""""""""""""" 插件配置 """""""""""""""""""""""""""""""""""""""""
" vim-gutentags 配置
" 使用说明: 
"   ctrl + ]        -- 跳转到对应定义位置
"   ctrl + o        -- 回退到原来位置
"   ctrl - w + ]    -- 新窗口预览定义
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']    " 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_ctags_tagfile = '.tags'                                 " 生成数据文件的名称
let s:vim_tags = expand('~/.cache/tags')                                " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = s:vim_tags                                  " 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']    " 配置 ctags 的参数
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxIi']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" c 语言插件 
let g:C_UseTool_cmake = 'no'
let g:C_UseTool_doxygen = 'no'

" c 语言自动补全 youcompleteme
let g:ycm_global_ycm_extra_conf = '/home/dingjing/.vim/bundle/youcompleteme/third_party/ycmd/.ycm_extra_conf.py'    " 默认配置

" vim-tags 用于生成 tag 的标签文件
set exrc
set secure
let g:vim_tags_auto_generate = 1                                                                                    " 开启此插件
let g:vim_tags_use_vim_dispatch = 1                                                                                 " 异步生成标签
let g:vim_tags_use_language_field = 1                                                                               " 配合 YouCompleteMe 插件使用
let g:vim_tags_main_file = 'tags'                                                                                   " ctag 的名字
let g:vim_tags_ctags_binary = '/usr/bin/ctags'                                                                      " 指定 ctags 的命令
let g:vim_tags_ignore_file_comment_pattern = '^(#|"|//|/*|*/)'                                                      " 忽略注释
let g:vim_tags_directories = [".git", ".hg", ".svn", ".pro", "Makefile", "CVS", "."]                                " 查找类似文件,作为根目录
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', '.*']                                      " 忽略的文件
let g:vim_tags_project_tags_command = "{CTAGS} -R {OPTIONS} {DIRECTORY} 2>/dev/null"                                " 生成 ctags
let g:vim_tags_gems_tags_command = "{CTAGS} -R {OPTIONS} bundle show --paths 2>/dev/null"                           " 默认

" 手动 ctags 生成, (1) ctags -R . (2) ctrl + ] 到定义的位置 ctrl + t 返回
let g:autotagStartMethod = 'fork'

" astyle
map <F2> :%!astyle --style=kr<CR>

" tagbar 
nmap <F8> :TagbarToggle <CR>        " 打开/关闭 ctags 生成的标签窗口

" 侧边栏文件 nerdtree 打开目录时候自动运行
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" 多行编辑
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
let g:multi_cursor_start_word_key      = '<C-n>'    " 选中后按 ctrl + n 竖直编辑
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" airline 漂亮的底栏
let g:airline#extensions#tabline#enabled = 1                " 路径
let g:airline#extensions#tabline#formatter = 'unique_tail'  " 路径展示

" markdown 编辑
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 1
let g:markdown_minlines = 100


" 设置文件头信息
autocmd BufNewFile *.* exec ":call SetFileTitle()"
func SetFileTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# -*- coding=utf-8 -*-")
        call append(line(".")+1, "")
    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
    elseif &filetype == 'md'
        call setline(1, "")
    elseif &filetype == 'asm'
        call setline(1,"########################################################")
        call append(line("."), "# FileName     : ".expand("%"))
        call append(line(".")+1, "# Author       : DingJing")
        call append(line(".")+2, "# Mail         : dingjing@live.cn")
        call append(line(".")+3, "# Created Time : ".strftime("%c"))
        call append(line('.')+4, "########################################################")
    else
        call setline(1,"/*************************************************************************")
        call append(line("."),      "> FileName: ".expand("%"))
        call append(line(".")+1,    "> Author  : DingJing")
        call append(line(".")+2,    "> Mail    : dingjing@live.cn")
        call append(line(".")+3,    "> Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+5, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+6, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
endfunc

autocmd BufNewFile * normal G

" 设置文件头--结束
" 记住上次打开的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

