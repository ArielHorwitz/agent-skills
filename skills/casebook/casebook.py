#! /bin/python

import argparse
import datetime
import secrets
import subprocess
import sys
from pathlib import Path
from typing import Optional

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


def format_case_line(case_id: str, metadata: dict) -> str:
    title = metadata.get("title", "(untitled)")
    status = metadata.get("status", "unknown")
    return f"  {case_id}  [{status}]  {title}"


def case_matches(metadata: dict, args) -> bool:
    status = metadata.get("status")
    if args.status and status not in args.status:
        return False
    if args.not_status and status in args.not_status:
        return False
    case_keywords = metadata.get("keywords", [])
    if args.keyword and not any(kw in case_keywords for kw in args.keyword):
        return False
    if args.not_keyword and any(kw in case_keywords for kw in args.not_keyword):
        return False
    return True


def cmd_list(args):
    if args.all_branches:
        cmd_list_all_branches(args)
        return
    casebook_path = find_casebook_root()
    cases = sorted(
        path
        for path in casebook_path.iterdir()
        if path.is_dir() and path.joinpath("case.toml").exists()
    )
    if not cases:
        print("No cases found.")
        return
    matched = [
        (case_path, load_case_metadata(case_path))
        for case_path in cases
    ]
    matched = [pair for pair in matched if case_matches(pair[1], args)]
    if not matched:
        print("No cases match the filter.")
        return
    for case_path, metadata in matched:
        print(format_case_line(case_path.name, metadata))


def git_repo_root() -> Path:
    result = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        print("error: not inside a git repository", file=sys.stderr)
        raise SystemExit(1)
    return Path(result.stdout.strip())


def git_local_branches(root: Path) -> list[str]:
    result = subprocess.run(
        ["git", "for-each-ref", "--format=%(refname:short)", "refs/heads"],
        capture_output=True,
        text=True,
        cwd=root,
    )
    return result.stdout.split()


def git_current_branch(root: Path) -> Optional[str]:
    result = subprocess.run(
        ["git", "rev-parse", "--abbrev-ref", "HEAD"],
        capture_output=True,
        text=True,
        cwd=root,
    )
    name = result.stdout.strip()
    return None if name in ("", "HEAD") else name


def git_cases_on_branch(branch: str, root: Path) -> list:
    listing = subprocess.run(
        ["git", "ls-tree", "-r", "--name-only", branch, "--", f"{CASEBOOK_DIR}/"],
        capture_output=True,
        text=True,
        cwd=root,
    )
    cases = []
    for path in listing.stdout.splitlines():
        if not path.endswith("/case.toml"):
            continue
        case_id = path.split("/")[-2]
        blob = subprocess.run(
            ["git", "show", f"{branch}:{path}"],
            capture_output=True,
            text=True,
            cwd=root,
        )
        if blob.returncode != 0:
            continue
        try:
            metadata = tomllib.loads(blob.stdout)
        except tomllib.TOMLDecodeError:
            continue
        cases.append((case_id, metadata))
    cases.sort(key=lambda pair: pair[0])
    return cases


def cmd_list_all_branches(args):
    root = git_repo_root()
    branches = git_local_branches(root)
    if not branches:
        print("No local branches found.")
        return
    current = git_current_branch(root)
    ordered = sorted(branches)
    if current in ordered:
        ordered.remove(current)
        ordered.insert(0, current)
    print(
        "Cases on every local branch (committed tips; uncommitted work is not shown):"
    )
    any_shown = False
    for branch in ordered:
        shown = [
            (case_id, metadata)
            for case_id, metadata in git_cases_on_branch(branch, root)
            if case_matches(metadata, args)
        ]
        if not shown:
            continue
        any_shown = True
        label = f"{branch}  (current)" if branch == current else branch
        print(f"\n{label}")
        for case_id, metadata in shown:
            print(format_case_line(case_id, metadata))
    if not any_shown:
        print("\nNo committed cases found on any branch.")


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
        "-a",
        "--all-branches",
        action="store_true",
        dest="all_branches",
        help="List committed cases on every local branch, grouped by branch",
    )
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
