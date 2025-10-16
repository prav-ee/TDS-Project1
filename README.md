# TDS Project 1

This repository contains an automated task receiver and processor system built with FastAPI. The system is designed to receive task assignments, generate code using Google's Gemini AI, and automatically deploy the generated applications to GitHub Pages.

## Overview

The application serves as a backend service that:

1. **Receives Task Requests**: Accepts task specifications via HTTP POST requests
2. **AI Code Generation**: Uses Google's Gemini 2.5 Flash model to generate complete web applications
3. **GitHub Integration**: Creates or updates GitHub repositories with the generated code
4. **Automated Deployment**: Configures GitHub Pages for instant web deployment
5. **Evaluation Feedback**: Sends deployment details back to evaluation endpoints

## Architecture

### Core Components

- **FastAPI Application** (`main.py`): Main web server handling task requests
- **Data Models** (`models.py`): Pydantic models for request/response validation
- **Configuration** (`config.py`): Environment-based settings management
- **Docker Support** (`Dockerfile`): Containerized deployment configuration

### Key Features

- **Multi-round Task Handling**: Supports iterative task rounds (R1, R2, etc.)
- **Git Operations**: Automated repository creation, cloning, committing, and pushing
- **GitHub Pages Integration**: Automatic deployment configuration with retry logic
- **Error Handling**: Comprehensive error handling for API calls and Git operations
- **Security**: Secret-based authentication for task submissions

## API Endpoints

### POST `/receive-task`

Receives and processes task assignments.

**Request Body:**
```json
{
  "email": "student@example.com",
  "secret": "student_secret",
  "task": "unique-task-id",
  "round": 1,
  "nonce": "evaluation_nonce",
  "brief": "Description of the app to build",
  "checks": ["license", "readme", "functionality"],
  "evaluation_url": "https://evaluation.endpoint",
  "attachments": [
    {
      "name": "sample.png",
      "url": "data:image/png;base64,..."
    }
  ]
}
```

**Response:**
```json
{
  "status": "success",
  "repo_url": "https://github.com/username/repo-name",
  "commit_sha": "abc123...",
  "pages_url": "https://username.github.io/repo-name/"
}
```

## Setup and Installation

### Prerequisites

- Python 3.10+
- Git
- GitHub account with personal access token
- Google Gemini API key

### Environment Variables

Create a `.env` file in the root directory:

```env
GEMINI_API_KEY=your_gemini_api_key
GITHUB_TOKEN=your_github_personal_access_token
STUDENT_SECRET=your_student_secret
GITHUB_USERNAME=your_github_username
```

### Local Development

1. Clone the repository:
```bash
git clone https://github.com/prav-ee/TDS-Project1.git
cd TDS-Project1
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up environment variables in `.env`

4. Run the application:
```bash
uvicorn main:app --reload
```

The API will be available at `http://localhost:8000`

### Docker Deployment

Build and run with Docker:

```bash
docker build -t tds-project1 .
docker run -p 7860:7860 --env-file .env tds-project1
```

## Dependencies

- **FastAPI**: Modern web framework for building APIs
- **Uvicorn**: ASGI server for FastAPI
- **Pydantic**: Data validation and settings management
- **httpx**: Asynchronous HTTP client for API calls
- **GitPython**: Git operations automation
- **python-dotenv**: Environment variable loading

## Workflow

1. **Task Reception**: System receives task details via API
2. **Authentication**: Verifies student secret
3. **Repository Setup**: Creates new repo (Round 1) or clones existing (Round 2+)
4. **AI Generation**: Sends task brief to Gemini API for code generation
5. **Code Processing**: Parses and organizes generated code into project structure
6. **File Creation**: Writes generated files to local repository
7. **Git Operations**: Adds, commits, and pushes changes
8. **Pages Deployment**: Configures GitHub Pages with retry logic
9. **Evaluation**: Sends deployment URLs back to evaluation endpoint

## Security Considerations

- API requests require valid student secrets
- GitHub tokens should have minimal required permissions
- Environment variables keep sensitive data secure
- HTTPS is used for all external API communications

## Error Handling

The system includes comprehensive error handling for:
- GitHub API failures
- Git operation errors
- AI generation timeouts
- Network connectivity issues
- Repository access problems

## Generated Projects

Generated applications are stored in the `generated_tasks/` directory and include:
- Complete web applications
- HTML, CSS, JavaScript files
- README and license files
- Proper project structure

## Contributing

This is a project-specific implementation. For modifications:
1. Ensure all dependencies are properly managed
2. Test API endpoints thoroughly
3. Validate GitHub integration
4. Update documentation for any changes

## License

This project is part of TDS coursework. See individual generated project licenses for details.
