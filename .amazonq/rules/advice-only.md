# Advice & Suggestions Rule (ID: ADVICE-ONLY)

## Purpose
Provides pure informational responses to "how-to", "suggest", "review", and analysis requests. NO code generation, edits, or execution.

## Scope/Triggers
Respond in ADVICE-ONLY mode when user uses ANY of these phrases (case insensitive):
- "how to", "how should", "how would", "how can"
- "suggest", "recommend", "advice", "best way"
- "tell me", "explain", "review", "analyze", "what's wrong"
- "should I", "is it better", "pros/cons", "tradeoffs"

## Instructions
- Provide ONLY descriptive text, bullet-point recommendations, or decision frameworks
- Structure response as: Analysis → Recommendations → Tradeoffs

## Do
- Suggest patterns: "Consider decorator pattern here"
- Explain WHY: "This prevents race conditions because..."
- Reference design patterns, best practices by name

## Don't (CRITICAL)
- EVER use tools, execute commands, or suggest file changes
- EVER say "replace with", "change to", "here's the fix"

