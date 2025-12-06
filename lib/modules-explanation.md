# modules.nix Function Reference

## Overview

This file contains utility functions for mapping and loading Nix modules from directory structures.

---

## `mapModules` - Non-recursive module mapper

```nix
mapModules =
  dir: fn:
  attrs.mapFilterAttrs' (
    n: v:
    let
      path = "${toString dir}/${n}";
    in
    if v == "directory" && pathExists "${path}/default.nix" then
      nameValuePair n (fn path)
    else if v == "regular" && n != "default.nix" && n != "flake.nix" && hasSuffix ".nix" n then
      nameValuePair (removeSuffix ".nix" n) (fn path)
    else
      nameValuePair "" null
  ) (n: v: v != null && !(hasPrefix "_" n)) (readDir dir);
```

**Parameters:**
- `dir`: Directory to scan
- `fn`: Function to apply to each valid module path

**Process:**
1. `readDir dir` - Gets all entries in directory as `{ name = "type"; ... }` (types: "regular", "directory", etc.)
2. `attrs.mapFilterAttrs'` - Custom function that maps and filters attributes
3. For each entry `(n: v:)` where `n` = name, `v` = type:
   - Builds full `path`
   - **If directory with `default.nix`**: Include as `{ moduleName = fn path; }`
   - **If .nix file** (but not `default.nix` or `flake.nix`): Include as `{ fileNameWithoutExt = fn path; }`
   - **Otherwise**: Return `nameValuePair "" null` (filtered out)
4. Filter predicate `(n: v: v != null && !(hasPrefix "_" n))` - Remove nulls and names starting with `_`

**Example:**
```
dir/
├── foo.nix          → { foo = fn "dir/foo.nix"; }
├── bar/
│   └── default.nix  → { bar = fn "dir/bar"; }
├── _private.nix     → (filtered out)
└── default.nix      → (ignored)

Result: { foo = ...; bar = ...; }
```

---

## `mapModules'` - List version

```nix
mapModules' = dir: fn: attrValues (mapModules dir fn);
```

Same as `mapModules` but returns a list of values instead of an attribute set.

---

## `mapModulesRec` - Recursive module mapper

```nix
mapModulesRec =
  dir: fn:
  attrs.mapFilterAttrs' (
    n: v:
    let
      path = "${toString dir}/${n}";
    in
    if v == "directory" then
      nameValuePair n (mapModulesRec path fn)
    else if v == "regular" && n != "default.nix" && n != "flake.nix" && hasSuffix ".nix" n then
      nameValuePair (removeSuffix ".nix" n) (fn path)
    else
      nameValuePair "" null
  ) (n: v: v != null && !(hasPrefix "_" n)) (readDir dir);
```

**Parameters:**
- Same as `mapModules`

**Key Difference:**
- When it encounters a **directory**, it recursively calls itself: `nameValuePair n (mapModulesRec path fn)`
- This creates nested attribute sets matching the directory structure

**Process:**
1. Same as `mapModules`, but for directories:
   - **No check for `default.nix`** - ALL directories are recursed into
   - Creates nested structure: `{ dirName = (recursive result); }`
2. Files are handled identically to `mapModules`

**Example:**
```
dir/
├── top.nix
├── services/
│   ├── web.nix
│   └── api.nix
└── config/
    └── network/
        └── dns.nix

Result: {
  top = fn "dir/top.nix";
  services = {
    web = fn "dir/services/web.nix";
    api = fn "dir/services/api.nix";
  };
  config = {
    network = {
      dns = fn "dir/config/network/dns.nix";
    };
  };
}
```

---

## `mapModulesRec'` - Flat list of all modules

```nix
mapModulesRec' =
  dir: fn:
  let
    dirs = mapAttrsToList (k: _: "${dir}/${k}") (
      filterAttrs (n: v: v == "directory" && !(hasPrefix "_" n) && !(pathExists "${dir}/${n}/.noload")) (
        readDir dir
      )
    );
    files = attrValues (mapModules dir id);
    paths = files ++ concatLists (map (d: mapModulesRec' d id) dirs);
  in
  map fn paths;
```

**Purpose:** Recursively finds all Nix modules in a directory tree and returns a flat list

**Process:**
1. Find all valid subdirectories (not starting with `_`, no `.noload` marker file)
2. Get all files in current directory using `mapModules`
3. Recursively get files from subdirectories
4. Concatenate everything into a flat list
5. Apply `fn` to each path

**Use case:** When you need all module paths in a list rather than a nested structure

---

## `mapHosts` - Host configuration loader

```nix
mapHosts =
  dir:
  mapModules dir (path: {
    inherit path;
    config = import path;
  });
```

**Purpose:** Specialized version of `mapModules` for host configurations

**Returns:** Attribute set where each host has:
- `path`: The file/directory path
- `config`: The imported module

---

## Summary Comparison

| Function | Structure | Recursion | Use Case |
|----------|-----------|-----------|----------|
| `mapModules` | Flat attrs | No | Load one level of modules |
| `mapModules'` | Flat list | No | Same as above, as list |
| `mapModulesRec` | Nested attrs | Yes | Mirror directory tree structure |
| `mapModulesRec'` | Flat list | Yes | Get all modules in tree as list |
| `mapHosts` | Flat attrs | No | Load host configurations |

**Key Filtering Rules (all functions):**
- Skip files/dirs starting with `_`
- Skip `default.nix` and `flake.nix` files
- Only process `.nix` files
- `mapModules`: directories must have `default.nix`
- `mapModulesRec'`: skip dirs with `.noload` file
