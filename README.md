# Iosappaudit

Xcode project reviewer

## Installation

`iosappaudit` uses [Lizard](https://github.com/terryyin/lizard) under the hood. Install it first:

```sh
pip install lizard
```

`pip` is part of Python 3. If it is not already set up on your machine, install it using `pyenv`:

```sh
brew install pyenv
pyenv global 3.7.0
```

Finally install the gem:

```ruby
gem install iosappaudit
```

## Usage

Configure `iosappaudit` by creating a `yaml` file:

```yaml
project_url: "" # required
sources_url: "" # required, used to compute the cyclomatic complexity number
xcodeproj:
  name: "" # first xcodeproj found will be used if empty
  main_target_name: "" # first target will be used if empty
complexity:
  file_line_count_threshold: 500
output_format:
  adds_row_padding: true
  size: 0 # adds samples for each project caracteristic
csv_output: audit.csv
```

Only `project_url` and `sources_url` are required. Example:

```yaml
project_url: /.../Project
sources_url: /.../Project/Classes
```

Then launch the review :

```
iosappaudit -o example.yaml
```

It generates a quick csv recap of your project:

```csv
Project
Name,MyProject,
Version,1166,
Deployment Target,11.2,
Localizations,1,fr,
Settings
Targets,13,
Configurations,4,
Code
Files,1079,
Swift files,770,
Objective C files,309,
Lines of code,74630,
Files with more than 500 lines,14
Cyclomatic Complexity Number,13136,
Resources
Xibs,196,
Storyboards,3,
Tests,
Unit Tests,7,
UI Tests,4,
```
