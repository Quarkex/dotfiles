" Vim syntax file
" Language:	Liquid
" Maintainer:	Manlio García <quarkex@gmail.com>
" Last Change:	2016 Nov 03

syntax spell toplevel

syn case ignore

" tags
syn region  LiquidString  contained start=+"+ end=+"+
syn region  LiquidString  contained start=+'+ end=+'+
syn match   LiquidValue   contained ":[^%|}]*\(|\|%}\)"hs=s+1
syn region  LiquidTag               start=+{%+ end=+%}+ fold contains=ALL

" tag names
syn keyword LiquidTagName contained and
syn keyword LiquidTagName contained or
syn keyword LiquidTagName contained else
syn keyword LiquidTagName contained elsif
syn keyword LiquidTagName contained in
syn keyword LiquidTagName contained for
syn keyword LiquidTagName contained endfor
syn keyword LiquidTagName contained if
syn keyword LiquidTagName contained endif
syn keyword LiquidTagName contained unless
syn keyword LiquidTagName contained endunless
syn keyword LiquidTagName contained capture
syn keyword LiquidTagName contained endcapture
syn keyword LiquidTagName contained assign
syn keyword LiquidTagName contained increment
syn keyword LiquidTagName contained decrement
syn keyword LiquidTagName contained comment
syn keyword LiquidTagName contained endcomment
syn keyword LiquidTagName contained include
syn keyword LiquidTagName contained link
syn keyword LiquidTagName contained post_url
syn keyword LiquidTagName contained gist
syn keyword LiquidTagName contained highlight
syn keyword LiquidTagName contained endhighlight
syn keyword LiquidTagName contained lineos

" legal arg names
syn keyword LiquidArg contained relative_url
syn keyword LiquidArg contained absolute_url
syn keyword LiquidArg contained date_to_xmlschema
syn keyword LiquidArg contained date_to_rfc822
syn keyword LiquidArg contained date_to_string
syn keyword LiquidArg contained date_to_long_string
syn keyword LiquidArg contained where
syn keyword LiquidArg contained where_exp
syn keyword LiquidArg contained group_by
syn keyword LiquidArg contained xml_escape
syn keyword LiquidArg contained cgi_escape
syn keyword LiquidArg contained uri_escape
syn keyword LiquidArg contained number_of_words
syn keyword LiquidArg contained array_to_sentence_string
syn keyword LiquidArg contained markdownify
syn keyword LiquidArg contained smartify
syn keyword LiquidArg contained scssify
syn keyword LiquidArg contained sassify
syn keyword LiquidArg contained slugify
syn keyword LiquidArg contained jsonify
syn keyword LiquidArg contained normalize_whitespace
syn keyword LiquidArg contained sort
syn keyword LiquidArg contained sample
syn keyword LiquidArg contained to_integer
syn keyword LiquidArg contained push
syn keyword LiquidArg contained pop
syn keyword LiquidArg contained shift
syn keyword LiquidArg contained unshift
syn keyword LiquidArg contained inspect

" Comments
syn region LiquidComment start=+{%[\ ]*comment[\ ]*%}+ end=+{%[\ ]*endcomment[\ ]*%}+   contains=@Spell

syn match LiquidSpace "\s\+"          contained
syn match LiquidLeadingSpace "^\s\+"  contained
syn match LiquidTrailingSpace "\s\+$" contained

" The default highlighting.
hi link LiquidTag                Function
hi link LiquidArg                Type
hi link LiquidTagName            LiquidStatement
hi link LiquidValue              String

hi link LiquidSpace              None
hi link LiquidLeadingSpace       None
hi link LiquidTrailingSpace      None

hi link LiquidString             String
hi link LiquidStatement          Statement
hi link LiquidComment            Comment
hi link LiquidValue              String

" vim: ts=8
