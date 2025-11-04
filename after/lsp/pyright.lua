return {
    settings = {
        python = {
            analysis = {
                diagnosticMode = "workspace",
                diagnosticSeverityOverrides = {},
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                },
            },
            venvPath = "venv"
        }
    },
    root_markers = { "pyrightconfig.json", "pyproject.toml", "main.py", "app.py", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" }

}
