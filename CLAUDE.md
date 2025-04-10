# CLAUDE.md - Elixir/Phoenix Project Guidelines

## Commands
- Build: `mix compile` or `make build`
- Run: `mix phx.server` or `make run`
- Format: `mix format` or `make format`
- Lint: `mix format --check-formatted` or `make lint`
- Test all: `mix test --cover` or `make test`
- Test single: `mix test path/to/test.exs:line_number`
- Test with coverage: `make test-coverage`
- Full CI: `make ci`

## Coding Style
- Follow standard Elixir conventions and Phoenix patterns
- Use Ecto schemas for DB models with explicit field types
- Document functions with `@doc` annotations
- Organize tests with `describe` blocks and use `test` macro
- Use `@valid_attrs` and `@invalid_attrs` in tests
- Format with configured formatter (see `.formatter.exs`)
- Use pipe operator `|>` for function chains
- Prefer explicit error handling with pattern matching
- Follow naming conventions:
  - Modules: PascalCase
  - Variables/functions: snake_case
  - Database tables: plural snake_case
  - Schema fields: snake_case