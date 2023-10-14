#!/bin/bash

(
  main() {
    printf "setting ghq ...\\n"

    GHQ_ROOT="$(ghq root)"
    if [ -z "${GHQ_ROOT}" ]; then
      printf "ghq root not found.\\n"
      printf "Exit 1\\n"

      exit 1
    fi

    EXPECTED_GHQ_ROOT="${HOME}/projects"
    if [ "${GHQ_ROOT}" != "${EXPECTED_GHQ_ROOT}" ]; then
      printf "ghq.root is not as expected.\\n"
      printf "expected: %s\\n" "${EXPECTED_GHQ_ROOT}"
      printf "actual: %s\\n" "${GHQ_ROOT}"
      printf "Exit 1\\n"

      exit 1
    fi

    printf "done !\\n"
    printf "\\n"
  }
  main
)
