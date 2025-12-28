-- Add empty padding to the end of a file when scrolling
return {
  'Aasim-A/scrollEOF.nvim',
  event = { 'CursorMoved', 'WinScrolled' },
  opts = {},
}
