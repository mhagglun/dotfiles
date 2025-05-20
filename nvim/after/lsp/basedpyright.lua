return {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        autoImportCompletions = true,
        diagnosticSeverityOverrides = {
          reportUnusedClass = "warning",
          reportUnusedFunction = "warning",
        },
      },
    },
  },
}
