## 2024-05-24 - Avoid Neovim O(N) table allocation helpers for simple checks
**Learning:** `vim.tbl_keys` and `vim.values` eagerly allocate new O(N) tables. Using them for simple presence checks (e.g. `is_in`) or inside loops causes massive unnecessary memory allocation and garbage collection overhead.
**Action:** Use direct `tbl[key] ~= nil` for O(1) key lookups, `pairs()` for value iteration, and hoist `vim.tbl_keys` outside of loops if its result needs to be mutated or iterated multiple times.
