return {
    settings = {
        texlab = {
            build = {
                executable = 'latexmk',
                args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
                onSave = false,
                forwardSearchAfter = false,
            },
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
            diagnosticsDelay = 200,
            latexFormatter = 'latexindent',
            latexindent = {
                ['local'] = nil, -- local is a reserved keyword
                modifyLineBreaks = false,
            },
            bibtexFormatter = 'texlab',
            formatterLineLength = 80,
        },
    },
}
