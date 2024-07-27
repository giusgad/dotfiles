return {
  checkOnSave = true,
  check = {
    command = "clippy",
    extraArgs = { "--all", "--", "-W", "clippy::all" },
  },
}
