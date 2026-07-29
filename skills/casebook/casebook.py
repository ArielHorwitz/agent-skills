#! /bin/python

import argparse
import datetime
import secrets
import sys
from pathlib import Path

import tomllib

CASEBOOK_DIR = "docs/casebook"

STUB = """\
# Casebook

This directory is a **casebook** — a collection of cases, each a bounded unit of
work (investigation, brainstorm, feature, design, etc.). Each case is a
subdirectory containing a `case.toml` (metadata: `title`, `status`, `keywords`,
`created`) alongside its files (`overview.md`, reports, designs, …).

This directory is managed by the `casebook` tool and skill. For working
conventions — how to create, find, and work within cases — see the casebook
skill.
"""

CASE_TOML_TEMPLATE = """\
title = "{title}"
status = "open"
created = "{created}"
keywords = []
"""


def find_casebook_root() -> Path:
    casebook_path = Path.cwd() / CASEBOOK_DIR
    if not casebook_path.is_dir():
        print(f"error: no casebook found (looking for {CASEBOOK_DIR}/)", file=sys.stderr)
        print("  Run 'casebook init' to create one.", file=sys.stderr)
        raise SystemExit(1)
    return casebook_path


def cmd_init(args):
    casebook_path = Path.cwd() / CASEBOOK_DIR
    casebook_path.mkdir(parents=True, exist_ok=True)
    casebook_path.joinpath("agents.md").write_text(STUB)
    print(f"Initialized casebook at {casebook_path}")


def new_case_id() -> str:
    date_prefix = datetime.date.today().strftime("%Y-%m-%d")
    hex_suffix = secrets.token_hex(4)
    return f"{date_prefix}__{hex_suffix}"


def cmd_new(args):
    casebook_path = find_casebook_root()
    case_id = new_case_id()
    case_path = casebook_path / case_id
    title = "Unnamed case"
    case_path.mkdir(parents=True)
    case_toml = CASE_TOML_TEMPLATE.format(
        title=title,
        created=datetime.datetime.now().isoformat(),
    )
    case_path.joinpath("case.toml").write_text(case_toml)
    print(f"Created case {case_id}: {title}")
    print(f"  {case_path}")


def load_case_metadata(case_path: Path) -> dict:
    return tomllib.loads(case_path.joinpath("case.toml").read_text())


def cmd_list(args):
    casebook_path = find_casebook_root()
    cases = sorted(
        path
        for path in casebook_path.iterdir()
        if path.is_dir() and path.joinpath("case.toml").exists()
    )
    if not cases:
        print("No cases found.")
        return
    status_include = args.status
    status_exclude = args.not_status
    keyword_include = args.keyword
    keyword_exclude = args.not_keyword
    matched = []
    for case_path in cases:
        metadata = load_case_metadata(case_path)
        status = metadata.get("status")
        if status_include and status not in status_include:
            continue
        if status_exclude and status in status_exclude:
            continue
        case_keywords = metadata.get("keywords", [])
        if keyword_include and not any(kw in case_keywords for kw in keyword_include):
            continue
        if keyword_exclude and any(kw in case_keywords for kw in keyword_exclude):
            continue
        matched.append((case_path, metadata))
    if not matched:
        print("No cases match the filter.")
        return
    for case_path, metadata in matched:
        case_id = case_path.name
        title = metadata.get("title", "(untitled)")
        status = metadata.get("status", "unknown")
        print(f"  {case_id}  [{status}]  {title}")


def main():
    parser = argparse.ArgumentParser(
        prog="casebook",
        description="Bare manipulation operations for a project casebook.",
    )
    subparsers = parser.add_subparsers(dest="command")

    subparsers.add_parser(
        "init", help="Initialize a casebook in the current project"
    )

    subparsers.add_parser("new", help="Create a new case")

    list_parser = subparsers.add_parser("list", help="List cases")
    list_parser.add_argument(
        "-s",
        "--status",
        nargs="+",
        metavar="STATUS",
        help="Only list cases with one of these statuses",
    )
    list_parser.add_argument(
        "-S",
        "--not-status",
        nargs="+",
        metavar="STATUS",
        dest="not_status",
        help="Exclude cases with any of these statuses",
    )
    list_parser.add_argument(
        "-k",
        "--keyword",
        nargs="+",
        metavar="KEYWORD",
        help="Only list cases with one of these keywords",
    )
    list_parser.add_argument(
        "-K",
        "--not-keyword",
        nargs="+",
        metavar="KEYWORD",
        dest="not_keyword",
        help="Exclude cases with any of these keywords",
    )

    args = parser.parse_args()

    if args.command == "init":
        cmd_init(args)
    elif args.command == "new":
        cmd_new(args)
    elif args.command == "list":
        cmd_list(args)
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
