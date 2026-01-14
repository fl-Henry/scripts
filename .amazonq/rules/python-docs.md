# Python Docstring & Comments Rule (ID: PYDOCS)

## Purpose
Ensures consistent, PEP 257-compliant docstrings/comments ONLY when explicitly requested. No unsolicited additions or logic changes.

## Scope
Applies to ALL Python code generation involving docstrings (__doc__) or inline comments (#).

## Instructions
- ONLY generate docstrings/comments if user EXPLICITLY says "add docstrings", "write comments", "document this", or equivalent.
- Use IMPERATIVE MOOD: "Return", "Raise", "Convert" (NEVER "Returns", "Raises").
- Triple DOUBLE quotes ONLY: """ (NEVER ''' unless escaping required).

## Do
- Follow PEP 257, PEP 8 exactly
- Include ALL relevant sections (don't omit Raises if exceptions possible)
- Validate existing docstrings match this format when "fix docs" requested

## Don't (CRITICAL)
- EVER add docstrings/comments unless EXPLICITLY requested
- EVER refactor, rename variables, change logic/parameters, or restructure code
- Use imperative alternatives like "Calculates" instead of "Return"
- Mix single/double/triple quotes inconsistently
- Add "TODO", "FIXME", or implementation notes in docstrings
