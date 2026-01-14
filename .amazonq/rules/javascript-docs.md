# JavaScript JSDoc & Comments Rule (ID: JSDOCS)

## Purpose
Ensures consistent, JSDoc-compliant documentation and comments ONLY when explicitly requested. No unsolicited additions or logic changes.

## Scope
Applies to ALL JavaScript/TypeScript code generation involving JSDoc (/** */) or inline comments (// /* */).

## Instructions
- ONLY generate JSDoc comments or inline comments if user EXPLICITLY says "add JSDoc", "write comments", "document this", "add docs", or equivalent.
- Use IMPERATIVE MOOD: "Returns", "Throws", "Converts" (follows JSDoc convention).

## Do
- Follow JSDoc 3.6+ standards and common style guides exactly
- Include ALL relevant tags (@param, @returns, @throws) when applicable
- Use standard JSDoc tags: @param, @returns, @throws, @example, etc.
- Validate existing JSDoc matches this format when "fix docs" requested

## Don't (CRITICAL)
- EVER add JSDoc comments or inline comments unless EXPLICITLY requested
- EVER refactor, rename variables/functions, change logic/parameters, or restructure code
- Use non-standard tags or custom formatting
- Mix /* */ with /** */ inconsistently for documentation
- Add "TODO", "FIXME", or implementation notes in JSDoc blocks
- Generate documentation for trivial getters/setters or one-liners without request
