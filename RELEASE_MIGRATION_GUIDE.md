# Release Strategy Migration Guide

## Overview

The artwork repository has migrated from a shared release tag strategy to independent releases per wallpaper pack.

## What Changed

### Before (Old Strategy)
- All wallpaper packs shared a single date-based release tag: `v2024-01-15`
- All packs had to be released together to maintain consistency
- Updating one pack required releasing all packs

### After (New Strategy)
- Each wallpaper pack has its own release tag with a prefix: `{pack}-v2024-01-15`
- Packs can be released independently
- Only the updated pack needs to be released

## Release Tag Formats

| Wallpaper Pack | Old Tag Format | New Tag Format |
|---------------|----------------|----------------|
| Bluefin | `v2024-01-15` | `bluefin-v2024-01-15` |
| Bluefin Extra | `v2024-01-15` | `bluefin-extra-v2024-01-15` |
| Aurora | `v2024-01-15` | `aurora-v2024-01-15` |
| Bazzite | `v2024-01-15` | `bazzite-v2024-01-15` |
| Framework | `v2024-01-15` | `framework-v2024-01-15` |

## Impact on Downstream Projects

### Homebrew Casks

If you maintain Homebrew Casks that reference these releases, you need to update the livecheck patterns to match the new tag format.

**Example for Bluefin:**

Old livecheck pattern:
```ruby
livecheck do
  url :stable
  regex(/^v?(\d{4}-\d{2}-\d{2})$/i)
end
```

New livecheck pattern:
```ruby
livecheck do
  url :stable
  regex(/^bluefin-v?(\d{4}-\d{2}-\d{2})$/i)
end
```

### URL Changes

Release artifact URLs will also change:

**Old URL format:**
```
https://github.com/hanthor/artwork/releases/download/v2024-01-15/bluefin-wallpapers-gnome.tar.zstd
```

**New URL format:**
```
https://github.com/hanthor/artwork/releases/download/bluefin-v2024-01-15/bluefin-wallpapers-gnome.tar.zstd
```

## Benefits

1. **Independent Releases**: Each pack can be updated without affecting others
2. **Clearer History**: Release history is separated by pack
3. **Reduced Overhead**: No need to rebuild and release unchanged packs
4. **Better Versioning**: Each pack's version directly relates to its changes

## Migration Timeline

- **Effective Date**: After this PR is merged
- **Last Old-Style Release**: `v2025-11-01`
- **First New-Style Releases**: Will use the new tag format (e.g., `bluefin-v2025-11-02`)

## Questions or Issues?

If you maintain a project that depends on these releases and need assistance with migration, please open an issue in the repository.
