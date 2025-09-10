return {
    cmd = { 'pyright' },
    filetypes = { 'python' },
    settings = {
        python = {
            analysis = {
                diagnosticMode = "workspace",
                diagnosticSeverityOverrides = {
                }
            },
            venvPath = "venv",
        },
    },
}
