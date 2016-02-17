# Front-end project example/test

This repository contains a project structure example.

## Dependencies

```
apt-get install jq moreutils
npm install -g bower wiredep uglifyjs ng-annotate
```

## How-to ?

Build:
```
# Install bower components and wire them
make deps

# Build the app
make
```

Clean:
```
# Clean the app
make clean
# Clean the components
make reallyclean
```
