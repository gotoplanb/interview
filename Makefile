.PHONY: setup format lint test build run clean help ci

# Default target
help:
	@echo "Available commands:"
	@echo "  make setup    - Install dependencies and setup database"
	@echo "  make format   - Format all Elixir files"
	@echo "  make lint     - Run linter (mix format --check-formatted)"
	@echo "  make test     - Run tests"
	@echo "  make build    - Build the project"
	@echo "  make run      - Start the Phoenix server"
	@echo "  make clean    - Clean build artifacts"
	@echo "  make ci       - Run CI pipeline (setup through build)"
	@echo "  make help     - Show this help message"

# Setup project
setup:
	mix deps.get
	mix ecto.setup

# Format code
format:
	mix format

# Check formatting
lint:
	mix format --check-formatted

# Run tests
test:
	mix test

# Build project
build:
	mix compile

# Run CI pipeline
ci: setup format lint test build

# Run Phoenix server
run:
	mix phx.server

# Clean build artifacts
clean:
	mix clean
	rm -rf _build
	rm -rf deps
	rm -rf cover 