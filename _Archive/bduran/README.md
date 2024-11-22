# NixOS Flake Configuration with Home Manager

Welcome to the NixOS flake configuration guide! This repository provides a structured way to manage your NixOS configurations using flakes, with Home Manager integrated for user-specific settings. By organizing configurations and dotfiles, you can maintain reproducibility and consistency across different machines.

---

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Getting Started](#getting-started)
- [Adding a New Host](#adding-a-new-host)
- [Managing Dotfiles](#managing-dotfiles)
- [Integrating Dotfiles with Home Manager](#integrating-dotfiles-with-home-manager)
- [Rebuilding the Configuration](#rebuilding-the-configuration)
- [Troubleshooting](#troubleshooting)
- [Additional Resources](#additional-resources)
- [Conclusion](#conclusion)

---

## Overview

This setup allows you to:

- Manage multiple NixOS configurations using flakes.
- Use Home Manager for user-specific configurations.
- Organize dotfiles in a structured way.
- Maintain consistency across multiple machines (hosts).

---

## Prerequisites

- **NixOS Installed**: Ensure that NixOS is installed on your machine.
- **Basic Knowledge of Nix and Flakes**: Familiarity with Nix expressions and the concept of flakes.
- **Git Installed**: Git is used to manage configuration files and dotfiles.
- **Home Manager**: Integrated as a NixOS module for managing user environments.

---

## Directory Structure

The repository is organized as follows:

```plaintext
nixos-config/
├── flake.nix
├── flake.lock
├── hosts/
│   ├── hostname1/
│   │   └── configuration.nix
│   └── hostname2/
│       └── configuration.nix
├── dotfiles/
│   ├── zsh/
│   │   └── .zshrc
│   ├── nvim/
│   │   └── init.vim
│   └── kitty/
│       └── kitty.conf
├── home.nix
└── README.md
```

## Getting Started

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/yourusername/nixos-config.git
```

### 3. Review the Flake Configuration
Open the flake.nix file to understand how inputs and outputs are defined.

## Adding a New Host
To add a new host (machine) to the configuration:

### 1. Create a Host Directory
In the hosts/ directory, create a new folder named after your machine's hostname:

```bash
mkdir hosts/my-new-host
```

### 2. Create configuration.nix for the Host
Create a configuration.nix file inside the new host directory:

```bash
touch hosts/my-new-host/configuration.nix
```
### 3. Define the Host Configuration
Edit hosts/my-new-host/configuration.nix:

```nix
{ config, pkgs, ... }:

{
  imports = [
    ../../home.nix  # Import shared Home Manager configuration
    ./hardware-configuration.nix  # Hardware configuration for the host
  ];

  networking.hostName = "my-new-host";
  # ... other host-specific configurations ...
}
```

### 4. Update flake.nix
Add the new host to the nixosConfigurations output in flake.nix:

```nix
{
  description = "NixOS configurations with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        "my-new-host" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/my-new-host/configuration.nix
          ];
          specialArgs = { inherit self; };
        };

        # ... other hosts ...
      };
    };
}
```

## Managing Dotfiles
Your dotfiles are stored in the dotfiles/ directory.

### 1. Add or Update Dotfiles
Place your configuration files in the appropriate subdirectories:

- Zsh configuration: dotfiles/zsh/.zshrc
- Neovim configuration: dotfiles/nvim/init.vim
- Kitty configuration: dotfiles/kitty/kitty.conf

### 2. Track Dotfiles with Git
Ensure your dotfiles are tracked by Git:

```bash
git add dotfiles/
git commit -m "Add/update dotfiles"
```

## Integrating Dotfiles with Home Manager
Home Manager allows you to manage user-specific configurations declaratively.

### 1. Edit home.nix
Define your Home Manager configuration in home.nix:

```nix
{ config, pkgs, self, ... }:

{
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    neovim
    kitty
    # ... other packages ...
  ];

  home.files = {
    ".zshrc".source = "${self}/dotfiles/zsh/.zshrc";
    ".config/nvim" = {
      source = "${self}/dotfiles/nvim";
      recursive = true;
    };
    ".config/kitty" = {
      source = "${self}/dotfiles/kitty";
      recursive = true;
    };
  };

  # ... other Home Manager configurations ...
}
```

### 2. Ensure self Is Passed Correctly
In your flake.nix, ensure that self is passed via specialArgs:

```nix
{
  # ... existing content ...

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        "my-new-host" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/my-new-host/configuration.nix
          ];
          specialArgs = { inherit self; };
        };

        # ... other hosts ...
      };
    };
}
```
Ensure that self is accepted in your home.nix and any configuration.nix files:

```nix
{ config, pkgs, self, ... }:
```

## Rebuilding the Configuration
### 1. Build and Switch to the New Configuration
Run the following command, replacing my-new-host with your actual hostname:

```bash
sudo nixos-rebuild switch --flake .#my-new-host
```

### 2. Verify Home Manager Integration
Check that your dotfiles are correctly linked:

```bash
ls -l ~/.zshrc
ls -l ~/.config/nvim
ls -l ~/.config/kitty
```
They should be symlinks pointing to the Nix store.

### 3. Test Your Configurations
Zsh: Open a new terminal to test your shell configuration.
Neovim: Launch Neovim to ensure your settings are applied.
Kitty: Open Kitty to verify your configurations.

## Troubleshooting
Home Manager Files Not Applied
Cause: Existing files in your home directory prevent Home Manager from linking its files.

Solution: Move or remove conflicting files, or configure Home Manager to back up existing files by adding to home.nix:

```nix
home.backupFileExtension = "backup";
```
Flake Not Including Dotfiles
Cause: Untracked or uncommitted files are not included in the flake's source.

Solution: Ensure all files are tracked by Git and committed.

```bash
git add .
git commit -m "Update configuration"
```
Errors During Rebuild
Cause: Syntax errors or misconfigurations in your Nix files.
Solution: Check error messages, validate your Nix expressions, and ensure paths are correct.

## Additional Resources
- NixOS Manual: https://nixos.org/manual/nixos/stable/
- Nix Pills (Tutorial): https://nixos.org/guides/nix-pills/
- Home Manager Manual: https://nix-community.github.io/home-manager/
- Flakes Introduction: https://nixos.wiki/wiki/Flakes
- NixOS Discourse (Community Support): https://discourse.nixos.org/
