# salt-formula-packages

Handles installation of large numbers of packages from pillar configs.

Now does Python pip, Ruby gem and node.js npm based install/removal also.

TODO:
1. Change from 'uninstall' list to remove list which can accept additional options/arguments, e.g. to uninstall with pip/gem/npm as a specific user
2. Install dependency executables, e.g. gem/pip/npm based on map.jinja by O/S and O/S family/version etc.
