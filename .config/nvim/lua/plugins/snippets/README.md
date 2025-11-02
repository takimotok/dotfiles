# Snippet Configuration

## Overview

This directory contains specialized snippets that are not provided by friendly-snippets.

## Design Philosophy

### Snippet Strategy

1. **friendly-snippets**: Provides basic snippets
2. **Custom snippets**: Only specialized snippets not available in friendly-snippets
3. **Duplication elimination**: Basic snippets are delegated to friendly-snippets

## Current Custom Snippets

### Lua - LuaCats Annotations

| Prefix     | Description                      |
|:-----------|:---------------------------------|
| `class`    | LuaCats class definition         |
| `func`     | LuaCats function annotation      |
| `alias`    | LuaCats type alias               |
| `param`    | LuaCats parameter annotation     |
| `return`   | LuaCats return annotation        |
| `type`     | LuaCats type annotation          |
| `field`    | LuaCats field annotation         |
| `module`   | LuaCats module definition        |
| `config`   | LuaCats configuration table      |
| `returns`  | LuaCats multiple return values   |
| `array`    | LuaCats array type               |
| `dict`     | LuaCats dictionary type          |
| `optional` | LuaCats optional type            |
| `union`    | LuaCats union type               |

## Usage

1. Open a Lua file
2. Type a prefix (e.g., `class`, `func`)
3. Press Tab to expand the snippet
4. Use Tab/Shift+Tab to navigate between placeholders

## Distinction with friendly-snippets

### Use friendly-snippets for

- **All basic snippets**: React (`rfc`, `us`, `ue`), Python (`def`, `class`), HTML (`!`, `a`), etc.
- **Standard syntax**: Common snippets for almost all languages

### Use custom snippets for

- **Lua development**: LuaCats annotations
- **Project-specific features**: To be added in the future

## Addition Policy

New custom snippets are added only when they meet the following criteria:

1. **Not available in friendly-snippets**
2. **Project-specific requirements**
3. **Clear advantages**

## Configuration Location

- **Entry point**: `lua/plugins/coding.lua`
- **Snippet files**: `lua/snippets/`
