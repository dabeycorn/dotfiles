{ pkgs, outputs, overlays, lib, inputs, ... }:
let
in
{
	boot.loader = {
		systemd-boot.enable = true;
	#	grub.enable = true;
	#	grub.efiSupport = true;
	#	grub.device = "nodev";
	};

	hardware.opengl.enable = true;

	#boot.loader.efi.canTouchEfiVariables = true;
	#boot.loader.efi.efiSysMountPoint = "/efi";

	programs.zsh.enable = true;
	programs.nix-ld.enable = true;

	programs.hyprland.enable = true;
	environment.sessionVariables.NIXOS_OZONE_WL = "1";

	networking = {
		networkmanager.enable = true;
		firewall.enable = false;
	};

	security.sudo.enable = true;
	services.blueman.enable = true;
	location.provider = "geoclue2";	

	services.redshift = {
		enable = true;
		brightness = {
			day = "1";
			night = "1";
		};

		temperature = {
			day = 5500;
			night = 3700;
		};
	};

	xdg.portal = {
		enable = true;
		config.common.default = "*";
		extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-hyprland ];
	};

	time = {
		############### !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	};

	# Local shit

	#console shit

	# user shit

	programs.adb.enable = true;
	hardware.pulseaudio.enable = true;
	
	hardware.bluetooth = {}; # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
	security.rtkit.enable = true;
	virtualisation = {
		libvirtd.enable = true;
	};
	services.dbus.enable = true;
	programs.steam.enable = true;
	
	environment.systemPackages = with pkgs; [
		home-manager
		brightnessctl
		unzip
		vim
		neovim
		libnotify
		xdg-utils
		kitty
		gtk3
		osu-lazer
		grim
		git
		firefox
		mpv
		spotify
		pamixer
		python3
		wofi
		appimage-run
		networkmanager_dmenu
		udiskie
		brillo
		xclip
		xwayland
		wirelesstools
	];

	security.pam.services.gdm.enableGnomeKeyring = true;

	fonts.packages = with pkgs; [
		#google.fonts
		#nerdfonts.override { fonts = [ "Hurmit" ]; })
	];	

	fonts.fontconfig = {
		defaultFonts = {
		
		};
	};

	fonts.enableDefaultPackages = true;

	environment.shells = with pkgs; [ zsh ];
	programs.dconf.enable = true;

	qt = {
		enable = true;
		platformTheme = "gtk2";
		style = "gtk2";
	};

	services.printing.enable = true;

	services.xserver = {
		layout = "us";
		xkbVariant = "us,";
	};

	security.polkit.enable = true;

	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			trusted-users = [ "root" "@wheel" ];
			auto-optimise-store = true;
			warn-dirty = false;
			substituters = [ "https://nix-gaming.cachix.org" ];
			
		};
		gc = {
			automatic = true;
			options = "--delete-older-than 5d";
		};
		optimise.automatic = true;
	};

	system = {
		copySystemConfiguration = false;
		stateVersion = "22.11";
	};
}
