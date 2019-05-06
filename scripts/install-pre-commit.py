#!/usr/bin/env python
"""Install the pre-commit hooks"""
import os


if os.path.isdir(".git") and not os.path.isfile(".git/hooks/pre-commit"):
    print("##################################################################")
    print("Installing pre-commit hooks")
    print("##################################################################")
    os.system("pre-commit install")
