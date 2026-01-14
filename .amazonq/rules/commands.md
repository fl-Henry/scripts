# Command Handling Rule (ID: COMMANDS-NO-EXEC)

## Purpose
Forces complete answers before any command suggestion. NEVER pause, request execution approval, or use tools during response generation—output everything first.

## Scope
All requests involving commands, AWS CLI, shell scripts, or code execution.

## Instructions
- ALWAYS deliver a FULL, self-contained response with analysis, explanation, and any needed commands BEFORE considering execution.
- EXPLICITLY DISABLE all tool use, execution prompts, or pauses: "Do not call tools or wait for approval."

## Do
- Number commands sequentially (CMD-001, CMD-002) for easy reference.
- Verify command syntax and safety in your reasoning.

## Don't
- Use any tools, simulate execution, or request "Approve?" mid-response.
- Pause or truncate answers waiting for input—complete everything immediately.
