const fs = require('fs');
const path = require('path');

const packageListPath = path.join(process.env.HOME, '.atom', 'installed-packages.txt');

function updateDotfile() {
  const userInstalledPackageList = atom.packages.getLoadedPackages()
    .filter(pkg => !pkg.bundledPackage)
    .map(pkg => pkg.name)
    .sort()
    .join('\n') + '\n';

  let savedList = null;
  try {
    savedList = fs.readFileSync(packageListPath, 'utf8');
  } catch (e) {}

  if (savedList !== userInstalledPackageList) {
    try {
      fs.writeFileSync(packageListPath, userInstalledPackageList, { mode: 0o644 });
      atom.notifications.addSuccess('Saved installed packages', {
        detail: packageListPath,
        dismissable: true
      });
    } catch (e) {
      atom.notifications.addError('Failed to save installed packages', {
        detail: e,
        dismissable: true
      });
    }
  }
};

updateDotfile();

atom.packages.onDidLoadPackage(updateDotfile);
atom.packages.onDidUnloadPackage(updateDotfile);
