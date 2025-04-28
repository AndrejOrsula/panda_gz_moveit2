#!/usr/bin/env bash

PKG_SHARE_DIR="$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")" &>/dev/null && pwd)"
ament_prepend_unique_value GZ_SIM_RESOURCE_PATH "${PKG_SHARE_DIR}"