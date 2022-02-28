# Building template

* Pre-release versions are automatically created of `develop` branch.
  * Feature branches should be merged to `develop` to produce pre-release version and to `master`.
* Release packages are created from tags on master branch.
* After creating release run `git pull --rebase origin master` on `develop` branch or recreate `develop` branch from `master`.
