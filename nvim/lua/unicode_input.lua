-- LaTeX-style Unicode input, e.g. for Rocq/Iris.
--
--   \forall<Space>   ->  "∀ "   expand the \name before the cursor, keep the space
--   \lc<C-]>         ->  "⌜"    expand without a space (for ⌜φ⌝, ↑N, γ₁, ...)
--   <C-v><Space>                insert a plain space without expanding
--   \fo then <CR>/<Tab>         pick from the completion menu (see cmp_source)
--
-- Unknown names are left alone. Since expansion only happens on one of those
-- keys, a name may be a prefix of another (\to / \top, \le / \leq).
--
-- Names: Iris's own set (iris/docs/editor.md, same as its Emacs and RocqIDE
-- configs) plus the usual LaTeX ones.
local M = {}

M.symbols = {
  -- Iris (docs/editor.md)
  fun = "λ", lam = "λ", Lam = "Λ", Sig = "Σ", pred = "φ", gname = "γ",
  all = "∀", ex = "∃", ["and"] = "∧", ["or"] = "∨", to = "→", iff = "↔",
  ent = "⊢", sep = "∗", mult = "⋅", valid = "✓", incl = "≼", update = "⇝",
  later = "▷", latert = "▶", box = "□", bbox = "■", diamond = "◇",
  lc = "⌜", rc = "⌝", Lc = "⎡", Rc = "⎤",
  aa = "●", af = "◯", auth = "●", frag = "◯",
  comp = "∘", ccomp = "◎", empty = "∅", ["-"] = "∖", ['"o'] = "ö",

  -- logic
  forall = "∀", exists = "∃", nexists = "∄", neg = "¬", lnot = "¬",
  land = "∧", wedge = "∧", lor = "∨", vee = "∨", top = "⊤", bot = "⊥",
  vdash = "⊢", dashv = "⊣", models = "⊨",
  -- arrows
  rightarrow = "→", leftarrow = "←", gets = "←", leftrightarrow = "↔",
  Rightarrow = "⇒", implies = "⇒", Leftrightarrow = "⇔", mapsto = "↦",
  uparrow = "↑", downarrow = "↓", leadsto = "⇝",
  -- relations
  le = "≤", leq = "≤", ge = "≥", geq = "≥", ne = "≠", neq = "≠",
  equiv = "≡", nequiv = "≢", approx = "≈", simeq = "≃", cong = "≅",
  preceq = "≼", sqsubseteq = "⊑", gg = "≫", ll = "≪",
  -- sets
  ["in"] = "∈", notin = "∉", ni = "∋", subset = "⊂", subseteq = "⊆",
  nsubseteq = "⊈", supset = "⊃", supseteq = "⊇", cap = "∩", cup = "∪",
  uplus = "⊎", setminus = "∖", emptyset = "∅", varnothing = "∅",
  -- operators & misc
  ast = "∗", cdot = "⋅", circ = "∘", times = "×", oplus = "⊕", otimes = "⊗",
  sum = "∑", prod = "∏",
  triangleright = "▷", blacktriangleright = "▶", Box = "□", blacksquare = "■",
  Diamond = "◇", bigcirc = "◯", checkmark = "✓", ulcorner = "⌜", urcorner = "⌝",
  langle = "⟨", rangle = "⟩", dagger = "†", ell = "ℓ", infty = "∞",
  -- used in Iris/stdpp but not in editor.md: later credits (£ n), mono lists
  -- (γ ↪●ML l), big unions, lattices, sigma types (x ↾ p), time receipts;
  -- ⟦ ⟧ is the usual bracket for semantic types in logical relations
  pounds = "£", hookrightarrow = "↪", bigcup = "⋃", nsubset = "⊄",
  sqcap = "⊓", sqcup = "⊔", upharpoonright = "↾", restriction = "↾",
  bullet = "∙", hourglass = "⧖", half = "½",
  llbracket = "⟦", rrbracket = "⟧",
  -- greek
  alpha = "α", beta = "β", gamma = "γ", delta = "δ", epsilon = "ε",
  zeta = "ζ", eta = "η", theta = "θ", iota = "ι", kappa = "κ",
  lambda = "λ", mu = "μ", nu = "ν", xi = "ξ", pi = "π", rho = "ρ",
  sigma = "σ", tau = "τ", upsilon = "υ", phi = "φ", varphi = "ϕ",
  chi = "χ", psi = "ψ", omega = "ω",
  Gamma = "Γ", Delta = "Δ", Theta = "Θ", Lambda = "Λ", Xi = "Ξ", Pi = "Π",
  Sigma = "Σ", Upsilon = "Υ", Phi = "Φ", Psi = "Ψ", Omega = "Ω",
  -- sub/superscripts (\_1 -> ₁, \^+ -> ⁺)
  ["_0"] = "₀", ["_1"] = "₁", ["_2"] = "₂", ["_3"] = "₃", ["_4"] = "₄",
  ["_5"] = "₅", ["_6"] = "₆", ["_7"] = "₇", ["_8"] = "₈", ["_9"] = "₉",
  ["_+"] = "₊", ["^+"] = "⁺", ["^-"] = "⁻",
  ["_a"] = "ₐ", ["_e"] = "ₑ", ["_h"] = "ₕ", ["_i"] = "ᵢ", ["_k"] = "ₖ",
  ["_l"] = "ₗ", ["_m"] = "ₘ", ["_n"] = "ₙ", ["_o"] = "ₒ", ["_p"] = "ₚ",
  ["_r"] = "ᵣ", ["_s"] = "ₛ", ["_t"] = "ₜ", ["_u"] = "ᵤ", ["_v"] = "ᵥ",
  ["_x"] = "ₓ",
}

-- Builds a mapping: if the text before the cursor ends in `\name` with a known
-- name, erase it and type the symbol followed by `after`; otherwise type
-- `fallback` (the key's normal behaviour).
--
-- Deliberately not an `expr` mapping: when keys arrive in a burst (fast typing,
-- macros, laggy terminal) Neovim evaluates expr mappings *before* the previous
-- characters are in the buffer, so it would see `\foral` instead of `\forall`.
-- A callback runs after them; feeding with "i" puts our keys ahead of anything
-- still pending, and "n" stops them from triggering this mapping again.
local function expander(after, fallback)
  return function()
    local before = vim.api.nvim_get_current_line():sub(1, vim.fn.col(".") - 1)
    local name = before:match("\\([^%s\\]+)$")
    local sym = name and M.symbols[name]
    local keys = sym and ("<BS>"):rep(#name + 1) .. sym .. after or fallback
    vim.api.nvim_feedkeys(vim.keycode(keys), "ni", false)
  end
end

function M.attach(buf)
  vim.b[buf].unicode_input = true
  vim.keymap.set("i", "<Space>", expander(" ", " "), { buffer = buf })
  vim.keymap.set("i", "<C-]>", expander("", "<C-]>"), { buffer = buf })
end

-- nvim-cmp source (registered in plugins/lsp.lua): after `\` and one more
-- character it lists the matching names with their symbols, narrowed as you
-- type; accepting an entry replaces `\name` with the symbol. Only offered in
-- buffers set up above. No menu on a bare `\` (keyword_length = 2 there), or
-- Enter after Coq's `/\` at the end of a line would insert a symbol.
function M.cmp_source()
  return {
    is_available = function() return vim.b.unicode_input == true end,
    -- what gets replaced: the `\` and everything after it up to the cursor
    get_keyword_pattern = function() return [[\\[^[:space:]\\]*]] end,
    complete = function(_, _, callback)
      local kind = require("cmp").lsp.CompletionItemKind.Text
      local items = {}
      for name, sym in pairs(M.symbols) do
        items[#items + 1] = {
          label = "\\" .. name,
          labelDetails = { detail = sym },
          insertText = sym,
          kind = kind,
        }
      end
      callback(items)
    end,
  }
end

function M.setup(filetypes)
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("UnicodeInput", { clear = true }),
    pattern = filetypes,
    callback = function(ev) M.attach(ev.buf) end,
  })
end

return M
