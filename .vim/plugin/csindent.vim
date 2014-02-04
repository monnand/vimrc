" Vim global plugin for binding custom indent file per project.
" Last Change:	2011 Jan 16
" Maintainer:	Konstantin Lepa <konstantin.lepa@gmail.com>
" License:      MIT
" Version:      1.1.2
"
" Changes {{{
" 1.2.0 2011-02-01
"   Added support of Windows.
"   Removed g:csindent_dir. Used 'runtimepath' instead it.
"   Added support of expanding environment variables in g:csindent_ini.
"
" 1.1.2 2011-01-17
"   Fixed syntax errors in SelectCodingStyleIndent().
"
" 1.1.1 2011-01-16
"   Fixed problem of detecting of invalid indent filename.
"
" 1.1.0 2011-01-16
"   Renamed script name from coding_style to csindent.
"   Added support of default coding style.
"   Added support of `filetype indent on` by default.
"   Renamed g:coding_style_ini to g:csindent_ini (~/.vim_csindent.ini).
"   Renamed g:coding_style_dir to g:csindent_dir (~/.vim/csindent).
"   Changed indent file path to `g:csindent_dir` + `filetype` + `indent file`.
"   Changed comment char from '#' to ';' in g:csindent_ini file.
"
" 1.0.3 2009-11-18
"   Added support of comments in the g:csindent_ini file.
"
" 1.0.2 2009-05-17
"   Renamed the folder cs_indent to coding_styles.
"   Removed styles.txt.
"   Added g:coding_style_ini (default ~/.coding_style.ini).
"   Added g:coding_style_dir (default ~/.vim/coding_styles).
"
" 1.0.1 2009-05-16
"   Added CodingStyle() for checking of current coding style.
"
" 1.0.0 2009-05-15
"   Initial upload.
"}}}
"
" How to use the plug-in:
" 1. Create `~/.vim_csindent.ini' (default value of `g:csindent_ini') with
"    format:
"        '[' <FILETYPE_NAME> [':' <DEFAULT_INDENT_NAME> ] ']'
"        <INDENT_NAME> '=' <PATH>
"
"    <INDENT_NAME> is common indent file without '.vim' suffix.
"    <PATH> is your path of project.
"
"    If exists <DEFAULT_INDENT_NAME>, then <DEFAULT_INDENT_NAME>.vim file is
"    default indent file for this filetype.
"
"    For example:
"        [cpp:shetukhin]
"        google = $HOME/work/pyctpp2
"
"        [c]
"        linux = $HOME/work/kernels/
"        gnu = $HOME/work/hurd
"
" 2. Create `~/.vim/csindent/<FILETYPE_NAME>/<INDENT_NAME>.vim'
"    (instead of `~/.vim/csindent` you can use any path from 'runtimepath').
"    For example:
"         ~/.vim/csindent/cpp/shetukhin.vim
"         ~/.vim/csindent/cpp/google.vim
"         ~/.vim/csindent/c/linux.vim
"         ~/.vim/csindent/c/gnu.vim
"
" Note 1: This script is compatible with `filetype indent`.
"         See `:help filetype`.
"
" Note 2: You can use more informative status line using CodingStyleIndent().
"         For example:
"             set statusline=%<%f%h%m%r%=style=%{CodingStyleIndent()}
"             \ %15(L%l,C%c%V%)\ %3P
"

if exists("g:loaded_csindent")
    finish
endif
let g:loaded_csindent = 1

let s:save_cpo = &cpo
set cpo&vim

let s:indent_map = {}
let s:indent_defaults = {}
function s:ReadConfigFile(filename)
    for l:line in readfile(a:filename)
        let l:line = substitute(l:line, '^;.*$', "", "")
        let l:line = substitute(l:line, '\([\\]\)\@<!;.*$', "", "g")
        let l:line = substitute(l:line, '[\\];', ";", "g")
        if l:line =~ '^\s*\[\S\+\(:\S\+\)\?\]\s*$'
            let l:parsed = matchlist(l:line,
\                              '^\s*\[\([^:]\+\)\%([[:]\(\S\+\)\)\=\]\s*$')
            let l:ft = l:parsed[1]
            if l:parsed[2] != ''
                let s:indent_defaults[l:ft] = l:parsed[2]
            endif
        endif
        if l:line =~ '^\s*\([^=]\)\+\s\+=\s\+\([^=]\)\+\s*$'
            let l:parsed = matchlist(l:line,
\                                    '^\([^=]\+\)\s\+=\s\+\([^=]\+\)$')
            if !exists('s:indent_map[l:ft]')
                let s:indent_map[l:ft] = []
            endif
            call extend(s:indent_map[l:ft],
\                 [{'name': l:parsed[1], 'path': expand(l:parsed[2])}])
        endif
    endfor
endfunction

function s:ReverseCompare(i1, i2)
    return a:i1['path'] == a:i2['path'] ? 0 :
\        a:i1['path'] > a:i2['path'] ? -1 : 1
endfunction

function s:FindIndentFile(filetp, curpath)
    if !has_key(s:indent_map, a:filetp) | return 'none' | endif
    for l:line in sort(s:indent_map[a:filetp], 's:ReverseCompare')
        if l:line['path'] =~ '[/\]\s*$' || l:line['path'] =~ '\\\s*$'
            let l:pathlen = strlen(l:line['path'])
            let l:line['path'] = strpart(l:line['path'], 0, l:pathlen - 1)
        endif
        if match(tr(a:curpath, '\', '/'), tr(l:line['path'], '\', '/')) == 0
            return l:line['name']
        endif
    endfor
    return 'none'
endfunction

function SelectCodingStyleIndent()
    if !exists('g:csindent_ini')
        let g:csindent_ini = expand('~/.vim_csindent.ini')
    endif
    if !filereadable(g:csindent_ini)
        let b:csindent = 'none'
        return
    endif
    call s:ReadConfigFile(g:csindent_ini)
    let b:csindent = s:FindIndentFile(&filetype, expand('%:p:h'))
    if b:csindent == 'none'
        if has_key(s:indent_defaults, &filetype)
            let b:csindent = s:indent_defaults[&filetype]
        else
            return
        endif
    endif
    
    let l:tmp = globpath(&rtp,
                \ 'csindent' . '/' . &filetype . '/' . b:csindent . '.vim')
    let l:path_list = l:tmp == type([]) ? l:tmp : [l:tmp]
    for l:path in l:path_list
        if filereadable(l:path)
            let l:found = 1
            break
        endif
    endfor
    
    if !exists("l:found")
        let b:csindent = 'none'
        return
    endif

    setl noai nocin nosi inde=
    unlet b:did_indent
    source `=l:path`
    if exists("b:undo_indent")
        let b:undo_indent .= " ai< cin< si< inde<"
    else
        let b:undo_indent = "setl ai< cin< si< inde<"
    endif
endfunction

function CodingStyleIndent()
    if exists("b:csindent") | return b:csindent | endif
    return 'none'
endfunction

au BufNewFile,BufRead * call SelectCodingStyleIndent()

let &cpo = s:save_cpo

