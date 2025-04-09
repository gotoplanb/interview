# Interview Project

A Phoenix-based interview project with SQLite database.

## Current Features

- User model with basic attributes
- SQLite database integration
- Test suite with model tests
- Standardized development workflow with Makefile

## Development

### Prerequisites
- Elixir 1.15 or later
- Erlang/OTP 26 or later
- SQLite 3

### Setup
1. Clone the repository
2. Install dependencies:
   ```bash
   mix deps.get
   ```
3. Create and migrate the database:
   ```bash
   mix ecto.setup
   ```
4. Start the Phoenix server:
   ```bash
   mix phx.server
   ```

### Testing
Run the test suite:
```bash
mix test
```

## Makefile Commands

This project includes a Makefile to standardize common development tasks. Here are the available commands:

```bash
make setup    # Install dependencies and setup database
make format   # Format all Elixir files
make lint     # Run linter (mix format --check-formatted)
make test     # Run tests
make build    # Build the project
make run      # Start the Phoenix server
make clean    # Clean build artifacts
make ci       # Run CI pipeline (setup through build)
make help     # Show all available commands
```

The `make ci` command runs the complete CI pipeline, executing setup, format, lint, test, and build in sequence. This is useful for both local development and CI/CD environments.

## Project Structure

```
interview/
├── assets/          # Frontend assets
├── config/          # Configuration files
├── lib/             # Application code
│   ├── interview/   # Business logic
│   └── interview_web/ # Web-related code
├── test/            # Test files
└── priv/            # Private application files
```

## Database

The project uses SQLite as the database. The database file is located at `priv/repo/interview.db`.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
