if exists("b:current_syntax")
  finish
endif

syn clear

set commentstring=;%s
set comments=";"

syn keyword MimaInstruction DS LDC LDV LDIV STV STIV ADD AND OR XOR EQL JMP JMN JIND JDS HALT NOT RAR
syn region MimaComment excludenl start=";" end="\n"
syn match MimaLabel excludenl "\<\w*\>"
syn match MimaStar excludenl "\*"
syn match MimaNumber excludenl "\<0x\?[0-9a-fA-F]*\>"


hi default link MimaNumber Number
hi default link MimaComment Comment
hi default link MimaInstruction Label
hi default link MimaLabel Type
hi default link MimaStar SpecialChar

let b:current_syntax="mima"
