{ lib, pkgs, ... }:
{
  home.activation.ensureZshRepos = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
      echo "Cloning oh-my-zsh..."
      ${pkgs.git}/bin/git clone --branch master --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
    fi

    if [ ! -d "$HOME/fzf-git.sh" ]; then
      echo "Cloning fzf-git.sh..."
      ${pkgs.git}/bin/git clone --branch master https://github.com/junegunn/fzf-git.sh.git "$HOME/fzf-git.sh"
    fi

    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
      echo "Cloning zsh-syntax-highlighting..."
      ${pkgs.git}/bin/git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    fi
  '';
}
