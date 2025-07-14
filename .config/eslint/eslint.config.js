// eslint.config.js
import js from "@eslint/js";
import typescript from "@typescript-eslint/eslint-plugin";
import typescriptParser from "@typescript-eslint/parser";
import importPlugin from "eslint-plugin-import";
import nextPlugin from "@next/eslint-plugin-next";
import react from "eslint-plugin-react";
import reactHooks from "eslint-plugin-react-hooks";
import unusedImports from "eslint-plugin-unused-imports";
import { defineConfig } from "eslint/config";

export default defineConfig([
  // Global ignores
  {
    ignores: [
      ".next/**/*",
      ".git/**/*",
      "node_modules/**/*",
      "public/**/*",
      "src/styles/**/*",
      ".*"
    ]
  },

  // Base configuration for all files
  {
    files: ["**/*.{js,mjs,cjs,ts,tsx}"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      parser: typescriptParser,
      parserOptions: {
        project: "./tsconfig.json",
        ecmaFeatures: {
          jsx: true
        }
      }
    },
    plugins: {
      "@typescript-eslint": typescript,
      import: importPlugin,
      "@next/next": nextPlugin,
      react,
      "react-hooks": reactHooks,
      "unused-imports": unusedImports
    },
    settings: {
      next: {
        rootDir: "./"
      },
      "import/resolver": {
        typescript: {
          alwaysTryTypes: true
        }
      },
      react: {
        version: "detect"
      }
    }
  },

  // ESLint recommended rules
  js.configs.recommended,

  // TypeScript configuration
  {
    files: ["**/*.{ts,tsx}"],
    extends: [
      typescript.configs.recommended
    ],
    rules: {
      "@typescript-eslint/no-unused-vars": "off"
    }
  },

  // React and Next.js configuration
  {
    files: ["**/*.{jsx,tsx}"],
    extends: [
      nextPlugin.configs.recommended,
      nextPlugin.configs["core-web-vitals"]
    ],
    rules: {
      "react/no-unescaped-entities": "off"
    }
  },

  // Import rules configuration
  {
    files: ["**/*.{js,mjs,cjs,ts,tsx}"],
    rules: {
      "unused-imports/no-unused-imports": "warn",
      "import/prefer-default-export": "off",
      "import/no-named-as-default": "off",
      "import/no-named-as-default-member": "off",
      "import/order": [
        "error",
        {
          groups: ["builtin", "external", "internal", ["parent", "sibling"], "object", "type", "index"],
          "newlines-between": "always",
          pathGroupsExcludedImportTypes: ["builtin"],
          alphabetize: {
            order: "asc",
            caseInsensitive: true
          },
          pathGroups: [
            { pattern: "@/types/**", group: "internal", position: "before" },
            { pattern: "@/libs/**", group: "internal", position: "before" },
            { pattern: "@/components/**", group: "internal", position: "before" },
            { pattern: "@/constants/**", group: "internal", position: "before" },
            { pattern: "@/styles/**", group: "index", position: "before" }
          ]
        }
      ]
    }
  }
]);
