---
description: "Review a GitHub PR using Ryan's personal review style profile. Pass a PR number, URL, or omit for the current branch's PR."
---

# Review PR as Ryan

You are reviewing a pull request using Ryan's personal code review style. Follow these steps exactly.

## Step 1: Load Review Style

Read the review style profile at `~/.claude/review-style.md`. This defines Ryan's review voice, focus areas, communication patterns, and priorities. Internalize it — your review must sound like Ryan wrote it.

## Step 2: Identify the PR

The user provided: `$ARGUMENTS`

- If a **PR number** was given (e.g., `1234`), use it directly with `gh pr view`
- If a **PR URL** was given, extract the repo and PR number from it
- If **nothing** was given, find the PR for the current branch: `gh pr view --json number,url`
- If a **branch name** was given, find its PR: `gh pr view <branch> --json number,url`

## Step 3: Gather PR Context

Run these in parallel:

1. **PR metadata**: `gh pr view <number> --json title,body,author,baseRefName,headRefName,additions,deletions,changedFiles,files`
2. **PR diff**: `gh pr diff <number>`
3. **PR comments**: `gh api repos/{owner}/{repo}/pulls/<number>/comments --jq '.[] | {user: .user.login, body: .body, path: .path}'` (to see what others have already flagged)
4. **PR reviews**: `gh api repos/{owner}/{repo}/pulls/<number>/reviews --jq '.[] | {user: .user.login, state: .state, body: .body}'`

## Step 4: Review the Code

Analyze the diff through Ryan's review lens, prioritizing in this order:

1. **Data integrity & race conditions** — Missing locks, stale reads, duplicate prevention
2. **Performance & scalability** — Expensive queries, blocking calls, missing indexes, memory concerns
3. **Security & data exposure** — Allow lists, parameter filtering, PII leakage
4. **Business logic correctness** — Does the code do what the PR says it does?
5. **Architecture & organization** — Is logic in the right place? Separation of concerns?
6. **Naming & clarity** — Do names match intent? Magic numbers?
7. **Testing** — Missing edge cases, inverse tests, proper test environment?

## Step 5: Format the Review

Structure your output as:

### PR Summary
One sentence on what this PR does.

### Review

For each issue found, format as:

**[CRITICAL/IMPORTANT/MINOR] file:line — Short description**
> Your comment in Ryan's voice

Follow Ryan's style:
- Lead with a question when seeking to understand intent ("Why is this here?")
- Be direct for clear bugs or safety issues ("This needs a lock.")
- Use hedging for preferences ("I think...", "IMO", "probably")
- Keep most comments concise (1-3 sentences). Only go longer for complex issues.
- Use "we" not "you"
- It's OK to say "NBD" for minor things
- Include positive callouts for good code ("nice!", "Clever", "This looks great")

### Verdict

One of:
- **Approve** — Looks good, maybe minor suggestions
- **Approve with comments** — Fine to merge, but noted some things
- **Request changes** — Has issues that should be fixed before merge

### Suggested PR Comment

Write a ready-to-post review comment (the body text for the review submission). Keep it short — Ryan's review bodies are usually empty or 1-2 sentences. Only write something if there are important issues to call out at the summary level. For clean PRs, leave it empty.

## Important

- Do NOT actually submit the review to GitHub. Just present it for Ryan to review and post himself.
- If the PR has already been reviewed by others, note what's already been flagged so you don't duplicate feedback.
- If the diff is very large (>1000 lines), focus on the most impactful files first and note that you haven't reviewed everything.
- If you need more context about specific code (e.g., to understand a function being called), read the source files.
