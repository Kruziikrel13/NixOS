VERSION=unstable
HM_CHANNEL="https://github.com/nix-community/home-manager/archive/release-$(VERSION).tar.gz"
HM_MASTER_CHANNEL:="https://github.com/nix-community/home-manager/archive/master.tar.gz"
NIX_CHANNEL:="https://nixos.org/channels/nixos-$(VERSION)"

ifeq ($(VERSION),unstable)
	HM_CHANNEL=$(HM_MASTER_CHANNEL)
endif

home-manager:
	sudo nix-channel --add $(HM_CHANNEL) home-manager
	sudo nix-channel --update

nixos:
	sudo nix-channel --add $(NIX_CHANNEL) nixos
	sudo nix-channel --update

