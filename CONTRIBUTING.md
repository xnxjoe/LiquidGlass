# Contributing to LiquidGlass

First off, thank you for considering contributing to LiquidGlass! 🎉

The following is a set of guidelines for contributing to LiquidGlass. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Code of Conduct

This project and everyone participating in it is governed by our commitment to providing a welcoming and inspiring community for all. Please be respectful and constructive in all interactions.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples** to demonstrate the steps
- **Describe the behavior you observed** and what behavior you expected
- **Include screenshots or animated GIFs** if applicable
- **Include your environment details** (iOS version, Xcode version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a detailed description** of the suggested enhancement
- **Explain why this enhancement would be useful**
- **List some examples** of how it would be used

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Make your changes** and ensure they follow the project's coding style
3. **Add tests** for any new functionality
4. **Ensure all tests pass** by running `swift test`
5. **Update documentation** as needed
6. **Commit your changes** with clear, descriptive commit messages
7. **Push to your fork** and submit a pull request

#### Pull Request Guidelines

- Follow the Swift API Design Guidelines
- Include documentation for new public APIs
- Add tests for new features or bug fixes
- Keep pull requests focused on a single feature or fix
- Write clear commit messages following conventional commits format

Example commit message:
```
feat: add polygon shape support

- Implement custom polygon path generation
- Add tests for polygon shapes
- Update documentation with examples
```

Commit types:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `test:` - Adding or updating tests
- `refactor:` - Code refactoring
- `perf:` - Performance improvements
- `chore:` - Maintenance tasks

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/xnxjoe/LiquidGlass.git
   cd LiquidGlass
   ```

2. Open in Xcode:
   ```bash
   open Package.swift
   ```

3. Build the project:
   ```bash
   swift build
   ```

4. Run tests:
   ```bash
   swift test
   ```

## Coding Style

- Follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use clear, descriptive variable and function names
- Add documentation comments for all public APIs
- Use MARK comments to organize code sections
- Keep functions focused and single-purpose
- Prefer value types (structs) over reference types (classes) where appropriate

## Testing

- Write tests for all new features
- Ensure existing tests pass before submitting PR
- Aim for high test coverage of public APIs
- Use descriptive test names that explain what is being tested

## Documentation

- Add documentation comments (`///`) for all public APIs
- Include usage examples in documentation
- Update README.md if adding significant features
- Keep CHANGELOG.md updated with notable changes

## Questions?

Feel free to open an issue with your question or reach out through GitHub discussions.

## Recognition

Contributors will be recognized in the project README and release notes.

Thank you for contributing to LiquidGlass! 🙏
