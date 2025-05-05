## Dependencies
- [Neovim](https://github.com/neovim/neovim)
  - v0.10+ **Nightly | Stable**
- [RipGrep](https://github.com/BurntSushi/ripgrep)
- [LazyGit](https://github.com/jesseduffield/lazygit)

#### Fugit
- [LibGit](https://github.com/libgit2/libgit2)
- [GH](https://github.com/cli/cli)

### Windows
Ensure neovim is started in an environment with Clang or MSVC on the path.
  - This can be done by sourcing the visual studio build tools cli environment variables

Batch Scripts for Winget are provided but you can also use the above links to install these dependencies

### Ubuntu
```bash
./installers/unix/lazygit.install
./installers/unix/neovim.install
sudo apt install gcc g++ ripgrep -y
sudo apt install libgit2.1.7 libgit2-dev -y # If using Fugit
```
