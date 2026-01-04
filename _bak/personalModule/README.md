# personalModule

**Note:** This is a nonstandard, private NixOS module intended for personal use only.

## Overview

The `personalModule` directory contains a custom NixOS module designed to automate and wrap configuration options for both NixOS system and Home Manager user environments. This approach allows for unified management of settings that affect both the system and user profiles.

## Features

- Centralizes configuration logic for both NixOS and Home Manager.
- Enables defining options that synchronize system-wide and user-specific settings (e.g., themes, packages).
- Reduces duplication and simplifies complex setups.
- Intended for private, personal workflows—**not** for general or public use.

## Usage

Import this module in your main NixOS configuration to activate its features. This setup is heavily opinionated with my personal system settings and as such is likely of no use to anyone other than myself.
