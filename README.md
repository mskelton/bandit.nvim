# bandit.nvim

> The fugitive's sidekick.

This plugin is a small plugin that provides a few nice features to augment the
amazing [vim-fugitive](https://github.com/tpope/vim-fugitive) plugin.

## Installation

Install with your favorite package manager (`packer` in this example).

```lua
use({
  "mskelton/bandit.nvim"
  requires = { "MunifTanjim/nui.nvim" }
})
```

## Usage

### Committing files

The Bandit commit input allows you to quickly open a floating window where you
can type a commit message and quick flags to modify behavior. By default, Bandit
will add all files (including untracked files) before committing.

```lua
require("bandit").commit()
```

Available quick flags that can be prepended to the commit message. These flags
will be stripped from the commit message.

- `?` - Only commit changes to tracked files
- `.` - Only commit staged changes

### Creating branches
