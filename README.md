# docker-semantic-release

[`semantic-release`][semantic-release-github] makes versioning and
releases unsentimental. Projects using `semantic-release` commit to [a
Git commit style][conventional-commits] which is used by
`semantic-release` to infer the semantic version for an automated
release.

This repository provides [a Docker image][docker-hub] with
`semantic-release`, `commitlint` (a commit history linter), as well as
some `semantic-release` plugins to aid with semantic-release
integration, especially [in non-npm projects][integrated-projects].

[conventional-commits]: https://www.conventionalcommits.org
[semantic-release-github]: https://github.com/semantic-release/semantic-release
[docker-hub]: https://hub.docker.com/repository/docker/deliveroo/semantic-release/general
[integrated-projects]: https://github.com/search?l=YAML&q=org%3Adeliveroo+%22deliveroo%2Fsemantic-release%22&type=Code

## Dependencies

```
@commitlint/config-conventional:             ^8.3.4
@semantic-release/changelog:                 ^5.0.1
semantic-release-docker:                     ^2.2.0
commitlint:                                  ^8.3.5
conventional-changelog-conventionalcommits:  ^4.3.0
semantic-release:                           ^17.0.8
```

## Setup

Add a [`.commitlintrc.json`](./.commitlintrc.json) and a
[`.releaserc.json`](./.releaserc.json) to your project. You can use
the ones found in this repository as a starting guide. Note that only
the semantic-release plugins above are available for use.

### Integrating with CircleCI

For example:

```yml
jobs:
  release:
    docker:
      - image: deliveroo/semantic-release:latest
    steps:
      - checkout
      - run: semantic-release -r ${CIRCLE_REPOSITORY_URL}

  # Ensure that commits conform
  commitlint:
    docker:
      - image: deliveroo/semantic-release:latest
    environment:
      - DEFAULT_BRANCH=origin/main
    steps:
      - checkout
      - run: commitlint --from $(git rev-parse $DEFAULT_BRANCH) --to $CIRCLE_SHA1 --verbose

workflows:
  version: 2
  default:
    jobs:
      - commitlint
      - release:
          filters:
            branches:
              only:
                - main
```
