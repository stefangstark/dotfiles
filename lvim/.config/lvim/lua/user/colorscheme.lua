local themes = {
  gruvbox = "gruvbox",
  rose_pine = "rose-pine",
  lunar = "lunar",
  gruvbox_material = "gruvbox-material",
  onedarker = "onedarker",
  onedark = "onedark",
  horizon = "horizon",
  tokyonight = "tokyonight",
  tokyonight_night = "tokyonight-night",
  tokyonight_day = "tokyonight-day",
  tokyonight_moon = "tokyonight-moon",
  desert = "desert",
  morning = "morning",
  sonokai = "sonokai",
  edge = "edge",
  ayu = "ayu",
  onenord = "onenord",
}

lvim.colorscheme = themes.onenord
lvim.transparent_window = true
lvim.autocommands = {
  {
    { "ColorScheme" },
    {
      pattern = "*",
      callback = function()
      -- I need to do this because nvim-navic does not have a way to remove the bg
      -- or I just don't know how to do it
      -- these update the background of the icons to be transparent
      -- this is verbose because nvim_set_hl does not have an easy way to update the bg
      -- they can only overwrite the bg, not sure why this is so hard ... 
      vim.api.nvim_set_hl(0, "NavicIconsFile", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsFile"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsModule", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsModule"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsNamespace", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsNamespace"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsPackage", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsPackage"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsClass", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsClass"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsMethod", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsMethod"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsProperty", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsProperty"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsField", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsField"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsConstructor", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsConstructor"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsEnum", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsEnum"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsInterface", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsInterface"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsFunction", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsFunction"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsVariable", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsVariable"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsConstant", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsConstant"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsString", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsString"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsNumber", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsNumber"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsBoolean", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsBoolean"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsArray", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsArray"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsObject", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsObject"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsKey", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsKey"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsNull", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsNull"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsEnumMember", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsEnumMember"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsStruct", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsStruct"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsEvent", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsEvent"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsOperator", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsOperator"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", vim.tbl_extend("force", vim.api.nvim_get_hl(0, {name="NavicIconsTypeParameter"}), {bg = "None"}))
      vim.api.nvim_set_hl(0, "NavicSeparator", vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = "NavicSeparator" }), { bg = "None" }))
      vim.api.nvim_set_hl(0, "NavicText", vim.tbl_extend("force", vim.api.nvim_get_hl(0, { name = "NavicText" }), { bg = "None" }))
      vim.api.nvim_set_hl(0, "WinBar", {force=true, bg="#353B49"})
      end,
    },
  },
}
