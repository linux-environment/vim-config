" vundle 安装 git clone https://github.com/linux-environment/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
":PluginInstall     -- 安装插件
":PluginUpdate      -- 更新插件
":PluginClean       -- 删除未使用插件

set nocompatible
filetype off
"set runtimepath+=/etc/vim/vim_runtime/
set rtp+=/etc/vim/bundle/Vundle.vim/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'                   " vim 插件管理
Plugin 'linux-environment/vim-airline'          " 底栏信息; bn 切换到下一个文件, bp 切换到上一个文件
Plugin 'linux-environment/syntastic'            " 语法高亮与错误检查
Plugin 'linux-environment/vim-multiple-cursors' " 多行编辑; 选中多行后按 Ctrl+n 即可进入多行编译
Plugin 'linux-environment/vim-fugitive'         " github 操作 :Git commit, :Git rebase -1, Git mergetool, Gdiffsplit
Plugin 'linux-environment/nerdtree'             " 侧边栏文件
Plugin 'linux-environment/completor.vim'        " 自动补全插件
Plugin 'linux-environment/vim-gutentags'        " 自动更新 ctag
Plugin 'linux-environment/rainbow_parentheses'  " 成对括号
Plugin 'linux-environment/vim-commentary'       " 多行注释
Plugin 'linux-environment/gruvbox'              " 主题颜色
Plugin 'linux-environment/vim-indent-guides'    " 缩进显示
Plugin 'linux-environment/ferret'               " 多文件搜索; 执行： Ack xxx 即可搜索

Plugin 'ycm-core/YouCompleteMe'                 " C/C++自动补全
call vundle#end()

hi clear
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
set tabstop=4                                   " 空格替换一个tab
set shiftwidth=4                                " 自动缩进4
set softtabstop=4                               " 自动缩进4
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
set background=dark                             " 使用黑色主题

" 按住 shift 再鼠标右键
if has('mouse')
set mouse-=a                                    " 使用鼠标
endif

filetype plugin indent on

let g:go_version_warning = 0                    " 去除版本信息警告

language message zh_CN.UTF-8

nnoremap <C-c> :call multiple_cursors#quit()<CR>
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse

vnoremap <C-y> "+y                              " 支持在Visual模式下，通过C-y复制到系统剪切板

"""""""""""""""""""""""""""""" 插件配置 """""""""""""""""""""""""""""""""""""""""
" vim-airline 漂亮的底栏
let g:airline#extensions#tabline#enabled = 1                " 路径
let g:airline#extensions#tabline#formatter = 'unique_tail'  " 路径展示
nnoremap <C-p> :bp<CR>                          " ctrl + p 上一个Buffer文件

" vim-multiple-cursors 多行编辑
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

" nerdtree 打开目录时候自动运行
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc()==1&&isdirectory(argv()[0])&&!exists("s:std_in")|exe 'NERDTree' argv()[0]|wincmd p|ene|exe 'cd '.argv()[0]|endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" c/c++ 语言自动补全 youcompleteme
let g:ycm_log_level = 'debug'                                           " 日志级别 debug info
let g:ycm_keep_logfiles = 0
"   1. 先进入 ~/.vim/youcompleteme/下并执行 install.py --all --clangd-completer
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'           " 默认配置
let g:ycm_key_invoke_completion='<C-/>'
let g:ycm_goto_buffer_command='new-or-existing-tab'                     " open new tabe when jump to definition
let g:ycm_max_diagnostics_to_display = 0                                " 诊断报错
let g:ycm_use_clangd = 1
let g:ycm_clangd_binary_path = '/usr/bin/clangd'
let g:ycm_clangd_uses_ycmd_caching = 1
let g:ycm_auto_trigger = 1                                              " 0:关闭补全触发器; 1:打开语义补全触发器
let g:ycm_confirm_extra_conf = 0                                        " 允许自动加载 .ycm_extra_conf.py
let g:ycm_max_num_candidates = 20                                       " 语义补全最大候选数量
let g:ycm_show_diagnostics_ui = 10240                                   "
let g:ycm_add_preview_to_completeopt = 1                                " 为当前补全选项在vim顶部窗口增加预览窗口，用来显示函数原型
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_min_num_of_chars_for_completion = 1                           " 触发补全的最小字符数
let g:ycm_update_diagnostics_in_insert_mode = 1
let g:ycm_collect_identifiers_from_tag_files = 1
let g:ycm_min_num_identifier_candidate_chars = 0                        " 候选补全列表中显示的最小字符数
let g:ycm_collect_identifiers_from_tags_files = 1                       " 开启tags补全引擎
let g:ycm_filepath_completion_use_working_dir = 0                       " 按照文件所在目录解释相对路径
let g:ycm_disable_for_files_larger_than_kb = 10240000                   " 大于 xxxkb 不再自动补全
let g:ycm_autoclose_preview_window_after_insertion = 1                  " close preview window after leaving insert mode
let g:ycm_autoclose_preview_window_after_completion = 1                 " 选中补全后自动关闭预览窗口
let g:ycm_filetype_whitelist = {'*' : 1}                                " 文件类型白名单
let g:ycm_filetype_blacklist = 
  \ {'md' : 1}  
  \                                                                     " 黑名单
let g:ycm_error_symbol = '>>'                                           " 错误提示符号
let g:ycm_warning_symbol = '>>'                                         " 警告提示符号
let g:ycm_echo_current_diagnostic = 1                                   " 打开错误提示
let g:ycm_echo_current_diagnostic = 'virtual-text'                      " 错误提示信息
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }


nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jdf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jdc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>st :YcmCompleter GetType<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" completor.vim 自动补全插件配置
" c/c++ 配置，使用 clang 补全
" 另外 可以在项目根目录下创建 .clang_complete 然后加入配置:
"   -std=c++11
"   -I/path/to/include1/
"   -I/path/to/include2/
let g:completor_clang_binary = '/usr/bin/clang'
let g:completor_auto_trigger = 1                                        " 自动打开补全


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

" rainbow_parentheses 成对括号
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 36
let g:rbpt_loadcmd_toggle = 1
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au VimEnter * RainbowParenthesesLoadSquare
au VimEnter * RainbowParenthesesLoadBraces
au VimEnter * RainbowParenthesesLoadChevrons

" vim-commentary
" 使用方法
"   gcc 注释一行
"   选中 + gc 注释和取消注释

" gruvbox 主题颜色 
colorscheme gruvbox

" vim-indent-guides 缩进显示
let g:indent_guides_enable_on_vim_startup = 1
" au VimEnter * IndentGuidesEnable

" ferret 多文件搜索
" 使用方法
"   在 vim 命令模式下执行 :Ack <要搜索的字符串>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" c 语言插件 
let g:C_UseTool_cmake = 'no'
let g:C_UseTool_doxygen = 'no'


" 手动 ctags 生成, (1) ctags -R . (2) ctrl + ] 到定义的位置 ctrl + t 返回
let g:autotagStartMethod = 'fork'



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
    elseif &filetype == 'js'
        call setline(1, "")
    elseif &filetype == 'html'
        call setline(1, "")
    elseif &filetype == 'asm'
        call setline(1,"########################################################")
        call append(line("."), "# FileName     : ".expand("%"))
        call append(line(".")+1, "# Author       : DingJing")
        call append(line(".")+2, "# Mail         : dingjing@live.cn")
        call append(line(".")+3, "# Created Time : ".strftime("%c"))
        call append(line('.')+4, "########################################################")
    elseif &filetype == 'c'
        call setline(1,"/*************************************************************************")
        call append(line("."),      "> FileName: ".expand("%"))
        call append(line(".")+1,    "> Author  : DingJing")
        call append(line(".")+2,    "> Mail    : dingjing@live.cn")
        call append(line(".")+3,    "> Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    elseif &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    elseif expand("%:e") == 'cpp'
        call setline(1,"/*************************************************************************")
        call append(line("."),      "> FileName: ".expand("%"))
        call append(line(".")+1,    "> Author  : DingJing")
        call append(line(".")+2,    "> Mail    : dingjing@live.cn")
        call append(line(".")+3,    "> Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    elseif expand("%:e") == 'h'
        call setline(1,"/*************************************************************************")
        call append(line("."),      "> FileName: ".expand("%"))
        call append(line(".")+1,    "> Author  : DingJing")
        call append(line(".")+2,    "> Mail    : dingjing@live.cn")
        call append(line(".")+3,    "> Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "#ifndef _".substitute(toupper(expand("%:r")),"-","_","g")."_H")
        call append(line(".")+6, "#define _".substitute(toupper(expand("%:r")),"-","_","g")."_H")
        call append(line(".")+7, "")
        call append(line(".")+8, "#endif")
    endif
endfunc

autocmd BufNewFile * normal G

" 设置文件头--结束
" 记住上次打开的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

