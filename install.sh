#!/bin/sh

set -xe

D="$(realpath $(dirname $0))"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm $HOME/.zshrc

mkdir -p $HOME/.zsh
git clone https://github.com/zsh-users/zaw.git $HOME/.zsh/zaw

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

ln -s $D/bin $HOME/bin

for i in .alacritty.toml .ackrc .gitconfig .gitignore_global .npmrc .tmux.conf .zshrc ; do
	ln -s $D/$i $HOME/$i
done
for i in psqlrc ; do
	ln -s $D/$i $HOME/.$i
done

mkdir -p $HOME/.cargo
ln -s $D/cargo.config.toml $HOME/.cargo/config.toml

mkdir -p $HOME/.config/htop
ln -s $D/htoprc $HOME/.config/htop/htoprc

mkdir -p $HOME/.dir_colors
ln -s $D/dircolors $HOME/.dir_colors/dircolors

mkdir -p $HOME/.ssh
ln -s $D/ssh_config $HOME/.ssh/config

mkdir -p $HOME/.gnupg
ln -s $D/gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
ln -s $D/gnupg/scdaemon.conf $HOME/.gnupg/scdaemon.conf

chmod -R 700 $HOME/.gnupg $HOME/.ssh

gpg --import < $HOME/Sync/pubkey.asc

mkdir -p $HOME/.config
ln -s $D/nvim $HOME/.config/nvim
ln -s $D/helix $HOME/.config/helix
ln -s $D/ghostty $HOME/.config/ghostty

ln -s $D/dlv $HOME/.config/dlv

mkdir -p $HOME/.config/systemd
for i in $D/systemd-user/* ; do
	ln -s $i $HOME/.config/systemd/user/
done

systemctl --user daemon-reload
systemctl --user enable backup.timer
