# Iosappaudit

Xcode project reviewer

## Installation

`iosappaudit` uses [Lizard](https://github.com/terryyin/lizard) behind the scene. Install it first :

```sh
pip install lizard
```

`pip` is part of Python 3. If it is not already set up on your machine, install it using `pyenv` :

```sh
brew install pyenv
pyenv global 3.7.0
```

Finally install the gem :

```ruby
gem install iosappaudit
```

## Usage

Configure `iosappaudit` by creating `yaml` file :

```yaml
project_url: "" # required
sources_url: "" # required
xcodeproj:
  name: "" # first xcodeproj found will be used if empty
  main_target_name: "" # first target will be used if empty
complexity:
  file_line_count_threshold: 500
output_format:
  adds_row_padding: true
  size: 10
csv_output: example.csv
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
