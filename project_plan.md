# Interview Management System - Project Plan

## Overview
This document outlines the implementation plan for an interview management system built with Elixir/Phoenix. The system will help standardize and streamline the interview process, ensuring consistent candidate assessment across different roles and teams.

## Technical Stack
- **Backend**: Elixir/Phoenix
- **Database**: SQLite (development)
- **Frontend**: Phoenix LiveView
- **Testing**: ExUnit
- **Build/Dev Tools**: Make

## Project Structure
```
interview/
├── assets/                 # Frontend assets
├── lib/
│   ├── interview/          # Business logic
│   │   ├── accounts/       # User management
│   │   ├── roles/         # Role management
│   │   ├── interviews/    # Interview management
│   │   └── questions/     # Question templates
│   └── interview_web/      # Web interface
├── priv/
│   └── repo/              # Database migrations
├── test/                  # Test files
├── Makefile              # Build and development commands
└── mix.exs               # Project configuration
```

## Data Models

### User ✓
```elixir
schema "users" do
  field :name, :string
  field :type, Ecto.Enum, values: [:employee, :candidate]
  timestamps()
end
```

### Role
```elixir
schema "roles" do
  field :name, :string
  has_many :question_templates, QuestionTemplate
  timestamps()
end
```

### QuestionTemplate
```elixir
schema "question_templates" do
  field :question, :string
  field :required, :boolean, default: false
  belongs_to :role, Role
  timestamps()
end
```

### Interview
```elixir
schema "interviews" do
  field :status, Ecto.Enum, values: [:first, :second, :done]
  belongs_to :interviewer, User
  belongs_to :candidate, User
  belongs_to :role, Role
  has_many :answers, Answer
  timestamps()
end
```

### Answer
```elixir
schema "answers" do
  field :rating, :integer  # 1-5 Likert scale
  field :notes, :string
  belongs_to :interview, Interview
  belongs_to :question_template, QuestionTemplate
  timestamps()
end
```

## Implementation Phases

### Phase 1: Project Setup and Basic Infrastructure ✓
1. Initialize Phoenix project ✓
2. Set up SQLite database ✓
3. Create Makefile with basic commands ✓
4. Implement basic user authentication
5. Set up development environment ✓

### Phase 2: Core Data Models
1. Implement User model and context ✓
2. Implement Role model and context
3. Implement QuestionTemplate model and context
4. Implement Interview model and context
5. Implement Answer model and context
6. Create database migrations ✓
7. Write model tests ✓

### Phase 3: Interview Management
1. Implement interview creation workflow
2. Create interview assessment interface
3. Implement interview status management
4. Add validation rules for interview progression
5. Create interview summary views

### Phase 4: Question Management
1. Implement question template CRUD
2. Create question rating interface
3. Add support for required/optional questions
4. Implement question validation

### Phase 5: Reporting and Data Management
1. Implement CSV export functionality
2. Create interview statistics and reports
3. Add data import capabilities
4. Implement basic analytics

### Phase 6: UI/UX Improvements
1. Enhance interview workflow UI
2. Add responsive design
3. Implement real-time updates with LiveView
4. Add form validation and error handling

## Development Guidelines

### Code Organization
- Use contexts to organize business logic
- Keep controllers thin
- Use schemas for data validation
- Implement proper error handling

### Testing Strategy
- Unit tests for all business logic
- Integration tests for workflows
- E2E tests for critical paths
- Maintain test coverage above 80%

### Database Considerations
- Use migrations for all schema changes
- Implement proper indexes
- Use constraints for data integrity
- Plan for future PostgreSQL migration

### Security
- Implement proper authentication
- Use proper authorization checks
- Sanitize all user inputs
- Follow OWASP security guidelines

## Next Steps
1. ✓ Set up development environment
2. ✓ Initialize Phoenix project
3. ✓ Create initial database schema
4. ✓ Implement basic user model
5. Begin implementing role model

## Future Considerations
- Migration to PostgreSQL for production
- Integration with external HR systems
- Advanced analytics and reporting
- Mobile application support
- API for external integrations 