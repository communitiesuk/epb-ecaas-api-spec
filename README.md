# Specification for ECaaS APIs

This repository uses [TypeSpec](https://typespec.io) to specify the APIs exposed by the [ECaaS](https://docs.building-energy-calculator.communities.gov.uk/) project. TypeSpec allows us to define API specifications at a higher level of abstraction than using e.g. raw OpenAPI specification files, and supports features such as [versioning](https://typespec.io/docs/libraries/versioning/reference/).

## Generation

Once npm dependencies have been installed, run

```sh
npm run generate
```

to emit OpenAPI 3.1 documents.